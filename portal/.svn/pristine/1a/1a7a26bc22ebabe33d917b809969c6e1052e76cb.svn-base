package com.ifunpay.portal.controller.security;

import com.ifunpay.portal.dao.simple.SimpleOrderDao;
import com.ifunpay.portal.entity.OrderPayRefundEntity;
import com.ifunpay.portal.entity.order.OrderEntity;
import com.ifunpay.util.enums.PaymentStatusEnum;
import com.ifunpay.portal.model.payment.RefundResult;
import com.ifunpay.portal.service.PayRefundService;
import com.ifunpay.portal.service.payment.CmbcBankPaymentManager;
import com.jspgou.cms.dao.SequenceDao;
import com.jspgou.cms.entity.*;
import com.jspgou.cms.manager.*;
import org.apache.log4j.Logger;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import javax.persistence.Transient;
import java.util.Date;
import java.util.Map;
import java.util.HashMap;
import java.util.List;

/**
 * Created by Administrator on 2015/4/7.
 */
@RestController
@RequestMapping("/security/order")
public class OrderRestController {

    private static Logger logger = Logger.getLogger(OrderRestController.class);

    @Resource
    private SimpleOrderDao simpleOrderDao;

    @Resource
    private OrderMng orderMng;

    @Resource
    private ProductFashionMng productFashionMng;

    @Resource
    private ProductMng productMng;

    @Resource
    private ShopScoreMng shopScoreMng;


    @Resource
    private ShopMemberMng shopMemberMng;


    @Resource
    private CmbcBankPaymentManager cmbcBankPaymentManager;

    @Resource
    private SequenceDao sequenceDao;

    @Resource
    private PayRefundService payRefundService;

    @RequestMapping("/fetch")
    public Object fetch(@RequestBody Map<String, Object> requestParam) {

        Map<String, Object> map = new HashMap<>();

//        String orderId = (String) requestParam.get("id");
//        String commerceName = (String) requestParam.get("commerceName");
        Map<String, Object> filters = (Map<String, Object>) requestParam.get("filters");
        String sortField = (String) requestParam.get("sortField");
        boolean isASC = "ASC".equalsIgnoreCase((String) requestParam.get("sortOrder"));
        int start = (int) requestParam.get("start");
        int size = (int) requestParam.get("size");
        List<OrderEntity> orderList = simpleOrderDao.fetchOrders(filters, sortField, isASC, start, size);
        logger.info("list order size is:" + orderList.size());
        map.put("orders", orderList);
        return map;
    }


    @RequestMapping("/refund")
    public Object refund(@RequestBody Map<String, Object> requestParam) {
        Map<String, Object> map = new HashMap<>();

        map.put("result", "refundError");

        String orderId = (String) requestParam.get("orderId");
        int amount = (int) requestParam.get("amount");
        String refundId = sequenceDao.getOrderRefundEntityId();
        logger.info("refund id == " + refundId);
        List<OrderPayRefundEntity> orderRefundEntityList = payRefundService.getAllRefundListByOrderId("0", orderId);//退款List
        List<OrderPayRefundEntity> orderPayEntityList = payRefundService.getAllRefundListByOrderId("1", orderId);//付款List

        if (orderRefundEntityList.size() > 0) {
            OrderPayRefundEntity orderRefundEntity = orderRefundEntityList.get(0);
            if (orderRefundEntity.getPayStatus() == PaymentStatusEnum.RefundFailed) {
                //退款失败，重新进行退款
                logger.info("退款失败，重新进行退款");
                RefundResult result = dealWithRefund(orderId, amount, refundId, orderRefundEntity);
                map.put("result", result);
            }

        } else if (orderPayEntityList.size() > 0) {
            OrderPayRefundEntity orderPayEntity = orderPayEntityList.get(0);
            if (orderPayEntity.getPayStatus() == PaymentStatusEnum.PaySucceeded) {
                //付款成功，进行退款
                logger.info("付款成功，进行退款");
                RefundResult result = dealWithRefund(orderId, amount, refundId, orderPayEntity);
                map.put("result", result);
            }
        }

        return map;
    }

