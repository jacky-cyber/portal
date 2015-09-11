package com.ifunpay.portal.security;

import com.ifunpay.portal.entity.MemberUserEntity;
import com.ifunpay.portal.service.MemberUserService;
import org.apache.shiro.authc.*;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.crypto.hash.Sha256Hash;
import org.apache.shiro.crypto.hash.SimpleHash;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.util.ByteSource;

import javax.annotation.Resource;

/**
 * Created by yu on 15-6-11.
 */
public class MemberUserRealm extends AuthorizingRealm {


    public static final String SALT = Sha256Hash.ALGORITHM_NAME;

    @Resource
    MemberUserService memberUserService;

    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken token) throws AuthenticationException {
        UsernamePasswordToken usernamePasswordToken = (UsernamePasswordToken) token;
        String username = usernamePasswordToken.getUsername();
        MemberUserEntity memberUserEntity = memberUserService.getEntityByName(username);
        if(memberUserEntity != null){
            return new SimpleAuthenticationInfo(username, memberUserEntity.getPassword(), getSaltByteSource(), getName());
        }else{
            return null;
        }
    }


    @Override
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principals) {
        return null;
    }


    public static String encryptPassword(Object password) {
        return new SimpleHash(SALT, password, getSaltByteSource())
                .toBase64();
    }

    private static ByteSource getSaltByteSource() {
        return ByteSource.Util.bytes(SALT);
    }


}
