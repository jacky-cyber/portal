package com.ifunpay.portal.service;

import com.ifunpay.portal.ProjectXml;
import com.ifunpay.portal.dao.NewOrderVoucherDao;
import com.ifunpay.portal.dao.order.OrderEntityDao;
import com.ifunpay.portal.dao.order.OrderProductDao;
import com.ifunpay.portal.entity.OrderVoucher;
import com.ifunpay.portal.entity.order.OrderEntity;
import com.ifunpay.portal.entity.order.OrderProduct;
import com.ifunpay.portal.enums.VoucherStatus;
import com.ifunpay.portal.util.DESEncodeForString;
import com.ifunpay.sms.SmsCenterResponse;
import com.ifunpay.sms.sdk.SmsClient;
import com.ifunpay.util.common.StringUtil;
import com.ifunpay.util.jackson.JsonUtil;
import com.ifunpay.util.network.HttpStatusClient;
import com.ifunpay.util.sdk.ClientConfig;
import freemarker.cache.StringTemplateLoader;
import freemarker.template.Configuration;
import freemarker.template.Template;
import net.sf.json.JSONObject;
import org.apache.log4j.Logger;
import org.hibernate.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.io.StringWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by zhengjiang on 2015/4/20.
 */
@Service
public class OrderVoucherService {

    @Resource
    private OrderEntityDao orderEntityDao;

    /**
     * 生成凭证
     */
    @Transactional
    public void generateVoucher(String orderId){
        try{
            List<OrderProduct> orderProducts = orderProductDao.getOrderProductByOrderId(orderId);
            if(orderProducts == null){
                throw new Exception(orderId+"订单号不存在");
            }
            logger.info("orderID is"+orderId);

            for(OrderProduct orderProduct:orderProducts) {
                String generatedCode = DESEncodeForString.getVoucherCode(orderId, orderProduct.getProduct().getId());
                OrderVoucher orderVoucher = generateCodeCommon(orderId, generatedCode, orderProduct);
                logger.info("send voucher to phone " + orderVoucher.getRecepPhone());
                sendVoucherMsg(orderVoucher.getVoucherCode(),orderVoucher.getProductName(),orderVoucher.getOrderProduct().getProductQty(),orderVoucher.getRecepPhone());
            }
        }catch (Exception e ){
            logger.error("",e);
        }
    }

    public OrderVoucher generateCodeCommon(String orderId,String generateCode,OrderProduct orderProduct){
        OrderVoucher orderVoucher = new OrderVoucher();
        orderVoucher.setVoucherCode(generateCode);
        orderVoucher.setOrderProduct(orderProduct);
        orderVoucher.setCode(orderId);
        orderVoucher.setRecepPhone(orderProduct.getEntity().getPhone());
        orderVoucher.setStatus(VoucherStatus.NotUsed);
        orderVoucher.setCost(orderProduct.getEntity().getTotalAmount());
        orderVoucher.setCommerce(orderProduct.getCommerce());
        orderVoucher.setCommerceName(orderProduct.getCommerceName());
        orderVoucher.setProductName(orderProduct.getProductName());
        orderVoucher.setSendTime(new Date());
        orderVoucher.setStartTime(orderProduct.getProduct().getVoucherTimeBegin());
        orderVoucher.setEndTime(orderProduct.getProduct().getVoucherTimeEnd());
        orderVoucher.setChannel(orderProduct.getEntity().getChannel());
        newOrderVoucherDao.save(orderVoucher);
        logger.info("generate voucher successful...");
        return orderVoucher;
    }

    public String sendVoucherMsg(String voucherCode,String productName,int qty,String mobile) {
//        String smsContent="您已购买[${product_name}]，数量[${quantity}]，有效期[${start_date}]至[${end_date}]。感谢您的使用！客服电话：4000668882！[${commerce_name}]";
        String smsModel = getPubMould(ProjectXml.getValue("send_voucher_sms_model_key"));
        Map<String, String> smsValue = new HashMap<String, String>();
        smsValue.put("product_name", productName);
        smsValue.put("quantity", qty+"");
        smsValue.put("voucher_code",voucherCode);
        String smsContent = null;
        try {
            smsContent = process(smsValue, smsModel);
        } catch (Exception e) {
            logger.info("", e);
        }
        try {
            SmsCenterResponse smsCenterResponse = client.sendMessage(mobile, smsContent);
            logger.info("smsContent = "+smsContent);
            logger.info("smsResponse ="+smsCenterResponse.getMessage());
            return smsCenterResponse.getMessage();
        } catch (Exception e) {
            return null;
        }
    }


