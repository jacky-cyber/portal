package com.ifunpay.portal.service.security;

import com.ifunpay.portal.security.MemberUserRealm;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;

/**
 * Created by yu on 15-6-11.
 */
@Component
public class ShiroSecurityService {

    public void auth(String username, String password){
        UsernamePasswordToken token = new UsernamePasswordToken(username, MemberUserRealm.encryptPassword(password));
        SecurityUtils.getSubject().login(token);
    }
}
