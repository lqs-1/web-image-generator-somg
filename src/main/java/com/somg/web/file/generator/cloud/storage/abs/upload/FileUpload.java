package com.somg.web.file.generator.cloud.storage.abs.upload;

import com.somg.web.file.generator.cloud.storage.abs.FileStorageAbs;
import com.somg.web.file.generator.cloud.storage.abs.auto.*;
import com.somg.web.file.generator.cloud.storage.abs.exception.FileUploadClientConfigException;
import com.somg.web.file.generator.cloud.storage.abs.utils.MinioFileStorage;
import com.somg.web.file.generator.cloud.storage.abs.utils.OssFileStorage;
import com.somg.web.file.generator.cloud.storage.abs.utils.QiniuFileStorage;
import lombok.Data;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;


import java.util.Arrays;

/**
 * @author somg
 * @date 2023/3/9 8:17
 * @do 文件上传对象可以根据配置自动选择用什么文件存储 丐版
 */

@Component
@Data
public class FileUpload {


    @Autowired(required = false)
    private UploadProperties uploadProperties;

    @Autowired(required = false)
    private QiniuProperties qiniuProperties;

    @Autowired(required = false)
    private OssProperties ossProperties;

    @Autowired(required = false)
    private MinioProperties minioProperties;


    // 用户可以在使用工具的时候自定义上传到什么文件夹 如若文件夹不存在 是可以自动创建的
    protected String fileType = "";


    /**
     * 构建文件存储对象
     * @param fileTypes
     * @return
     */
    public FileStorageAbs build(String... fileTypes){

        if (fileTypes.length > 0) structureFileType(fileTypes);

        if (uploadProperties.getType().equals("qiniu")){
            return new QiniuFileStorage
                    .QiniuFileStorageBuilder(qiniuProperties.getAccessKey(), qiniuProperties.getAccessSecretKey())
                    .bucket(qiniuProperties.getBucketName())
                    .baseUrl(qiniuProperties.getBaseUrl())
                    .type(fileType.isEmpty() ? qiniuProperties.getType() : fileType)
                    .build();
        } else if (uploadProperties.getType().equals("oss")) {
            return new OssFileStorage
                    .OssFileStorageBuilder(ossProperties.getOssClient())
                    .baseUrl(ossProperties.getBaseUrl())
                    .bucket(ossProperties.getBucketName())
                    .type(fileType.isEmpty() ? ossProperties.getType() : fileType)
                    .build();
        } else if (uploadProperties.getType().equals("minio")) {
            return new MinioFileStorage
                    .MinioFileStorageBuilder(
                            minioProperties.getEndpoint(),
                            minioProperties.getUserName(),
                            minioProperties.getPassWord())
                    .bucket(minioProperties.getBucketName())
                    .type(fileType.isEmpty() ? minioProperties.getType() : fileType)
                    .baseUrl(minioProperties.getBaseUrl())
                    .build();
        } else {
            throw new FileUploadClientConfigException(uploadProperties.getType());
        }

    }


    /**
     * 根据用户传递的上传文件夹的参数来拼接完整的文件夹路径
     * @param fileTypes
     */
    protected void structureFileType(String... fileTypes){

        StringBuffer stringBuffer = new StringBuffer();

        Arrays.stream(fileTypes).forEach(item -> {
            stringBuffer.append(item);
            stringBuffer.append("/");
        });

        this.fileType = stringBuffer.toString().substring(0, stringBuffer.toString().length() - 1);

    }



}
