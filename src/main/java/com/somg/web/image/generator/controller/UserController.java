package com.somg.web.image.generator.controller;

import com.somg.web.image.generator.action.*;
import com.somg.web.image.generator.constant.Constant;
import com.somg.web.image.generator.constant.REnum;
import com.somg.web.image.generator.pojo.origin.Permission;
import com.somg.web.image.generator.pojo.origin.Role;
import com.somg.web.image.generator.pojo.origin.User;
import com.somg.web.image.generator.utils.Pagination.PageUtils;
import com.somg.web.image.generator.utils.R;
import com.somg.web.image.generator.vo.UserLoginVo;
import com.somg.web.image.generator.vo.UserVo;
import com.wf.captcha.SpecCaptcha;
import com.wf.captcha.base.Captcha;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("user")
public class UserController {

    /**
     * 不用
     */
    // @Autowired
    // private JedisPool jedisPool;

    @Autowired
    private UserService userService;

    @Autowired
    private UserRoleService userRoleService;

    @Autowired
    private RoleService roleService;

    @Autowired
    private PermissionService permissionService;

    @Autowired
    private UserPermissionService userPermissionService;


    @GetMapping("captcha")
    public void getCaptcha(
            HttpServletResponse httpServletResponse,
            HttpServletRequest httpServletRequest) throws IOException {

        httpServletResponse.setContentType("image/png");

        // 三个参数分别为宽、高、位数
        SpecCaptcha captcha = new SpecCaptcha(120, 30, 4);

        // 设置类型 数字和字母混合
        captcha.setCharType(Captcha.TYPE_DEFAULT);

        //设置字体
        captcha.setCharType(Captcha.FONT_9);

        // 将文本存储到redis
        // Jedis jedis = jedisPool.getResource();
        // jedis.setex(username,300, captcha.text());
        httpServletRequest.getSession().setAttribute("code", captcha.text());


        // 输出图片流
        captcha.out(httpServletResponse.getOutputStream());
    }


    /**
     * 方法作废用spring-security
     * @param request
     * @param userLoginVo
     * @return
     * @throws Exception
     */
    @PostMapping("login")
    public R login(
            HttpServletRequest request,
            @RequestBody UserLoginVo userLoginVo) throws Exception {

        // 从redis中取出验证码
        // Jedis jedis = jedisPool.getResource();
        // String code = jedis.get(userLoginVo.getUsername());

        String code = (String) request.getSession().getAttribute("code");

        if (code.toLowerCase().equals(userLoginVo.getCode().toLowerCase())){

            try{

                    User user = new User();

                    BeanUtils.copyProperties(userLoginVo,user);

                    R result = userService.getUser(user, request);

                    return result;

            }catch (Exception e){

                e.printStackTrace();

                return R.error(REnum.DATABASE_ERROR.getStatusCode(),
                        REnum.DATABASE_ERROR.getStatusMsg());

            }
        }else {

            return R.error(REnum.VALIDATE_CODE_ERROR.getStatusCode(),
                    REnum.VALIDATE_CODE_ERROR.getStatusMsg());

        }
    }

    /**
     * 废方法，不会应用到
     * @param request
     * @return
     */
    @GetMapping("session")
    public R session(HttpServletRequest request){

        User user = (User) request.getSession().getAttribute("user");

        if (user == null){

            return R.error(REnum.PLEASE_LOGIN.getStatusCode(),
                    REnum.PLEASE_LOGIN.getStatusMsg());

        }

        return R.ok(REnum.WELCOME_MAIN.getStatusCode(),
                REnum.WELCOME_MAIN.getStatusMsg())
                .put("user", user);
    }


    /**
     * 废方法，不会应用到
     * @param httpServletRequest
     * @return
     */
    @GetMapping("cleanSession")
    public R cleanSession(HttpServletRequest httpServletRequest){

        httpServletRequest.getSession().invalidate();

        return R.ok(REnum.LOGOUT_SUCCESS.getStatusCode(),
                REnum.LOGOUT_SUCCESS.getStatusMsg());
    }


    /**
     * 废方法。改用getUserPage了
     * @return
     */
    @PreAuthorize("hasAnyRole('common')")
    @GetMapping("userList")
    public R getUserList(){

        try{
            List<User> userList = userService.getUserList();

            return R.ok(REnum.GET_USER_LIST_SUCCESS.getStatusCode(),
                    REnum.GET_USER_LIST_SUCCESS.getStatusMsg())
                    .put("userList", userList);

        }catch (Exception e){

            e.printStackTrace();

            return R.error(REnum.GET_USER_LIST_FAIL.getStatusCode(),
                    REnum.GET_USER_LIST_FAIL.getStatusMsg());
        }
    }


    @PreAuthorize("hasAnyRole('common','admin', 'supermanager') and hasAuthority('select')")
    @GetMapping("userPage")
    public R getUserPage(@RequestParam Map<String, Object> params){
        try{

            // Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
            // System.out.println(authentication.getPrincipal());
            PageUtils userList = userService.getUserPage(params);

            return R.ok(REnum.GET_USER_LIST_SUCCESS.getStatusCode(),
                            REnum.GET_USER_LIST_SUCCESS.getStatusMsg())
                    .put("userList", userList);

        }catch (Exception e){

            e.printStackTrace();

            return R.error(REnum.GET_USER_LIST_FAIL.getStatusCode(),
                    REnum.GET_USER_LIST_FAIL.getStatusMsg());
        }
    }


