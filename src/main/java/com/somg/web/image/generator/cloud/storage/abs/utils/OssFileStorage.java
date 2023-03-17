package com.somg.web.image.generator.cloud.storage.abs.utils;

import com.aliyun.oss.OSS;
import com.somg.web.image.generator.cloud.storage.abs.support.OssFileStorageAbs;
import com.somg.web.image.generator.utils.R;

import com.sun.istack.NotNull;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

/**
 * @author somg
 * @date 2023/3/7 12:41
 * @do 一句话描述此模块的功能
 */
public class OssFileStorage extends OssFileStorageAbs {


    /**
     * 构造存储参数
     * @param ossFileStorageBuilder 构建者参数
     */
    private OssFileStorage(OssFileStorageBuilder ossFileStorageBuilder){
        this.ossClient = ossFileStorageBuilder.ossClient;
        this.bucketName = ossFileStorageBuilder.bucketName;
        this.type = ossFileStorageBuilder.type;
        this.baseUrl = ossFileStorageBuilder.baseUrl;
    }


    /**
     * 单个文件上传
     * @param file 要上传的文件对象
     * @return
     */
    public R singleFileUpload(@NotNull MultipartFile file) {
        return super.singleFileUpload(file);
    }


    /**
     * 批量文件上传
     * @param fileList 要上传的所有文件列表
     * @return
     */
    public R multiFileUpload(@NotNull List<MultipartFile> fileList) {
        return super.multiFileUpload(fileList);
    }


    /**
     * 单个文件删除
     * @param fileUrl 要被删除文件的url
     * @return
     */
    public R singleFileClear(@NotNull String fileUrl) {
        return super.singleFileClear(fileUrl);
    }


    /**
     * 批量文件删除
     * @param fileUrlList 要被删除的文件url列表
     * @return
     */
    public R batchFileClear(List<String> fileUrlList) {
        return super.batchFileClear(fileUrlList);
    }


    /**
     * 使用建造这模式
     */
    public static class OssFileStorageBuilder{

        private OSS ossClient;

        private String bucketName;

        private String type;

        private String baseUrl;


        /**
         * 构建简介对象
         * @param ossClient oss连接对象
         */
        public OssFileStorageBuilder(@NotNull OSS ossClient){
            this.ossClient = ossClient;
        }

        /**
         * 构建存储仓库
         * @param bucketName 存储仓库
         * @return
         */
        public OssFileStorageBuilder bucket(@NotNull String bucketName){
            this.bucketName = bucketName;
            return this;
        }

        /**
         * 构建存储文件夹
         * @param type 文件存储的文件夹，没有的话会自动创建
         * @return
         */
        public OssFileStorageBuilder type(@NotNull String type){
            this.type = type;
            return this;
        }

        /**
         * 构建url前缀
         * @param baseUrl url前缀
         * @return
         */
        public OssFileStorageBuilder baseUrl(@NotNull String baseUrl){
            this.baseUrl = baseUrl;
            return this;
        }

        /**
         * 构建Oss存储对象
         * @return
         */
        public OssFileStorage build(){
            return new OssFileStorage(this);
        }


    }

}
