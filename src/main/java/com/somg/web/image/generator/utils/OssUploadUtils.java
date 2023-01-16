package com.somg.web.image.generator.utils;

import com.aliyun.oss.OSS;
import com.aliyun.oss.common.comm.ResponseMessage;
import com.aliyun.oss.model.PutObjectResult;
import com.somg.web.image.generator.constant.Constant;
import com.somg.web.image.generator.constant.REnum;

import java.io.File;
import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;

/**
 * @author somg
 * @date 2023/1/16 12:12
 * @do OSS文件上传工具
 */
public class OssUploadUtils {

    /**
     *
     * @param type  上传到那个文件夹
     * @param originFileName  原文件的路径
     * @param inputStream  原文件的输入流
     * @param baseUrl  外网访问的域名，url
     * @param ossClient  Oss的对象
     * @param bucketName  Oss的Bucket名字
     * @return R
     */

    public static R uploadByFile(String type, String originFileName, InputStream inputStream, String baseUrl, OSS ossClient, String bucketName){
        // 根据种类定义文件夹 类别/今天 如果存在就直接存储 不存在就创建 方便按天统计
        String webImageUploadDir = type + "/" + new SimpleDateFormat("yyyy-MM-dd").format(new Date()) + "/";
        // 获取原文件的拓展名 lastIndexOf(".")查找”.“在最右边出现的位置 substring从在最右边出现的位置截取到结束（包含）
        String webImageExName = originFileName.substring(originFileName.lastIndexOf("."));
        // 生成uuid唯一文件主体名字
        String webImageMainName = UUID.randomUUID().toString().replace("-", "");
        // 真实的上传文件的路径+文件名，不加域名
        String webImageRealPath = webImageUploadDir + webImageMainName + webImageExName;

        // 上传文件
        try{
            PutObjectResult putObjectResult = ossClient.putObject(bucketName, webImageRealPath, inputStream);
            ResponseMessage response = putObjectResult.getResponse();
            if(response == null){
                // 上传成功
                String webImageUrl = baseUrl + webImageRealPath;

                return R.ok(REnum.WEB_IMAGE_GENERATE_SUCCESS.getStatusCode(),
                                REnum.WEB_IMAGE_GENERATE_SUCCESS.getStatusMsg())
                        .put(Constant.WEB_IMAGE_GENERATE_SINGLE_SUCCESS_RESPONSE_NAME, webImageUrl);
            }else {

                return R.error(REnum.WEB_IMAGE_GENERATE_FAIL.getStatusCode(),
                        REnum.WEB_IMAGE_GENERATE_FAIL.getStatusMsg());
            }

        }catch (Exception e){
            e.printStackTrace();
            return R.error(REnum.NETWORK_CONNECT_FAIL.getStatusCode(),
                    REnum.NETWORK_CONNECT_FAIL.getStatusMsg());
        }
    }

}
