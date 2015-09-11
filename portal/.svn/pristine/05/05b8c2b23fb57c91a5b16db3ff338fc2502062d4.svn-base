package com.ifunpay.portal.service;


import com.ifunpay.portal.dao.BaseDao;
import com.ifunpay.portal.entity.BankPayInfo;
import com.ifunpay.util.common.StringUtil;
import com.ifunpay.util.enums.OperatingSystems;
import com.ifunpay.portal.model.BankAppEnum;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.hibernate.Criteria;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.io.Serializable;
import java.util.List;

/**
 * Created by Yu on 2014/12/16.
 */
@Component
public class BankPayInfoService {

    @Resource
    private BaseDao baseDao;
    private static Logger log = Logger.getLogger(BankPayInfoService.class);


    /**
     * 保存支付方式信息
     * @param bankPayInfo
     * @return
     */
    @Transactional
    public Boolean saveBankPayInfo(BankPayInfo bankPayInfo) {
        try {
            if (StringUtils.isBlank(bankPayInfo.getId())) bankPayInfo.setId(StringUtil.uuid());
            baseDao.saveOrUpdate(bankPayInfo);
            return true;
        } catch (Exception e) {
            log.error("保存银行支付信息失败！", e);
        }
        return false;
    }

    /**
     * 根据ID查找支付方式信息
     * @param id
     * @return
     */
    public BankPayInfo getBankPayInfoById(String id) {
        try {
            return baseDao.get(BankPayInfo.class, id).get();
        } catch (Exception e) {
            log.error("查找支付信息失败！", e);
            return null;
        }
    }

    /**
     * 删除支付方式
     * @param payMethodId
     */
    @Transactional
    public void deletePayMethodInfos(String... payMethodId) {
        try{
            baseDao.delete(BankPayInfo.class, payMethodId);
        } catch (Exception e) {
            log.error("删除支付方式失败！", e);
        }
    }

    /**
     * 用户重名检验
     * @param name
     * @param type
     * @param id
     * @return
     */
    public String validateName(String name, String type, String id) {
        org.hibernate.Criteria criteria = baseDao.getSession().createCriteria(BankPayInfo.class);
        criteria.add(Restrictions.eq("name", name));
        if (type.equals("edit")) {
            criteria.add(Restrictions.ne("id", id));
            if (1 <= criteria.list().size()) {
                return "true";
            } else {
                return "false";
            }
        } else {
            if (1 <= criteria.list().size()) {
                return "true";
            } else {
                return "false";
            }
        }
    }

    /**
     * 获取所有的支付信息
     * @return
     */
    public List<BankPayInfo> getPayInfo() {
        return baseDao.getAll(BankPayInfo.class);
    }
}
