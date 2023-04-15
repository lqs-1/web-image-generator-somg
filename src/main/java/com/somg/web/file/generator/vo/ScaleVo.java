package com.somg.web.file.generator.vo;

import lombok.Data;

/**
 * @author somg
 * @date 2023/4/14 16:20
 * @do 图片缩放vo
 */
@Data
public class ScaleVo {

    private String imagePath;

    private Float scale;

    private String contentType;


}
