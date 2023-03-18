package com.somg.web.file.generator.controller;


import com.somg.web.file.generator.action.PermissionService;
import com.somg.web.file.generator.pojo.origin.Permission;
import com.somg.web.file.generator.utils.Pagination.PageUtils;
import com.somg.web.file.generator.utils.R;
import com.somg.web.file.generator.constant.REnum;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("permission")
public class PermissionController {

    @Autowired
    private PermissionService permissionService;

    @PreAuthorize("hasAnyRole('common','admin', 'supermanager') and hasAuthority('select')")
    @GetMapping("permissionPage")
    public R getPage(@RequestParam Map<String, Object> param){

        try{

            PageUtils permissionList = permissionService.getPermissionPage(param);

            return R.ok(REnum.GET_PERMISSION_SUCCESS.getStatusCode(),
                            REnum.GET_PERMISSION_SUCCESS.getStatusMsg())
                    .put("permissionList", permissionList);

        }catch (Exception e){

            e.printStackTrace();

            return R.error(REnum.GET_PERMISSION_FAIL.getStatusCode(),
                    REnum.GET_PERMISSION_FAIL.getStatusMsg());
        }
    }


    @PreAuthorize("hasAnyRole('admin', 'supermanager') and hasAuthority('select')")
    @GetMapping("permissionList")
    public R getList(){

        try{

            List<Permission> permissionList = permissionService.getList();

            return R.ok(REnum.GET_PERMISSION_SUCCESS.getStatusCode(),
                            REnum.GET_PERMISSION_SUCCESS.getStatusMsg())
                    .put("permissionList", permissionList);

        }catch (Exception e){

            e.printStackTrace();

            return R.error(REnum.GET_PERMISSION_FAIL.getStatusCode(),
                    REnum.GET_PERMISSION_FAIL.getStatusMsg());

        }
    }


    @PreAuthorize("hasAnyRole('admin', 'supermanager') and hasAuthority('add')")
    @PostMapping("addPermission")
    public R addPermission(@RequestBody Permission permission){
        try{

            R result = permissionService.addPermission(permission);

            return result;

        }catch (Exception e){

            e.printStackTrace();

            return R.error(REnum.PERMISSION_ADD_FAIL.getStatusCode(),
                    REnum.PERMISSION_ADD_FAIL.getStatusMsg());
        }
    }


    @PreAuthorize("hasAnyRole('admin', 'supermanager') and hasAuthority('update')")
    @PostMapping("editPermission")
    public R editPermission(@RequestBody Permission permission){

        try{

            permissionService.editPermission(permission);

            return R.ok(REnum.PERMISSION_EDIT_SUCCESS.getStatusCode(),
                    REnum.PERMISSION_EDIT_SUCCESS.getStatusMsg());

        }catch (Exception e){

            e.printStackTrace();

            return R.error(REnum.PERMISSION_EDIT_FAIL.getStatusCode(),
                    REnum.PERMISSION_EDIT_FAIL.getStatusMsg());
        }
    }


    @PreAuthorize("hasAnyRole('admin', 'supermanager') and hasAuthority('delete')")
    @PostMapping("deletePermission")
    public R deletePermission(@RequestBody Permission permission){

        try{

            permissionService.deletePermissionById(permission.getId());

            return R.ok(REnum.PERMISSION_DELETE_SUCCESS.getStatusCode(),
                    REnum.PERMISSION_DELETE_SUCCESS.getStatusMsg());

        }catch (Exception e){

            e.printStackTrace();

            return R.error(REnum.PERMISSION_DELETE_FAIL.getStatusCode(),
                    REnum.PERMISSION_DELETE_FAIL.getStatusMsg());
        }
    }


}
