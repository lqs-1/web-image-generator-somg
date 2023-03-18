package com.somg.web.file.generator.cloud.storage.abs.exception;

/**
 * @author somg
 * @date 2023/3/8 7:46
 * @do 一句话描述此模块的功能
 */
public class FileUploadErrorException extends RuntimeException{

    public FileUploadErrorException(){
        super("File-Upload-Error");
    }

}
