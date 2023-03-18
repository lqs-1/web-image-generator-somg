package com.somg.web.file.generator.config;

import com.somg.web.file.generator.handler.security.UnAuthEntryPoint;
import com.somg.web.file.generator.handler.security.LogoutSuccessHandler;
import com.somg.web.file.generator.handler.security.filter.TokenAuthFilter;
import com.somg.web.file.generator.handler.security.filter.TokenLoginFilter;
import com.somg.web.file.generator.handler.security.utils.JwtToken;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import redis.clients.jedis.JedisPool;

/**
 * @author somg
 * @date 2023/3/17 8:12
 * @do 一句话描述此模块的功能
 */
@Configuration
@EnableWebSecurity
@EnableGlobalMethodSecurity(prePostEnabled = true, securedEnabled = true)
public class SecurityConfigurerAdapter extends WebSecurityConfigurerAdapter {


    private JwtToken jwtToken;

    private JedisPool jedisPool;

    private UserDetailsService userDetailsService;

    @Autowired
    public SecurityConfigurerAdapter(JwtToken jwtToken, JedisPool jedisPool, UserDetailsService userDetailsService){
        this.userDetailsService = userDetailsService;
        this.jwtToken = jwtToken;
        this.jedisPool = jedisPool;
    }


    @Override
    protected void configure(HttpSecurity http) throws Exception {

        http.csrf().disable(); // 关闭csrf防护

        http.exceptionHandling().authenticationEntryPoint(new UnAuthEntryPoint()); // 没有权限时候的处理方案(匿名用户，没有登录)

        // 在这里就开始准备redis，token工具类
        http.logout().logoutUrl("/user/logout").addLogoutHandler(new LogoutSuccessHandler(jwtToken, jedisPool)); // 登出逻辑和处理器以及如果需要删除cookie

        // 登录过滤器
        http.addFilter(new TokenLoginFilter(authenticationManager(), jwtToken, jedisPool));

        // 处理权限的过滤器
        http.addFilter(new TokenAuthFilter(authenticationManager(), jwtToken, jedisPool));

        http.authorizeRequests().anyRequest().authenticated(); // 所有接口都需要做权限认证

        http.httpBasic();
    }


    /**
     * 添加获取数据库用户数据的配置
     * @param auth
     * @throws Exception
     */
    @Override
    protected void configure(AuthenticationManagerBuilder auth) throws Exception {

        auth.userDetailsService(userDetailsService).passwordEncoder(passwordEncoder());

        super.configure(auth);
    }


    @Bean
    public BCryptPasswordEncoder passwordEncoder(){

        return new BCryptPasswordEncoder();

    }

}
