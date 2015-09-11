package com.ifunpay.test.security;

import com.ifunpay.util.common.StringUtil;
import com.ifunpay.util.jackson.JsonUtil;
import com.ifunpay.util.network.HttpStatusClient;
import net.sf.json.JSONObject;
import org.apache.log4j.Logger;
import org.junit.After;
import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;

import java.util.HashMap;
import java.util.Map;

/**
 * Created by David on 2015/4/7.
 */
public class TestMerchandiseRest {
    public static String baseUrl = "http://localhost:8080/mvc/security/merchandise";
    public static String appKey = "testAppKey";
    public static String appCode = "testAppCode";
    static Logger logger = Logger.getLogger(TestUserRest.class);
    static HttpStatusClient client = new HttpStatusClient();

    @Before
    public void testInit(){
        System.out.println("-----test init------");
    }
    /**
     * 测试商品查询
     */
    @Test
    public  void testFetch(){
        Map<String, Object> request = new HashMap<>();
        request.put("id", "25");  //按商品id进行查询
//        request.put("start", 0);  //第几条开始
//        request.put("size", 50);  // 总共查询数目
        long time = System.currentTimeMillis();
        String json = JsonUtil.toJson(request);
        String md5 = StringUtil.getMd5HexByUtf8Encoding(json + time + appCode);
        client.addHeader("signature", md5);
        client.addHeader("timestamp", time + "");
        client.addHeader("appKey", appKey);
        String response = client.postJson(baseUrl + "/fetch", json);
        logger.info(response);
        JSONObject responseParam = JSONObject.fromObject(response);
        Integer size = Integer.valueOf(responseParam.getString("size").toString());
        Assert.assertEquals(size>0,true);
    }

    @Test
    public  void testCheck(){
        Map<String, Object> request = new HashMap<>();
        request.put("id", "25");
        request.put("pass", true);
        long time = System.currentTimeMillis();
        String json = JsonUtil.toJson(request);
        String md5 = StringUtil.getMd5HexByUtf8Encoding(json + time + appCode);
        client.addHeader("signature", md5);
        client.addHeader("timestamp", time + "");
        client.addHeader("appKey", appKey);
        String response = client.postJson(baseUrl + "/check", json);
        logger.info(response);
        JSONObject responseParam = JSONObject.fromObject(response);
        boolean ok = responseParam.getBoolean("ok");
        Assert.assertTrue(ok);
    }
    @Test
    public  void testShelf(){
        Map<String, Object> request = new HashMap<>();
        request.put("id", "25");
        request.put("active", "on"); //商品上架
//        request.put("active", "off");   //商品下架
        long time = System.currentTimeMillis();
        String json = JsonUtil.toJson(request);
        String md5 = StringUtil.getMd5HexByUtf8Encoding(json + time + appCode);
        client.addHeader("signature", md5);
        client.addHeader("timestamp", time + "");
        client.addHeader("appKey", appKey);
        String response = client.postJson(baseUrl + "/shelf", json);
        logger.info(response);
        JSONObject responseParam = JSONObject.fromObject(response);
        boolean ok = responseParam.getBoolean("ok");
        Assert.assertTrue(ok);
    }

    @After
    public void testAfter(){
        System.out.println("-------test finished---------");
    }

}
