package com.ifunpay.test;

import com.ifunpay.test.security.TestUserRest;
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
 * Created by David on 2015/8/12.
 */
public class TestKnocker {
    public static String baseUrl = "http://192.168.6.156:8082/knocker";
    public static String appKey = "testAppKey";
    public static String appCode = "testAppCode";
    static Logger logger = Logger.getLogger(TestUserRest.class);
    static HttpStatusClient client = new HttpStatusClient();

    @Before
    public void testInit(){
        System.out.println("-----test init------");
    }
    /**
     * 测试终端机获取本地商品
     */
    @Test
    public  void testAlterStock(){
        Map<String, Object> request = new HashMap<>();
        Map<String, Object> header = new HashMap<>();
        Map<String, Object> body = new HashMap<>();

        long time = System.currentTimeMillis();


        header.put("version","2");
        int x=1+(int)(Math.random()*500);
        header.put("sequence_id",x+"");
        header.put("appKey", appKey);
        header.put("message_type","ALTER_STOCK");
        body.put("terminalId", "0755CCB00000059");
        body.put("productId", "1557");
        body.put("productCount", "6");
        Map<String,Object> param= new HashMap<>();

        request.put("header",header);
        request.put("body",body);
        String json = JsonUtil.toJson(request);
        String md5 = StringUtil.getMd5HexByUtf8Encoding(json + appCode);
        logger.info("to md5 "+json  + appCode);
        client.addHeader("signature",md5);
        client.addHeader("appKey",appKey);
        client.addHeader("timestamp",time+"");
        String response = client.postJson(baseUrl , json);
        logger.info(response);
        JSONObject responseParam = JSONObject.fromObject(response);

        Integer status = Integer.valueOf(responseParam.getJSONObject("header").getString("status"));
        Assert.assertEquals(status == 0, true);
    }


    @After
    public void testAfter(){
        System.out.println("-------test finished---------");
    }


}
