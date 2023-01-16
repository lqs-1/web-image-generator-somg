package com.somg.web.image.generator.controller;

import com.alibaba.fastjson.TypeReference;
import com.aliyun.oss.OSS;
import com.somg.web.image.generator.constant.Constant;
import com.somg.web.image.generator.constant.REnum;
import com.somg.web.image.generator.utils.OssUploadUtils;
import com.somg.web.image.generator.utils.R;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

/**
 * @author somg
 * @date 2023/1/16 12:27
 * @do 网络图片生成控制器
 */

@Controller
@RequestMapping("somg")
public class WebImageGenerateController {


    // 外网访问的域名，url
    @Value("${oss.base.url}")
    private String ossBaseUrl;

    // Oss的客户端对象
    @Autowired
    private OSS ossClient;

    @Value("${oss.bucketName}")
    private String bucketName;


    /**
     * 单张图片上传
     * @param image
     * @return
     */
    @PostMapping("web-image-generate/single")
    @ResponseBody
    public R webImageSingleGenerate(@RequestBody MultipartFile image) throws IOException {
            // 上传文件 单文件
            R webImageSingleUploadResponse = OssUploadUtils.uploadByFile(
                    Constant.WEB_IMAGE_SINGLE_GENERATE_DIR,
                    image.getOriginalFilename(),
                    image.getInputStream(),
                    ossBaseUrl,
                    ossClient,
                    bucketName
            );

            return webImageSingleUploadResponse;

    }



    /**
     * 批量图片上传
     * @param images
     * @return
     */
    @PostMapping("web-image-generate/multi")
    @ResponseBody
    public R webImageMultiGenerate(@RequestBody List<MultipartFile> images) throws IOException {

        List<String> webImageUrlList = new ArrayList<>();

        // 循环 上传单文件文件
        for (MultipartFile image : images) {

            // 上传文件
            R webImageSingleUploadResponse = OssUploadUtils.uploadByFile(
                    Constant.WEB_IMAGE_MULTI_GENERATE_DIR,
                    image.getOriginalFilename(),
                    image.getInputStream(),
                    ossBaseUrl,
                    ossClient,
                    bucketName
            );

            // 判断状态
            if (webImageSingleUploadResponse.parseCode() < 20000){
                // 封装成功数据
                webImageUrlList.add(webImageSingleUploadResponse.parseType(new TypeReference<String>(){}, Constant.WEB_IMAGE_GENERATE_SINGLE_SUCCESS_RESPONSE_NAME));
            }else {
                return R.error(REnum.WEB_IMAGE_GENERATE_FAIL.getStatusCode(), REnum.WEB_IMAGE_GENERATE_FAIL.getStatusMsg());
            }

        }

        return R.ok(REnum.WEB_IMAGE_GENERATE_SUCCESS.getStatusCode(), REnum.WEB_IMAGE_GENERATE_SUCCESS.getStatusMsg())
                .put(Constant.WEB_IMAGE_GENERATE_MULTI_SUCCESS_RESPONSE_NAME, webImageUrlList);

    }

}
