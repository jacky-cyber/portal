package com.ifunpay.portal.controller;

import com.ifunpay.portal.service.TerminalOrderService;
import org.apache.commons.io.IOUtils;
import org.apache.log4j.Logger;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.io.IOException;

/**
 * Created by Yu on 2015/4/1.
 */
@RestController
@RequestMapping("/notification")
public class NotificationController {

    private Logger logger = Logger.getLogger(NotificationController.class);

    @Resource
    TerminalOrderService terminalOrderService;

    @RequestMapping("/terminal/feedback")
    public void terminalDeliverFeedback(HttpServletRequest request) {
        String s = null;
        try {
            s = IOUtils.toString(request.getInputStream(), "utf-8");
        } catch (IOException e) {
            logger.error("", e);
        }
        //       terminalOrderService.deliverFeedback(s);

    }

//    public Object feedback(HttpServletRequest request) {
//        Map<String, Object> result = new HashMap<>();
//        result.put("success", false);
//        try {
//            String json = IOUtils.toString(request.getInputStream(), "utf-8");
//            Map<String, Object> map = JsonUtil.toObject(json);
//            Map<String, Object> body = (Map<String, Object>) map.get("body");
//            String terminalId = (String) body.get("terminalId");
//            String serial = (String) body.get("serial");
//            Integer state = (Integer) body.get("state");
//            String errorMessage = (String) body.get("errorMessage");
//            OrderEntity orderEntity = orderDao.getOrderByTerminalSerial(terminalId, serial);
//            if (orderEntity == null) {
//                result.put("message", "no such order");
//            } else {
//                if (orderEntity.getShipStatus() == ShipmentStatusEnum.Received ) {
//                    //ignore
//                } else {
//                    if (state == 0) {
//                        TerminalStorageRack terminalStorageRack = orderDao.getStorageRack(orderEntity);
//                        if( terminalStorageRack == null){
//                            logger.info("storage info: 没有库存信息 TERMINAL[" + terminalId + "], ORDER[" + orderEntity.getId() + "]");
//                        }else{
//                            int storage = terminalStorageRack.getCellStockCurrent();
//                            if(storage <= 0){
//                                logger.info("storage info: 库存量： " + storage);
//                            }else{
//                                terminalStorageRack.setCellStockCurrent(storage - 1);
//                                logger.info("storage info: 库存量改为：" + (storage - 1));
//                                orderDao.save(terminalStorageRack);
//                            }
//                        }
//                        orderEntity.setShipStatus(ShipmentStatusEnum.Received);
//                    }else {
//                        orderEntity.setShipStatus(ShipmentStatusEnum.DeliverFailed);
//                        orderEntity.setFeedbackMessage(errorMessage);
//                    }
//                    orderDao.save(orderEntity);
//                }
//                result.put("success", true);
//            }
//        } catch (Exception e) {
//            String message = e.getClass().getSimpleName() + ": " + e.getMessage();
//            result.put("message", message);
//        }
//        return result;
//    }
}
