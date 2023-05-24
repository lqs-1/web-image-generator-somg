package com.somg.web.file.generator.handler.security.filter;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.mysql.cj.util.StringUtils;
import com.somg.web.file.generator.action.UserService;
import com.somg.web.file.generator.constant.Constant;
import com.somg.web.file.generator.constant.REnum;
import com.somg.web.file.generator.handler.security.utils.JwtToken;
import com.somg.web.file.generator.handler.security.utils.TokenObj;
import com.somg.web.file.generator.pojo.SecurityUser;
import com.somg.web.file.generator.pojo.User;
import com.somg.web.file.generator.utils.R;
import com.somg.web.file.generator.handler.security.utils.ResponseUtils;
import com.somg.web.file.generator.vo.MenuVo;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

/**
 * @author somg
 * @date 2023/3/18 16:24
 * @do 登录拦截器
 */
@Slf4j
public class TokenLoginFilter extends UsernamePasswordAuthenticationFilter {

    private JwtToken jwtToken;

    private RedisTemplate redisTemplate;

    private AuthenticationManager authenticationManager;

    private UserService userService;


    public TokenLoginFilter(AuthenticationManager authenticationManager, JwtToken jwtToken, RedisTemplate redisTemplate, UserService userService) {
        this.authenticationManager = authenticationManager;
        this.jwtToken = jwtToken;
        this.redisTemplate = redisTemplate;
        this.userService = userService;
        // 不是只允许post请求,才能经过这个filter
        this.setPostOnly(false);
        // 设置登录的路径和请求方式
        this.setRequiresAuthenticationRequestMatcher(new AntPathRequestMatcher("/user/login", "POST"));
    }

    /**
     * 执行认证的方法 给认证做准备工作，获取前端传递的数据
     * @param request
     * @param response
     * @return
     * @throws AuthenticationException
     */
    @Override
    public Authentication attemptAuthentication(HttpServletRequest request, HttpServletResponse response) throws AuthenticationException {

        // 获取表单提交的数据
        ObjectMapper objectMapper = new ObjectMapper();
        log.info("登录认证之前的准备工作执行了");

        try {
            User user = objectMapper.readValue(request.getInputStream(), User.class);

            // 校验 认证的过程
            return authenticationManager.authenticate(new UsernamePasswordAuthenticationToken(user.getUsername(), user.getPassword(), new ArrayList<>()));
        } catch (IOException e) {
            throw new RuntimeException();
        }
    }

    /**
     * 认证成功以后
     * @param request
     * @param response
     * @param chain
     * @param authResult
     * @throws IOException
     * @throws ServletException
     */
    @Override
    protected void successfulAuthentication(HttpServletRequest request, HttpServletResponse response, FilterChain chain, Authentication authResult) throws IOException, ServletException {

        // 先验证图形验证码是否正确
        String imageKey = request.getParameter("imageKey");
        String code = request.getParameter("code");

        String realImageCode = (String) redisTemplate.opsForValue().get(imageKey);
        
        // 校验验证码是否过期
        if (StringUtils.isNullOrEmpty(realImageCode)){
            ResponseUtils.out(response, R.error(REnum.IMAGE_CODE_EXPIRED.getStatusCode(), REnum.IMAGE_CODE_EXPIRED.getStatusMsg()));
            return;
        }

        if (!code.toLowerCase().equals(realImageCode.toLowerCase())){
            redisTemplate.delete(imageKey);
            ResponseUtils.out(response, R.error(REnum.VALIDATE_CODE_ERROR.getStatusCode(), REnum.VALIDATE_CODE_ERROR.getStatusMsg()));
            return;
        }

        redisTemplate.delete(imageKey);

        // 获取当前用户 UserDetails
        SecurityUser securityUser = (SecurityUser) authResult.getPrincipal();

        // 用户被删除了
        if (securityUser.getCurrentUser().getIsDelete() == 1) {
            ResponseUtils.out(response, R.error(REnum.USER_DOES_NOT_EXIST.getStatusCode(), REnum.USER_DOES_NOT_EXIST.getStatusMsg()));
            return;
        }

        log.info(securityUser.getUsername() + " 登录成功了");
        String username = securityUser.getUsername();

        // 权限存入redis
        List<String> permissionValueList = securityUser.getPermissionValueList();
        log.info(username + " 存权限-token");

        // 原始方式从redis中获取权限
        // redisTemplate.opsForValue().set(username, permissionValueList);


        // 组织token对象
        TokenObj tokenObj = new TokenObj();
        tokenObj.setUserName(username);
        tokenObj.setPermissionValueList(permissionValueList);

        // 生成token
        String token = jwtToken.createTokenObjectAsBody(tokenObj);

        // 获取菜单权限
        List<MenuVo> menuVoList = securityUser.getMenuVoList();

        log.info(username + " 登录成功返回数据");

        // 更新登录时间
        userService.updateLoginTimeByUserName(username);

        // 设置请求头
        response.addHeader(jwtToken.authHeaderName, token);
        response.addHeader(Constant.ACCESS_CONTROL_EXPOSE_HEADERS, jwtToken.authHeaderName);

        // 回写数据
        ResponseUtils.out(response, R.ok(REnum.LOGIN_SUCCESS.getStatusCode(), REnum.LOGIN_SUCCESS.getStatusMsg()).put("token", token).put("menus", menuVoList).put("username", username));

    }


    /**
     * 认证失败
     * @param request
     * @param response
     * @param failed
     * @throws IOException
     * @throws ServletException
     */
    @Override
    protected void unsuccessfulAuthentication(HttpServletRequest request, HttpServletResponse response, AuthenticationException failed) throws IOException, ServletException {
        log.error(TokenAuthFilter.userNameThreadLocal.get() + " 登录失败了");
        ResponseUtils.out(response, R.error(REnum.LOGIN_FAIL.getStatusCode(),REnum.LOGIN_FAIL.getStatusMsg()));
    }
}
