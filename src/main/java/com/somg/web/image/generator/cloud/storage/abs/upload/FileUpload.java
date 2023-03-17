package com.somg.web.image.generator.cloud.storage.abs.upload;

import com.somg.web.image.generator.cloud.storage.abs.FileStorageAbs;
import com.somg.web.image.generator.cloud.storage.abs.auto.*;
import com.somg.web.image.generator.cloud.storage.abs.exception.FileUploadClientConfigException;
import com.somg.web.image.generator.cloud.storage.abs.utils.MinioFileStorage;
import com.somg.web.image.generator.cloud.storage.abs.utils.OssFileStorage;
import com.somg.web.image.generator.cloud.storage.abs.utils.QiniuFileStorage;
import lombok.Data;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;


import java.util.Arrays;

/**
 * @author somg
 * @date 2023/3/9 8:17
 * @do 一句话描述此模块的功能
 */

@Component
@Data
public class FileUpload {

    @Autowired(required = false)
    protected UploadPlusProperties uploadPlusProperties;

    @Autowired(required = false)
    private UploadProperties uploadProperties;

    @Autowired(required = false)
    private QiniuProperties qiniuProperties;

    @Autowired(required = false)
    private OssProperties ossProperties;

    @Autowired(required = false)
    private MinioProperties minioProperties;


    protected String fileType = "";


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



    protected void structureFileType(String... fileTypes){

        StringBuffer stringBuffer = new StringBuffer();

        Arrays.stream(fileTypes).forEach(item -> {
            stringBuffer.append(item);
            stringBuffer.append("/");
        });

        this.fileType = stringBuffer.toString().substring(0, stringBuffer.toString().length() - 1);

    }



}
