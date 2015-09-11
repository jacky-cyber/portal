package com.ifunpay.test.security;

import com.ifunpay.util.common.StringUtil;
import com.ifunpay.util.jackson.JsonUtil;
import com.ifunpay.util.network.HttpStatusClient;
import net.sf.json.JSONObject;
import org.apache.log4j.Logger;
import org.junit.Assert;
import org.junit.Test;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by yu on 4/3/15.
 */
public class TestUserRest {

    public static String host = "dv:34808";
    public static String host2 = "192.168.6.119:8080";
    public static String host3 = "127.0.0.1:8080";
    public static String baseUrl = "http://" + host2 + "/mvc/security/user";
    public static String appKey = "testAppKey";
    public static String appCode = "testAppCode";

    static Logger logger = Logger.getLogger(TestUserRest.class);
    static HttpStatusClient client = new HttpStatusClient();

    public static void main(String... args) throws IOException {
        testFetch();
    }

    public static void testFetch() throws IOException {
        Map<String, Object> request = new HashMap<>();
 //       request.put("id", "1000000000");
        request.put("phone", "与");
        request.put("size", 1);
        request.put("start", 1);
        long time = System.currentTimeMillis();
        String json = JsonUtil.toJson(request);
        String md5 = StringUtil.getMd5Hex(json + time + appCode, "UTF-8");
        client.addHeader("signature", md5);
        client.addHeader("timestamp", time + "");
        client.addHeader("appKey", appKey);
        String response = client.postJson(baseUrl + "/fetch", "UTF-8", json);
        logger.info(response);
    }

    @Test
    public  void testDelete(){
        Map<String, Object> request = new HashMap<>();
        String[] ids = {"f63a85cf-89f9-43bb-ab4a-8c74643b5790"};
        request.put("ids", ids);
        long time = System.currentTimeMillis();
        String json = JsonUtil.toJson(request);
        String md5 = StringUtil.getMd5HexByUtf8Encoding(json + time + appCode);
        client.addHeader("signature", md5);
        client.addHeader("timestamp", time + "");
        client.addHeader("appKey", appKey);
        String response = client.postJson(baseUrl + "/delete", json);
        logger.info(response);
        JSONObject responseParam = JSONObject.fromObject(response);
        boolean ok = responseParam.getBoolean("ok");
        Assert.assertTrue(ok);
    }
}
