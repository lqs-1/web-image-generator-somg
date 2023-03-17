package com.somg.web.image.generator.action.im;

import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

/**
 * @author somg
 * @date 2023/3/17 8:14
 * @do 一句话描述此模块的功能
 */
//@Service
public class UserDetailImpl implements UserDetailsService {

// 登录逻辑
    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {

        List<SimpleGrantedAuthority> simpleGrantedAuthorities = new ArrayList<>();

        BCryptPasswordEncoder bCryptPasswordEncoder = new BCryptPasswordEncoder();
        String password = "admin";

        System.out.println(username);

        return new User(username, bCryptPasswordEncoder.encode(password), simpleGrantedAuthorities);

    }
}
