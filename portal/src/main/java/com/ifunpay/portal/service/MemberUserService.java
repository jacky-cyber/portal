package com.ifunpay.portal.service;

import com.ifunpay.portal.dao.MemberUserDao;
import com.ifunpay.portal.dao.MemberUserHibernateDao;
import com.ifunpay.portal.entity.MemberUserEntity;
import com.jspgou.common.page.Pagination;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.Date;

/**
 * Created by David on 2015/4/16.
 */
@Component
public class MemberUserService {
    @Resource
    private MemberUserDao memberUserDao;

    @Resource
    private MemberUserHibernateDao memberUserHibernateDao;
   @Transactional
    public MemberUserEntity getEntityByName(String username){
        return memberUserDao.getEntityName(username);
    }

    public void save(MemberUserEntity memberUserEntity) {
        memberUserDao.save(memberUserEntity);
    }

    public void update(MemberUserEntity memberUserEntity) {
        memberUserDao.saveOrUpdate(memberUserEntity);
    }

    public java.util.List<MemberUserEntity> getAllMemberUser(){
       return memberUserDao.getAllMemberUser();
    }

    public MemberUserEntity getEntityByUuid(String member_user_id) {

        return memberUserDao.getEntityByUuid(member_user_id);
    }

    public Pagination getPageForClientUser(String channelId, String commerceId, String phone, String registerIp, Integer origin, Date startTime, Date endTime, Long webId, int pageNo, int pageSize){

        Pagination page = memberUserHibernateDao.getPageForClientDao(channelId, commerceId, phone, registerIp, origin, startTime, endTime, webId, pageNo, pageSize);
        return page;
    }
}
