package com.somg.web.file.generator.action.im;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.mysql.cj.util.StringUtils;
import com.somg.web.file.generator.action.MenuService;
import com.somg.web.file.generator.action.UserMenuService;
import com.somg.web.file.generator.constant.Constant;
import com.somg.web.file.generator.mapper.MenuMapper;
import com.somg.web.file.generator.pojo.origin.Menus;
import com.somg.web.file.generator.utils.Pagination.PageUtils;
import com.somg.web.file.generator.utils.Pagination.QueryPage;
import com.somg.web.file.generator.vo.AddMenuVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

/**
 * @author somg
 * @date 2023/3/20 12:12
 * @do 菜单实现 （给菜单授权使用 前端权限）
 */

@Service
public class MenuServiceImpl extends ServiceImpl<MenuMapper, Menus> implements MenuService {


    @Autowired
    private UserMenuService userMenuService;

    /**
     * 根据给定的menuId列表查出对应的菜单
     * @param menuIds
     * @return
     */
    @Override
    public List<Menus> getMenus(List<Long> menuIds) {

        List<Menus> menuList = this.baseMapper.selectList(new LambdaQueryWrapper<Menus>().in(Menus::getId, menuIds));
        return menuList;

    }

    /**
     * 查询出所有的父菜单
     * @return
     */
    @Override
    public List<Menus> getAllParentMenus() {

        List<Menus> menusList = this.baseMapper.selectList(null);


        return menusList.stream()
                .filter(menu -> menu.getMenuIndex() != null ? true : false).collect(Collectors.toList());

    }

    /**
     * 添加菜单（前端设计的页面的路径必须和添加的路径一样）
     * @param addMenuVo
     */
    @Override
    @Transactional(readOnly = false)
    public void addMenu(AddMenuVo addMenuVo) {


        if (!StringUtils.isNullOrEmpty(addMenuVo.getPmenuPath()) && !StringUtils.isNullOrEmpty(addMenuVo.getPmenuName())){
            if (this.baseMapper.selectList(new LambdaQueryWrapper<Menus>().eq(Menus::getMenuName, addMenuVo.getPmenuName())).size() > 0) {
                return;
            }

            Menus menus = new Menus();

            menus.setMenuName(addMenuVo.getPmenuName());
            menus.setMenuPath(addMenuVo.getPmenuPath());

            List<Menus> allParentMenus = this.getAllParentMenus();

            Long index = 0L;
            for (Menus allParentMenu : allParentMenus) {
                Long menuIndex = allParentMenu.getMenuIndex();
                index += menuIndex;
            }

            menus.setMenuIndex(index);
            this.baseMapper.insert(menus);
        }else if (!StringUtils.isNullOrEmpty(addMenuVo.getMenuName()) &&
                !StringUtils.isNullOrEmpty(addMenuVo.getMenuPath()) &&
                !StringUtils.isNullOrEmpty(addMenuVo.getParentIndex().toString())){

            if (this.baseMapper.selectList(new LambdaQueryWrapper<Menus>().eq(Menus::getMenuName, addMenuVo.getMenuName())).size() > 0) {
                return;
            }

            Menus menus = new Menus();

            menus.setMenuName(addMenuVo.getMenuName());
            menus.setMenuPath(addMenuVo.getMenuPath());
            menus.setParentIndex(addMenuVo.getParentIndex());

            this.baseMapper.insert(menus);
        }else {
            throw new RuntimeException();
        }

    }

    /**
     * 获取菜单分页数据
     * @param params
     * @return
     */
    @Override
    public PageUtils allMenusPage(Map<String, Object> params) {
        IPage<Menus> page = this.page(new QueryPage<Menus>().getPage(params, true),
                null);

        return new PageUtils(page);
    }

    /**
     * 删除对应的菜单 根据id
     * @param menus
     */
    @Override
    @Transactional(readOnly = false)
    public void deleteMenu(Menus menus) {

        this.baseMapper.deleteById(menus.getId());

    }

    /**
     * 获取所有的菜单
     * @return
     */
    @Override
    public List<Menus> getAllMenus() {

        return this.baseMapper.selectList(null);
    }

    /**
     * 获取自己已经有访问权限的菜单
     * @param userId
     * @return
     */
    @Override
    public List<Menus> checkedMenuList(Long userId) {

        List<Long> menuIds = userMenuService.getMenuIds(userId);

        if (menuIds.size() > 0){
            List<Menus> menus = getMenus(menuIds);
            return menus;
        }

        return null;
    }


    /**
     * 获取注册和添加用户的时候默认添加的菜单访问权限 所需要用到的MenuId
     * @return
     */
    @Override
    public List<Long> getCommonMenuIds() {

        return this.baseMapper.selectList(new LambdaQueryWrapper<Menus>()
                        .like(Menus::getMenuPath, Constant.COMMON_MENU_AUTH_ONE).or()
                        .like(Menus::getMenuPath, Constant.COMMON_MENU_AUTH_TWO).or()
                        .like(Menus::getMenuPath, Constant.COMMON_MENU_AUTH_THREE))
                .stream().distinct()
                .map(item -> item.getId()).collect(Collectors.toList());
    }

}
