package com.somg.web.file.generator.action;

import com.baomidou.mybatisplus.extension.service.IService;
import com.somg.web.file.generator.pojo.User;
import com.somg.web.file.generator.utils.Pagination.PageUtils;
import com.somg.web.file.generator.utils.R;

import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Map;

/**
 * @author somg
 * @date 2023/3/20 12:09
 * @do 用户接口
 */
public interface UserService extends IService<User> {

    R getUser(User user, HttpServletRequest request) throws Exception;

    List<User> getUserList();

    PageUtils getUserPage(Map<String, Object> params);

    R addUser(User user);

    void editUser(User user);

    void deleteUserById(Long id);

    R alterPwdByUserNameAndEmail(User user);

    User selectUserByName(String username);

    List<Long> selectUserLikeName(String username);

    void updateLoginTimeByUserName(String username);

    R resetPassWord(Long userId);
}
