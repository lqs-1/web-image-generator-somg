package com.somg.web.file.generator.cloud.storage.abs.support;

import com.somg.web.file.generator.cloud.storage.abs.FileStorageAbs;
import com.somg.web.file.generator.cloud.storage.abs.exception.FileBucketErrorException;
import com.somg.web.file.generator.cloud.storage.abs.exception.FileClearErrorException;
import com.somg.web.file.generator.cloud.storage.abs.exception.FileUploadErrorException;
import com.somg.web.file.generator.constant.Constant;
import com.somg.web.file.generator.constant.REnum;
import com.somg.web.file.generator.utils.R;
import io.minio.*;
import io.minio.messages.Bucket;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;
import java.util.stream.Collectors;

/**
 * @author somg
 * @date 2023/3/13 13:28
 * @do 一句话描述此模块的功能
 */
public class MinioFileStorageAbs extends FileStorageAbs {


    protected String endpoint;

    protected String username;

    protected String password;

    protected Long maxSize = 1024L * 1024L * 1024;



    /**
     * 创建客户端
     * @return
     */
    private MinioClient createMinioClient(){
        // 创建一个minio客户端
        MinioClient minioClient =
                MinioClient.builder()
                        .endpoint(this.endpoint) // minio的客户端接口
                        .credentials(this.username, this.password) // 用户名和密码
                        .build();
        return minioClient;
    }

    /**
     * 获取全部bucket
     */
    public List<Bucket> getAllBuckets(){
        try {
            return createMinioClient().listBuckets();
        } catch (Exception e) {
            e.printStackTrace();
            throw new FileBucketErrorException();
        }
    }


    /**
     * 判断bucket是否存在,不存在就创建
     * @param minioClient 客户端对象
     */
    public void bucketExist(MinioClient minioClient){

        try{
            // 是否存在haha这个bucket
            boolean found = minioClient.bucketExists(BucketExistsArgs.builder().bucket(this.bucketName).build());
            if (!found) {
                // 不存在就创建
                minioClient.makeBucket(MakeBucketArgs.builder().bucket(bucketName).build());
            }
        }catch (Exception e){
            e.printStackTrace();
            throw new FileBucketErrorException();
        }

    }


    public R singleFileUpload(MultipartFile file) {
        String uploadFileRealPath = generatorFileUploadPath(file.getOriginalFilename());

        try{
            // 创建minio客户端
            MinioClient minioClient = createMinioClient();

            // 判断bucket是否存在
            bucketExist(minioClient);

            // 上传文件
            minioClient.putObject(
                    PutObjectArgs.builder()
                            .bucket(this.bucketName)
                            .object(uploadFileRealPath)
                            .contentType(file.getContentType())
                            .stream(
                                    file.getInputStream(),
                                    -1,
                                    maxSize
                            )
                            .build()
            );
        }catch (FileBucketErrorException e){
            e.printStackTrace();
            return R.error(REnum.WEB_FILE_GENERATE_FAIL.getStatusCode(),
                    REnum.WEB_FILE_GENERATE_FAIL.getStatusMsg());
        }
        catch (Exception e){
            e.printStackTrace();
            return R.error(REnum.NETWORK_CONNECT_FAIL.getStatusCode(),
                    REnum.NETWORK_CONNECT_FAIL.getStatusMsg());
        }


        this.fullUrl = this.baseUrl + this.bucketName + "/" + uploadFileRealPath;

        return R.ok(REnum.WEB_FILE_GENERATE_SUCCESS.getStatusCode(),
                REnum.WEB_FILE_GENERATE_SUCCESS.getStatusMsg())
                .put(Constant.WEB_FILE_GENERATE_SINGLE_SUCCESS_RESPONSE_NAME, fullUrl);


    }

