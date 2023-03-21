package com.somg.web.file.generator.cloud.storage.abs.utils;

import com.somg.web.file.generator.cloud.storage.abs.support.QiniuFileStorageAbs;
import com.somg.web.file.generator.utils.R;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

/**
 * @author somg
 * @date 2023/3/8 15:45
 * @do QiNiu存储对象具体构建
 */


public class QiniuFileStorage extends QiniuFileStorageAbs {


    /**
     * 私有构造器
     * @param qiniuFileStorageBuilder
     */
    private QiniuFileStorage(QiniuFileStorageBuilder qiniuFileStorageBuilder){
        this.accessKey = qiniuFileStorageBuilder.accessKey;
        this.accessSecretKey = qiniuFileStorageBuilder.accessSecretKey;
        this.baseUrl = qiniuFileStorageBuilder.baseUrl;
        this.bucketName = qiniuFileStorageBuilder.bucketName;
        this.type = qiniuFileStorageBuilder.type;

    }

    /**
     * 单文件上传
     * @param file 要上传的文件对象
     * @return
     */
    public R singleFileUpload(MultipartFile file){
        return super.singleFileUpload(file);
    }


    /**
     * 批量文件上传
     * @param fileList 要上传的所有文件列表
     * @return
     */
    @Override
    public R multiFileUpload(List<MultipartFile> fileList){
        return super.multiFileUpload(fileList);
    }


    /**
     * 单文件删除
     * @param fileUrl 要被删除文件的url
     * @return
     */
    @Override
    public R singleFileClear(String fileUrl){
        return super.singleFileClear(fileUrl);
    }


    /**
     * 批量文件删除
     * @param fileUrlList 要被删除的文件url列表
     * @return
     */
    @Override
    public R batchFileClear(List<String> fileUrlList) {
        return super.batchFileClear(fileUrlList);
    }

    public static class QiniuFileStorageBuilder{

        // username
        private String accessKey;

        // password
        private String accessSecretKey;

        // 存储桶
        private String bucketName;

        // url前缀和上传地址
        private String baseUrl;

        // 上传文件夹
        private String type;

        /**
         * 构建连接对象
         * @param accessKey
         * @param accessSecretKey
         */
        public QiniuFileStorageBuilder(String accessKey, String accessSecretKey){
            this.accessKey = accessKey;
            this.accessSecretKey = accessSecretKey;
        }

        /**
         * 构建桶参数
         * @param bucketName
         * @return
         */
        public QiniuFileStorageBuilder bucket(String bucketName){
            this.bucketName = bucketName;
            return this;
        }

        /**
         * 构建baseUrl参数
         * @param baseUrl
         * @return
         */
        public QiniuFileStorageBuilder baseUrl(String baseUrl){
            this.baseUrl = baseUrl;
            return this;
        }

        /**
         * 构建上传文件夹参数
         * @param type
         * @return
         */
        public QiniuFileStorageBuilder type(String type){
            this.type = type;
            return this;
        }

        /**
         * 构建对象
         * @return
         */
        public QiniuFileStorage build(){
            return new QiniuFileStorage(this);
        }


    }


}
