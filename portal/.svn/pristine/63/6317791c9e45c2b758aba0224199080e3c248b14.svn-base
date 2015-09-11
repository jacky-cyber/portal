package com.ifunpay.portal.service;

import com.ifunpay.portal.dao.OrderPayRefundDao;
import com.ifunpay.portal.entity.OrderPayRefundEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * Created by Cong Long Xie on 2015/4/9.
 */
import javax.annotation.Resource;
import java.util.*;
@Service
public class PayRefundService {
    @Resource
    private OrderPayRefundDao orderPayRefundDao;

    public List<OrderPayRefundEntity> getAllRefundListByOrderId(String isPay,String orderId){
        return orderPayRefundDao.findOrderRefundListByOrderId(isPay,orderId);
    }

    @Transactional
    public void saveRefundInfo(OrderPayRefundEntity orderPayRefundEntity){
        orderPayRefundDao.save(orderPayRefundEntity);
    }
}
