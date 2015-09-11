package com.ifunpay.portal.service;

import com.ifunpay.portal.dao.BaseDao;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;

/**
 * Created by Yu on 2015/3/3.
 */
@Component
public class TestService {

    @Resource
    BaseDao baseDao;

    @Transactional
    public void save(Object o){
        baseDao.getSession().save(o);
    }

}
