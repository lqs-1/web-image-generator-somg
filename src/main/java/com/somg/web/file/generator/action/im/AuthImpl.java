//package com.somg.web.image.generator.action.im;
//
//import com.somg.web.image.generator.action.UserService;
//import com.somg.web.image.generator.pojo.origin.MyUser;
//import com.somg.web.image.generator.pojo.origin.User;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.security.core.authority.SimpleGrantedAuthority;
//import org.springframework.security.core.userdetails.UserDetails;
//import org.springframework.security.core.userdetails.UserDetailsService;
//import org.springframework.security.core.userdetails.UsernameNotFoundException;
//import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
//import org.springframework.stereotype.Service;
//
//import java.util.ArrayList;
//import java.util.List;
//
///**
// * @author somg
// * @date 2023/3/17 15:46
// * @do 一句话描述此模块的功能
// */
////@Service
//public class AuthImpl implements UserDetailsService {
//
//    @Autowired
//    UserService userService;
//
//    @Override
//    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
//        List<SimpleGrantedAuthority> simpleGrantedAuthorities = new ArrayList<>();
//
//        System.out.println(username);
//
//        try {
//
//            User user = this.baseMapper.getUserByUserName(username);
//            // System.out.println(user);
//
//            if (user != null) {
//
//                List<Long> roleIdList = userRoleService.selectByUserId(user.getId());
//
//                for (Long roleId : roleIdList) {
//
//                    Role role = roleService.getById(roleId);
//
//                    simpleGrantedAuthorities.add(new SimpleGrantedAuthority("ROLE_" + role.getRoleName()));
//
//                }
//
//                List<Long> permissionIdList = userPermissionService.selectByUserId(user.getId());
//
//                for (Long permissionId : permissionIdList) {
//
//                    Permission permission = permissionService.getById(permissionId);
//
//                    simpleGrantedAuthorities.add(new SimpleGrantedAuthority(permission.getPermissionName()));
//
//                }
//
//
//            }
//
//            return new MyUser(username, new BCryptPasswordEncoder().encode("admin"), simpleGrantedAuthorities);
//
//        }catch (Exception e){
//
//            e.printStackTrace();
//
//            return new MyUser(username, "", simpleGrantedAuthorities);
//
//        }
//    }
//}
