package com.somg.web.file.generator.cloud.storage.abs.exception;

/**
 * @author somg
 * @date 2023/3/14 11:51
 * @do Bucket异常
 */
public class FileBucketErrorException extends RuntimeException{

    public FileBucketErrorException(){
        super("File-Bucket-Error");
    }


}
