package com.somg.web.image.generator.action;

import com.baomidou.mybatisplus.extension.service.IService;
import com.somg.web.image.generator.pojo.origin.UserRole;

import java.util.List;

public interface UserRoleService extends IService<UserRole> {

    List<Long> selectByUserId(Long id);

    void addUserRoleRenation(Long userId, List<Long> roleIds);

    void deleteUserRoleRelation(Long id);

}
