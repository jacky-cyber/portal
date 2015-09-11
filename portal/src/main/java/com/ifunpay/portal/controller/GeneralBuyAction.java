package com.ifunpay.portal.controller;

import com.ifunpay.portal.entity.Channel;
import com.ifunpay.portal.entity.MemberUserEntity;
import com.ifunpay.portal.entity.TerminalOrder;
import com.ifunpay.portal.entity.order.OrderEntity;
import com.ifunpay.util.enums.PayMethodEnum;
import com.ifunpay.portal.service.MemberUserService;
import com.ifunpay.portal.service.NotifyPayService;
import com.ifunpay.portal.service.OrderVoucherService;
import com.ifunpay.portal.service.TerminalOrderService;
import com.ifunpay.portal.service.commerce.ChannelService;
import com.ifunpay.portal.service.order.OrderEntityService;
import com.ifunpay.util.Constant;
import com.ifunpay.util.web.cookie.CookieUtil;
import com.jspgou.cms.entity.Order;
import com.jspgou.cms.entity.Product;
import com.jspgou.cms.entity.ShopMember;
import com.jspgou.cms.manager.OrderMng;
import com.jspgou.cms.manager.ProductMng;
import org.apache.log4j.Logger;
import org.apache.shiro.SecurityUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Optional;

/**
 * Created by Administrator on 2015/3/6.
 */
@Controller
@RequestMapping("/mall")
public class GeneralBuyAction {
    private Logger logger = Logger.getLogger(GeneralBuyAction.class);

    @Resource
    private OrderMng orderMng;

    @Resource
    private TerminalOrderService terminalOrderService;
    @Resource
    private MemberUserService memberUserService;

    @Resource
    private ProductMng productMng;

    @Resource
    private ChannelService channelService;

    @Resource
    private OrderEntityService orderEntityService;

    @Resource
    private NotifyPayService notifyPayService;

    @Resource
    private OrderVoucherService orderVoucherService;


  /*  @Resource
    private TerminalOrderService terminalOrderService;*/

    @RequestMapping("generalbuy-ashot")
    public ModelAndView buyszccbSimple(ModelAndView mav, HttpServletRequest request,
                            HttpServletResponse response
    ) {
        HttpSession session = request.getSession();

        String terminalId = request.getParameter("terminalId");
        String serialNo = request.getParameter("serialNo");
        String needLogin = request.getParameter("needLogin");

        logger.info("terminalId =" + terminalId);
        String apId = request.getParameter("apId");

        logger.info(" process in GeneralBuyAction Simple");
        //获得商品数量
        int quantity = 1;
        String quantityRequest = request.getParameter("quantity");
        if (quantityRequest != null || !("".equals(quantityRequest))) {
            quantity = Integer.parseInt(quantityRequest);
        }
        Integer [] quantityList ={quantity};
        logger.info("quanlity Request is :" + quantityRequest);
        //获得支付发方式
        PayMethodEnum payMethodEnum = null;//默认是银联支付
        if ("1".equals(request.getParameter("flag"))) {
            payMethodEnum = PayMethodEnum.AShotToPay;//一拍支付
        }
        //获得登录用户
        MemberUserEntity memberUserEntity = null;
        String userPhone = null;
        if ("0".equals(needLogin)) {
            Object sub = SecurityUtils.getSubject().getPrincipal();
            logger.info("sub = "+sub.toString());
            String memberUserId = sub.toString();
            logger.debug("apId is :" + apId);
            memberUserEntity = memberUserService.getEntityByName(memberUserId);
            if(memberUserEntity!=null){
                userPhone = memberUserEntity.getPhone();
            }
        }
        //Order order = null;
        OrderEntity orderEntity =null;
        String receiveName = "";
        String phone = "";
        String province = "";
        String city = "";
        String addressDetails = "";
        //获得商品Id
        long proId = Long.parseLong(apId);
        Long[] proIds = {proId};
        //创建新订单
        Optional<String> cookie = CookieUtil.getCookieValue(request, Constant.DEVICE_COOKIE_NAME);
        String deviceName = cookie.orElse(null);
        logger.info("device name ="+deviceName);

        List<OrderEntity> oe = orderEntityService.findOrderEntityByTerminalIdAndSerialNo(terminalId, serialNo);
        if(oe!=null&&oe.size()>0){
            mav.setViewName("error");
            mav.addObject("content", "<h1>同一终端机交易流水必须唯一</h1>");
            return mav;
        }

        orderEntity = orderEntityService.buildOrderEntity(proIds,payMethodEnum,memberUserEntity,terminalId,serialNo,quantityList,receiveName,phone,province,city,addressDetails,deviceName);


        /*try {
            //支付信息测试
            notifyPayService.updateNewOrderPaymentStatus("xcl", orderEntity.getCode(), orderEntity.getTotalAmount() + "", orderEntity.getPayAccountName(), orderEntity.getSerialNo());
            //凭证测试
            orderVoucherService.generateVoucher(orderEntity.getCode());
        }catch (Exception e){
            logger.info("",e);
        }
*/

        logger.info("total amount is :" + orderEntity.getTotalAmount());
        String payInfoId = getPayInfoFromChannel(productMng.findById(proId));
        logger.info("bank info is:"+payInfoId);
        if(apId!=null) {
            try {
                mav.setViewName("redirect:/mvc/mobilePay/" + payInfoId + "/" + orderEntity.getTotalAmount() + "/" + orderEntity.getCode());
            }catch (Exception e){
                logger.info("",e);
            }
        }else {
            mav.setViewName("error");
            mav.addObject("content", "<h1>获得商品ID为空</h1>");
        }
        return mav;
    }

