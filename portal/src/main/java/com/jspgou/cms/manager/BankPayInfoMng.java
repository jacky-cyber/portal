package com.jspgou.cms.manager;

import com.ifunpay.portal.entity.BankPayInfo;
import com.jspgou.common.page.Pagination;

/**
 * Created by zj on 15-7-17.
 */

public interface BankPayInfoMng {

    Pagination getBankPayInfo(String id, int pageNo, int pageSize);

    Boolean checkName(String name, Object... values);

    String save(BankPayInfo bankPayInfo);

    BankPayInfo getBankPayInfoById(String id);

    void update(BankPayInfo bankPayInfo);

    BankPayInfo[] deleteByIds(String[] ids);

    BankPayInfo deleteById(String id);

}
