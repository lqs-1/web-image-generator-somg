package com.somg.web.file.generator.action.im;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.somg.web.file.generator.action.UserPermissionService;
import com.somg.web.file.generator.pojo.UserPermission;
import com.somg.web.file.generator.mapper.UserPermissionMapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;


/**
 * @author somg
 * @date 2023/3/20 12:13
 * @do 用户权限授权关系实现 （接口权限）
 */
@Service
public class UserPermissionServiceImpl extends ServiceImpl<UserPermissionMapper, UserPermission> implements UserPermissionService {


    /**
     * 根据userId获取用户已经拥有的权限id列表
     * @param id
     * @return
     */
    @Override
    public List<Long> selectByUserId(Long id) {

        List<Long> permissionIdList = this.baseMapper.selectByUserId(id);

        return permissionIdList;
    }

    /**
     * 给用户添加权限
     * @param userId
     * @param permissionIds
     */
    @Override
    @Transactional(readOnly = false)
    public void addUserPermissionRelation(Long userId, List<Long> permissionIds) {

        if (permissionIds != null){

            this.baseMapper.delete(new LambdaQueryWrapper<UserPermission>()
                    .eq(UserPermission::getUserId, userId));

            for (Long permissionId : permissionIds) {

                UserPermission userPermission = new UserPermission();

                userPermission.setUserId(userId);

                userPermission.setPermissionId(permissionId);

                this.baseMapper.insert(userPermission);

            }
        }

    }

    /**
     * 删除用户的权限
     * @param id
     */
    @Transactional(readOnly = false)
    @Override
    public void deleteUserPermissionRelation(Long id) {
        if (id != null){

            this.baseMapper.delete(new LambdaQueryWrapper<UserPermission>()
                    .eq(UserPermission::getUserId, id));

        }
    }
}
