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
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

/**
 * @author somg
 * @date 2023/3/20 12:12
 * @do 角色实现 （接口权限）
 */
@Service
public class RoleServiceImpl extends ServiceImpl<RoleMapper, Role> implements RoleService {

    /**
     * 获取角色分页数据 可以根据关键字筛选
     * @param param
     * @return
     */
    @Override
    public PageUtils getRolePage(Map<String, Object> param) {

        IPage<Role> page = this.page(new QueryPage<Role>().getPage(param, true),
                new LambdaQueryWrapper<Role>().like(Role::getRoleName,
                        (String) param.get("rolename")));

        return new  PageUtils(page);
    }

    /**
     * 添加权限
     * @param role
     * @return
     */
    @Override
    @Transactional(readOnly = false)
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

    /**
     * 更新角色
     * @param role
     */
    @Override
    @Transactional(readOnly = false)
    public void editRole(Role role) {

        this.baseMapper.updateById(role);

    }

    /**
     * 删除角色
     * @param id
     */
    @Override
    @Transactional(readOnly = false)
    public void deleteRoleById(Long id) {

        this.baseMapper.deleteById(id);

    }

    /**
     * 获取所有的角色
     * @return
     */
    @Override
    public List<Role> getList() {

        List<Role> roleList = this.baseMapper.selectList(null);

        return roleList;

    }

    /**
     * 注册和添加用户的时候 在这里查出默认要添加的角色
     * @param commonRole
     * @return
     */
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
