package com.somg.web.file.generator.controller;

import com.somg.web.file.generator.cloud.storage.abs.upload.FileUploadPlus;
import com.somg.web.file.generator.utils.R;
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
public class WebImageGenerateController {

    @Autowired
    private FileUploadPlus fileUpload;


    /**
     * 单张图片上传
     * @param image
     * @return
     */
    @PostMapping("web-image-generate/single")
    @ResponseBody
    public R webImageSingleGenerate(@RequestBody MultipartFile image) {

        return fileUpload.build().singleFileUpload(image);

    }



    /**
     * 批量图片上传 一般用不上
     * @param images
     * @return
     */
    @PostMapping("web-image-generate/multi")
    @ResponseBody
    public R webImageMultiGenerate(@RequestBody List<MultipartFile> images){

        return fileUpload.build().multiFileUpload(images);

    }

}
