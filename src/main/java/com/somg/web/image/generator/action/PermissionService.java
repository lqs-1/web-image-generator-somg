package com.somg.web.image.generator.action;

import com.baomidou.mybatisplus.extension.service.IService;
import com.somg.web.image.generator.pojo.origin.Permission;
import com.somg.web.image.generator.utils.Pagination.PageUtils;
import com.somg.web.image.generator.utils.R;

import java.util.List;
import java.util.Map;


public interface PermissionService extends IService<Permission> {
    PageUtils getPermissionPage(Map<String, Object> param);

    R addPermission(Permission permission);

    void editPermission(Permission permission);

    void deletePermissionById(Long id);

    List<Permission> getList();

    List<Permission> selectCommonPermission(String commonPermission);
}
