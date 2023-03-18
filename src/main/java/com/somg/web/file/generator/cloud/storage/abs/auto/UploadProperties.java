package com.somg.web.file.generator.cloud.storage.abs.auto;

import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

/**
 * @author somg
 * @date 2023/3/9 8:31
 * @do 一句话描述此模块的功能
 */

@Component
@ConfigurationProperties(prefix = "spring.somg.upload")
@Data
public class UploadProperties {


    private String type = "oss";

    private String fileType;

}
