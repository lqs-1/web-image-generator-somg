package com.somg.web.file.generator.action.im;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.somg.web.file.generator.pojo.origin.Permission;
import com.somg.web.file.generator.utils.Pagination.PageUtils;
import com.somg.web.file.generator.utils.Pagination.QueryPage;
import com.somg.web.file.generator.utils.R;
import com.somg.web.file.generator.action.PermissionService;
import com.somg.web.file.generator.constant.REnum;
import com.somg.web.file.generator.mapper.PermissionMapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;


/**
 * @author somg
 * @date 2023/3/20 12:12
 * @do 权限实现（访问接口的权限）
 */
@Service
public class PermissionServiceImpl extends ServiceImpl<PermissionMapper, Permission> implements PermissionService {
    /**
     * 获取所有权限 根据给定的关键字来筛选
     * @param param
     * @return
     */
    @Override
    public PageUtils getPermissionPage(Map<String, Object> param) {

        IPage<Permission> page = this.page(new QueryPage<Permission>().getPage(param, true),
                new LambdaQueryWrapper<Permission>().like(Permission::getPermissionName,
                        (String) param.get("permissionname")));

        return new  PageUtils(page);
    }

    /**
     * 添加权限
     * @param permission
     * @return
     */
    @Override
    @Transactional(readOnly = false)
    public R addPermission(Permission permission) {

        Permission queryPermission = this.baseMapper.getPermissionByPermissionName(permission.getPermissionName());

        if (queryPermission != null){

            return R.error(REnum.PERMISSION_DOES_EXIST.getStatusCode(),
                    REnum.PERMISSION_DOES_EXIST.getStatusMsg());

        }

        this.baseMapper.insert(permission);

        return R.ok(REnum.PERMISSION_ADD_SUCCESS.getStatusCode(),
                REnum.PERMISSION_ADD_SUCCESS.getStatusMsg());

    }

    /**
     * 编辑权限 更新权限
     * @param permission
     */
    @Override
    @Transactional(readOnly = false)
    public void editPermission(Permission permission) {

        this.baseMapper.updateById(permission);

    }

    /**
     * 删除权限 单个
     * @param id
     */
    @Override
    @Transactional(readOnly = false)
    public void deletePermissionById(Long id) {

        this.baseMapper.deleteById(id);

    }

    /**
     * 获取所有的权限
     * @return
     */
    @Override
    public List<Permission> getList() {

        List<Permission> permissionList = this.baseMapper.selectList(null);

        return permissionList;

    }

    /**
     * 注册和添加用户的时候 在这里查出默认要添加的权限
     * @param commonPermission
     * @return
     */
    @Override
    public List<Permission> selectCommonPermission(String commonPermission) {

        List<Permission> permissionList = this.baseMapper.selectList(new LambdaQueryWrapper<Permission>().eq(Permission::getPermissionName, commonPermission));

        if (permissionList.size() == 1){

            return permissionList;

        }

        return null;
    }
}
