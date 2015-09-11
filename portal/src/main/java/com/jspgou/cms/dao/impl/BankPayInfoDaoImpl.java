package com.jspgou.cms.dao.impl;

import com.ifunpay.portal.dao.BaseDao;
import com.ifunpay.portal.entity.BankPayInfo;
import com.jspgou.cms.dao.BankPayInfoDao;
import com.jspgou.common.hibernate3.Finder;
import com.jspgou.common.hibernate3.HibernateBaseDao;
import com.jspgou.common.page.Pagination;
import org.apache.commons.lang.StringUtils;
import org.hibernate.Criteria;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Repository;

import javax.annotation.Resource;

/**
 * Created by zj on 15-7-17.
 */
@Repository
public class BankPayInfoDaoImpl extends HibernateBaseDao<BankPayInfo,String> implements BankPayInfoDao {

    public Pagination getBankPayInfo(String id, int pageNo, int pageSize) {
        StringBuffer hql = new StringBuffer();
        hql.append("from BankPayInfo where 1=1 ");
        if (StringUtils.isNotBlank(id)){
            hql.append("and id like '%" + id + "%'");
        }

        Finder f = Finder.create(hql.toString());
        return find(f, pageNo, pageSize);
    }

    @Override
    public Boolean checkName(String name, Object... values) {
        Criteria criteria = baseDao.createCriteria(BankPayInfo.class);
        criteria.add(Restrictions.eq("name", name));
        if (0<values.length){
            criteria.add(Restrictions.ne("id", values[0]));
        }
        if (1 <= criteria.list().size()) {
            return true;
        }
        return false;
    }

    public void save(BankPayInfo bankPayInfo) {
        baseDao.save(bankPayInfo);
    }

    @Override
    public BankPayInfo getBankPayInfoById(String id) {
        return baseDao.get(id, BankPayInfo.class);
    }

    public void update(BankPayInfo bankPayInfo) {
        BankPayInfo bpi = getBankPayInfoById(bankPayInfo.getId());
        bpi.setName(bankPayInfo.getName());
        bpi.setMerchantId(bankPayInfo.getMerchantId());
        bpi.setWebCounter(bankPayInfo.getWebCounter());
        bpi.setMobileCounter(bankPayInfo.getMobileCounter());
        bpi.setBranch(bankPayInfo.getBranch());
        bpi.setApp(bankPayInfo.getApp());
        bpi.setPublicKey(bankPayInfo.getPublicKey());
        bpi.setRemark(bankPayInfo.getRemark());
        bpi.setType(bankPayInfo.getType());
        baseDao.update(bpi);
    }

    public BankPayInfo deleteById(String id) {
        BankPayInfo bankPayInfo = super.get(id);
        baseDao.delete(bankPayInfo);
        return bankPayInfo;
    }

    @Override
    protected Class<BankPayInfo> getEntityClass() {
        return BankPayInfo.class;
    }

    @Resource
    private BaseDao baseDao;
}
