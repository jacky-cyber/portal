package com.ifunpay.portal.service;

import com.ifunpay.portal.controller.interact.ResponseContent;
import com.ifunpay.portal.controller.interact.ResponseContentHeader;
import com.ifunpay.util.jackson.JsonUtil;
import com.jspgou.cms.entity.Product;
import com.jspgou.cms.manager.ProductMng;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by David on 2015/7/20.
 */
@Service
public class ProcessPriceService {
    private Logger logger = Logger.getLogger(ProcessPriceService.class);
    @Resource
    ProductMng productMng;
    public void processPrice(String requestJson, ResponseContent responseContent,ResponseContentHeader header){
        Map<String, Object> body = (Map) JsonUtil.toObject(requestJson).get("body");
        logger.info("PRICE REQUEST BODY: " + body);
        List<Map<String, Object>> list = (List<Map<String, Object>>) body.get("data");
        list.forEach(e -> {
            String merchandise_id = (String) e.get("merchandise_id");
            Integer price = (Integer) e.get("price");
            Long timestamp = (Long) e.get("date");
            long duration = System.currentTimeMillis() - timestamp;
            if (merchandise_id.isEmpty() || duration > 1000 * 60 * 60 * 24 || duration < - 1000 * 60 * 60) {
                header.setStatus(1);
                throw new RuntimeException();
            }else {
                Product bean = productMng.findById(Long.valueOf(merchandise_id));
                if(null!=bean){

                    productMng.update(bean);
                }
            }
        });
        HashMap<String,Object> bodys= new HashMap<>();
        bodys.put("status", 0);
        responseContent.setBody(bodys);
    }
}
