package com.somg.web.file.generator.pojo.origin;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableLogic;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

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

    @TableLogic
    private Integer isDelete;

    @TableField(exist = false)
    private String userName;

}
