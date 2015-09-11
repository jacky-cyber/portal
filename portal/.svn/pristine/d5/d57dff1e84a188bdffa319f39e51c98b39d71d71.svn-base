package com.ifunpay.portal.service;

import com.ifunpay.portal.controller.interact.ResponseContent;
import com.ifunpay.portal.controller.interact.ResponseContentHeader;
import com.ifunpay.portal.dao.NewOrderVoucherDao;
import com.ifunpay.portal.entity.OrderVoucher;
import com.ifunpay.portal.enums.VoucherStatus;
import com.jspgou.cms.entity.Order;
import com.jspgou.cms.manager.OrderMng;
import net.sf.json.JSONObject;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by David on 2015/4/28.
 */
@Service
public class OrderCertificateService {
   private Logger logger = Logger.getLogger(OrderCertificateService.class);
    @Resource
    NewOrderVoucherDao newOrderVoucherDao;
    @Resource
    OrderMng orderMng;
    public OrderVoucher getOrderVoucherByCode(String code){
        return newOrderVoucherDao.findByVoucherCodeForAllStatus(code);
    }
    public void reqInteract(String requestJson, ResponseContent responseContent, ResponseContentHeader header) {

        try {
            JSONObject par = JSONObject.fromObject(requestJson);
            setParam(par, responseContent);
        } catch (Exception e) {
            logger.error("", e);
            header.setStatus(1);
            header.setError_message("获取数据失败");
        }
    }

    private void setParam(JSONObject par, ResponseContent responseContent) {
        JSONObject reBody = par.getJSONObject("body");
        String voucherCode = reBody.getString("voucher_number");
        String act = reBody.getString("action");
        Map<String, Object> body = new HashMap<>();
        OrderVoucher orderVoucher = getOrderVoucherByCode(voucherCode);
        if (null != orderVoucher) {
            Order order = orderMng.getEntityByCode(orderVoucher.getCode());
            Long productId = order.getProduct().getId();
            if (("QUERY").equals(act)) {
                if (("1").equals(orderVoucher.getStatus())) {
                    body.put("merchandise_id", productId);
                    body.put("message", "凭证未消费过");
                } else if (("0").equals(orderVoucher.getStatus())) {
                    body.put("merchandise_id", productId);
                    body.put("message", "凭证已被消费过");
                } else if (("2").equals(orderVoucher.getStatus())){
                    body.put("merchandise_id", productId);
                    body.put("message", "终端机未处理成功该凭证");
                } else {
                    body.put("merchandise_id", productId);
                    body.put("message", "未知凭证状态");
                }
            } else if (("SUCCEEDED").equals(act)) {
                try {
                    if("0".equals(orderVoucher.getStatus())){
                        orderVoucher.setStatus(VoucherStatus.Used);
                        newOrderVoucherDao.update(orderVoucher);
                        body.put("merchandise_id", productId);
                        body.put("message", "凭证消费成功");
                    }else {
                        body.put("merchandise_id", productId);
                        body.put("message", "消费失败，凭证已被消费过");
                    }

                } catch (Exception e){
                    logger.error(e);
                    body.put("merchandise_id", productId);
                    body.put("message", "凭证消费失败");
                }
            } else if (("FAILED").equals(act)) {
                try {
                    orderVoucher.setStatus(VoucherStatus.NotUsed);
                    newOrderVoucherDao.update(orderVoucher);
                    body.put("merchandise_id", productId);
                    body.put("message", "凭证状态为未处理");
                } catch (Exception e){
                    logger.error(e);
                    body.put("merchandise_id", productId);
                    body.put("message", "凭证状态修改失败");
                }
            }
        } else {
            body.put("merchandise_id", null);
            body.put("message", "凭证不存在");
        }
        responseContent.setBody(body);
    }
}
