package com.somg.web.file.generator.cloud.storage.abs.auto;

import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

/**
 * @author somg
 * @date 2023/3/9 8:31
 * @do 文件上传对象可以根据配置自动选择用什么文件存储的配置属性 丐版
 */

@Component
@ConfigurationProperties(prefix = "spring.somg.upload")
@Data
public class UploadProperties {


    private String type = "oss";

    private String fileType;

}
