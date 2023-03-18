package com.somg.web.file.generator.controller;

import com.somg.web.file.generator.action.RoleService;
import com.somg.web.file.generator.constant.REnum;
import com.somg.web.file.generator.pojo.origin.Role;
import com.somg.web.file.generator.utils.Pagination.PageUtils;
import com.somg.web.file.generator.utils.R;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("role")
public class RoleController {

    @Autowired
    private RoleService roleService;


    @PreAuthorize("hasAnyRole('common','admin', 'supermanager') and hasAuthority('select')")
    @GetMapping("rolePage")
    public R getPage(@RequestParam Map<String, Object> param){

        try{

            PageUtils roleList = roleService.getRolePage(param);

            return R.ok(REnum.GET_ROLE_SUCCESS.getStatusCode(),
                            REnum.GET_ROLE_SUCCESS.getStatusMsg())
                    .put("roleList", roleList);

        }catch (Exception e){

            e.printStackTrace();

            return R.error(REnum.GET_ROLE_FAIL.getStatusCode(),
                    REnum.GET_ROLE_FAIL.getStatusMsg());
        }
    }

    @PreAuthorize("hasAnyRole('admin', 'supermanager') and hasAuthority('select')")
    @GetMapping("roleList")
    public R getList(){

        try{

            List<Role> roleList = roleService.getList();

            return R.ok(REnum.GET_ROLE_SUCCESS.getStatusCode(),
                            REnum.GET_ROLE_SUCCESS.getStatusMsg())
                    .put("roleList", roleList);

        }catch (Exception e){

            e.printStackTrace();

            return R.error(REnum.GET_ROLE_FAIL.getStatusCode(),
                    REnum.GET_ROLE_FAIL.getStatusMsg());

        }
    }


    @PreAuthorize("hasAnyRole('admin', 'supermanager') and hasAuthority('add')")
    @PostMapping("addRole")
    public R addRole(@RequestBody Role role){

        try{

            R result = roleService.addRole(role);

            return result;

        }catch (Exception e){

            e.printStackTrace();

            return R.error(REnum.ROLE_ADD_FAIL.getStatusCode(),
                    REnum.ROLE_ADD_FAIL.getStatusMsg());
        }
    }


    @PreAuthorize("hasAnyRole('admin', 'supermanager') and hasAuthority('update')")

    @PostMapping("editRole")
    public R editRole(@RequestBody Role role){

        try{

            roleService.editRole(role);

            return R.ok(REnum.ROLE_EDIT_SUCCESS.getStatusCode(),
                    REnum.ROLE_EDIT_SUCCESS.getStatusMsg());

        }catch (Exception e){

            e.printStackTrace();

            return R.error(REnum.ROLE_EDIT_FAIL.getStatusCode(),
                    REnum.ROLE_EDIT_FAIL.getStatusMsg());
        }
    }



    @PreAuthorize("hasAnyRole('admin', 'supermanager') and hasAuthority('delete')")
    @PostMapping("deleteRole")
    public R deleteRole(@RequestBody Role role){

        try{

            roleService.deleteRoleById(role.getId());

            return R.ok(REnum.ROLE_DELETE_SUCCESS.getStatusCode(),
                    REnum.ROLE_DELETE_SUCCESS.getStatusMsg());

        }catch (Exception e){

            e.printStackTrace();

            return R.error(REnum.ROLE_DELETE_FAIL.getStatusCode(),
                    REnum.ROLE_DELETE_FAIL.getStatusMsg());
        }
    }


}
