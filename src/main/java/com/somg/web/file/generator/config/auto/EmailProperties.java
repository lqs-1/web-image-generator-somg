package com.somg.web.file.generator.config.auto;

import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

/**
 * @author somg
 * @date 2023/4/15 17:10
 * @do 发送邮件的配置属性
 */

@Data
@Component
@ConfigurationProperties(prefix = "email.somg")
public class EmailProperties {

    private String formEmail = "749062870@qq.com"; // 发送邮件的邮箱

    private String formEmailNickName = "somg在线工具"; // 发送邮件的邮箱的昵称

    private String subject = "somg在线工具验证码"; // 发送邮件的主题

    private String sendValidateCodeContentPrefix = "尊敬的用户你本次的验证码为:"; // 邮件内容前缀 非HTML邮件使用

    private Long expireTime = 300l; // 默认过期时间

    private String cacheKeyPrefix = "somgEmail:"; // 缓存默认前缀



}
