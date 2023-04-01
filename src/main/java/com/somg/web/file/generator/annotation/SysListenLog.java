package com.somg.web.file.generator.annotation;


import java.lang.annotation.*;

/**
 * @author somg
 * @date 2023/4/1 12:45
 * @do 日志注解
 */
@Target({ElementType.METHOD})
@Retention(RetentionPolicy.RUNTIME)
@Documented
public @interface SysListenLog {

    String serverName() default ""; // 哪个服务

    String action() default ""; // 哪个操作

}