    private RefundResult dealWithRefund(String orderId, int amount, String refundId, OrderPayRefundEntity orderPayRefundEntity) {
        RefundResult refundResult = cmbcBankPaymentManager.refund(orderId, amount, refundId);

        OrderPayRefundEntity entity = new OrderPayRefundEntity();

        entity.setId(refundId);
        entity.setCode(refundResult.getOrderId());
        entity.setAmount(orderPayRefundEntity.getAmount());
        entity.setAccountNumber(orderPayRefundEntity.getAccountName());
        entity.setAccountNumber(orderPayRefundEntity.getAccountNumber());

        int status = refundResult.getStatus();
        if (status == 0) {
            entity.setPayStatus(PaymentStatusEnum.RefundSucceeded);
        } else {
            entity.setPayStatus(PaymentStatusEnum.RefundFailed);
        }
        entity.setIsPay("0".toCharArray()[0]);
        entity.setPayMethod(orderPayRefundEntity.getPayMethod());
        entity.setPayTime(new Date());
        entity.setSerialNumber(orderPayRefundEntity.getSerialNumber());

        logger.info("save refund entity");
        payRefundService.saveRefundInfo(entity);

        Order order = orderMng.getEntityByCode(orderId);
        //order.setPaymentStatus(entity.getPayStatus());
        orderMng.updateByUpdater(order);
        return refundResult;
    }

    @RequestMapping("/confirm")
    public Object confirm(@RequestBody Map<String, Object> requestParam) {
        Map<String, Object> map = new HashMap<>();

        map.put("result", "fail");

        String orderId = (String) requestParam.get("id");
        Order order = orderMng.getEntityByCode(orderId);
        if (order.getStatus() == 1) {
            order.setStatus(2);
            orderMng.updateByUpdater(order);
            map.put("result", "success");
        }
        return map;
    }

    @RequestMapping("/fetchCurrent")
    public Object fetchCurrent(@RequestBody Map<String, Object> requestParam) {
        Map<String, Object> map = new HashMap<>();
        map.put("order", null);
        String orderId = (String) requestParam.get("id");
        Order order = orderMng.getEntityByCode(orderId);
        map.put("order", order);
        return map;
    }

    @RequestMapping("/fetchOrderPay")
    public Object fetchOrderPayDetails(@RequestBody Map<String, Object> requestParam) {
        Map<String, Object> map = new HashMap<>();
        String orderId = (String) requestParam.get("id");
        List<OrderPayRefundEntity> orderPayList = payRefundService.getAllRefundListByOrderId("1", orderId);
        map.put("pays", orderPayList);
        List<OrderPayRefundEntity> refundList = payRefundService.getAllRefundListByOrderId("0", orderId);
        map.put("refunds", refundList);
        return map;
    }

    @RequestMapping("/cancel")
    public Object cancel(@RequestBody Map<String, Object> requestParam) {

        Map<String, Object> map = new HashMap<>();

        map.put("result", false);
        String orderId = (String) requestParam.get("id");
        Order order = orderMng.getEntityByCode(orderId);
        if (order.getStatus() != 4 && order.getStatus() != 3 && order.getShippingStatus() != 2 && order.getPaymentStatus() != 2) {
            order.setStatus(3);
            //处理库存
            for (OrderItem item : order.getItems()) {
                Product product = item.getProduct();
                if (item.getProductFash() != null) {
                    ProductFashion fashion = item.getProductFash();
                    fashion.setStockCount(fashion.getStockCount() + item.getCount());
                    product.setStockCount(product.getStockCount() + item.getCount());
                    productFashionMng.update(fashion);
                } else {
                    product.setStockCount(product.getStockCount() + item.getCount());
                }
                productMng.updateByUpdater(product);
            }
            //会员冻结的积分
            ShopMember member = order.getMember();
            member.setFreezeScore(member.getFreezeScore() - order.getScore());
            shopMemberMng.update(member);
            List<ShopScore> list = shopScoreMng.getlist(order.getCode());
            for (ShopScore s : list) {
                shopScoreMng.deleteById(s.getId());
            }
            orderMng.updateByUpdater(order);
            map.put("result", true);
        }
        return map;
    }
}