    public R multiFileUpload(List<MultipartFile> fileList){

        try{
            // 创建minio客户端
            MinioClient minioClient = createMinioClient();

            // 判断bucket是否存在
            bucketExist(minioClient);
            fullUrlList = fileList.stream().map(file -> {

                String uploadFileRealPath = generatorFileUploadPath(file.getOriginalFilename());

                // 上传文件
                try {
                    minioClient.putObject(
                            PutObjectArgs.builder()
                                    .bucket(this.bucketName)
                                    .object(uploadFileRealPath)
                                    .contentType(file.getContentType())
                                    .stream(
                                            file.getInputStream(),
                                            -1,
                                            maxSize
                                    )
                                    .build()
                    );
                } catch (Exception e) {
                    throw new FileUploadErrorException();
                }

                this.fullUrl = this.baseUrl + this.bucketName + "/" + uploadFileRealPath;
                return fullUrl;
            }).collect(Collectors.toList());

        }catch (FileBucketErrorException e){
        e.printStackTrace();
        return R.error(REnum.WEB_FILE_GENERATE_FAIL.getStatusCode(),
                REnum.WEB_FILE_GENERATE_FAIL.getStatusMsg());
        }catch (FileUploadErrorException e){
            e.printStackTrace();
            R.error(REnum.WEB_FILE_GENERATE_FAIL.getStatusCode(),
                    REnum.WEB_FILE_GENERATE_FAIL.getStatusMsg());
        }catch (Exception e){
            e.printStackTrace();
            return R.error(REnum.NETWORK_CONNECT_FAIL.getStatusCode(),
                    REnum.NETWORK_CONNECT_FAIL.getStatusMsg());
        }



        return R.ok(REnum.WEB_FILE_GENERATE_SUCCESS.getStatusCode(),
                        REnum.WEB_FILE_GENERATE_SUCCESS.getStatusMsg())
                .put(Constant.WEB_FILE_GENERATE_MULTI_SUCCESS_RESPONSE_NAME, fullUrlList);
    }

    public R singleFileClear(String fileUrl) {
        try{
            // 创建minio客户端
            MinioClient minioClient = createMinioClient();

            // 判断bucket是否存在
            bucketExist(minioClient);
            System.out.println(extractFileFullPath(fileUrl));


            // 删除文件
            minioClient.removeObject(RemoveObjectArgs.builder()
                    .bucket(this.bucketName)
                    .object(extractFileFullPath(fileUrl))
                    .build());
        }catch (Exception e){
            e.printStackTrace();
            return R.error(REnum.WEB_FILE_SINGLE_DELETE_FAIL.getStatusCode(),
                    REnum.WEB_FILE_SINGLE_DELETE_FAIL.getStatusMsg());
        }

        return R.ok(REnum.WEB_FILE_SINGLE_DELETE_SUCCESS.getStatusCode(), REnum.WEB_FILE_SINGLE_DELETE_SUCCESS.getStatusMsg());

    }

    public R batchFileClear(List<String> fileUrlList) {

        try{
            // 创建minio客户端
            MinioClient minioClient = createMinioClient();

            // 判断bucket是否存在
            bucketExist(minioClient);

            fileUrlList.stream().forEach(fileUrl -> {
                try {
                    minioClient.removeObject(RemoveObjectArgs.builder()
                            .bucket(this.bucketName)
                            .object(extractFileFullPath(fileUrl))
                            .build());
                } catch (Exception e) {
                    throw new FileClearErrorException();
                }
            });
        }catch (FileClearErrorException e){
            e.printStackTrace();
            return R.error(REnum.WEB_FILE_MULTI_DELETE_FAIL.getStatusCode(),
                    REnum.WEB_FILE_MULTI_DELETE_FAIL.getStatusMsg());
        }catch (Exception e){
            e.printStackTrace();
            return R.error(REnum.WEB_FILE_MULTI_DELETE_FAIL.getStatusCode(),
                    REnum.WEB_FILE_MULTI_DELETE_FAIL.getStatusMsg());
        }

        return R.ok(REnum.WEB_FILE_MULTI_DELETE_SUCCESS.getStatusCode(),
                REnum.WEB_FILE_MULTI_DELETE_SUCCESS.getStatusMsg());
    }


    protected String extractFileFullPath(String fileUrl) {
        return super.extractFileFullPath(fileUrl).replace(this.bucketName + "/", "");
    }
}
