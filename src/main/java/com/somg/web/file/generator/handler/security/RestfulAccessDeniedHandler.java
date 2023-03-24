package com.somg.web.file.generator.handler.security;

import com.somg.web.file.generator.constant.REnum;
import com.somg.web.file.generator.handler.security.utils.JwtToken;
import com.somg.web.file.generator.handler.security.utils.ResponseUtils;
import com.somg.web.file.generator.utils.R;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.web.access.AccessDeniedHandler;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * @author somg
 * @date 2023/3/19 2:50
 * @do 没有资源访问权限的处理器
 */
@Slf4j
public class RestfulAccessDeniedHandler implements AccessDeniedHandler {


    private JwtToken jwtToken;

    public RestfulAccessDeniedHandler(JwtToken jwtToken){
        this.jwtToken = jwtToken;
    }

    @Override
    public void handle(HttpServletRequest request, HttpServletResponse response, AccessDeniedException accessDeniedException) throws IOException, ServletException {
        // 从请求头中获取携带的token
        String token = request.getHeader("token");
        String usrName = jwtToken.parseUsernameFormToken(token);
        log.info(usrName + " 访问路径 [" + request.getRequestURI() + "] 没有权限");
        ResponseUtils.out(response, R.error(REnum.NO_AUTH.getStatusCode(),REnum.NO_AUTH.getStatusMsg()));
    }
}
