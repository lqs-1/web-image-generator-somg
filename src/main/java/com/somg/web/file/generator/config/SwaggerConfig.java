package com.somg.web.file.generator.config;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import springfox.documentation.builders.ApiInfoBuilder;
import springfox.documentation.builders.PathSelectors;
import springfox.documentation.builders.RequestHandlerSelectors;
import springfox.documentation.oas.annotations.EnableOpenApi;
import springfox.documentation.service.ApiInfo;
import springfox.documentation.spi.DocumentationType;
import springfox.documentation.spring.web.plugins.Docket;

/**
 * @author somg
 * @date 2023/4/2 17:22
 * @do Swagger配置类
 */

@Configuration // 标明是配置类
@EnableOpenApi //开启swagger功能
public class SwaggerConfig {
    @Bean
    public Docket createRestApi() {
        return new Docket(DocumentationType.SWAGGER_2)  // DocumentationType.SWAGGER_2 固定的，代表swagger2
//                .groupName("分布式任务系统") // 如果配置多个文档的时候，那么需要配置groupName来分组标识
                .apiInfo(apiInfo()) // 用于生成API信息
                .select() // select()函数返回一个ApiSelectorBuilder实例,用来控制接口被swagger做成文档
                .apis(RequestHandlerSelectors.basePackage("com.somg.web.file.generator.controller"))
                .apis(RequestHandlerSelectors.withClassAnnotation(Api.class))
                .apis(RequestHandlerSelectors.withMethodAnnotation(ApiOperation.class))
                .paths(PathSelectors.any())// 选择所有的API,如果你想只为部分API生成文档，可以配置这里
                .build();


//        return new Docket(DocumentationType.OAS_30)
//                .apiInfo(apiInfo())
//                .select() // 通过.select()方法,去配置扫描接口,RequestHandlerSelectors配置如何扫描接口
//                .apis(RequestHandlerSelectors.withClassAnnotation(Api.class))           //仅扫描类上有@Api注解的
////      .apis(RequestHandlerSelectors.withMethodAnnotation(ApiOperation.class)) //仅扫描类上有@ApiOperation注解的
////      .apis(RequestHandlerSelectors.basePackage("com.qfx.controller"))        //只扫描该包下面的接口
//                .paths(PathSelectors.any())                                             //任何请求都扫描
////      .paths(PathSelectors.regex("/test/.*"))                                 //匹配/test/开头的路径信息
//                .build();

    }

    /**
     * 用于定义API主界面的信息，比如可以声明所有的API的总标题、描述、版本
     * @return
     */
    private ApiInfo apiInfo() {
        return new ApiInfoBuilder()
                .title("web-file-generator") //  可以用来自定义API的主标题
                .description("Vue+SpringBoot+SpringSecurity的文件存储系统") // 可以用来描述整体的API
                .termsOfServiceUrl("http://nobibibi.top") // 用于定义服务的域名
                .version("1.0") // 可以用来定义版本。
                .build();
    }
}