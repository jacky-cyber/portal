package com.ifunpay.portal.service.order;

import com.ifunpay.portal.dao.OrderPayRefundDao;
import com.ifunpay.portal.entity.OrderPayRefundEntity;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by CongLong Xie on 2015/7/31.
 */
@Service
public class OrderPayRefundService {
    @Resource
    private OrderPayRefundDao orderPayRefundDao;

    public List<OrderPayRefundEntity> findPayRefundListByOrderNumber(String orderNumber){
        return orderPayRefundDao.findPayRefundOrderByOrderNumber(orderNumber);
    }

    public OrderPayRefundEntity getPaySuccessEntityByOrderID(String orderNumber){
        return orderPayRefundDao.getPaySuccessEntity(orderNumber);
    }

}
