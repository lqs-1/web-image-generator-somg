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

import java.util.List;
import java.util.Map;

@Service
public class PermissionServiceImpl extends ServiceImpl<PermissionMapper, Permission> implements PermissionService {
    @Override
    public PageUtils getPermissionPage(Map<String, Object> param) {

        IPage<Permission> page = this.page(new QueryPage<Permission>().getPage(param, true),
                new LambdaQueryWrapper<Permission>().like(Permission::getPermissionName,
                        (String) param.get("permissionname")));

        return new  PageUtils(page);
    }

    @Override
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

    @Override
    public void editPermission(Permission permission) {

        this.baseMapper.updateById(permission);

    }

    @Override
    public void deletePermissionById(Long id) {

        this.baseMapper.deleteById(id);

    }

    @Override
    public List<Permission> getList() {

        List<Permission> permissionList = this.baseMapper.selectList(null);

        return permissionList;

    }

    @Override
    public List<Permission> selectCommonPermission(String commonPermission) {

        List<Permission> permissionList = this.baseMapper.selectList(new LambdaQueryWrapper<Permission>().eq(Permission::getPermissionName, commonPermission));

        if (permissionList.size() == 1){

            return permissionList;

        }

        return null;
    }
}
