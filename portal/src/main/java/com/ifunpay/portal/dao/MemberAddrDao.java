package com.ifunpay.portal.dao;

import com.ifunpay.portal.entity.MemberAddr;
import com.jspgou.common.hibernate3.HibernateBaseDao;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by David on 2015/5/8.
 */

public class MemberAddrDao extends HibernateBaseDao<MemberAddr,String> {



    public List<MemberAddr> getAddrByMember(String id){
    return baseDao.findBy("memberId",id,MemberAddr.class);
    };
    @Resource
    BaseDao baseDao;
    @Override
    protected Class<MemberAddr> getEntityClass() {
        return null;
    }

    @Transactional
    public void update(MemberAddr memberAddr) {
        baseDao.update(memberAddr);
    }

    @Transactional
    public void save(MemberAddr memberAddr) {
        baseDao.save(memberAddr);
    }
}
