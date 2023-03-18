package com.somg.web.file.generator.cloud.storage.abs.utils;

import com.somg.web.file.generator.cloud.storage.abs.support.QiniuFileStorageAbs;
import com.somg.web.file.generator.utils.R;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

/**
 * @author somg
 * @date 2023/3/8 15:45
 * @do 一句话描述此模块的功能
 */


public class QiniuFileStorage extends QiniuFileStorageAbs {


    private QiniuFileStorage(QiniuFileStorageBuilder qiniuFileStorageBuilder){
        this.accessKey = qiniuFileStorageBuilder.accessKey;
        this.accessSecretKey = qiniuFileStorageBuilder.accessSecretKey;
        this.baseUrl = qiniuFileStorageBuilder.baseUrl;
        this.bucketName = qiniuFileStorageBuilder.bucketName;
        this.type = qiniuFileStorageBuilder.type;

    }

    public R singleFileUpload(MultipartFile file) {
        return super.singleFileUpload(file);
    }


    public R multiFileUpload(List<MultipartFile> fileList) {
        return super.multiFileUpload(fileList);
    }

    public R singleFileClear(String fileUrl) {
        return super.singleFileClear(fileUrl);
    }

    public R batchFileClear(List<String> fileUrlList) {
        return super.batchFileClear(fileUrlList);
    }


    public static class QiniuFileStorageBuilder{

        private String accessKey;

        private String accessSecretKey;

        private String bucketName;

        private String baseUrl;

        private String type;

        public QiniuFileStorageBuilder(String accessKey, String accessSecretKey){
            this.accessKey = accessKey;
            this.accessSecretKey = accessSecretKey;
        }

        public QiniuFileStorageBuilder bucket(String bucketName){
            this.bucketName = bucketName;
            return this;
        }

        public QiniuFileStorageBuilder baseUrl(String baseUrl){
            this.baseUrl = baseUrl;
            return this;
        }

        public QiniuFileStorageBuilder type(String type){
            this.type = type;
            return this;
        }

        public QiniuFileStorage build(){
            return new QiniuFileStorage(this);
        }


    }


}
