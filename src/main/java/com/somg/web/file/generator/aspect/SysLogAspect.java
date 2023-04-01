package com.somg.web.file.generator.aspect;

import com.somg.web.file.generator.action.SysLogService;
import com.somg.web.file.generator.action.UserService;
import com.somg.web.file.generator.annotation.SysListenLog;
import com.somg.web.file.generator.handler.security.filter.TokenAuthFilter;
import com.somg.web.file.generator.pojo.origin.SysLog;
import com.somg.web.file.generator.pojo.origin.User;
import lombok.extern.slf4j.Slf4j;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.AfterReturning;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.aspectj.lang.reflect.MethodSignature;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.lang.reflect.Method;
import java.util.Date;

/**
 * @author somg
 * @date 2023/4/1 12:49
 * @do 日志切面处理类
 */
@Aspect
@Component
@Slf4j
public class SysLogAspect {

    @Autowired
    private UserService userService;

    @Autowired
    private SysLogService sysLogService;


    // 设置切点
    @Pointcut("@annotation(com.somg.web.file.generator.annotation.SysListenLog)")
    public void sysLogPointCut(){}


    // 在他运行之后处理
    @AfterReturning("sysLogPointCut()")
    public void saveSysLog(JoinPoint joinPoint){

        SysLog sysLog = new SysLog();


        // 获取使用这个注解的方法签名
        MethodSignature methodSignature = (MethodSignature) joinPoint.getSignature();

        // 获取具体方法
        Method method = methodSignature.getMethod();

        // 获取这个方法上面的日志注解
        SysListenLog annotation = method.getAnnotation(SysListenLog.class);

        // 获取对应的用户id
        User user = userService.selectUserByName(TokenAuthFilter.userNameThreadLocal.get());

        // 填充数据
        sysLog.setTime(new Date());
        sysLog.setUserId(user.getId());
        sysLog.setUserName(user.getUsername());

        sysLog.setAction(annotation.action());
        sysLog.setServerName(annotation.serverName());

        // 持久化
        sysLogService.save(sysLog);

    }



}
