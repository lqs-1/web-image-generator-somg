package com.somg.web.file.generator.cloud.storage.abs.utils.result;

import lombok.Data;

import javax.servlet.ServletOutputStream;
import java.io.FileInputStream;

/**
 * @author somg
 * @date 2023/3/28 16:00
 * @do 图片缩放的返回对象
 */
@Data
public class ScaleResult {

    private byte[] data;

    private FileInputStream inputStream;

    private String imagePath;


}
