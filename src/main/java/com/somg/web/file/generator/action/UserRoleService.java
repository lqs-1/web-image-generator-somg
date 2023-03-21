package com.somg.web.file.generator.action;

import com.baomidou.mybatisplus.extension.service.IService;
import com.somg.web.file.generator.pojo.origin.UserRole;

import java.util.List;
/**
 * @author somg
 * @date 2023/3/20 12:09
 * @do 用户角色授权关系接口 （接口权限）
 */
public interface UserRoleService extends IService<UserRole> {

    List<Long> selectByUserId(Long id);

    void addUserRoleRenation(Long userId, List<Long> roleIds);

    void deleteUserRoleRelation(Long id);

}
