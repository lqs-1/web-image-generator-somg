package com.somg.web.file.generator.handler.security;

import com.mysql.cj.util.StringUtils;
import com.somg.web.file.generator.constant.REnum;
import com.somg.web.file.generator.handler.security.utils.JwtToken;
import com.somg.web.file.generator.handler.security.utils.TokenObj;
import com.somg.web.file.generator.utils.R;
import com.somg.web.file.generator.handler.security.utils.ResponseUtils;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.logout.LogoutHandler;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * @author somg
 * @date 2023/3/17 8:12
 * @do 登出处理器
 */

@Slf4j
public class LogoutSuccessHandler implements LogoutHandler {


    private JwtToken jwtToken;

    private RedisTemplate redisTemplate;



    public LogoutSuccessHandler(JwtToken jwtToken, RedisTemplate redisTemplate) {
        this.jwtToken = jwtToken;
        this.redisTemplate = redisTemplate;
    }

    /**
     * 登出逻辑
     * @param request
     * @param response
     * @param authentication
     */
    @Override
    public void logout(HttpServletRequest request, HttpServletResponse response, Authentication authentication) {

        // 从请求头中获取携带的token
        String token = request.getHeader("token");

        if (!StringUtils.isNullOrEmpty(token)){
            // 从token中解析出userName
            TokenObj tokenObj = jwtToken.parseObject(token, TokenObj.class);
            // 删除redis中的权限数据 原始方式
            // redisTemplate.delete(username);
            log.info(tokenObj.getUserName() + " 退出登录了");
        }

        ResponseUtils.out(response, R.ok(REnum.LOGOUT_SUCCESS_E.getStatusCode(), REnum.LOGOUT_SUCCESS_E.getStatusMsg()));

    }
}
