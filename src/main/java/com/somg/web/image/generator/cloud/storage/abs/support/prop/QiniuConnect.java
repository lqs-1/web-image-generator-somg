package com.somg.web.image.generator.cloud.storage.abs.support.prop;

import com.qiniu.storage.BucketManager;
import com.qiniu.storage.UploadManager;
import lombok.Data;

/**
 * @author somg
 * @date 2023/3/8 16:10
 * @do 一句话描述此模块的功能
 */

@Data
public class QiniuConnect {

    private UploadManager uploadManager;

    private BucketManager bucketManager;

    private String upToken;


    public QiniuConnect(UploadManager uploadManager, BucketManager bucketManager, String upToken){
        this.uploadManager = uploadManager;
        this.bucketManager = bucketManager;
        this.upToken = upToken;
    }

}
