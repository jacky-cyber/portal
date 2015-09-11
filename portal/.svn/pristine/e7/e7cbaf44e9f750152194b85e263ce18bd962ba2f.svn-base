package com.ifunpay.portal.dao.order;

import com.ifunpay.portal.dao.BaseDao;
import com.ifunpay.portal.entity.order.OrderEntity;
import com.ifunpay.portal.entity.order.OrderPostInfo;
import com.ifunpay.portal.entity.order.OrderProduct;
import com.jspgou.common.hibernate3.HibernateBaseDao;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

/**
 * Created by CongLong Xie on 2015/7/27.
 */
@Service
public class OrderPostInfoDao extends HibernateBaseDao<OrderPostInfo,Long>{

    @Resource
    private BaseDao baseDao;

    public void saveOrderPostInfo(OrderPostInfo orderPostInfo){
        baseDao.save(orderPostInfo);
    }

    public OrderPostInfo findPostInfoByOrderId(String orderId){
        return (OrderPostInfo)getSession().createQuery("from OrderPostInfo where orderNumber ='"+orderId+"'").uniqueResult();
    }

    @Override
    protected Class<OrderPostInfo> getEntityClass() {
        return null;
    }
}
