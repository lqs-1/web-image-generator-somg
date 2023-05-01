package com.somg.web.file.generator.action.im;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.somg.web.file.generator.action.UserRoleService;
import com.somg.web.file.generator.pojo.UserRole;
import com.somg.web.file.generator.mapper.UserRoleMapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * @author somg
 * @date 2023/3/20 12:13
 * @do 用户角色授权关系实现 （接口权限）
 */
@Service
public class UserRoleServiceImpl extends ServiceImpl<UserRoleMapper, UserRole> implements UserRoleService {

    /**
     * 根据userId获取用户已经拥有的角色id列表
     * @param id
     * @return
     */
    @Override
    public List<Long> selectByUserId(Long id) {

        List<Long> roleIdList = this.baseMapper.selectByUserId(id);

        return roleIdList;
    }

    /**
     * 给用户添加角色
     * @param userId
     * @param roleIds
     */
    @Override
    @Transactional(readOnly = false)
    public void addUserRoleRenation(Long userId, List<Long> roleIds) {

        if (roleIds != null){

            this.baseMapper.delete(new LambdaQueryWrapper<UserRole>()
                    .eq(UserRole::getUserId, userId));

            // System.out.println(userId);

            for (Long roleId : roleIds) {
               //  System.out.println(roleId);

                UserRole userRole = new UserRole();

                userRole.setRoleId(roleId);

                userRole.setUserId(userId);

                this.baseMapper.insert(userRole);

            }
        }
    }

    /**
     * 删除用户角色
     * @param id
     */
    @Override
    public void deleteUserRoleRelation(Long id) {

        if (id != null){

            this.baseMapper.delete(new LambdaQueryWrapper<UserRole>()
                    .eq(UserRole::getUserId, id));

        }
    }


}
