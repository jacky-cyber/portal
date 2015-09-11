package com.ifunpay.portal.service;

import com.ifunpay.front.TerminalFrontRemoteControl;
import com.ifunpay.front.bean.response.BaseRestResponse;
import com.ifunpay.portal.ProjectXml;
import com.ifunpay.portal.entity.order.OrderEntity;
import com.ifunpay.portal.entity.order.OrderProduct;
import com.ifunpay.util.enums.PaymentStatusEnum;
import com.ifunpay.portal.model.PaidInfo;
import com.ifunpay.portal.service.order.OrderEntityService;
import com.ifunpay.portal.service.order.OrderProductService;
import com.jspgou.cms.manager.ProductMng;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.annotation.Lazy;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.PostConstruct;
import javax.annotation.Resource;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Observable;
import java.util.Observer;

/**
 * Created by Xie Cong Long on 2014/12/25.
 * deal with the info by paid call back
 */
@Component
@Lazy(false)
public class MobilePayCallBackService implements Observer {

    Logger logger = LoggerFactory.getLogger(MobilePayCallBackService.class);

    @Resource
    PaymentManageService paymentManageService;

    @Resource
    private ThreadPoolService threadPoolService;

    @Resource
    private TerminalFrontRemoteControl terminalFrontRemoteControl;

    @Resource
    private NotifyPayService notifyPayService;

    @Resource
    private OrderProductService orderProductService;

    @Resource
    private OrderVoucherService orderVoucherService;

    @Resource
    private OrderEntityService orderEntityService;

    @Resource
    private ProductMng productMng;

    @PostConstruct
    public void init() {
        paymentManageService.addObserver(this);
    }

    @Override
    public void update(Observable o, Object arg) {
        if (arg instanceof PaidInfo) {
            PaidInfo paidInfo = (PaidInfo) arg;
            logger.info("Pay Call Back Starting ... order id ="+paidInfo.getOrderId());
            boolean acceptBankCallbackFromUser = Boolean.valueOf(ProjectXml.getValue("from_user"));
            boolean acceptBankCallbackFromBackground = Boolean.valueOf(ProjectXml.getValue("from_back_end"));
            if(acceptBankCallbackFromUser && paidInfo.isFromUser() || !paidInfo.isFromUser() && acceptBankCallbackFromBackground)
                synchronized (paidInfo.getOrderId().intern()) {
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
                try {
                    if (checkIfAlreadyProcessed(paidInfo)) {
                        logger.info("already process, ignore. " + paidInfo.getOrderId());
                    } else {
                        logger.info("order Id =" + paidInfo.getOrderId());
                        logger.info("amount =" + paidInfo.getAmount());
                        List<OrderProduct> orderProducts = orderProductService.getOrderProductByOrderId(paidInfo.getOrderId());
                        for (OrderProduct orderProduct : orderProducts) {

                            logger.info("before pay status:" + orderProduct.getEntity().getPaymentStatus());
                            //notifyPayService.updateOrderPayment(paidInfo.getUserName(), paidInfo.getOrderId(), paidInfo.getAmount() + "", paidInfo.getAccount(), paidInfo.getSerialNumber());
                            notifyPayService.updateNewOrderPaymentStatus(paidInfo.getUserName(), paidInfo.getOrderId(), paidInfo.getAmount() + "", paidInfo.getAccount(), paidInfo.getSerialNumber());

                            logger.info("after pay status:" + orderProduct.getEntity().getPaymentStatus());
                            logger.info("compare");


                            //支付成功，则出货
                            if (orderProduct.getEntity().getPaymentStatus() == PaymentStatusEnum.PaySucceeded) {
                                //商品类型，1.本地商品，2.虚拟商品，3.商城商品，4.金融商品
                                logger.info("商品数量:"+orderProduct.getProductQty());
                                for(int i=0;i<orderProduct.getProductQty();i++) {
                                    long productType = orderProduct.getProduct().getProductStamp();
                                    logger.info("product type ==" + productType);
                                    //order.getCode() equals customize order id
                                    if (productType == 1) {
                                        logger.info("当前商品是本地商品,出货,");
                                        dealWithScanTwoDimensionCodePayForMobileApp(orderProduct.getOrderNumber(), orderProduct);
                                    }
                                    logger.info("product type 3-商城商品;product type 2-虚拟商品,"+productType+",send message or not ="+orderProduct.getProduct().getSendMassage()+",phone = "+orderProduct.getEntity().getPhone());
                                    if((productType == 3 || productType ==2)&&orderProduct.getProduct().getSendMassage() ==1&&orderProduct.getEntity().getPhone()!=null){
                                        //生产凭证 0-不发凭证；1-发凭证,并且收货手机号码不能为空
                                        logger.info("当前商品是非本地商品,generated voucher ");
                                        orderVoucherService.generateVoucher(orderProduct.getOrderNumber());
                                    }
                                }
                            }
                        }
                    }

                } catch (Exception e) {
                    logger.error("", e);
                }
            }
            if(paidInfo.isFromUser()){
                logger.info("from user starting ...");
                String viewName = "redirect:/mvc/mallszccb/generate-voucher?orderId=" + paidInfo.getOrderId();
                paidInfo.getModelAndView().setViewName(viewName);
            }
        }
    }

    private boolean checkIfAlreadyProcessed(PaidInfo paidInfo) {
        OrderEntity orderEntity = orderEntityService.findOrderEntityByOrderId(paidInfo.getOrderId());
        if(orderEntity.getPaymentStatus() == PaymentStatusEnum.PaySucceeded){
            return true;
        }else {
            return false;
        }
    }

    @Transactional
    public void dealWithScanTwoDimensionCodePayForMobileApp(String orderId, OrderProduct orderProduct) {

        String terminalId = orderProduct.getEntity().getTerminalId();
        String productId = orderProduct.getProduct().getId()+"";

        logger.info("mobile APP paid terminal Id====paying==============" + terminalId);
        logger.info("mobile App  product Id====paying==============" + productId);

        String serialNo = orderProduct == null ? null : orderProduct.getEntity().getSerialNo();


            final String terminalIdForDeliver = terminalId;
            final String productIdForDeliver = productId;
            threadPoolService.execute(() -> {
                logger.info("start to send deliver message to  through remote control");
                BaseRestResponse response = terminalFrontRemoteControl.deliver(terminalIdForDeliver, 1, orderId, productIdForDeliver,serialNo);
                logger.info("deliver response: " + response);
                if(response.OK == response.getHeader().getStatus()){

                    //减少本地商品库存的商品ID和数量1
                    //修改订单状态
                    logger.info("response ok ,update order status");
                    notifyPayService.updateOrderShipmentStatus(orderId);
                }
            });



    }

}