    public String getPubMould(String keyName) {

        Map<String, String> header = new HashMap<>();
        Map<String, String> body = new HashMap<>();
        header.put("version", "2");
        int x = 1 + (int) (Math.random() * 500);
        header.put("sequence_id", x + "");
        header.put("appKey", ClientConfig.omsAppKey);
        header.put("message_type", "PUB_MOULD");
        body.put("mould_key", keyName);
        Map<String, Object> param = new HashMap<>();
        param.put("header", header);
        param.put("body", body);
        String json = JsonUtil.toJson(param);

        HttpStatusClient client = new HttpStatusClient();
        long time = System.currentTimeMillis();
        String md5 = StringUtil.getMd5HexByUtf8Encoding(json + ClientConfig.omsAppCode);
        client.addHeader("signature", md5);
        client.addHeader("appKey", ClientConfig.omsAppKey);
        client.addHeader("timestamp", time + "");
        String result = client.postJson(ClientConfig.omsBaseUrl + "/knocker", json);
        JSONObject resultObject = JSONObject.fromObject(result);
        JSONObject data = resultObject.getJSONObject("body");
        String pubMould = data.getString("pubMould");
        return pubMould;
    }


    public String process(Map param, String templateStr) throws Exception {
        Configuration cfg = new Configuration();
        cfg.setClassicCompatible(true);// 空值处理
        StringTemplateLoader templateLoader = new StringTemplateLoader();
        templateLoader.putTemplate("", templateStr);
        cfg.setTemplateLoader(templateLoader);
        cfg.setDefaultEncoding("UTF-8");
        Template template = cfg.getTemplate("");

        StringWriter writer = new StringWriter();
        template.process(param, writer);

        return writer.toString();
    }

    /**
     * 查询凭证
     * @param code
     * @return
     */
    public OrderVoucher queryVoucher(String code){
        OrderVoucher orderVoucher = newOrderVoucherDao.findByVoucherCodeForAllStatus(code);
        return orderVoucher;
    }

    /**
     * 根据凭证号查询凭证
     * @param voucherCode
     * @return
     */
    public java.util.List<OrderVoucher> findByAllVoucherCodeByTimeOrder(String voucherCode){
       return newOrderVoucherDao.findByAllVoucherCodeByTimeOrder(voucherCode);
    }

    /**
     * 根据订单号查找未使用的凭证信息
     * @param code
     * @return
     */
    public  OrderVoucher findNotUserVoucherByVoucherCode(String code){
        return newOrderVoucherDao.findNotUserVoucherByVoucherCode(code);
    }


    public void updateVoucherCode(OrderVoucher orderVoucher){
        newOrderVoucherDao.updateOrderVoucher(orderVoucher);
    }

    /**
     * 使用凭证
     * @param code
     * @return
     */
    public Map<String, Object> useVoucher(String code){
        OrderVoucher orderVoucher = newOrderVoucherDao.findByVoucherCode(code);

        Long productId = orderVoucher.getOrderProduct().getProduct().getId();
        Map<String, Object> map = new HashMap<>();
        map.put("merchandise_id", productId);
        if (orderVoucher.getStatus() == VoucherStatus.NotUsed){
            try {
                orderVoucher.setStatus(VoucherStatus.Used);
                newOrderVoucherDao.update(orderVoucher);
                map.put("message", "消费成功");
                return map;
            } catch (Exception e){
                logger.error(e);
            }
            map.put("message", "修改凭证状态失败");
            return map;
        } else if (("1").equals(orderVoucher.getStatus())){
            map.put("message", "凭证已使用过，不能重复使用");
            return map;
        } else if (("2").equals(orderVoucher.getStatus())){
            map.put("message", "凭证已过期");
            return map;
        } else if (("3").equals(orderVoucher.getStatus())){
            map.put("message", "凭证已作废");
            return map;
        } else {
            map.put("message", "未知凭证状态： " + orderVoucher.getStatus().getDisplayName());
            return map;
        }
    }

    /**
     * 凭证消费失败
     * @param code
     * @return
     */
    public Map<String, Object> failedUseVoucher(String code){
        OrderVoucher orderVoucher = newOrderVoucherDao.findByVoucherCode(code);
        Long productId = orderVoucher.getOrderProduct().getProduct().getId();
        Map<String, Object> map = new HashMap<>();
        map.put("merchandise_id", productId);
        try {
            orderVoucher.setStatus(VoucherStatus.Expired);
            newOrderVoucherDao.update(orderVoucher);
            map.put("message", "该凭证状态已修改为：2");
            return map;
        }catch (Exception e){
            logger.error(e);
        }
        map.put("message", "修改凭证状态失败");
        return map;
    }

    /**
     * 作废原有凭证，重发新凭证
     * @param orderId
     */
    @Transactional
    public void reSendVoucher(String orderId){
        newOrderVoucherDao.updateVoucherStatusToUseless(orderId);
        generateVoucher(orderId);
    }

    public OrderVoucher customerVoucher(String orderNumber){
        return newOrderVoucherDao.customerVoucher(orderNumber);
    }


    @Resource
    private NewOrderVoucherDao newOrderVoucherDao;
    @Resource
    private OrderProductDao orderProductDao;

    private Logger logger = Logger.getLogger(OrderVoucher.class);

    @Autowired
    private SmsClient client;
}
