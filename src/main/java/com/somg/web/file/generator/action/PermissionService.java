package com.somg.web.file.generator.action;

import com.baomidou.mybatisplus.extension.service.IService;
import com.somg.web.file.generator.pojo.Permission;
import com.somg.web.file.generator.utils.Pagination.PageUtils;
import com.somg.web.file.generator.utils.R;

import java.util.List;
import java.util.Map;

/**
 * @author somg
 * @date 2023/3/20 12:09
 * @do 用户权限接口（访问接口的权限）
 */
public interface PermissionService extends IService<Permission> {
    PageUtils getPermissionPage(Map<String, Object> param);

    R addPermission(Permission permission);

    void editPermission(Permission permission);

    void deletePermissionById(Long id);

    List<Permission> getList();

    List<Permission> selectCommonPermission(String commonPermission);
}
