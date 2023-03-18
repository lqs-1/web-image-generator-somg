package com.somg.web.file.generator.cloud.storage.abs.upload;

import com.somg.web.file.generator.cloud.storage.abs.FileStorageAbs;
import com.somg.web.file.generator.cloud.storage.abs.exception.FileUploadClientConfigException;
import com.somg.web.file.generator.cloud.storage.abs.utils.MinioFileStorage;
import com.somg.web.file.generator.cloud.storage.abs.utils.OssFileStorage;
import com.somg.web.file.generator.cloud.storage.abs.utils.QiniuFileStorage;
import com.sun.istack.NotNull;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

/**
 * @author somg
 * @date 2023/3/13 21:38
 * @do 一句话描述此模块的功能
 */

@Component
public class FileUploadPlus extends FileUpload{


    @Override
    public FileStorageAbs build(String... fileTypes) {

        if (fileTypes.length > 0) structureFileType(fileTypes);

        if (uploadPlusProperties.getType().equals("qiniu")){
            return new QiniuFileStorage
                    .QiniuFileStorageBuilder(uploadPlusProperties.getQiniuAccessKey(), uploadPlusProperties.getQiniuAccessSecretKey())
                    .bucket(uploadPlusProperties.getBucketName())
                    .baseUrl(uploadPlusProperties.getBaseUrl())
                    .type(fileType.isEmpty() ? uploadPlusProperties.getFileType() : fileType)
                    .build();
        } else if (uploadPlusProperties.getType().equals("oss")) {
            return new OssFileStorage
                    .OssFileStorageBuilder(uploadPlusProperties.getOssClient())
                    .baseUrl(uploadPlusProperties.getBaseUrl())
                    .bucket(uploadPlusProperties.getBucketName())
                    .type(fileType.isEmpty() ? uploadPlusProperties.getFileType() : fileType)
                    .build();
        } else if (uploadPlusProperties.getType().equals("minio")) {
            return new MinioFileStorage
                    .MinioFileStorageBuilder(
                    uploadPlusProperties.getBaseUrl(),
                    uploadPlusProperties.getMinioUserName(),
                    uploadPlusProperties.getMinioPassWord())
                    .bucket(uploadPlusProperties.getBucketName())
                    .type(fileType.isEmpty() ? uploadPlusProperties.getFileType() : fileType)
                    .baseUrl(uploadPlusProperties.getBaseUrl())
                    .build();
        } else {
            throw new FileUploadClientConfigException(uploadPlusProperties.getType());
        }
    }


    public FileStorageAbs buildImg(@NotNull MultipartFile image, String... fileTypes){
//        FileStorageAbs fileUpload = this.build(fileTypes);
//        InputStream inputStream = fileUpload.imageCompression(image.getInputStream(),fileUpload.generatorFileUploadPath(image.getOriginalFilename()));
        return null;
    }

    public FileStorageAbs buildImg(@NotNull List<MultipartFile> images, String... fileTypes){
        return null;
    }


}
