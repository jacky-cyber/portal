package com.ifunpay.portal.service.order;

import com.ifunpay.portal.dao.order.OrderPostInfoDao;
import com.ifunpay.portal.entity.order.OrderPostInfo;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

/**
 * Created by CongLong Xie on 2015/7/31.
 */
@Service
public class OrderPostInfoService {
    private static Logger logger = Logger.getLogger(OrderPostInfoService.class);

    @Resource
    private OrderPostInfoDao orderPostInfoDao;

    public OrderPostInfo findOrderPostInfoByOrderNumber(String orderNumber){
        return  orderPostInfoDao.findPostInfoByOrderId(orderNumber);
    }
}
