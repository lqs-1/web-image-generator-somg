package com.somg.web.file.generator.cloud.storage.abs.support.prop;

import com.qiniu.storage.BucketManager;
import com.qiniu.storage.UploadManager;
import lombok.Data;

/**
 * @author somg
 * @date 2023/3/8 16:10
 * @do QiNiu连接对象
 */

@Data
public class QiniuConnect {

    private UploadManager uploadManager;

    private BucketManager bucketManager;

    private String upToken;


    /**
     * 构造客户端对象
     * @param uploadManager
     * @param bucketManager
     * @param upToken
     */
    public QiniuConnect(UploadManager uploadManager, BucketManager bucketManager, String upToken){
        this.uploadManager = uploadManager;
        this.bucketManager = bucketManager;
        this.upToken = upToken;
    }

}
