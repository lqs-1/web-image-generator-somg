package com.somg.web.file.generator.action;

import com.baomidou.mybatisplus.extension.service.IService;
import com.somg.web.file.generator.pojo.origin.UserPermission;

import java.util.List;

public interface UserPermissionService extends IService<UserPermission> {
    List<Long> selectByUserId(Long id);

    void addUserPermissionRelation(Long userId, List<Long> permissionIds);

    void deleteUserPermissionRelation(Long id);
}
