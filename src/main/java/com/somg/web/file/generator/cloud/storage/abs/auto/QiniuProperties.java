package com.somg.web.file.generator.cloud.storage.abs.auto;

import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

/**
 * @author somg
 * @date 2023/3/8 13:40
 * @do 一句话描述此模块的功能
 */

@Data
@Component
@ConfigurationProperties(prefix = "qiniu.somg")
public class QiniuProperties {

    private String accessKey;

    private String accessSecretKey;

    private String bucketName;

    private String baseUrl;

    private String type;

}
