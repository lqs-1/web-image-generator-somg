package com.somg.web.file.generator.cloud.storage.abs.exception;

/**
 * @author somg
 * @date 2023/3/13 12:35
 * @do 文件上传客户端异常
 */
public class FileUploadClientConfigException extends RuntimeException{


    public FileUploadClientConfigException(String clientType){
        super(clientType);
    }


}
