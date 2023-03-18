package com.somg.web.file.generator.action;

import com.baomidou.mybatisplus.extension.service.IService;
import com.somg.web.file.generator.pojo.origin.UserRole;

import java.util.List;

public interface UserRoleService extends IService<UserRole> {

    List<Long> selectByUserId(Long id);

    void addUserRoleRenation(Long userId, List<Long> roleIds);

    void deleteUserRoleRelation(Long id);

}
