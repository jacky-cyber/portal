package com.ifunpay.test.security;

import com.ifunpay.test.FastPrintUtil;
import com.ifunpay.util.common.StringUtil;
import com.ifunpay.util.jackson.JsonUtil;
import com.ifunpay.util.network.HttpStatusClient;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by yu on 4/3/15.
 */
public class TestCallback {

    static HttpStatusClient httpStatusClient = new HttpStatusClient();

    static String baseUrl = "http://localhost:8080/mvc/security/";
    static String appKey = "testAppKey";
    static String appCode = "testAppCode";

    public static void main(String... args) throws IOException {
        callback();
    }

    public static void callback() throws IOException {
        String url = baseUrl + "callback";
        Map<String, Map<?, ?>> requestMap = new HashMap<>();
        Map<String, Object> header = new HashMap<>();
        requestMap.put("header", header);
        header.put("terminal_id", "123456" );
        header.put("appKey", appKey);
        String json = JsonUtil.toJson(requestMap);
        String md5 = StringUtil.getMd5Hex((json + appCode).getBytes("utf-8"));
        httpStatusClient.addHeader("signature", md5);
        String response = httpStatusClient.postJson(url, "utf-8", json);
        FastPrintUtil.p(response);
    }
}
