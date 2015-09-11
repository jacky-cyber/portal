package com.jspgou.core.utils;

import com.ifunpay.util.network.HttpStatusClient;
import net.sf.json.JSONObject;

import java.io.IOException;
import java.util.HashMap;

/**
 * Created by David on 2015/3/30.
 */
public class PortToDHB {
    public JSONObject port(HashMap<String,String> header,HashMap<String,String> body,String url,String key) {
        HttpStatusClient httpStatusClient = new HttpStatusClient();
        HashMap<String,Object> param= new HashMap<String, Object>();
        param.put("header",header);
        param.put("body",body);
        JSONObject jsonObject =JSONObject.fromObject(param);
        String re;
        try {
            httpStatusClient.addHeader("signature",new CreateMD5().getMD5Str(jsonObject.toString() + key));
            re = httpStatusClient.postJson(url,"utf-8",jsonObject.toString());
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
        JSONObject json = JSONObject.fromObject(re);
        JSONObject data = json.getJSONObject("body");
        return data;
    }
}
