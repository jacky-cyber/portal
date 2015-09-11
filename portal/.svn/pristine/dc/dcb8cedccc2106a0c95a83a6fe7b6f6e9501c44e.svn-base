package com.ifunpay.portal.task;

import com.ifunpay.portal.service.order.OrderEntityService;
import com.ifunpay.portal.service.order.OrderProductService;
import org.apache.log4j.Logger;

import javax.annotation.Resource;
import java.util.Date;

/**
 * Created by CongLong Xie on 2015/7/24.
 */
public class OrderStatusTask {
    Logger logger = Logger.getLogger(OrderStatusTask.class);
    @Resource
    private OrderEntityService orderEntityService;
    public void execute(){
       logger.info("recovery inventory starting ...");
        orderEntityService.updateOrderEntityExpireAndRecoveryInventory();
        logger.info("recovery inventory ending ...");
    }
}
