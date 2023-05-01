package com.somg.web.file.generator.action;

import com.baomidou.mybatisplus.extension.service.IService;
import com.somg.web.file.generator.pojo.Menus;
import com.somg.web.file.generator.utils.Pagination.PageUtils;
import com.somg.web.file.generator.vo.AddMenuVo;

import java.util.List;
import java.util.Map;

/**
 * @author somg
 * @date 2023/3/20 12:09
 * @do 菜单接口（主要是页面的路径添加到后台，好做菜单权限 前端权限）
 */
public interface MenuService extends IService<Menus> {
    List<Menus> getMenus(List<Long> menuIds);

    List<Menus> getAllParentMenus();

    void addMenu(AddMenuVo addMenuVo);

    PageUtils allMenusPage(Map<String, Object> params);

    void deleteMenu(Menus menus);

    List<Menus> getAllMenus();

    List<Menus> checkedMenuList(Long userId);

    List<Long> getCommonMenuIds();

}
