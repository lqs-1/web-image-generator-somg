package com.somg.web.image.generator.action;

import com.baomidou.mybatisplus.extension.service.IService;
import com.somg.web.image.generator.pojo.origin.User;
import com.somg.web.image.generator.utils.Pagination.PageUtils;
import com.somg.web.image.generator.utils.R;

import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Map;

public interface UserService extends IService<User> {

    R getUser(User user, HttpServletRequest request) throws Exception;

    List<User> getUserList();

    PageUtils getUserPage(Map<String, Object> params);

    R addUser(User user);

    void editUser(User user);

    void deleteUserById(Long id);

    R alterPwdByUserName(User user);

    User selectUserByName(String username);
}
