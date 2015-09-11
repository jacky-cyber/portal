package com.ifunpay.test.interact;

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

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

/**
 * update by Conglong Xie on 2015/07/28.
 */
public class TestCreateOrder {


    public static String baseUrl = "http://192.168.6.115:8083/mvc/interact";
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
    public  void testCreateOrder(){
        Map<String, Object> request = new HashMap<>();
        Map<String, Object> header = new HashMap<>();
        Map<String, Object> body = new HashMap<>();

        Long time = System.currentTimeMillis();


        header.put("terminal_id","54644455");
        header.put("message_type","CREATE_ORDER");
        header.put("version","2.0");
        header.put("timestamp", time + "");
        header.put("appKey",appKey);
        header.put("sequence_id","18");
        body.put("order_id","");
        body.put("terminal_order_id","4555550");
        body.put("price",new Long(654));
        body.put("pay_method","AShotToPay");
        body.put("order_timestamp",time);
        body.put("pay_timestamp",0);
        body.put("serial_number","10054545");
        body.put("user_account","36525223232323");
        ArrayList<Object> merchandises = new ArrayList<>();
        HashMap<String,Object> product = new HashMap<>();
        product.put("id",new Long(1521));
        product.put("count",1);
        merchandises.add(product);
        HashMap<String,Object> product1 = new HashMap<>();
        product1.put("id",new Long(1524));
        product1.put("count",2);
        merchandises.add(product1);
        body.put("merchandises",merchandises);
        body.put("deliver_status",0);

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
