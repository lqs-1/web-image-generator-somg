package com.somg.web.file.generator.pojo;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableLogic;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.util.Date;

/**
 * @author somg
 * @date 2023/3/19 18:05
 * @do 用户文件对象
 */

@Data
@TableName("user_file")
public class UserFile {

    private Long id;

    private Long userId;

    private String file;

    private String fileType;

    private Date uploadTime;

    private String fileName;

    private Date deleteTime;

    private Integer isDelete;

    @TableField(exist = false)
    private String userName;

    @TableField(exist = false)
    private Long expire;

}
