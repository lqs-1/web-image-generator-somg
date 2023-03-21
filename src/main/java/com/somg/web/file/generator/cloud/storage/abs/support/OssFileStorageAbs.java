package com.somg.web.file.generator.cloud.storage.abs.support;

import com.aliyun.oss.OSS;
import com.aliyun.oss.common.comm.ResponseMessage;
import com.aliyun.oss.model.PutObjectResult;
import com.somg.web.file.generator.cloud.storage.abs.FileStorageAbs;
import com.somg.web.file.generator.cloud.storage.abs.exception.FileUploadErrorException;
import com.somg.web.file.generator.constant.Constant;
import com.somg.web.file.generator.constant.REnum;
import com.somg.web.file.generator.utils.R;
import com.sun.istack.NotNull;
import org.springframework.web.multipart.MultipartFile;
import java.io.IOException;
import java.util.List;
import java.util.stream.Collectors;


/**
 * @author somg
 * @date 2023/3/1 13:16
 * @do aliyunOss文件存储抽象类
 */

public abstract class OssFileStorageAbs extends FileStorageAbs {


    // oss客户端
    protected OSS ossClient;

    /**
     * 单个文件上传
     * @param file 要上传的文件对象
     * @return
     */
    public R singleFileUpload(@NotNull MultipartFile file){

        String uploadFileRealPath = generatorFileUploadPath(file.getOriginalFilename());

        // 上传文件
        try{
            PutObjectResult putObjectResult = ossClient.putObject(bucketName, uploadFileRealPath, file.getInputStream());
            ResponseMessage response = putObjectResult.getResponse();

            // System.out.println(response);
            if(response == null){
                // 上传成功
                this.fullUrl = baseUrl + uploadFileRealPath;

                return R.ok(REnum.WEB_FILE_GENERATE_SUCCESS.getStatusCode(),
                                REnum.WEB_FILE_GENERATE_SUCCESS.getStatusMsg())
                        .put(Constant.WEB_FILE_GENERATE_SINGLE_SUCCESS_RESPONSE_NAME, this.fullUrl);
            }else {

                return R.error(REnum.WEB_FILE_GENERATE_FAIL.getStatusCode(),
                        REnum.WEB_FILE_GENERATE_FAIL.getStatusMsg());
            }

        } catch (Exception e){
            e.printStackTrace();
            return R.error(REnum.NETWORK_CONNECT_FAIL.getStatusCode(),
                    REnum.NETWORK_CONNECT_FAIL.getStatusMsg());
        }finally {
            // ossClient.shutdown();
        }

    }


    /**
     * 批量文件上传
     * @param fileList 要上传的所有文件列表
     * @return
     */
    public R multiFileUpload(@NotNull List<MultipartFile> fileList){

        try{
            this.fullUrlList = fileList.stream()
                    .map(file -> {
                        String uploadFileRealPath = generatorFileUploadPath(file.getOriginalFilename());

                        PutObjectResult putObjectResult = null;
                        try {
                            putObjectResult = ossClient.putObject(bucketName, uploadFileRealPath, file.getInputStream());
                        } catch (IOException e) {
                            throw new FileUploadErrorException();
                        }

                        ResponseMessage response = putObjectResult.getResponse();
                        if (response == null) {
                            // 上传成功
                            return this.baseUrl + uploadFileRealPath;
                        } else {
                            throw new FileUploadErrorException();
                        }

                    }).collect(Collectors.toList());
        }catch (FileUploadErrorException fileUploadErrorException){
            fileUploadErrorException.printStackTrace();
            return R.error(REnum.WEB_FILE_GENERATE_FAIL.getStatusCode(),
                    REnum.WEB_FILE_GENERATE_FAIL.getStatusMsg());
        } catch (Exception e){
            e.printStackTrace();
            return R.error(REnum.WEB_FILE_GENERATE_FAIL.getStatusCode(),
                    REnum.WEB_FILE_GENERATE_FAIL.getStatusMsg());
        }

        return R.ok(REnum.WEB_FILE_GENERATE_SUCCESS.getStatusCode(),
                        REnum.WEB_FILE_GENERATE_SUCCESS.getStatusMsg())
                .put(Constant.WEB_FILE_GENERATE_MULTI_SUCCESS_RESPONSE_NAME, this.fullUrlList);


    }



    /**
     * 单个文件删除
     * @param fileUrl 要被删除文件的url
     * @return
     */
    public R singleFileClear(@NotNull String fileUrl){


        try {
            // 删除文件请求
            ossClient.deleteObject(bucketName, extractFileFullPath(fileUrl));
            return R.ok(REnum.WEB_FILE_SINGLE_DELETE_SUCCESS.getStatusCode(),
                    REnum.WEB_FILE_SINGLE_DELETE_SUCCESS.getStatusMsg());
        } catch (Exception e) {
            e.printStackTrace();
            return R.error(REnum.WEB_FILE_SINGLE_DELETE_FAIL.getStatusCode(),
                    REnum.WEB_FILE_SINGLE_DELETE_FAIL.getStatusMsg());
        } finally {
            if (ossClient != null) {
                // ossClient.shutdown();
            }
        }


    }


    /**
     * 批量删除文件
     * @param fileUrlList 要被删除的文件url列表
     * @return
     */
    public R batchFileClear(@NotNull List<String> fileUrlList){

        try{
            fileUrlList.stream().map(fileUrl ->
                    extractFileFullPath(fileUrl)
            ).forEach(deleteUrl -> {
                ossClient.deleteObject(this.bucketName, deleteUrl);
            });
        }catch (Exception e){
            e.printStackTrace();
            return R.error(REnum.WEB_FILE_MULTI_DELETE_FAIL.getStatusCode(),
                    REnum.WEB_FILE_MULTI_DELETE_FAIL.getStatusMsg());
        }finally {
            if (ossClient != null) {
                // ossClient.shutdown();
            }
        }

        return R.ok(REnum.WEB_FILE_MULTI_DELETE_SUCCESS.getStatusCode(),
                REnum.WEB_FILE_MULTI_DELETE_SUCCESS.getStatusMsg());

    }

}
