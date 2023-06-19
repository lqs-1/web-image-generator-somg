package com.somg.web.file.generator.config;

import com.somg.web.file.generator.action.UserService;
import com.somg.web.file.generator.handler.security.RestfulAccessDeniedHandler;
import com.somg.web.file.generator.handler.security.UnAuthEntryPoint;
import com.somg.web.file.generator.handler.security.LogoutSuccessHandler;
import com.somg.web.file.generator.handler.security.filter.TokenAuthFilter;
import com.somg.web.file.generator.handler.security.filter.TokenLoginFilter;
import com.somg.web.file.generator.handler.security.utils.JwtToken;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.http.HttpMethod;
import org.springframework.security.config.Customizer;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.web.cors.CorsUtils;

/**
 * @author somg
 * @date 2023/3/17 8:12
 * @do SpringSecurity配置
 */
@Configuration
@EnableWebSecurity
@EnableGlobalMethodSecurity(prePostEnabled = true, securedEnabled = true)
public class SecurityConfigurerAdapter extends WebSecurityConfigurerAdapter {
    // jwtToken工具
    private JwtToken jwtToken;

    // 连接redis工具
    private RedisTemplate redisTemplate;

    // 自定义的登录逻辑实现
    private UserDetailsService userDetailsService;

    // 登录成功就更新登录时间
    private UserService userService;

    // 通过构造器注入以上三个参数
    @Autowired
    public SecurityConfigurerAdapter(JwtToken jwtToken, RedisTemplate redisTemplate, UserDetailsService userDetailsService, UserService userService){
        this.userDetailsService = userDetailsService;
        this.jwtToken = jwtToken;
        this.redisTemplate = redisTemplate;
        this.userService = userService;
    }


    /**
     * 认证这一块的配置
     * @param http
     * @throws Exception
     */
    @Override
    protected void configure(HttpSecurity http) throws Exception {

        http.csrf().disable(); // 关闭csrf防护

        http.cors(Customizer.withDefaults());

        //解决跨域问题。cors 预检请求放行,让Spring security 放行所有preflight request（cors 预检请求）
        http.authorizeRequests().requestMatchers(CorsUtils::isPreFlightRequest).permitAll();

     //    /swagger-ui.html
    //             /webjars/**
    //      /v2/**
     //     /swagger-resources/**

        http.authorizeRequests()
                // 放行一些功能接口 这个可以是任何请求方式
                .antMatchers(
                        "/user/captcha",
                        "/up",
                        "/up.html",
                        "/favicon.ico",
                        "/static/**",
                        "/somg/web-file-generate/simple",
                        "/allStatistical/allStatisticalData",
                        "/third/**").permitAll()
                .antMatchers(
                        "/swagger-ui/**",
                        "/swagger-ui.html",
                        "/webjars/**",
                        "/v2/**",
                        "/swagger-resources/**"
                ).permitAll()
                // 可以指定请求方式再放行
                .antMatchers("/user/register", "/user/alterPwd", "/user/email", "/image/scale", "/sysLog/thirdSysLog").permitAll()
                .anyRequest().authenticated(); // 除了这些接口，所有接口都需要做权限认证


        http.exceptionHandling().authenticationEntryPoint(new UnAuthEntryPoint(jwtToken)); // 没有权限时候的处理方案(匿名用户，没有登录)

        http.exceptionHandling().accessDeniedHandler(new RestfulAccessDeniedHandler(jwtToken)); // 没有权限访问时候的处理方案

        http.sessionManagement().sessionCreationPolicy(SessionCreationPolicy.STATELESS); // 关闭session

        // 在这里就开始准备redis，token工具类
        http.logout().logoutUrl("/user/logout").addLogoutHandler(new LogoutSuccessHandler(jwtToken, redisTemplate)); // 登出逻辑和处理器以及如果需要删除cookie

        // 登录过滤器
        http.addFilter(new TokenLoginFilter(authenticationManager(), jwtToken, redisTemplate, userService));

        // 处理权限的过滤器
        http.addFilter(new TokenAuthFilter(authenticationManager(), jwtToken, redisTemplate));

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


    /**
     * 给容器中配置一个加密器
     * @return
     */
    @Bean
    public BCryptPasswordEncoder passwordEncoder(){

        return new BCryptPasswordEncoder();

    }

}
