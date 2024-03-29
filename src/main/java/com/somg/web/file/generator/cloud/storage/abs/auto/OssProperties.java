package com.somg.web.file.generator.cloud.storage.abs.auto;

import com.aliyun.oss.OSS;
import lombok.Data;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

/**
 * @author somg
 * @date 2023/3/7 13:10
 * @do 使用Oss作为存储的配置对象
 */

@Component
@ConfigurationProperties(prefix = "oss.somg")
@Data
public class OssProperties {

    @Autowired(required = false)
    private OSS ossClient;

    private String bucketName;

    private String baseUrl;

    private String type;

}
