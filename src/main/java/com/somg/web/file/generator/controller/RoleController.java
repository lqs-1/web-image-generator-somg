package com.somg.web.file.generator.controller;

import com.somg.web.file.generator.action.RoleService;
import com.somg.web.file.generator.annotation.SysListenLog;
import com.somg.web.file.generator.constant.REnum;
import com.somg.web.file.generator.pojo.origin.Role;
import com.somg.web.file.generator.utils.Pagination.PageUtils;
import com.somg.web.file.generator.utils.R;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

/**
 * @author somg
 * @date 2023/3/20 16:21
 * @do 角色控制器
 */
@RestController
@RequestMapping("role")
@Api(tags = "角色模块")
public class RoleController {

    @Autowired
    private RoleService roleService;


    /**
     * 获取角色分页数据
     * @param param
     * @return
     */
    @SysListenLog(serverName = "角色服务", action = "角色列表[展示]")
    @PreAuthorize("hasAnyRole('admin', 'supermanager') and hasAuthority('select')")
    @GetMapping("rolePage")
    @ApiOperation(value = "角色列表[展示]")
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

    /**
     * 获取所有的角色数据
     * @return
     */
    @SysListenLog(serverName = "角色服务", action = "角色列表[授权]")
    @PreAuthorize("hasAnyRole('admin', 'supermanager') and hasAuthority('select')")
    @GetMapping("roleList")
    @ApiOperation(value = "角色列表[授权]")
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


    /**
     * 添加角色
     * @param role
     * @return
     */
    @SysListenLog(serverName = "角色服务", action = "新增角色")
    @PreAuthorize("hasAnyRole('admin', 'supermanager') and hasAuthority('add')")
    @PostMapping("addRole")
    @ApiOperation(value = "新增角色")
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


    /**
     * 修改角色
     * @param role
     * @return
     */
    @SysListenLog(serverName = "角色服务", action = "编辑角色")
    @PreAuthorize("hasAnyRole('admin', 'supermanager') and hasAuthority('update')")
    @PostMapping("editRole")
    @ApiOperation(value = "编辑角色")
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


    /**
     * 删除角色
     * @param role
     * @return
     */
    @SysListenLog(serverName = "角色服务", action = "删除角色")
    @PreAuthorize("hasAnyRole('admin', 'supermanager') and hasAuthority('delete')")
    @PostMapping("deleteRole")
    @ApiOperation(value = "删除角色")
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
