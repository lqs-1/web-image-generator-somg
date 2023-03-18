package com.somg.web.file.generator.action.im;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.somg.web.file.generator.action.UserRoleService;
import com.somg.web.file.generator.pojo.origin.UserRole;
import com.somg.web.file.generator.mapper.UserRoleMapper;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserRoleServiceImpl extends ServiceImpl<UserRoleMapper, UserRole> implements UserRoleService {

    @Override
    public List<Long> selectByUserId(Long id) {

        List<Long> roleIdList = this.baseMapper.selectByUserId(id);

        return roleIdList;
    }

    @Override
    public void addUserRoleRenation(Long userId, List<Long> roleIds) {

        if (roleIds != null){

            this.baseMapper.delete(new LambdaQueryWrapper<UserRole>()
                    .eq(UserRole::getUserId, userId));

            for (Long roleId : roleIds) {

                UserRole userRole = new UserRole();

                userRole.setRoleId(roleId);

                userRole.setUserId(userId);

                this.baseMapper.insert(userRole);

            }
        }
    }

    @Override
    public void deleteUserRoleRelation(Long id) {

        if (id != null){

            this.baseMapper.delete(new LambdaQueryWrapper<UserRole>()
                    .eq(UserRole::getUserId, id));

        }
    }


}
