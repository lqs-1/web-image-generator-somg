package com.somg.web.file.generator.controller;

import com.somg.web.file.generator.action.FileLocationAction;
import com.somg.web.file.generator.cloud.storage.abs.auto.OssProperties;
import com.somg.web.file.generator.cloud.storage.abs.auto.QiniuProperties;
import com.somg.web.file.generator.cloud.storage.abs.upload.FileUploadPlus;
import com.somg.web.file.generator.cloud.storage.abs.utils.OssFileStorage;
import com.somg.web.file.generator.cloud.storage.abs.utils.QiniuFileStorage;
import com.somg.web.file.generator.cloud.storage.abs.utils.result.ScaleResult;
import com.somg.web.file.generator.utils.R;
import org.springframework.beans.factory.annotation.Autowired;


import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;

import java.util.List;
import java.util.Map;


/**
 * @author somg
 * @date 2023/2/28 13:42
 * @do 文件上传第三方api测试
 */

@RestController
@RequestMapping("third")
public class TestController {

    @Autowired
    private FileUploadPlus fileUpload;

    @Autowired
    private OssProperties ossProperties;


    @Autowired
    private QiniuProperties qiniuProperties;


    @Autowired
    private FileLocationAction fileLocationAction;
    @PostMapping("testUtils")
    public R ThirdFileUploadUtilsTest(@RequestBody MultipartFile image){


        OssFileStorage wocao = new OssFileStorage.OssFileStorageBuilder(ossProperties.getOssClient()).bucket(ossProperties.getBucketName()).baseUrl(ossProperties.getBaseUrl()).type("wocao").build();

        System.out.println(wocao.help());

        R r = wocao.singleFileUpload(image);


        return r;
    }


    @PostMapping("testUtils02")
    public R ThirdFileUploadUtilsTest02(@RequestBody List<MultipartFile> images){

        OssFileStorage wocao = new OssFileStorage.OssFileStorageBuilder(ossProperties.getOssClient()).bucket(ossProperties.getBucketName()).baseUrl(ossProperties.getBaseUrl()).type("hahahahah").build();

        R r = wocao.multiFileUpload(images);


        return r;
    }



    @PostMapping("testUtils03")
    public R ThirdFileUploadUtilsTest03(@RequestBody Map<String, String> fileUrlMap){

        OssFileStorage wocao = new OssFileStorage.OssFileStorageBuilder(ossProperties.getOssClient()).bucket(ossProperties.getBucketName()).baseUrl(ossProperties.getBaseUrl()).bucket(ossProperties.getBucketName()).build();

        R r = wocao.singleFileClear(fileUrlMap.get("fileUrl"));

        return r;
    }



    @PostMapping("testUtils04")
    public R ThirdFileUploadUtilsTest04(@RequestBody Map<String, List<String>> fileUrlMap){

        OssFileStorage wocao = new OssFileStorage.OssFileStorageBuilder(ossProperties.getOssClient()).bucket(ossProperties.getBucketName()).baseUrl(ossProperties.getBaseUrl()).bucket(ossProperties.getBucketName()).build();

        List<String> fileUrlList = fileUrlMap.get("fileUrlList");

        R r = wocao.batchFileClear(fileUrlList);

        return r;
    }



    @PostMapping("testUtils05")
    public R  ThirdFileUploadUtilsTest05(@RequestBody MultipartFile image) {


        R r = new QiniuFileStorage.QiniuFileStorageBuilder(qiniuProperties.getAccessKey(), qiniuProperties.getAccessSecretKey())
                .baseUrl(qiniuProperties.getBaseUrl())
                .type("haha")
                .bucket(qiniuProperties.getBucketName())
                .build()
                .singleFileUpload(image);

        return r;
    }



    @PostMapping("testUtils06")
    public R  ThirdFileUploadUtilsTest06(@RequestBody List<MultipartFile> images) {


        R r = new QiniuFileStorage
                .QiniuFileStorageBuilder(qiniuProperties.getAccessKey(), qiniuProperties.getAccessSecretKey())
                .baseUrl(qiniuProperties.getBaseUrl())
                .type("haha")
                .bucket(qiniuProperties.getBucketName())
                .build()
                .multiFileUpload(images);

        return r;
    }



    @PostMapping("testUtils07")
    public R  ThirdFileUploadUtilsTest07(@RequestBody Map<String, String> fileUrlMap) {


        R r = new QiniuFileStorage
                .QiniuFileStorageBuilder(qiniuProperties.getAccessKey(), qiniuProperties.getAccessSecretKey())
                .baseUrl(qiniuProperties.getBaseUrl())
                .type("haha")
                .bucket(qiniuProperties.getBucketName())
                .build()
                .singleFileClear(fileUrlMap.get("fileUrl"));

        return r;
    }



    @PostMapping("testUtils08")
    public R  ThirdFileUploadUtilsTest08(@RequestBody Map<String, List<String>> fileUrlMap) {


        R r = new QiniuFileStorage
                .QiniuFileStorageBuilder(qiniuProperties.getAccessKey(), qiniuProperties.getAccessSecretKey())
                .baseUrl(qiniuProperties.getBaseUrl())
                .type("haha")
                .bucket(qiniuProperties.getBucketName())
                .build()
                .batchFileClear(fileUrlMap.get("fileUrlList"));

        return r;
    }



    @PostMapping("testUtils09")
    public R  ThirdFileUploadUtilsTest09() {

        System.out.println(fileUpload.build().help());

        return R.ok();
    }



    @PostMapping("testUtils10")
    public R  ThirdFileUploadUtilsTest10(@RequestBody MultipartFile image) throws Exception {

        return fileUpload.build().singleFileUpload(image);

    }


    @PostMapping("testUtils11")
    public R  ThirdFileUploadUtilsTest11(@RequestBody List<MultipartFile> images) throws Exception {

        System.out.println(images);

        return fileUpload.build().multiFileUpload(images);

    }


    @PostMapping("testUtils12")
    public R  ThirdFileUploadUtilsTest12(@RequestBody Map<String, String> fileUrlMap) throws Exception {

        return fileUpload.build().singleFileClear(fileUrlMap.get("fileUrl"));

    }


    @PostMapping("testUtils13")
    public R  ThirdFileUploadUtilsTest13(@RequestBody Map<String, List> fileUrlMap) throws Exception {

        return fileUpload.build().batchFileClear(fileUrlMap.get("fileUrlList"));

    }

    @PostMapping("testUtils14")
    public R  ThirdFileUploadUtilsTest14(@RequestBody Map<String, String> fileUrlMap) throws Exception {

        return fileUpload.build().singleFileClear(fileUrlMap.get("fileUrl"));

    }

    @PostMapping("testUtils15")
    public R  ThirdFileUploadUtilsTest15(@RequestBody Map<String, List> fileUrlMap) throws Exception {

        return fileUpload.build().batchFileClear(fileUrlMap.get("fileUrlList"));

    }


    @PostMapping("testUtils16")
    public void  ThirdFileUploadUtilsTest16(@RequestBody MultipartFile image, HttpServletResponse response) throws Exception {

        ScaleResult scaleResult = fileUpload.build().imageScale(image.getInputStream(), image.getOriginalFilename(), 2f);

        byte[] data = scaleResult.getData();

        fileLocationAction.addFileLocation(scaleResult.getImagePath());

        response.setContentType(image.getContentType());


        ServletOutputStream outputStream = response.getOutputStream();

        outputStream.write(data);
        outputStream.flush();
        outputStream.close();

    }







}
