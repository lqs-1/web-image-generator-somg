package com.somg.web.image.generator.cloud.storage.abs.exception;

/**
 * @author somg
 * @date 2023/3/13 12:35
 * @do 一句话描述此模块的功能
 */
public class FileUploadClientConfigException extends RuntimeException{


    public FileUploadClientConfigException(String clientType){
        super(clientType);
    }


}
