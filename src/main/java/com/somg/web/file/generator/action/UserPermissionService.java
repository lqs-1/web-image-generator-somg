package com.somg.web.file.generator.action;

import com.baomidou.mybatisplus.extension.service.IService;
import com.somg.web.file.generator.pojo.origin.UserPermission;

import java.util.List;
/**
 * @author somg
 * @date 2023/3/20 12:09
 * @do 用户权限授权关系接口 （接口权限）
 */
public interface UserPermissionService extends IService<UserPermission> {
    List<Long> selectByUserId(Long id);

    void addUserPermissionRelation(Long userId, List<Long> permissionIds);

    void deleteUserPermissionRelation(Long id);
}
