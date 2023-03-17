package com.somg.web.image.generator.vo;

import com.somg.web.image.generator.pojo.origin.User;
import lombok.Data;

import java.util.List;

@Data
public class UserVo extends User {

    private List<Long> roleIds;

    private List<Long> permissionIds;
}
