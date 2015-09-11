package com.ifunpay.portal.dao;

import com.jspgou.cms.entity.Order;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.Basic;

/**
 * Created by Administrator on 2015/3/10.
 */
@Component
public class TerminalOrderDao extends BaseDao {

    @Transactional
    public void updateOrder(Order order){
        update(order);
    }

}
