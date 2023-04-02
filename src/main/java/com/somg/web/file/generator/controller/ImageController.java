package com.somg.web.file.generator.controller;

import com.somg.web.file.generator.action.FileLocationAction;
import com.somg.web.file.generator.cloud.storage.abs.upload.FileUploadPlus;
import com.somg.web.file.generator.cloud.storage.abs.utils.ScaleResult;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * @author somg
 * @date 2023/3/28 17:20
 * @do 图片处理控制器
 */
@Controller
@RequestMapping("image")
@Api(tags = "图片处理模块")
public class ImageController {

    @Autowired
    private FileLocationAction fileLocationAction;


    @Autowired
    private FileUploadPlus fileUpload;

    /**
     * 图片的放大缩小
     * @param image
     * @param scale
     * @param response
     * @throws IOException
     */

    @PostMapping("scale")
    @ApiOperation(value = "图片缩放[开放]")
    public void imageScale(@RequestBody MultipartFile image, @RequestParam(value = "scale", required = false) Float scale, HttpServletResponse response) throws IOException {
        if (scale == null){
            scale = 2f;
        }
        ScaleResult scaleResult = fileUpload.build().imageScale(image.getInputStream(), image.getOriginalFilename(), scale);

        fileLocationAction.addFileLocation(scaleResult.getImagePath());

        response.setContentType(image.getContentType());

        ServletOutputStream outputStream = response.getOutputStream();

        outputStream.write(scaleResult.getData());

        outputStream.flush();
    }


}
