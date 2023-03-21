package com.somg.web.file.generator.controller;

import com.somg.web.file.generator.action.MenuService;
import com.somg.web.file.generator.action.UserMenuService;
import com.somg.web.file.generator.constant.REnum;
import com.somg.web.file.generator.pojo.origin.Menus;
import com.somg.web.file.generator.utils.Pagination.PageUtils;
import com.somg.web.file.generator.utils.R;
import com.somg.web.file.generator.vo.AddMenuAuthVo;
import com.somg.web.file.generator.vo.AddMenuVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

/**
 * @author somg
 * @date 2023/3/20 16:21
 * @do 菜单控制器
 */

@RestController
@RequestMapping("menu")
public class MenuController {


    @Autowired
    private MenuService menuService;


    @Autowired
    private UserMenuService userMenuService;


    @GetMapping("allParentMenus")
    @PreAuthorize("hasAnyRole('admin', 'supermanager') and hasAuthority('add')")
    public R allParenMenus(){
        try{
            List<Menus> menusList = menuService.getAllParentMenus();
            return R.ok(REnum.GET_ALL_PARENT_MENUS_SUCCESS.getStatusCode(),
                    REnum.GET_ALL_PARENT_MENUS_SUCCESS.getStatusMsg())
                    .put("allParentMenus", menusList);
        }catch (Exception e){
            e.printStackTrace();
            return R.error(REnum.GET_ALL_PARENT_MENUS_FAIL.getStatusCode(),
                    REnum.GET_ALL_PARENT_MENUS_FAIL.getStatusMsg());
        }
    }


    /**
     * 添加菜单
     * @param addMenuVo
     * @return
     */
    @PostMapping("addMenu")
    @PreAuthorize("hasAnyRole('admin', 'supermanager') and hasAuthority('add')")
    public R addMenu(@RequestBody AddMenuVo addMenuVo){

        try {
            menuService.addMenu(addMenuVo);

            return R.ok(REnum.ADD_MENUS_SUCCESS.getStatusCode(),REnum.ADD_MENUS_SUCCESS.getStatusMsg());
        }catch (Exception e){
            e.printStackTrace();
            return R.error(REnum.ADD_MENUS_FAIL.getStatusCode(), REnum.ADD_MENUS_FAIL.getStatusMsg());
        }

    }


    /**
     * 获取菜单分页数据
     * @param params
     * @return
     */
    @GetMapping("menusPage")
    @PreAuthorize("hasAnyRole('common','admin', 'supermanager') and hasAuthority('select')")
    public R allMenusPage(@RequestParam Map<String, Object> params){

        try {

            PageUtils menuList = menuService.allMenusPage(params);

            return R.ok(REnum.GET_MENUS_LIST_SUCCESS.getStatusCode(),
                    REnum.GET_MENUS_LIST_SUCCESS.getStatusMsg())
                    .put("menuList", menuList);

        }catch (Exception e){
            e.printStackTrace();

            return R.error(REnum.GET_MENUS_LIST_FAIL.getStatusCode(), REnum.GET_MENUS_LIST_FAIL.getStatusMsg());
        }
    }


    /**
     * 获取当前用户已经拥有的菜单权限
     * @param userId
     * @return
     */
    @GetMapping("currentUserMenuAuth")
    @PreAuthorize("hasAnyRole('common','admin', 'supermanager') and hasAuthority('select')")
    public R currentUserMenuAuth(@RequestParam Long userId){

        try {
            List<Menus> checkedMenuList = menuService.checkedMenuList(userId);

            return R.ok(REnum.GET_CHECKED_MENUS_SUCCESS.getStatusCode(),
                    REnum.GET_CHECKED_MENUS_SUCCESS.getStatusMsg())
                    .put("checkedMenuList", checkedMenuList);
        }catch (Exception e){
            return R.error(REnum.GET_CHECKED_MENUS_FAIL.getStatusCode(),
                    REnum.GET_CHECKED_MENUS_FAIL.getStatusMsg());
        }
    }


    /**
     * 给用户添加菜单权限
     * @param addMenuAuthVo
     * @return
     */
    @PostMapping("alterMenuAuth")
    @PreAuthorize("hasAnyRole('admin', 'supermanager') and hasAnyAuthority('add', 'update')")
    public R addMenuAuth(@RequestBody AddMenuAuthVo addMenuAuthVo){
        try {
            userMenuService.addMenuAuth(addMenuAuthVo);
            return R.ok(REnum.ALTER_MENUS_AUTH_SUCCESS.getStatusCode(), REnum.ALTER_MENUS_AUTH_SUCCESS.getStatusMsg());
        }catch (Exception e){
            e.printStackTrace();
            return R.error(REnum.ALTER_MENUS_AUTH_FAIL.getStatusCode(), REnum.ALTER_MENUS_AUTH_FAIL.getStatusMsg());
        }
    }


    /**
     * 获取所有的菜单
     * @return
     */
    @GetMapping("menuList")
    @PreAuthorize("hasAnyRole('common','admin', 'supermanager') and hasAuthority('select')")
    public R menusList(){

        try {

            List<Menus> menuList = menuService.getAllMenus();

            return R.ok(REnum.GET_MENUS_LIST_SUCCESS.getStatusCode(),
                            REnum.GET_MENUS_LIST_SUCCESS.getStatusMsg())
                    .put("menuList", menuList);

        }catch (Exception e){
            e.printStackTrace();

            return R.error(REnum.GET_MENUS_LIST_FAIL.getStatusCode(), REnum.GET_MENUS_LIST_FAIL.getStatusMsg());
        }

    }


    /**
     * 删除对应的菜单
     * @param menus
     * @return
     */
    @PostMapping("deleteMenu")
    @PreAuthorize("hasAnyRole('admin', 'supermanager') and hasAuthority('delete')")
    public R deleteMenu(@RequestBody Menus menus){

        try {

            menuService.deleteMenu(menus);

            return R.ok(REnum.DELETE_MENUS_SUCCESS.getStatusCode(),REnum.DELETE_MENUS_SUCCESS.getStatusMsg());
        }catch (Exception e){

            return R.error(REnum.DELETE_MENUS_FAIL.getStatusCode(), REnum.DELETE_MENUS_FAIL.getStatusMsg());
        }
    }
}
