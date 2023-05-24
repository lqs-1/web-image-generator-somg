package com.somg.web.file.generator.action.im;


import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.ObjectUtils;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.somg.web.file.generator.action.*;
import com.somg.web.file.generator.cloud.storage.abs.upload.FileUploadPlus;
import com.somg.web.file.generator.constant.Constant;
import com.somg.web.file.generator.pojo.*;
import com.somg.web.file.generator.utils.Pagination.PageUtils;
import com.somg.web.file.generator.utils.Pagination.QueryPage;
import com.somg.web.file.generator.utils.R;
import com.somg.web.file.generator.constant.REnum;
import com.somg.web.file.generator.mapper.UserMapper;
import com.somg.web.file.generator.vo.MenuVo;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;


/**
 * @author somg
 * @date 2023/3/20 12:13
 * @do 用户实现 和SpringSecurity登录逻辑实现
 */
@Slf4j
@Service
public class UserServiceImpl extends ServiceImpl<UserMapper, User> implements UserService, UserDetailsService {

    @Autowired
    private UserRoleService userRoleService;
    @Autowired
    private RoleService roleService;
    @Autowired
    private PermissionService permissionService;
    @Autowired
    private UserPermissionService userPermissionService;

    @Autowired
    private MenuService menuService;

    @Autowired
    private UserMenuService userMenuService;

    @Autowired
    private SysDictService sysDictService;


    /**
     * 登录的时候采用session方式来存储用户 已经过时不用
     * @param user
     * @param request
     * @return
     * @throws Exception
     */
    @Override
    public R getUser(User user, HttpServletRequest request) throws Exception {

        User querUser = this.baseMapper.selectByUserName(user.getUsername());

        if (user == null){

            return R.error(REnum.USER_DOES_NOT_EXIST.getStatusCode(),
                    REnum.USER_DOES_NOT_EXIST.getStatusMsg());

        } else if (!querUser.getPassword().equals(user.getPassword())) {

            return R.error(REnum.USER_PASSWORD_ERROR.getStatusCode(),
                    REnum.USER_PASSWORD_ERROR.getStatusMsg());

        }
        request.getSession().setAttribute("user", querUser);

        return R.ok(REnum.LOGIN_SUCCESS.getStatusCode(),
                REnum.LOGIN_SUCCESS.getStatusMsg());
    }

    /**
     * 获取所有用户的列表
     * @return
     */
    @Override
    public List<User> getUserList() {

        List<User> userList = this.baseMapper.selectList(null);

        return userList;
    }

    /**
     * 获取用户的分页数据 可以根据关键字来筛选
     * @param params
     * @return
     */
    @Override
    public PageUtils getUserPage(Map<String, Object> params) {

        IPage<User> page = this.page(new QueryPage<User>().getPage(params, true),
                new LambdaQueryWrapper<User>().like(User::getUsername,
                        (String) params.get("username")).eq(User::getIsDelete, 0));

        return new  PageUtils(page);

    }

