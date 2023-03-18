package com.somg.web.file.generator.cloud.storage.abs.auto;

import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

/**
 * @author somg
 * @date 2023/3/13 12:57
 * @do 一句话描述此模块的功能
 */

@Data
@Component
@ConfigurationProperties(prefix = "minio.somg")
public class MinioProperties {

    private String endpoint = "http://127.0.0.1:9000";
    private String baseUrl = "http://127.0.0.1:9001";
    private String userName = "minioadmin";
    private String passWord = "minioadmin";
    private String bucketName;
    private String type;


}
