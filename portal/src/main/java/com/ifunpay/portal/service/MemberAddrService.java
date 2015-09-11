package com.ifunpay.portal.service;

import com.ifunpay.portal.dao.MemberAddrDao;
import com.ifunpay.portal.entity.MemberAddr;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by David on 2015/5/8.
 */
@Component
public class MemberAddrService {
    @Resource
    MemberAddrDao memberAddrDao;
    @Transactional
    public List<MemberAddr> getAddrByMember(String id) {
        return memberAddrDao.getAddrByMember(id);
    }

    public void update(MemberAddr memberAddr) {
        memberAddrDao.update(memberAddr);
    }

    public void save(MemberAddr memberAddr) {
         memberAddrDao.save(memberAddr);
    }
}
