package com.somg.web.file.generator.vo;

import com.somg.web.file.generator.pojo.origin.User;
import lombok.Data;

import java.util.List;



/**
 * @author somg
 * @date 2023/3/20 12:02
 * @do 修改用户Vo 集成权限角色和用户
 */
@Data
public class UserVo extends User {

    private List<Long> roleIds;

    private List<Long> permissionIds;
}
