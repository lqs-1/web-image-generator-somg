package com.somg.web.file.generator.cloud.storage.abs.utils;

import com.somg.web.file.generator.cloud.storage.abs.support.MinioFileStorageAbs;
import com.somg.web.file.generator.cloud.storage.abs.utils.result.LocalFileResult;
import com.somg.web.file.generator.cloud.storage.abs.utils.result.ScaleResult;
import com.somg.web.file.generator.utils.R;
import com.sun.istack.NotNull;
import org.springframework.web.multipart.MultipartFile;

import java.io.InputStream;
import java.util.List;

/**
 * @author somg
 * @date 2023/3/13 17:12
 * @do Minio存储对象具体构建
 */
public class MinioFileStorage extends MinioFileStorageAbs {


    /**
     * 私有构造器
     * @param minioFileStorageBuilder
     */
    private MinioFileStorage(MinioFileStorageBuilder minioFileStorageBuilder){
        this.password = minioFileStorageBuilder.password;
        this.username = minioFileStorageBuilder.username;
        this.bucketName = minioFileStorageBuilder.bucket;
        this.endpoint = minioFileStorageBuilder.endpoint;
        this.type = minioFileStorageBuilder.type;
        this.baseUrl = minioFileStorageBuilder.baseUrl;
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


    /**
     *
     * @param imageInputStream 图片的inputStream
     * @param uploadFileRealPath 图片要上传的路径 [originFileName]
     * @param scale 放大或者缩小 <1表示缩小 >1表示放大
     * @return
     */
    @Override
    public ScaleResult imageScale(InputStream imageInputStream, String uploadFileRealPath, Float scale) {
        return super.imageScale(imageInputStream, uploadFileRealPath, scale);
    }

    /**
     *
     * @param imageInputStream 图片的inputStream
     * @param uploadFileRealPath 图片要上传的路径 [originFileName]
     * @return
     */
    @Override
    public LocalFileResult imageLocalUp(InputStream imageInputStream, String uploadFileRealPath) {
        return super.imageLocalUp(imageInputStream, uploadFileRealPath);
    }

    /**
     * 使用建造这模式
     */
    public static class MinioFileStorageBuilder{

        // url前缀和上传地址
        private String endpoint;
        // username
        private String username;
        // passwordd
        private String password;
        // 储存桶
        private String bucket;;
        // 要上传到的文件夹
        private String type;
        // url前缀和上传地址
        private String baseUrl;


        /**
         * 构建连接对象
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

        /**
         * 构建type参数
         * @param type
         * @return
         */
        public MinioFileStorageBuilder type(@NotNull String type){
            this.type = type;
            return this;
        }

        /**
         * 构建baseUrl参数
         * @param baseUrl
         * @return
         */
        public MinioFileStorageBuilder baseUrl(@NotNull String baseUrl){
            this.baseUrl = baseUrl;
            return this;
        }

        /**
         * 构建对象
         * @return
         */
        public MinioFileStorage build(){
            return new MinioFileStorage(this);
        }


    }




}
