package com.ifunpay.portal.dao.order;

import com.ifunpay.portal.dao.BaseDao;
import com.ifunpay.portal.entity.order.BankAccountInfo;
import com.ifunpay.portal.model.PaidInfo;
import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.Date;

/**
 * Created by CongLong Xie on 2015/8/6.
 */
@Service
public class BankAccountDao {
    @Resource
    private BaseDao baseDao;

    private Logger logger = LoggerFactory.getLogger(BankAccountDao.class);


    public void saveAccountInfo(PaidInfo paidInfo) {
        if(!StringUtils.isBlank(paidInfo.getSerialNumber())) {
            BankAccountInfo bankAccountInfo = new BankAccountInfo();
            bankAccountInfo.setOrderId(paidInfo.getOrderId());
            bankAccountInfo.setParamName("SerialNumber");
            bankAccountInfo.setParamValue(paidInfo.getSerialNumber());
            bankAccountInfo.setCreateTime(new Date());
            baseDao.save(bankAccountInfo);
        }
        if(!StringUtils.isBlank(paidInfo.getUserName())) {
            BankAccountInfo bankAccountInfo = new BankAccountInfo();
            bankAccountInfo.setOrderId(paidInfo.getOrderId());
            bankAccountInfo.setParamName("UserName");
            bankAccountInfo.setParamValue(paidInfo.getUserName());
            bankAccountInfo.setCreateTime(new Date());
            baseDao.save(bankAccountInfo);
        }
        if(!StringUtils.isBlank(paidInfo.getAccount())) {
            BankAccountInfo bankAccountInfo = new BankAccountInfo();
            bankAccountInfo.setOrderId(paidInfo.getOrderId());
            bankAccountInfo.setParamName("Account");
            bankAccountInfo.setParamValue(paidInfo.getAccount());
            bankAccountInfo.setCreateTime(new Date());
            baseDao.save(bankAccountInfo);
        }
        if(!StringUtils.isBlank(paidInfo.getBranchId())) {
            BankAccountInfo bankAccountInfo = new BankAccountInfo();
            bankAccountInfo.setOrderId(paidInfo.getOrderId());
            bankAccountInfo.setParamName("BranchId");
            bankAccountInfo.setParamValue(paidInfo.getBranchId());
            bankAccountInfo.setCreateTime(new Date());
            baseDao.save(bankAccountInfo);
        }
        if(!StringUtils.isBlank(paidInfo.getBank().name())) {
            BankAccountInfo bankAccountInfo = new BankAccountInfo();
            bankAccountInfo.setOrderId(paidInfo.getOrderId());
            bankAccountInfo.setParamName("Bank");
            bankAccountInfo.setParamValue(paidInfo.getBank().name());
            bankAccountInfo.setCreateTime(new Date());
            baseDao.save(bankAccountInfo);
        }
        if(!StringUtils.isBlank(paidInfo.getPosId())) {
            BankAccountInfo bankAccountInfo = new BankAccountInfo();
            bankAccountInfo.setOrderId(paidInfo.getOrderId());
            bankAccountInfo.setParamName("PosId");
            bankAccountInfo.setParamValue(paidInfo.getPosId());
            bankAccountInfo.setCreateTime(new Date());
            baseDao.save(bankAccountInfo);
        }
        if(!StringUtils.isBlank(paidInfo.getAmount()+"")) {
            BankAccountInfo bankAccountInfo = new BankAccountInfo();
            bankAccountInfo.setOrderId(paidInfo.getOrderId());
            bankAccountInfo.setParamName("Amount");
            bankAccountInfo.setParamValue(paidInfo.getAmount()+"");
            bankAccountInfo.setCreateTime(new Date());
            baseDao.save(bankAccountInfo);
        }
        if(!StringUtils.isBlank(paidInfo.getStatus().getDisplayName())) {
            BankAccountInfo bankAccountInfo = new BankAccountInfo();
            bankAccountInfo.setOrderId(paidInfo.getOrderId());
            bankAccountInfo.setParamName("Status");
            bankAccountInfo.setParamValue(paidInfo.getStatus().getDisplayName());
            bankAccountInfo.setCreateTime(new Date());
            baseDao.save(bankAccountInfo);
        }

    }
}
