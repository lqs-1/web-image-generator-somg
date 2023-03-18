package com.somg.web.file.generator.action.im;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.somg.web.file.generator.action.RoleService;
import com.somg.web.file.generator.pojo.origin.Role;
import com.somg.web.file.generator.utils.Pagination.PageUtils;
import com.somg.web.file.generator.utils.Pagination.QueryPage;
import com.somg.web.file.generator.utils.R;
import com.somg.web.file.generator.constant.REnum;
import com.somg.web.file.generator.mapper.RoleMapper;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class RoleServiceImpl extends ServiceImpl<RoleMapper, Role> implements RoleService {

    @Override
    public PageUtils getRolePage(Map<String, Object> param) {

        IPage<Role> page = this.page(new QueryPage<Role>().getPage(param, true),
                new LambdaQueryWrapper<Role>().like(Role::getRoleName,
                        (String) param.get("rolename")));

        return new  PageUtils(page);
    }

    @Override
    public R addRole(Role role) {
        Role queryRole = this.baseMapper.getRoleByRoleName(role.getRoleName());

        if (queryRole != null){

            return R.error(REnum.ROLE_DOES_EXIST.getStatusCode(),
                    REnum.ROLE_DOES_EXIST.getStatusMsg());

        }

        this.baseMapper.insert(role);

        return R.ok(REnum.ROLE_ADD_SUCCESS.getStatusCode(),
                REnum.ROLE_ADD_SUCCESS.getStatusMsg());

    }

    @Override
    public void editRole(Role role) {

        this.baseMapper.updateById(role);

    }

    @Override
    public void deleteRoleById(Long id) {

        this.baseMapper.deleteById(id);

    }

    @Override
    public List<Role> getList() {

        List<Role> roleList = this.baseMapper.selectList(null);

        return roleList;

    }

    @Override
    public List<Role> selectCommonRole(String commonRole) {

        List<Role> roleList = this.baseMapper.selectList(new LambdaQueryWrapper<Role>()
                .eq(Role::getRoleName, commonRole));

        if (roleList.size() == 1){

            return roleList;

        }

        return null;

    }
}
