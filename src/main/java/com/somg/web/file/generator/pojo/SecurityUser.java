package com.somg.web.file.generator.pojo;

import com.mysql.cj.util.StringUtils;
import com.somg.web.file.generator.vo.MenuVo;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

/**
 * @author somg
 * @date 2023/3/18 16:36
 * @do 自定义的UserDetails实现
 */
public class SecurityUser implements UserDetails {

    // 当前登录的用户
    private User currentUser;


    // 用户的权限列表
    private List<String> permissionValueList;


    // 菜单
    private List<MenuVo> menuVoList;

    public List<MenuVo> getMenuVoList() {
        return menuVoList;
    }

    public void setMenuVoList(List<MenuVo> menuVoList) {
        this.menuVoList = menuVoList;
    }

    public User getCurrentUser() {
        return currentUser;
    }

    public void setCurrentUser(User currentUser) {
        this.currentUser = currentUser;
    }

    public List<String> getPermissionValueList() {
        return permissionValueList;
    }

    public void setPermissionValueList(List<String> permissionValueList) {
        this.permissionValueList = permissionValueList;
    }

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        Collection<GrantedAuthority> authorities = new ArrayList<>();

        for (String permissionValue : this.permissionValueList) {
            if (!StringUtils.isNullOrEmpty(permissionValue)){
                authorities.add(new SimpleGrantedAuthority(permissionValue));
            }
        }

        return authorities;
    }

    @Override
    public String getPassword() {
        return this.currentUser.getPassword();
    }

    @Override
    public String getUsername() {
        return this.currentUser.getUsername();
    }

    @Override
    public boolean isAccountNonExpired() {
        return true;
    }

    @Override
    public boolean isAccountNonLocked() {
        return true;
    }

    @Override
    public boolean isCredentialsNonExpired() {
        return true;
    }

    @Override
    public boolean isEnabled() {
        return true;
    }
}
