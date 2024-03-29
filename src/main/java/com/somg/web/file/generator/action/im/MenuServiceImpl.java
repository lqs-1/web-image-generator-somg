package com.somg.web.file.generator.action.im;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.ObjectUtils;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.mysql.cj.util.StringUtils;
import com.somg.web.file.generator.action.MenuService;
import com.somg.web.file.generator.action.SysDictService;
import com.somg.web.file.generator.action.UserMenuService;
import com.somg.web.file.generator.constant.Constant;
import com.somg.web.file.generator.constant.REnum;
import com.somg.web.file.generator.mapper.MenuMapper;
import com.somg.web.file.generator.pojo.Menus;
import com.somg.web.file.generator.pojo.SysDict;
import com.somg.web.file.generator.utils.Pagination.PageUtils;
import com.somg.web.file.generator.utils.Pagination.QueryPage;
import com.somg.web.file.generator.utils.R;
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

    @Autowired
    private SysDictService sysDictService;

    /**
     * 根据给定的menuId列表查出对应的菜单
     *
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
     *
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
     *
     * @param addMenuVo
     */
    @Override
    @Transactional(readOnly = false)
    public void addMenu(AddMenuVo addMenuVo) {


        if (!StringUtils.isNullOrEmpty(addMenuVo.getPmenuPath()) && !StringUtils.isNullOrEmpty(addMenuVo.getPmenuName())) {
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
        } else if (!StringUtils.isNullOrEmpty(addMenuVo.getMenuName()) &&
                !StringUtils.isNullOrEmpty(addMenuVo.getMenuPath()) &&
                !StringUtils.isNullOrEmpty(addMenuVo.getParentIndex().toString())) {

            if (this.baseMapper.selectList(new LambdaQueryWrapper<Menus>().eq(Menus::getMenuName, addMenuVo.getMenuName())).size() > 0) {
                return;
            }

            Menus menus = new Menus();

            menus.setMenuName(addMenuVo.getMenuName());
            menus.setMenuPath(addMenuVo.getMenuPath());
            menus.setParentIndex(addMenuVo.getParentIndex());

            this.baseMapper.insert(menus);
        } else {
            throw new RuntimeException();
        }

    }

    /**
     * 获取菜单分页数据
     *
     * @param params
     * @return
     */
    @Override
    public PageUtils allMenusPage(Map<String, Object> params) {

        // 根菜单
        if (params.get("type").equals(Constant.MENU_TYPE_PARENT)){

            IPage<Menus> page = this.page(new QueryPage<Menus>().getPage(params, true),

                    new LambdaQueryWrapper<Menus>().isNull(Menus::getParentIndex));

            return new PageUtils(page);

        } else if (params.get("type").equals(Constant.MENU_TYPE_SON)) { // 子菜单

            IPage<Menus> page = this.page(new QueryPage<Menus>().getPage(params, true),

                    new LambdaQueryWrapper<Menus>().eq(Menus::getParentIndex, params.get("parentIndex")));

            return new PageUtils(page);
        }

        return null;

    }

    /**
     * 删除对应的菜单 根据id
     *
     * @param menus
     * @return
     */
    @Override
    @Transactional(readOnly = false)
    public R deleteMenu(Menus menus) {

        // 是否被使用
        Menus isMenu = this.baseMapper.selectById(menus.getId());
        if (isMenu.getParentIndex() == null) {
            List<Menus> sonMenu = this.baseMapper.selectList(new LambdaQueryWrapper<Menus>().eq(Menus::getParentIndex, isMenu.getMenuIndex()));
            if (sonMenu != null && sonMenu.size() > 0) {
                return R.error(REnum.PARENT_MENU_USED.getStatusCode(), REnum.PARENT_MENU_USED.getStatusMsg());
            }
            this.baseMapper.deleteById(menus.getId());

        }else {
            this.baseMapper.deleteById(menus.getId());
        }
        return R.ok(REnum.DELETE_MENUS_SUCCESS.getStatusCode(),REnum.DELETE_MENUS_SUCCESS.getStatusMsg());
    }

    /**
     * 获取所有的菜单
     *
     * @return
     */
    @Override
    public List<Menus> getAllMenus() {

        return this.baseMapper.selectList(null);
    }

    /**
     * 获取自己已经有访问权限的菜单
     *
     * @param userId
     * @return
     */
    @Override
    public List<Menus> checkedMenuList(Long userId) {

        List<Long> menuIds = userMenuService.getMenuIds(userId);

        if (menuIds.size() > 0) {
            List<Menus> menus = getMenus(menuIds);
            return menus;
        }

        return null;
    }


    /**
     * 获取注册和添加用户的时候默认添加的菜单访问权限 所需要用到的MenuId
     *
     * @return
     */
    @Override
    public List<Long> getCommonMenuIds() {

        SysDict menuDict = sysDictService.findDictByParentAndSelfCode(Constant.SYSTEM_DEFAULT_SETTING_DICT_PARENT_CODE, Constant.SYSTEM_DEFAULT_SETTING_DICT_USER_DEFAULT_MENU);
        String dictValueString = menuDict.getDictValue();
        String[] dictValues = dictValueString.split(":");

        LambdaQueryWrapper<Menus> menusLambdaQueryWrapper = new LambdaQueryWrapper<>();

        for (int i = 0; i < dictValues.length; i++) {
            if (i < dictValues.length -1){
                menusLambdaQueryWrapper
                        .like(Menus::getMenuPath, dictValues[i]).or();
            }else {
                menusLambdaQueryWrapper
                        .like(Menus::getMenuPath, dictValues[i]);
            }
        }

        return this.baseMapper.selectList(menusLambdaQueryWrapper)
                .stream().distinct()
                .map(item -> item.getId()).collect(Collectors.toList());
    }

}
