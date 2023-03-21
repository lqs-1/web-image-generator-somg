package com.somg.web.file.generator.handler.security;

import com.somg.web.file.generator.constant.REnum;
import com.somg.web.file.generator.handler.security.utils.ResponseUtils;
import com.somg.web.file.generator.utils.R;
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
public class RestfulAccessDeniedHandler implements AccessDeniedHandler {
    @Override
    public void handle(HttpServletRequest request, HttpServletResponse response, AccessDeniedException accessDeniedException) throws IOException, ServletException {
        System.out.println("没有资源的访问权限");
        ResponseUtils.out(response, R.error(REnum.NO_AUTH.getStatusCode(),REnum.NO_AUTH.getStatusMsg()));
    }
}
