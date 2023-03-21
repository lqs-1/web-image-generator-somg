package com.somg.web.file.generator.config;

import com.baomidou.mybatisplus.core.injector.DefaultSqlInjector;
import com.baomidou.mybatisplus.core.injector.ISqlInjector;
import com.baomidou.mybatisplus.extension.plugins.PaginationInterceptor;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

/**
 * @author somg
 * @date 2023/1/17 10:54
 * @do mybatisPlus分页拦截器
 */
@Configuration
public class MybatisPlusPaginationInterceptorConfig {
    /**
     * 配置分页插件（mybatisPlus）
     * @return
     */
    @Bean
    public PaginationInterceptor paginationInterceptor(){

        PaginationInterceptor paginationInterceptor = new PaginationInterceptor();

        // 设置单页最大条数
        paginationInterceptor.setLimit(1000L);

        // 设置请求的页面大于最大页后操作， true调回到首页，false 继续请求  默认false
        paginationInterceptor.setOverflow(true);

        return paginationInterceptor;

    }





    @Bean
    public ISqlInjector sqlInjector() {
        return new DefaultSqlInjector();
    }




}
