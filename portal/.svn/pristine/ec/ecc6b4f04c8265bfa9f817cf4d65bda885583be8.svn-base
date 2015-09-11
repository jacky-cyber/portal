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
 * Created by yu on 4/3/15.
 */
public class TestOrderRest {

    public static String baseUrl = "http://localhost:8081/mvc/security/order";
    public static String appKey = "testAppKey";
    public static String appCode = "testAppCode";

    static Logger logger = Logger.getLogger(TestOrderRest.class);
    static HttpStatusClient client = new HttpStatusClient();

    /*public static void main(String... args){
        //estFetch();
        //testConfirm();
        //testCancel();
        //testRefund();
    }*/

    @Before
    public void testInit(){
        logger.info("-----test init------");
    }


    public  void testFetch(){
        Map<String, Object> request = new HashMap<>();
        request.put("id", "");
        request.put("mobile", "");
        request.put("start", 0);
        request.put("size", 2);
        long time = System.currentTimeMillis();
        String json = JsonUtil.toJson(request);
        String md5 = StringUtil.getMd5HexByUtf8Encoding(json + time + appCode);
        client.addHeader("signature", md5);
        client.addHeader("timestamp", time + "");
        client.addHeader("appKey", appKey);
        String response = client.postJson(baseUrl + "/fetch", json);
        logger.info(response);
        Assert.assertNotNull(response);
    }

    public void testFetchOne(){
        Map<String,Object> request = new HashMap();
        request.put("id","0000005034");
        long time = System.currentTimeMillis();
        String json = JsonUtil.toJson(request);
        String md5 = StringUtil.getMd5HexByUtf8Encoding(json + time + appCode);
        client.addHeader("signature", md5);
        client.addHeader("timestamp", time + "");
        client.addHeader("appKey", appKey);
        String response = client.postJson(baseUrl + "/fetchCurrent", json);
        logger.info(response);
        Assert.assertNotNull(response);
    }

    public void testFetchOrderPay(){
        Map<String,Object> request = new HashMap();
        request.put("id","0000005034");
        long time = System.currentTimeMillis();
        String json = JsonUtil.toJson(request);
        String md5 = StringUtil.getMd5HexByUtf8Encoding(json + time + appCode);
        client.addHeader("signature", md5);
        client.addHeader("timestamp", time + "");
        client.addHeader("appKey", appKey);
        String response = client.postJson(baseUrl + "/fetchOrderPay", json);
        logger.info(response);
        Assert.assertNotNull(response);
    }


    public  void testConfirm(){
        Map<String, Object> request = new HashMap<>();
        request.put("id", "0000005049");
        long time = System.currentTimeMillis();
        String json = JsonUtil.toJson(request);
        String md5 = StringUtil.getMd5HexByUtf8Encoding(json + time + appCode);
        client.addHeader("signature", md5);
        client.addHeader("timestamp", time + "");
        client.addHeader("appKey", appKey);
        String response = client.postJson(baseUrl + "/confirm", json);
        logger.info(response);
        Assert.assertNotNull(response);
    }

    public  void testCancel(){
        Map<String, Object> request = new HashMap<>();
        request.put("id", "0000005050");
        long time = System.currentTimeMillis();
        String json = JsonUtil.toJson(request);
        String md5 = StringUtil.getMd5HexByUtf8Encoding(json + time + appCode);
        client.addHeader("signature", md5);
        client.addHeader("timestamp", time + "");
        client.addHeader("appKey", appKey);
        String response = client.postJson(baseUrl + "/cancel", json);
        logger.info(response);
        Assert.assertNotNull(response);
    }

    @Test
    public  void testRefund(){
        Map<String, Object> request = new HashMap<>();
        request.put("orderId", "0000005035");
        request.put("amount",100);
        long time = System.currentTimeMillis();
        String json = JsonUtil.toJson(request);
        String md5 = StringUtil.getMd5HexByUtf8Encoding(json + time + appCode);
        client.addHeader("signature", md5);
        client.addHeader("timestamp", time + "");
        client.addHeader("appKey", appKey);
        String response = client.postJson(baseUrl + "/refund", json);
        logger.info(response);
        Assert.assertNotNull(response);
    }

    @After
    public void testAfter(){
        logger.info("-------test finished---------");
    }
}
