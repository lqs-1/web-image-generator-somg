package com.somg.web.file.generator.action.im;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.somg.web.file.generator.action.UserMenuService;
import com.somg.web.file.generator.mapper.UserMenuMapper;
import com.somg.web.file.generator.pojo.origin.UserMenu;
import com.somg.web.file.generator.vo.AddMenuAuthVo;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

/**
 * @author somg
 * @date 2023/3/20 12:13
 * @do 菜单授权实现
 */
@Service
public class UserMenuServiceImpl extends ServiceImpl<UserMenuMapper, UserMenu> implements UserMenuService {

    /**
     * 根据userId获取已拥有权限的菜单id列表
     * @param userId
     * @return
     */
    @Override
    public List<Long> getMenuIds(Long userId) {
        List<UserMenu> userMenus = this.baseMapper.selectList(new LambdaQueryWrapper<UserMenu>().eq(UserMenu::getUserId, userId));

        List<Long> menuIds = userMenus.stream().map(userMenu -> userMenu.getMenuId()).collect(Collectors.toList());

        return menuIds;

    }

    /**
     * 清除用户的权限
     * @param usrId
     */
    @Override
    @Transactional(readOnly = false)
    public void clearMenuAuthByUserId(Long usrId) {
        this.baseMapper.delete(new LambdaQueryWrapper<UserMenu>().eq(UserMenu::getUserId, usrId));
    }


    /**
     * 给指定的用户添加菜单的访问权限
     * @param addMenuAuthVo
     */
    @Override
    @Transactional(readOnly = false)
    public void addMenuAuth(AddMenuAuthVo addMenuAuthVo) {

        Long userId = addMenuAuthVo.getUserId();

        List<Long> menuIds = addMenuAuthVo.getMenuIds();

        if (menuIds == null && menuIds.size() == 0){
            throw new RuntimeException();
        }

        // 先清空权限
        this.clearMenuAuthByUserId(userId);

        // 保存权限

        for (Long menuId : menuIds) {
            UserMenu userMenu = new UserMenu();
            userMenu.setUserId(userId);
            userMenu.setMenuId(menuId);
            this.save(userMenu);
        }

    }
}
