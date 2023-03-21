package com.somg.web.file.generator.cloud.storage.abs.auto;

import com.aliyun.oss.OSS;
import lombok.Data;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

/**
 * @author somg
 * @date 2023/3/13 21:37
 * @do 文件上传对象可以根据配置自动选择用什么文件存储的配置属性 强壮版
 */

@Component
@ConfigurationProperties(prefix = "spring.somg.upload.plus")
@Data
public class UploadPlusProperties {


    @Autowired(required = false)
    private OSS ossClient;

    private String type = "oss";

    private String fileType;

    private String bucketName;

    private String baseUrl;

    private String qiniuAccessKey;

    private String qiniuAccessSecretKey;

    private String minioUserName;

    private String minioPassWord;


}
