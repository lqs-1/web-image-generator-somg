package com.somg.web.file.generator.cloud.storage.abs.utils;

import com.somg.web.file.generator.cloud.storage.abs.support.MinioFileStorageAbs;
import com.somg.web.file.generator.utils.R;
import com.sun.istack.NotNull;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

/**
 * @author somg
 * @date 2023/3/13 17:12
 * @do 一句话描述此模块的功能
 */
public class MinioFileStorage extends MinioFileStorageAbs {


    private MinioFileStorage(MinioFileStorageBuilder minioFileStorageBuilder){
        this.password = minioFileStorageBuilder.password;
        this.username = minioFileStorageBuilder.username;
        this.bucketName = minioFileStorageBuilder.bucket;
        this.endpoint = minioFileStorageBuilder.endpoint;
        this.type = minioFileStorageBuilder.type;
        this.baseUrl = minioFileStorageBuilder.baseUrl;
    }


    public R singleFileUpload(MultipartFile file){
        return super.singleFileUpload(file);
    }


    @Override
    public R multiFileUpload(List<MultipartFile> fileList){
        return super.multiFileUpload(fileList);
    }


    @Override
    public R singleFileClear(String fileUrl){
        return super.singleFileClear(fileUrl);
    }


    @Override
    public R batchFileClear(List<String> fileUrlList) {
        return super.batchFileClear(fileUrlList);
    }

    /**
     * 使用建造这模式
     */
    public static class MinioFileStorageBuilder{

        private String endpoint;
        private String username;
        private String password;
        private String bucket;;
        private String type;
        private String baseUrl;


        /**
         * 构建简介对象
         * @param
         */
        public MinioFileStorageBuilder(@NotNull String endpoint, @NotNull String username, @NotNull String password){
            this.endpoint = endpoint;
            this.username = username;
            this.password = password;
        }

        /**
         * 构建存储仓库
         * @param bucketName 存储仓库
         * @return
         */
        public MinioFileStorageBuilder bucket(@NotNull String bucketName){
            this.bucket = bucketName;
            return this;
        }

        public MinioFileStorageBuilder type(@NotNull String type){
            this.type = type;
            return this;
        }

        public MinioFileStorageBuilder baseUrl(@NotNull String baseUrl){
            this.baseUrl = baseUrl;
            return this;
        }



        public MinioFileStorage build(){
            return new MinioFileStorage(this);
        }


    }




}
