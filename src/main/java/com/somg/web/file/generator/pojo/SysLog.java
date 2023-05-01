package com.somg.web.file.generator.pojo;

import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.util.Date;

/**
 * @author somg
 * @date 2023/4/1 14:12
 * @do 日志对象
 */

@Data
@TableName("sys_log")
public class SysLog {

    private Long id;

    private Long userId;

    private String userName;

    private Date time;

    private String serverName;

    private String action;



}
