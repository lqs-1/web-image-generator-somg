package com.somg.web.file.generator.action;

import com.baomidou.mybatisplus.extension.service.IService;
import com.somg.web.file.generator.pojo.origin.UserMenu;
import com.somg.web.file.generator.vo.AddMenuAuthVo;

import java.util.List;

/**
 * @author somg
 * @date 2023/3/20 12:11
 * @do 用户菜单授权接口
 */
public interface UserMenuService extends IService<UserMenu> {
    List<Long> getMenuIds(Long userId);

    void clearMenuAuthByUserId(Long userId);

    void addMenuAuth(AddMenuAuthVo addMenuAuthVo);
}