    /**
     * 添加或者注册用户 并给定默认的角色 接口权限 菜单权限
     * @param user
     * @return
     */
    @Override
    @Transactional(readOnly = false)
    public R addUser(User user) {

        User queryUser = this.baseMapper.getUserByUserName(user.getUsername());

        if (queryUser != null && queryUser.getIsDelete() == 0){

            return R.error(REnum.USER_DOES_EXIST.getStatusCode(),
                    REnum.USER_DOES_EXIST.getStatusMsg());

        } else if (queryUser != null && queryUser.getIsDelete() == 1) {
            // 填充数据 这总情况在于用户已经逻辑删除但是又要创建用户
            queryUser.setSex(user.getSex());
            queryUser.setEmail(user.getEmail());
            queryUser.setPassword(new BCryptPasswordEncoder().encode(user.getPassword()));
            queryUser.setIsDelete(0);
            queryUser.setLoginTime(new Date());

            this.baseMapper.updateById(queryUser);

            return R.ok(REnum.REGISTER_SUCCESS.getStatusCode(),
                    REnum.REGISTER_SUCCESS.getStatusMsg());
        }

        String password = user.getPassword();

        String encodePassword = new BCryptPasswordEncoder().encode(password);

        user.setPassword(encodePassword);

        user.setCreateTime(new Date());

        user.setLoginTime(new Date());

        this.baseMapper.insert(user);

        // 获取字典数据
        SysDict roleDict = sysDictService.findDictByParentAndSelfCode(Constant.SYSTEM_DEFAULT_SETTING_DICT_PARENT_CODE, Constant.SYSTEM_DEFAULT_SETTING_DICT_USER_DEFAULT_ROLE);
        SysDict permissionDict = sysDictService.findDictByParentAndSelfCode(Constant.SYSTEM_DEFAULT_SETTING_DICT_PARENT_CODE, Constant.SYSTEM_DEFAULT_SETTING_DICT_USER_DEFAULT_PERMISSION);
        SysDict menuDict = sysDictService.findDictByParentAndSelfCode(Constant.SYSTEM_DEFAULT_SETTING_DICT_PARENT_CODE, Constant.SYSTEM_DEFAULT_SETTING_DICT_USER_DEFAULT_MENU);

        if (ObjectUtils.isEmpty(roleDict) || ObjectUtils.isEmpty(permissionDict) || ObjectUtils.isEmpty(menuDict)){
            return R.error(REnum.DICT_DATA_ERROR.getStatusCode(), REnum.DICT_DATA_ERROR.getStatusMsg());
        }
        // 设置默认角色

        List<Role> roleList = roleService.selectCommonRole(roleDict.getDictValue());

        List<Long> roleIds = new ArrayList<>();

        for (Role role : roleList) {

            roleIds.add(role.getId());

        }
        userRoleService.addUserRoleRenation(user.getId(),roleIds);

        // 设置默认权限
        List<Permission> permissionList = permissionService.selectCommonPermission(permissionDict.getDictValue());

        List<Long> permissionIds = new ArrayList<>();

        for (Permission permission : permissionList) {
            permissionIds.add(permission.getId());
        }

        userPermissionService.addUserPermissionRelation(user.getId(), permissionIds);


        // 设置默认菜单
        List<Long> commonMenuIds =  menuService.getCommonMenuIds();

        commonMenuIds.stream().forEach(commonMenuId -> {
            UserMenu userMenu = new UserMenu();
            userMenu.setUserId(user.getId());
            userMenu.setMenuId(commonMenuId);
            userMenuService.save(userMenu);
        });



        return R.ok(REnum.REGISTER_SUCCESS.getStatusCode(),
                REnum.REGISTER_SUCCESS.getStatusMsg());

    }

    /**
     * 更新角色
     * @param user
     */
    @Override
    @Transactional(readOnly = false)
    public void editUser(User user) {

        this.baseMapper.updateById(user);

    }

    /**
     * 根据用户Id来删除用户
     * @param id
     */
    @Override
    @Transactional(readOnly = false)
    public void deleteUserById(Long id) {

        // 删除所有的文件
        // List<String> currentUserAllFilePath = userFileService.queryCurrentUserAllFilePath();
        // fileUpload.build().batchFileClear(currentUserAllFilePath);

        User user = this.getById(id);
        user.setIsDelete(1);

        this.baseMapper.updateById(user);

    }

    /**
     * 修改用户的密码
     * @param user
     * @return
     */
    @Override
    @Transactional(readOnly = false)
    public R alterPwdByUserNameAndEmail(User user) {

        User userByUserName = this.baseMapper.getUserByUserName(user.getUsername());

        // 被删除的用户不能修改密码 用户不存在也不能修改密码
        if(userByUserName == null || userByUserName.getIsDelete() == 1){

            return R.error(REnum.USER_DOES_NOT_EXIST.getStatusCode(),
                    REnum.USER_DOES_NOT_EXIST.getStatusMsg());

        }



        if (!user.getEmail().equals(userByUserName.getEmail())){
            return R.error(REnum.USER_VALID_ERROR.getStatusCode(),
                    REnum.USER_VALID_ERROR.getStatusMsg());
        }

        String password = user.getPassword();

        String encodePassword = new BCryptPasswordEncoder().encode(password);

        user.setPassword(encodePassword);

        this.baseMapper.alterPwdByUserName(user);

        return R.ok(REnum.ALTER_PASSWORD_SUCCESS.getStatusCode(),
                REnum.ALTER_PASSWORD_SUCCESS.getStatusMsg());
    }

    /**
     * 根据username查询用户
     * @param username
     * @return
     */
    @Override
    public User selectUserByName(String username) {

        User user = this.baseMapper.getUserByUserName(username);

        return user;

    }