    public String getPayInfoFromChannel(Product product){
        String payInfoId = "";
        try {
            String channelId = product.getChannelId();
            if(channelId!=null) {
                Channel channel = channelService.getChannelByChannelId(Long.parseLong(channelId));
                payInfoId = channel.getBankPayInfoId();
            }
            logger.info("payInfoId = " + payInfoId);

        }catch (Exception e){
            logger.info("",e);
        }
        return payInfoId;
    }


    @RequestMapping("newOrderBuy")
    public ModelAndView newOrderBuy(ModelAndView mav, HttpServletRequest request) {
        HttpSession session = request.getSession();

        String terminalId = (String) session.getAttribute("tId");
        String serialNo = (String) session.getAttribute("serialNo");
        String needLogin = (String) session.getAttribute("needLogin");

        String apId = request.getParameter("apId");
        String memberUserId = (String) session.getAttribute("member");
        String userName = request.getParameter("consignee");
        String userPhone = request.getParameter("consignee_phone");
        String address = request.getParameter("pro") + request.getParameter("city") + request.getParameter("detail");
        if ("nullnullnull".equals(address)) {
            address = "";
        }
        logger.debug("apId is :" + apId);

        logger.info(" process in GeneralBuyAction Simple");

        int quantity = 1;

        String quanlityRequest = request.getParameter("quantity");

        if (quanlityRequest != null || !("".equals(quanlityRequest))) {
            quantity = Integer.parseInt(quanlityRequest);
        }

        logger.info("quanlity Request is :" + quanlityRequest);

        //Website web = SiteUtils.getWeb(request);
        Long webId = new Long(1);
        //ShopMember member = MemberThread.get();
        //定义默认用户
       /* ShopMember member = shopMemberDao.findById((long)18);*/
        ShopMember member = null;

        // MemberUserEntity memberUserEntity = null;
       /* if(null!=memberUserId){
            memberUserEntity =memberUserService.getEntityByName(memberUserId);
        }*/

        MemberUserEntity memberUserEntity = null;
        if ("0".equals(needLogin)) {
            if (null != memberUserId) {
                memberUserEntity = memberUserService.getEntityByName(memberUserId);
            }
        } else if ("1".equals(needLogin)) {
            memberUserEntity = memberUserService.getEntityByName("13800138000");
        }


        Order order = null;

        //获得商品Id
        long proId = Long.parseLong(apId);

        Long[] cartItemId = {proId};
        //发货方式
        long shippingMethodId = 1;
        //收货信息
        long deliveryInfo = 1;
        //支付方式
        long paymentMethodId = 1;
        if ("1".equals(session.getAttribute("flag"))) {
            paymentMethodId = 4;//一拍支付
        }
        String comments = "";
        String memberCouponId = "";
        try {
            order = orderMng.createOrderForAShoot(memberUserEntity, terminalId, cartItemId, shippingMethodId, deliveryInfo, paymentMethodId, comments, request.getRemoteAddr(), member, memberCouponId, quantity, serialNo, userName, userPhone, address);
        } catch (Exception e) {
            logger.error("create order error ," + e);
        }

        //Test update order status
        //notifyPayService.updateOrderPaymentStatus(order.getCode());
        //notifyPayService.updateOrderShipmentSuccessforNewOrderCCB(order.getCode());

        if (terminalId != null) {
            TerminalOrder terminalOrder = new TerminalOrder();
            terminalOrder.setName("terminalId");
            terminalOrder.setValue(terminalId);
            terminalOrder.setOrderId(order.getCode());
            terminalOrderService.saveTerminalOrder(terminalOrder);
            //add param - product id to t_order
            TerminalOrder terminalOrderForAPID = new TerminalOrder();
            terminalOrderForAPID.setName("productId");
            terminalOrderForAPID.setValue(apId);
            terminalOrderForAPID.setOrderId(order.getCode());
            terminalOrderService.saveTerminalOrder(terminalOrderForAPID);
            logger.info("save terminal order relationship successful");
        }

        logger.info("totol amount is :" + order.getTotal());

        String payInfoId = "";
        if(apId!=null) {
            try {
                Product product = productMng.findById(Long.parseLong(apId));
                String channelId = product.getChannelId();
                if(channelId!=null) {
                    Channel channel = channelService.getChannelByChannelId(Long.parseLong(channelId));
                    payInfoId = channel.getBankPayInfoId();
                }
                logger.info("payInfoId = "+payInfoId);

                mav.setViewName("redirect:/mvc/mobilePay/" + payInfoId + "/" + order.getTotal() + "/" + order.getCode());
            }catch (Exception e){
                logger.info("",e);
            }
        }else {
            mav.setViewName("error");
            mav.addObject("content", "<h1>获得商品ID为空</h1>");
        }
        //if ("SZCCB".equals(payInfoId)){
        //mav.setViewName("redirect:/mvc/mobilePay/" + payInfoId + "/" + order.getTotal() + "/" + order.getCode());
          /*} else {
        mav.setViewName("redirect:/mobilePay/" + channelOrder.getChannel().getBankPayInfoId() + "/" + channelOrder.getTotalAmount() + "/" + channelOrder.getOrderId() + "");
          }*/
        return mav;
    }

}
