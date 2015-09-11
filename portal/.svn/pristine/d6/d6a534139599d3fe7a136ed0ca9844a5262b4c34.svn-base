package com.jspgou.core.utils;

import com.ifunpay.util.network.HttpStatusClient;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import java.io.IOException;
import java.util.Date;
import java.util.HashMap;

/**
 * Created by David on 2015/3/26.
 */
public class Login {
    public JSONObject toLogin(Integer type,String userName,String password) {
        HttpStatusClient httpStatusClient = new HttpStatusClient();
        HashMap<String,String> header =new HashMap<String, String>();
        HashMap<String,String> body =new HashMap<String, String>();
//        header.put("timestamp","1416554058295");
        header.put("timestamp",String.valueOf(new Date().getTime()));
        header.put("sequence_id","14");
        header.put("appKey","testAppKey");
        header.put("message_type","LOGIN");
        body.put("type",type.toString());
        body.put("user_name",userName);
        body.put("password",password);
        HashMap<String,Object> param= new HashMap<String, Object>();
        param.put("header",header);
        param.put("body",body);
        JSONObject jsonObject =JSONObject.fromObject(param);
        String re= null;
        try {
            httpStatusClient.addHeader("signature",new CreateMD5().getMD5Str(jsonObject.toString()+"testAppCode"));
            re = httpStatusClient.postJson("http://192.168.6.91:8080/dhb/knocker","utf-8",jsonObject.toString());
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
        JSONObject json = JSONObject.fromObject(re);
        JSONObject data = json.getJSONObject("body");
        return data;
    }
    public static Object[] getJsonToArray(String str) {
        JSONArray jsonArray = JSONArray.fromObject(str);
        return jsonArray.toArray();
    }
}
