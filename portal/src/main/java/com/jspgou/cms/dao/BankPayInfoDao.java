package com.jspgou.cms.dao;

import com.ifunpay.portal.entity.BankPayInfo;
import com.jspgou.common.page.Pagination;

/**
 * Created by zj on 15-7-17.
 */
public interface BankPayInfoDao {
    Pagination getBankPayInfo(String id, int pageNo, int pageSize);

    Boolean checkName(String name, Object... values);

    void save(BankPayInfo bankPayInfo);

    BankPayInfo getBankPayInfoById(String id);

    void update(BankPayInfo bankPayInfo);

    BankPayInfo deleteById(String id);
}