    @PreAuthorize("hasAnyRole('admin', 'supermanager') and hasAuthority('add')")
    @PostMapping("addUser")
    public R addUser(@RequestBody User user){

        try{

            R result = userService.addUser(user);

            List<Role> roleList = roleService.selectCommonRole(Constant.COMMON_ROLE);

            List<Long> roleIds = new ArrayList<>();

            for (Role role : roleList) {

                roleIds.add(role.getId());

            }
            userRoleService.addUserRoleRenation(user.getId(),roleIds);

            List<Permission> permissionList = permissionService.selectCommonPermission(Constant.COMMON_PERMISSION);

            List<Long> permissionIds = new ArrayList<>();

            for (Permission permission : permissionList) {
                permissionIds.add(permission.getId());
            }

            userPermissionService.addUserPermissionRelation(user.getId(), permissionIds);




            return result;

        }catch (Exception e){

            e.printStackTrace();

            return R.error(REnum.ADD_USER_FAIL.getStatusCode(),
                    REnum.ADD_USER_FAIL.getStatusMsg());

        }
    }

    @PreAuthorize("hasAnyRole('admin', 'supermanager') and hasAuthority('update')")
    @PostMapping("editUser")
    public R editUser(@RequestBody UserVo userVo){

        try{

            User user = new User();

            BeanUtils.copyProperties(userVo, user);

            userService.editUser(user);

            Long userId = user.getId();

            userRoleService.addUserRoleRenation(userId, userVo.getRoleIds());

            userPermissionService.addUserPermissionRelation(userId, userVo.getPermissionIds());

            return R.ok(REnum.EDIT_USER_SUCCESS.getStatusCode(),
                    REnum.EDIT_USER_SUCCESS.getStatusMsg());

        }catch (Exception e){

            e.printStackTrace();

            return R.error(REnum.EDIT_USER_FAIL.getStatusCode(),
                    REnum.EDIT_USER_FAIL.getStatusMsg());
        }
    }


    @PreAuthorize("hasAnyRole('admin', 'supermanager') and hasAuthority('delete')")
    @PostMapping("deleteUser")
    public R deleteUser(@RequestBody User user){

        try{

            userService.deleteUserById(user.getId());

            userRoleService.deleteUserRoleRelation(user.getId());

            userPermissionService.deleteUserPermissionRelation(user.getId());

            return R.ok(REnum.DELETE_USER_SUCCESS.getStatusCode(),
                    REnum.DELETE_USER_SUCCESS.getStatusMsg());

        }catch (Exception e){

            e.printStackTrace();

            return R.error(REnum.DELETE_USER_FAIL.getStatusCode(),
                    REnum.DELETE_USER_FAIL.getStatusMsg());
        }
    }




    @PostMapping("register")
    public R userRegister(@RequestBody User user){

        try{

            R result = userService.addUser(user);

            List<Role> roleList = roleService.selectCommonRole(Constant.COMMON_ROLE);

            List<Long> roleIds = new ArrayList<>();

            for (Role role : roleList) {

                roleIds.add(role.getId());

            }
            userRoleService.addUserRoleRenation(user.getId(),roleIds);

            List<Permission> permissionList = permissionService.selectCommonPermission(Constant.COMMON_PERMISSION);

            List<Long> permissionIds = new ArrayList<>();

            for (Permission permission : permissionList) {
                permissionIds.add(permission.getId());
            }

            userPermissionService.addUserPermissionRelation(user.getId(), permissionIds);

            return result;
        }catch (Exception e){

            e.printStackTrace();

            return R.error(REnum.REGISTER_FAIL.getStatusCode(),
                    REnum.REGISTER_FAIL.getStatusMsg());
        }
    }


    @PostMapping("alterPwd")
    public R userAlterPwd(@RequestBody User user){

        try {

            R result = userService.alterPwdByUserName(user);

            return result;

        }catch (Exception e){

            e.printStackTrace();

            return R.error(REnum.ALTER_PASSWORD_FAIL.getStatusCode(),
                    REnum.ALTER_PASSWORD_FAIL.getStatusMsg());

        }

    }


    @PreAuthorize("hasAnyRole('admin', 'supermanager') and hasAuthority('select')")
    @GetMapping("roleList")
    public R roleList(@RequestParam Long id){

        try {

            List<Long> roleIdList = userRoleService.selectByUserId(id);

            List<Long> roleIds = new ArrayList<>();

            for (Long roleId : roleIdList) {

                Role role = roleService.getById(roleId);

                roleIds.add(role.getId());

            }

            return R.ok(REnum.GET_EXIST_ROLE_SUCCESS.getStatusCode(),

                    REnum.GET_EXIST_ROLE_SUCCESS.getStatusMsg())

                    .put("roleIds", roleIds);

        }catch (Exception e){

            e.printStackTrace();

            return R.error(REnum.GET_EXIST_ROLE_FAIL.getStatusCode(),
                    REnum.GET_EXIST_ROLE_FAIL.getStatusMsg());
        }
    }


    @PreAuthorize("hasAnyRole('admin', 'supermanager') and hasAuthority('select')")
    @GetMapping("permissionList")
    public R permissionList(@RequestParam Long id){
        try {
            List<Long> permissionIdList = userPermissionService.selectByUserId(id);

            List<Long> permissionIds = new ArrayList<>();

            for (Long permissionId : permissionIdList) {

                Permission permission = permissionService.getById(permissionId);

                permissionIds.add(permission.getId());

            }

            return R.ok(REnum.GET_EXIST_PERMISSION_SUCCESS.getStatusCode(),
                            REnum.GET_EXIST_PERMISSION_SUCCESS.getStatusMsg())
                    .put("permissionIds", permissionIds);

        }catch (Exception e){

            e.printStackTrace();

            return R.error(REnum.GET_EXIST_PERMISSION_FAIL.getStatusCode(),
                    REnum.GET_EXIST_PERMISSION_FAIL.getStatusMsg());

        }
    }

}
