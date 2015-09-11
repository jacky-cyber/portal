package com.ifunpay.portal.service;

import com.ifunpay.util.common.StringUtil;
import com.ifunpay.util.jackson.JsonUtil;
import com.ifunpay.util.network.HttpStatusClient;
import com.ifunpay.util.sdk.ClientConfig;
import lombok.extern.log4j.Log4j;
import net.sf.json.JSONObject;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;

/**
 * Created by David on 2015/8/12.
 */
@Log4j
@Service
public class AlterTerminalStockService {

    public void alterStock(String terminalId,Long productId,Integer productCount){
        ClientConfig clientConfig = new ClientConfig();
        Map<String,String> header =new HashMap<>();
        Map<String,Object> body =new HashMap<>();
        header.put("version","2");
        int x=1+(int)(Math.random()*500);
        header.put("sequence_id",x+"");
        header.put("appKey", clientConfig.getOmsAppKey());
        header.put("message_type","ALTER_STOCK");
        body.put("terminalId", terminalId);
        body.put("productId", productId);
        body.put("productCount", productCount);
        Map<String,Object> param= new HashMap<>();
        param.put("header",header);
        param.put("body",body);
        String json = JsonUtil.toJson(param);

        HttpStatusClient client = new HttpStatusClient();
        long time = System.currentTimeMillis();
        String md5 = StringUtil.getMd5HexByUtf8Encoding(json + clientConfig.getOmsAppCode());
        client.addHeader("signature", md5);
        client.addHeader("appKey", clientConfig.getOmsAppKey());
        client.addHeader("timestamp", time + "");
        String result=client.postJson(clientConfig.getOmsBaseUrl()+"/knocker", json);
        JSONObject resultObject =JSONObject.fromObject(result);
        JSONObject data = resultObject.getJSONObject("header");
        log.info("alter stock result 0:success 1:false--->" + data.getString("status"));
    }
}
