package com.jspgou.cms.manager.impl;

import com.ifunpay.portal.entity.BankPayInfo;
import com.jspgou.cms.dao.BankPayInfoDao;
import com.jspgou.cms.entity.Payment;
import com.jspgou.cms.manager.BankPayInfoMng;
import com.jspgou.common.page.Pagination;
import org.springframework.beans.factory.annotation.Autowired;

/**
 * Created by zj on 15-7-17.
 */
public class BankPayInfoMngImpl implements BankPayInfoMng {

    @Override
    public Pagination getBankPayInfo(String id, int pageNo, int pageSize) {
        return bankPayInfoDao.getBankPayInfo(id, pageNo, pageSize);
    }

    @Override
    public Boolean checkName(String name, Object... values) {
        return bankPayInfoDao.checkName(name, values);
    }

    @Override
    public String save(BankPayInfo bankPayInfo) {
        String id = bankPayInfo.getName();
        bankPayInfo.setId(bankPayInfo.getName());
        bankPayInfoDao.save(bankPayInfo);
        return id;
    }

    @Override
    public BankPayInfo getBankPayInfoById(String id) {
        return bankPayInfoDao.getBankPayInfoById(id);
    }

    @Override
    public void update(BankPayInfo bankPayInfo) {
        bankPayInfoDao.update(bankPayInfo);
    }

    @Override
    public BankPayInfo[] deleteByIds(String[] ids) {
        BankPayInfo[] beans = new BankPayInfo[ids.length];
        for (int i = 0, len = ids.length; i < len; i++) {
            beans[i] = deleteById(ids[i]);
        }
        return beans;
    }

    public BankPayInfo deleteById(String id) {
        BankPayInfo bean = bankPayInfoDao.deleteById(id);
        return bean;
    }

    @Autowired
    private BankPayInfoDao bankPayInfoDao;
}