    /**
     * 根据给定的用户名 模糊查询出用户的id列表
     * @param username
     * @return
     */
    @Override
    public List<Long> selectUserLikeName(String username) {

        return this.baseMapper.selectList(new LambdaQueryWrapper<User>().like(User::getUsername, username))
                .stream().map(user -> user.getId()).collect(Collectors.toList());

    }

    /**
     * 登录成功更新登录时间
     * @param username
     */
    @Override
    @Transactional(readOnly = false)
    public void updateLoginTimeByUserName(String username) {
        User user = this.selectUserByName(username);
        user.setLoginTime(new Date());
        this.baseMapper.updateById(user);
    }

    /**
     * 重置用户密码
     * @param userId
     * @return
     */
    @Override
    public R resetPassWord(Long userId) {
        SysDict sysDict = sysDictService.findDictByParentAndSelfCode(Constant.SYSTEM_DEFAULT_SETTING_DICT_PARENT_CODE, Constant.SYSTEM_DEFAULT_SETTING_DICT_USER_DEFAULT_RESET_PASSWORD);

        if (ObjectUtils.isEmpty(sysDict)){
            return R.error(REnum.UNKNOW_DEFAULT_PASSWORD_DICT.getStatusCode(), REnum.UNKNOW_DEFAULT_PASSWORD_DICT.getStatusMsg());
        }

        String defaultPassWord = sysDict.getDictValue();

        User user = this.baseMapper.selectById(userId);

        String encodePassword = new BCryptPasswordEncoder().encode(defaultPassWord);

        user.setPassword(encodePassword);

        this.updateById(user);

        return R.ok(REnum.DEFAULT_PASSWORD_RESET_SUCCESS.getStatusCode(), REnum.DEFAULT_PASSWORD_RESET_SUCCESS.getStatusMsg());
    }


    /**
     * 重写UserDetailsService实现登录逻辑
     * @param username
     * @return
     * @throws UsernameNotFoundException
     */
    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {

        List<String> simpleGrantedAuthorities = new ArrayList<>();

        List<MenuVo> menuVoList = new ArrayList<>();

        log.info(username + " 执行了登录逻辑UserDetailService");

        try {

            User user = this.baseMapper.getUserByUserName(username);
            // System.out.println(user);

            if (user != null) {

                List<Long> roleIdList = userRoleService.selectByUserId(user.getId());

                for (Long roleId : roleIdList) {

                    Role role = roleService.getById(roleId);

                    simpleGrantedAuthorities.add("ROLE_" + role.getRoleName());

                }

                List<Long> permissionIdList = userPermissionService.selectByUserId(user.getId());

                for (Long permissionId : permissionIdList) {

                    Permission permission = permissionService.getById(permissionId);

                    simpleGrantedAuthorities.add(permission.getPermissionName());

                }

                // 获取菜单访问
                List<Long> menuIds = userMenuService.getMenuIds(user.getId());
                if (menuIds.size() > 0){
                    List<Menus> menuList = menuService.getMenus(menuIds);
                    // 封装

                    List<Menus> parentMenuList = menuList.stream().filter(menu -> menu.getMenuIndex() != null ? true : false).collect(Collectors.toList());

                    menuVoList = parentMenuList.stream().map(parentMenu -> {
                        MenuVo menuVo = new MenuVo();
                        menuVo.setMenuIndex(parentMenu.getMenuIndex());
                        menuVo.setMenuName(parentMenu.getMenuName());

                        List<MenuVo.MenuItem> menuItemList = new ArrayList<>();

                        menuList.stream().filter(menu -> menu.getParentIndex() != null && menu.getParentIndex() == parentMenu.getMenuIndex() ? true : false)
                                .forEach(menu -> {
                                    MenuVo.MenuItem menuItem = new MenuVo.MenuItem();
                                    menuItem.setMenuPath(menu.getMenuPath());
                                    menuItem.setMenuName(menu.getMenuName());
                                    menuItemList.add(menuItem);
                                });
                        menuVo.setMenuItems(menuItemList);
                        return menuVo;
                    }).collect(Collectors.toList());
                }


            }


            SecurityUser securityUser = new SecurityUser();
            securityUser.setMenuVoList(menuVoList);
            securityUser.setCurrentUser(user);
            securityUser.setPermissionValueList(simpleGrantedAuthorities);
            return securityUser;

        }catch (Exception e){

            throw new RuntimeException();

        }
    }
}
