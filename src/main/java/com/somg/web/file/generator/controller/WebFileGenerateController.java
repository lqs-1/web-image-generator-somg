package com.somg.web.file.generator.controller;

import com.somg.web.file.generator.action.UserFileService;
import com.somg.web.file.generator.annotation.SysListenLog;
import com.somg.web.file.generator.cloud.storage.abs.upload.FileUploadPlus;
import com.somg.web.file.generator.utils.R;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

/**
 * @author somg
 * @date 2023/1/16 12:27
 * @do 网络图片生成控制器
 */

@Controller
@RequestMapping("somg")
@Api(tags = "上传模块")
public class WebFileGenerateController {

    @Autowired
    private FileUploadPlus fileUpload;


    @Autowired
    private UserFileService userFileService;


    /**
     * 单张图片上传
     * @param file
     * @return
     */
    @PostMapping("web-file-generate/simple")
    @ResponseBody
    @ApiOperation(value = "单文件上传[开放]")
    public R webFileSingleGenerateSimple(@RequestBody MultipartFile file) {

        return fileUpload.build().singleFileUpload(file);


    }



    /**
     * 单张图片上传
     * @param file
     * @return
     */
    @SysListenLog(serverName = "上传服务", action = "上传单文件")
    @PostMapping("web-file-generate/single")
    @ApiOperation(value = "单文件上传[需要认证]")
    @ResponseBody
    public R webFileSingleGenerate(@RequestBody MultipartFile file) {

        return userFileService.singleUpload(file);

    }



    /**
     * 批量图片上传 一般用不上
     * @param files
     * @return
     */
    @SysListenLog(serverName = "上传服务", action = "批量上传")
    @PostMapping("web-file-generate/multi")
    @ApiOperation(value = "批量文件上传[需要认证]")
    @ResponseBody
    public R webFileMultiGenerate(@RequestBody List<MultipartFile> files){

        return userFileService.multiUpload(files);


    }

}
