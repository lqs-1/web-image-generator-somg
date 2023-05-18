package com.somg.web.file.generator.handler.security.utils;

import lombok.Data;

import java.util.List;

/**
 * @author somg
 * @date 2023/5/18 9:35
 * @do 用于存储token里面的对象
 */
@Data
public class TokenObj {

    private String userName;

    private List<String> permissionValueList;

}
