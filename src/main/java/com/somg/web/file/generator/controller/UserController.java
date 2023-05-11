package com.somg.web.file.generator.controller;

import com.mysql.cj.util.StringUtils;
import com.somg.web.file.generator.action.*;
import com.somg.web.file.generator.annotation.SysListenLog;
import com.somg.web.file.generator.config.EmailCodeClient;
import com.somg.web.file.generator.constant.REnum;
import com.somg.web.file.generator.pojo.Permission;
import com.somg.web.file.generator.pojo.Role;
import com.somg.web.file.generator.pojo.User;
import com.somg.web.file.generator.utils.GenerateValidateCodeUtils;
import com.somg.web.file.generator.utils.Pagination.PageUtils;
import com.somg.web.file.generator.utils.R;
import com.somg.web.file.generator.vo.UserLoginVo;
import com.somg.web.file.generator.vo.UserVo;
import com.wf.captcha.SpecCaptcha;
import com.wf.captcha.base.Captcha;
import io.swagger.annotations.*;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import javax.mail.internet.AddressException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.concurrent.TimeUnit;

/**
 * @author somg
 * @date 2023/3/20 16:21
 * @do 用户控制器
 */
@Api(tags = "用户模块")
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

    @Autowired
    private RedisTemplate redisTemplate;


    @Autowired
    private EmailCodeClient emailCodeClient;


    /**
     * 图像验证码
     * @param httpServletResponse
     * @param httpServletRequest
     * @throws IOException
     */
    @GetMapping("captcha")
    @ApiOperation(value = "获取验证码")
    public void getCaptcha(
            HttpServletResponse httpServletResponse,
            HttpServletRequest httpServletRequest) throws IOException {

        httpServletResponse.setContentType("image/png");

        String imageKey = httpServletRequest.getParameter("imageKey"); // 获取前端传递的时间戳, 当作redis的key

        // 三个参数分别为宽、高、位数
        SpecCaptcha captcha = new SpecCaptcha(120, 30, 4);

        // 设置类型 数字和字母混合
        captcha.setCharType(Captcha.TYPE_DEFAULT);

        //设置字体
        captcha.setCharType(Captcha.FONT_9);

        // 将文本存储到redis
        redisTemplate.opsForValue().set(imageKey, captcha.text(), 2, TimeUnit.MINUTES);

        ServletOutputStream outputStream = httpServletResponse.getOutputStream();

        // 输出图片流
        captcha.out(outputStream);

        outputStream.flush();

        outputStream.close();
    }


    @GetMapping("email")
    @ApiOperation(value = "获取邮箱验证码")
    public R getEmailValidate(@RequestParam(value = "email", required = true) String email) throws AddressException, UnsupportedEncodingException {

        // 验证验证码是否已经存在
        String code = (String) redisTemplate.opsForValue().get(emailCodeClient.getEmailProperties().getCacheKeyPrefix() + email);
        // 如若已经有验证码，直接返回错误错误消息，发送频繁
        if (!StringUtils.isNullOrEmpty(code)){
            return R.error(REnum.EMAIL_VALIDATE_SEND_FAST.getStatusCode(),
                    REnum.EMAIL_VALIDATE_SEND_FAST.getStatusMsg());
        }

        // 生成验证码
        String validateCode = GenerateValidateCodeUtils.generateEmailCodeNumber(7);

        R emailResult = emailCodeClient.sendEmailCode(email, validateCode, false);

        if (emailResult.parseCode() >= 10000 && emailResult.parseCode() < 20000){
            redisTemplate.opsForValue().set(emailCodeClient.getEmailProperties().getCacheKeyPrefix() + email, validateCode, emailCodeClient.getEmailProperties().getExpireTime(), TimeUnit.SECONDS);
        }

        return emailResult;

    }


    /**
     * 方法作废用spring-security 过时方法 登录方法
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
     * 废方法，不会应用到 过时方法 登录之后页面加载获取登录状态
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
     * 废方法，不会应用到 过时方法 退出登录 清除session
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
     * 废方法。改用getUserPage了 获取所有用户
     * @return
     */
    @PreAuthorize("hasAnyRole('admin','supermanager')")
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

    /**
     * 获取用户分页数据
     * @param params
     * @return
     */
    @SysListenLog(serverName = "用户模块", action = "用户列表")
    @PreAuthorize("hasAnyRole('admin', 'supermanager') and hasAuthority('select')")
    @GetMapping("userPage")
    @ApiOperation(value = "获取用户分页数据")
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

    /**
     * 添加用户
     * @param user
     * @return
     */
    @SysListenLog(serverName = "用户服务", action = "添加用户")
    @PreAuthorize("hasAnyRole('admin', 'supermanager') and hasAuthority('add')")
    @PostMapping("addUser")
    @ApiOperation(value = "添加用户")
    public R addUser(@RequestBody User user){

        try{

            R result = userService.addUser(user);

            return result;

        }catch (Exception e){

            e.printStackTrace();

            return R.error(REnum.ADD_USER_FAIL.getStatusCode(),
                    REnum.ADD_USER_FAIL.getStatusMsg());

        }
    }

    /**
     * 修改用户
     * @param userVo
     * @return
     */
    @SysListenLog(serverName = "用户服务", action = "编辑用户")
    @PreAuthorize("hasAnyRole('admin', 'supermanager') and hasAuthority('update')")
    @PostMapping("editUser")
    @ApiOperation(value = "修改用户")
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


    /**
     * 删除用户
     * @param user
     * @return
     */
    @SysListenLog(serverName = "用户服务", action = "删除用户")
    @PreAuthorize("hasAnyRole('admin', 'supermanager') and hasAuthority('delete')")
    @PostMapping("deleteUser")
    @ApiOperation(value = "删除用户[物理]")
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


    /**
     * 注册用户 添加用户
     * @param user
     * @return
     */
    @PostMapping("register")
    @ApiOperation(value = "用户注册")
    public R userRegister(@RequestBody User user){
        // 获取验证码
        String realValidateCode = (String) redisTemplate.opsForValue().get(emailCodeClient.getEmailProperties().getCacheKeyPrefix() + user.getEmail());
        // 验证码
        if (!realValidateCode.toLowerCase().equals(user.getEmailCode().toLowerCase())){
            return R.error(REnum.EMAIL_VALIDATE_ERROR.getStatusCode(),
                    REnum.EMAIL_VALIDATE_ERROR.getStatusMsg());
        }
        // 删除验证码
        redisTemplate.delete(emailCodeClient.getEmailProperties().getCacheKeyPrefix() + user.getEmail());

        try{

            R result = userService.addUser(user);

            return result;
        }catch (Exception e){

            e.printStackTrace();

            return R.error(REnum.REGISTER_FAIL.getStatusCode(),
                    REnum.REGISTER_FAIL.getStatusMsg());
        }
    }


    /**
     * 修改用户密码
     * @param user
     * @return
     */
    @PostMapping("alterPwd")
    @ApiOperation(value = "修改密码")
    public R userAlterPwd(@RequestBody User user){

        // 获取验证码
        String realValidateCode = (String) redisTemplate.opsForValue().get(emailCodeClient.getEmailProperties().getCacheKeyPrefix() + user.getEmail());
        // 验证码
        if (!realValidateCode.toLowerCase().equals(user.getEmailCode().toLowerCase())){
            return R.error(REnum.EMAIL_VALIDATE_ERROR.getStatusCode(),
                    REnum.EMAIL_VALIDATE_ERROR.getStatusMsg());
        }
        // 删除验证码
        redisTemplate.delete(emailCodeClient.getEmailProperties().getCacheKeyPrefix() + user.getEmail());


        try {

            R result = userService.alterPwdByUserNameAndEmail(user);

            return result;

        }catch (Exception e){

            e.printStackTrace();

            return R.error(REnum.ALTER_PASSWORD_FAIL.getStatusCode(),
                    REnum.ALTER_PASSWORD_FAIL.getStatusMsg());

        }

    }

    /**
     * 重置密码
     * @param userId
     * @return
     */
    @PostMapping("resetPassWord/{userId}")
    @SysListenLog(serverName = "用户服务", action = "重置密码")
    @ApiOperation(value = "重置密码")
    @PreAuthorize("hasAnyRole('admin', 'supermanager') and hasAuthority('update')")
    public R resetPassWord(@PathVariable Long userId){

        try {

            return userService.resetPassWord(userId);
        }catch (Exception e){

            e.printStackTrace();

            return R.error(REnum.DEFAULT_PASSWORD_RESET_FAIL.getStatusCode(),
                    REnum.DEFAULT_PASSWORD_RESET_FAIL.getStatusMsg());

        }

    }


    /**
     * 获取用户所有角色数据
     * @param id
     * @return
     */
    @SysListenLog(serverName = "用户服务", action = "修改用户角色")
    @PreAuthorize("hasAnyRole('admin', 'supermanager') and hasAuthority('select')")
    @GetMapping("roleList")
    @ApiOperation(value = "获取用户角色信息")
    public R roleList(@RequestParam Long id){

        try {

            List<Long> roleIdList = userRoleService.selectByUserId(id);

            List<Role> roleList = new ArrayList<>();

            for (Long roleId : roleIdList) {

                Role role = roleService.getById(roleId);

                roleList.add(role);

            }

            return R.ok(REnum.GET_EXIST_ROLE_SUCCESS.getStatusCode(),

                    REnum.GET_EXIST_ROLE_SUCCESS.getStatusMsg())

                    .put("roleList", roleList);

        }catch (Exception e){

            e.printStackTrace();

            return R.error(REnum.GET_EXIST_ROLE_FAIL.getStatusCode(),
                    REnum.GET_EXIST_ROLE_FAIL.getStatusMsg());
        }
    }


    /**
     * 获取用户所有的权限
     * @param id
     * @return
     */
    @SysListenLog(serverName = "用户服务", action = "修改用户权限")
    @PreAuthorize("hasAnyRole('admin', 'supermanager') and hasAuthority('select')")
    @GetMapping("permissionList")
    @ApiOperation(value = "获取用户权限信息")
    public R permissionList(@RequestParam Long id){
        try {
            List<Long> permissionIdList = userPermissionService.selectByUserId(id);

            List<Permission> permissionList = new ArrayList<>();

            for (Long permissionId : permissionIdList) {

                Permission permission = permissionService.getById(permissionId);

                permissionList.add(permission);

            }

            return R.ok(REnum.GET_EXIST_PERMISSION_SUCCESS.getStatusCode(),
                            REnum.GET_EXIST_PERMISSION_SUCCESS.getStatusMsg())
                    .put("permissionList", permissionList);

        }catch (Exception e){

            e.printStackTrace();

            return R.error(REnum.GET_EXIST_PERMISSION_FAIL.getStatusCode(),
                    REnum.GET_EXIST_PERMISSION_FAIL.getStatusMsg());

        }
    }

}
