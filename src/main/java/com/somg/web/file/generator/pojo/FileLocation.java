package com.somg.web.file.generator.pojo;

import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

/**
 * @author somg
 * @date 2023/3/10 8:49
 * @do 本地存储对象 未用
 */

@Data
@TableName("file_location")
public class FileLocation {

    private Long id;

    private String imagePath;

}
