package com.ifunpay.portal.controller.terminal;

import com.ifunpay.portal.entity.order.OrderEntity;
import com.ifunpay.portal.entity.order.OrderProduct;
import com.ifunpay.portal.service.order.OrderEntityService;
import com.ifunpay.portal.service.order.OrderProductService;
import com.ifunpay.util.enums.PaymentStatusEnum;
import com.ifunpay.util.enums.ShipmentStatusEnum;
import com.ifunpay.util.jackson.JsonUtil;
import com.jspgou.cms.manager.ProductMng;
import org.apache.commons.io.IOUtils;
import org.apache.log4j.Logger;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by Yu on 2015/3/24.
 */
@RestController
@RequestMapping("/terminal")
public class DeliverFeedbackController {

    private Logger logger = Logger.getLogger(DeliverFeedbackController.class);
    @Resource
    private OrderEntityService orderEntityService;

    @Resource
    private OrderProductService orderProductService;

    @Resource
    private ProductMng productMng;

    @RequestMapping("/feedback")
    public Object feedback(HttpServletRequest request) {
        Map<String, Object> result = new HashMap<>();
        result.put("success", false);
        try {
            String json = IOUtils.toString(request.getInputStream(), "utf-8");
            logger.info("receive feedback: " + json);
            Map<String, Object> map = JsonUtil.toObject(json);
            Map<String, Object> body = (Map<String, Object>) map.get("body");
            String terminalId = (String) body.get("terminalId");
            String serial = (String) body.get("serial");
            Integer state = Integer.valueOf(body.get("state").toString());
            String errorMessage = (String) body.get("errorMessage");
            logger.info("terminalId ="+terminalId+",serial no.="+serial);
            logger.info("errorMessage ="+errorMessage);
            List<OrderEntity> orderEntityList = orderEntityService.findOrderEntityByTerminalIdAndSerialNo(terminalId,serial);
            if (orderEntityList == null || orderEntityList.isEmpty()) {
                logger.info("no such order.");
                result.put("message", "当前订单不存在");
            }else {
                OrderEntity order = orderEntityList.get(0);
                logger.info("order id ="+order.getCode());
                List<OrderProduct> orderProducts = orderProductService.getOrderProductByOrderId(order.getCode());
                Long[] prodIds = new Long[orderProducts.size()];
                Integer[] qtys = new Integer[orderProducts.size()];
                logger.info("order products list size ="+orderProducts.size());
                for(int i=0;i<orderProducts.size();i++){
                    prodIds[i] = orderProducts.get(i).getProduct().getId();
                    qtys[i] = orderProducts.get(i).getProductQty();
                }
                if (state == 0) {
                    logger.info("local product reduce inventory.");
                    order.setShipmentStatus(ShipmentStatusEnum.Delivery);
                    productMng.reduceInventory(prodIds, qtys);
                } else {
                    if(order.getPaymentStatus() == PaymentStatusEnum.PaySucceeded) {
                        order.setShipmentStatus(ShipmentStatusEnum.ShipError);
                    }
                }
                order.setFeedBack(errorMessage);
                orderEntityService.updateOrderEntity(order);
                result.put("success", true);
            }
        } catch (Exception e) {
            logger.error("", e);
            String message = e.getClass().getSimpleName() + ": " + e.getMessage();
            result.put("message", message);
        }
        return result;
    }
}
