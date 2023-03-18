package com.somg.web.file.generator.cloud.storage.abs.support;

import com.qiniu.common.QiniuException;
import com.qiniu.http.Response;
import com.qiniu.storage.BucketManager;
import com.qiniu.storage.Configuration;
import com.qiniu.storage.Region;
import com.qiniu.storage.UploadManager;
import com.qiniu.util.Auth;
import com.somg.web.file.generator.cloud.storage.abs.FileStorageAbs;
import com.somg.web.file.generator.cloud.storage.abs.exception.FileClearErrorException;
import com.somg.web.file.generator.cloud.storage.abs.exception.FileUploadErrorException;
import com.somg.web.file.generator.cloud.storage.abs.support.prop.QiniuConnect;
import com.somg.web.file.generator.utils.R;
import com.somg.web.file.generator.constant.Constant;
import com.somg.web.file.generator.constant.REnum;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.List;
import java.util.stream.Collectors;


/**
 * @author somg
 * @date 2023/3/8 13:07
 * @do 一句话描述此模块的功能
 */
public abstract class QiniuFileStorageAbs extends FileStorageAbs {

    protected String accessKey;

    protected String accessSecretKey;


    private QiniuConnect structureQiniuConnector(){
        // Region.huadong(根据自己的对象空间的地址选) 这个是地区代码 可以看文档
        Configuration cfg = new Configuration(Region.huadong());
        UploadManager uploadManager = new UploadManager(cfg);



        // 获取七牛云提供的 token
        Auth auth = Auth.create(accessKey, accessSecretKey);
        String upToken = auth.uploadToken(bucketName);

        // 获取桶的操作
        BucketManager bucketManager = new BucketManager(auth, cfg);

        return new QiniuConnect(uploadManager, bucketManager, upToken);
    }

    public R singleFileUpload(MultipartFile file) {
        String uploadFileRealPath = generatorFileUploadPath(file.getOriginalFilename());
        try{
            // 获取文件上传的流
            // byte[] fileBytes = file.getBytes();

            QiniuConnect qiniuConnect = structureQiniuConnector();


            Response response = qiniuConnect.getUploadManager().put(file.getInputStream(), uploadFileRealPath, qiniuConnect.getUpToken(), null, null);

            if (response.statusCode == 200) {

                this.fullUrl = this.baseUrl + uploadFileRealPath;

                return R.ok(REnum.WEB_FILE_GENERATE_SUCCESS.getStatusCode(),
                                REnum.WEB_FILE_GENERATE_SUCCESS.getStatusMsg())
                        .put(Constant.WEB_FILE_GENERATE_SINGLE_SUCCESS_RESPONSE_NAME, this.fullUrl);
            }

            return R.error(REnum.WEB_FILE_GENERATE_FAIL.getStatusCode(),
                    REnum.WEB_FILE_GENERATE_FAIL.getStatusMsg());


        }catch (Exception e){

            e.printStackTrace();
            return R.error(REnum.WEB_FILE_GENERATE_FAIL.getStatusCode(),
                    REnum.WEB_FILE_GENERATE_FAIL.getStatusMsg());
        }

    }


    public R multiFileUpload(List<MultipartFile> fileList){

        try{
            this.fullUrlList = fileList.stream().map(file -> {
                String uploadFileRealPath = generatorFileUploadPath(file.getOriginalFilename());

//                byte[] fileBytes = new byte[0];
//                try {
//                    fileBytes = file.getBytes();
//                } catch (IOException e) {
//                    throw new FileUploadErrorException();
//                }

                QiniuConnect qiniuConnect = structureQiniuConnector();


                Response response = null;
                try {

                    response = qiniuConnect.getUploadManager().put(file.getInputStream(), uploadFileRealPath, qiniuConnect.getUpToken(), null, null);
                } catch (QiniuException e) {
                    throw new FileUploadErrorException();
                } catch (IOException e) {
                    throw new FileUploadErrorException();
                }

                if (response.statusCode != 200) {
                    throw new FileUploadErrorException();
                }

                this.fullUrl = this.baseUrl + uploadFileRealPath;

                return fullUrl;

            }).collect(Collectors.toList());
        }catch (Exception e){

            e.printStackTrace();
            return R.error(REnum.WEB_FILE_GENERATE_FAIL.getStatusCode(),
                    REnum.WEB_FILE_GENERATE_FAIL.getStatusMsg());
        }


        return R.ok(REnum.WEB_FILE_GENERATE_SUCCESS.getStatusCode(),
                        REnum.WEB_FILE_GENERATE_SUCCESS.getStatusMsg())
                .put(Constant.WEB_FILE_GENERATE_MULTI_SUCCESS_RESPONSE_NAME, this.fullUrlList);
    }



    public R singleFileClear(String fileUrl) {

        QiniuConnect qiniuConnect = structureQiniuConnector();

        try {
            // 删除文件请求
            Response response = qiniuConnect.getBucketManager().delete(this.bucketName, extractFileFullPath(fileUrl));
            if (response.statusCode == 200){
                return R.ok(REnum.WEB_FILE_SINGLE_DELETE_SUCCESS.getStatusCode(),
                        REnum.WEB_FILE_SINGLE_DELETE_SUCCESS.getStatusMsg());
            }
            return R.ok(REnum.WEB_FILE_SINGLE_DELETE_FAIL.getStatusCode(),
                    REnum.WEB_FILE_SINGLE_DELETE_FAIL.getStatusMsg());
        } catch (Exception e) {
            e.printStackTrace();
            return R.error(REnum.WEB_FILE_SINGLE_DELETE_FAIL.getStatusCode(),
                    REnum.WEB_FILE_SINGLE_DELETE_FAIL.getStatusMsg());
        }

    }


    public R batchFileClear(List<String> fileUrlList) {

        try{
            fileUrlList.stream()
                    .map(file ->extractFileFullPath(file))
                    .forEach(deleteUrl -> {
                        Response response = null;
                        try {
                            response = structureQiniuConnector().getBucketManager().delete(this.bucketName, deleteUrl);
                        } catch (QiniuException e) {
                            throw new FileClearErrorException();
                        }

                        if (response.statusCode != 200) {
                            throw new FileClearErrorException();
                        }
                    });
        }catch (Exception e){
            e.printStackTrace();
            return R.error(REnum.WEB_FILE_MULTI_DELETE_FAIL.getStatusCode(),
                    REnum.WEB_FILE_MULTI_DELETE_FAIL.getStatusMsg());
        }



        return R.ok(REnum.WEB_FILE_MULTI_DELETE_SUCCESS.getStatusCode(),
                REnum.WEB_FILE_MULTI_DELETE_SUCCESS.getStatusMsg());
    }
}
