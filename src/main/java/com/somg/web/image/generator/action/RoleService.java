package com.somg.web.image.generator.action;

import com.baomidou.mybatisplus.extension.service.IService;
import com.somg.web.image.generator.pojo.origin.Role;
import com.somg.web.image.generator.utils.Pagination.PageUtils;
import com.somg.web.image.generator.utils.R;

import java.util.List;
import java.util.Map;

public interface RoleService extends IService<Role> {

    PageUtils getRolePage(Map<String, Object> param);

    R addRole(Role role);

    void editRole(Role role);

    void deleteRoleById(Long id);

    List<Role> getList();

    List<Role> selectCommonRole(String commonRole);
}
