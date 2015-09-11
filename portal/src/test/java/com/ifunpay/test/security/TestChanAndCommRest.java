package com.ifunpay.test.security;

import com.ifunpay.util.common.StringUtil;
import com.ifunpay.util.jackson.JsonUtil;
import com.ifunpay.util.network.HttpStatusClient;
import org.apache.log4j.Logger;
import org.junit.After;
import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;

import java.util.HashMap;
import java.util.Map;

/**
 * Created by zj on 15-4-27.
 */
public class TestChanAndCommRest {
//    public static String baseUrl = "http://192.168.6.91:8080/mvc/security";
    public static String baseUrl = "http://192.168.6.130:8080/mvc/security";
    public static String appKey = "testAppKey";
    public static String appCode = "testAppCode";

    static Logger logger = Logger.getLogger(TestChanAndCommRest.class);
    static HttpStatusClient client = new HttpStatusClient();

    @Before
    public void testInit(){
        logger.info("-----test init------");
    }


    @Test
    public void testChannel(){
        Map<String, Object> request = new HashMap<>();
        request.put("name", "");
        request.put("channel_id", "98fcb162-d151-4268-9fd8-21b0253f409c");
        request.put("start", 0);
        request.put("size", 20);
        long time = System.currentTimeMillis();
        String json = JsonUtil.toJson(request);
        String md5 = StringUtil.getMd5HexByUtf8Encoding(json + time + appCode);
        client.addHeader("signature", md5);
        client.addHeader("timestamp", time + "");
        client.addHeader("appKey", appKey);
        String response = client.postJson(baseUrl + "/channel/channel", json);
        logger.info("response--------------->" + response);
        Assert.assertNotNull(response);
    }

    @Test
    public void testAllChannel(){
        Map<String, Object> request = new HashMap<>();
        long time = System.currentTimeMillis();
        String json = JsonUtil.toJson(request);
        String md5 = StringUtil.getMd5HexByUtf8Encoding(json + time + appCode);
        client.addHeader("signature", md5);
        client.addHeader("timestamp", time + "");
        client.addHeader("appKey", appKey);
        String response = client.postJson(baseUrl + "/channel/allChannel", json);
        logger.info("response--------------->" + response);
        Assert.assertNotNull(response);
    }

    @Test
    public void testCommerce(){
        Map<String, Object> request = new HashMap<>();
        request.put("channelId", "86");
        request.put("commerceId", "");
        request.put("name", "");
        request.put("channel_name", "");
        request.put("start", 0);
        request.put("size", 100);
        long time = System.currentTimeMillis();
        String json = JsonUtil.toJson(request);
        String md5 = StringUtil.getMd5HexByUtf8Encoding(json + time + appCode);
        client.addHeader("signature", md5);
        client.addHeader("timestamp", time + "");
        client.addHeader("appKey", appKey);
        String response = client.postJson(baseUrl + "/commerce/commerce", json);
        logger.info("response--------------->" + response);
        Assert.assertNotNull(response);
    }

    @After
    public void testAfter(){
        logger.info("-------test finished---------");
    }
}
