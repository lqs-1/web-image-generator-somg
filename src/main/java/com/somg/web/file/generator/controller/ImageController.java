package com.somg.web.file.generator.controller;

import com.somg.web.file.generator.action.FileLocationAction;
import com.somg.web.file.generator.annotation.SysListenLog;
import com.somg.web.file.generator.cloud.storage.abs.upload.FileUploadPlus;
import com.somg.web.file.generator.cloud.storage.abs.utils.ScaleResult;
import com.somg.web.file.generator.constant.REnum;
import com.somg.web.file.generator.utils.R;
import com.somg.web.file.generator.vo.ScaleVo;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.UUID;

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
     * 图片缩放的图片上传
     * @param image
     * @param response
     * @throws IOException
     */

    @PostMapping("image")
    @ResponseBody
    @ApiOperation(value = "图片缩放图片上传")
    @SysListenLog(serverName = "图片服务", action = "上传缩放图片")
    public R image(@RequestBody MultipartFile image, HttpServletResponse response) throws IOException {

        // 将图形按原图缩放并保存
        ScaleResult scaleResult = fileUpload.build().imageScale(image.getInputStream(), image.getOriginalFilename(), 1f);

        // 保存文件的地址方便定时任务删除
        fileLocationAction.addFileLocation(scaleResult.getImagePath());

        ScaleVo scaleVo = new ScaleVo();
        scaleVo.setImagePath(scaleResult.getImagePath());
        scaleVo.setContentType(image.getContentType());

        // 返回对应数据
        return R.ok(REnum.FILE_UPLOAD_SUCCESS.getStatusCode(),
                REnum.FILE_UPLOAD_SUCCESS.getStatusMsg())
                .put("image", scaleVo);

    }



    /**
     * 图片的放大缩小
     * @param scale
     * @param response
     * @throws IOException
     */

    @GetMapping("scale")
    @ApiOperation(value = "图片缩放[开放]")
    public void imageScale(ScaleVo scale, HttpServletResponse response) throws IOException {

        InputStream imageInputStream = new FileInputStream(scale.getImagePath()); // 获取文件输入流

        String imageExtension = StringUtils.getFilenameExtension(scale.getImagePath()); // 获取后缀名

        // 生成新的文件名字 没有处理过的
        String fileName = UUID.randomUUID().toString().replace("-", "") + "." + imageExtension;
        // 真正的缩放，按照用户的要求
        ScaleResult scaleResult = fileUpload.build().imageScale(imageInputStream, fileName, scale.getScale());

        // 关闭输入流
        imageInputStream.close();

        // 保存文件的地址方便定时任务删除
        fileLocationAction.addFileLocation(scaleResult.getImagePath());

        response.addHeader("Content-Disposition", "attachment;filename=" + fileName);

        // 设置response的contentType
        response.setContentType(scale.getContentType());

        // 获取response的输出流对象
        ServletOutputStream outputStream = response.getOutputStream();

        // 将图片写到response
        outputStream.write(scaleResult.getData());

        // 刷出去
        outputStream.flush();
    }


}
