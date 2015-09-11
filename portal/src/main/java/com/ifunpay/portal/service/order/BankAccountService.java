package com.ifunpay.portal.service.order;

import com.ifunpay.portal.dao.order.BankAccountDao;
import com.ifunpay.portal.model.PaidInfo;
import lombok.extern.log4j.Log4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;

/**
 * Created by CongLong Xie on 2015/8/6.
 */
@Service
@Log4j
public class BankAccountService {
    @Resource
    private BankAccountDao bankAccountDao;

    @Transactional
    public void saveBankAccountInfo(PaidInfo paidInfo){
        bankAccountDao.saveAccountInfo(paidInfo);
    }
}
