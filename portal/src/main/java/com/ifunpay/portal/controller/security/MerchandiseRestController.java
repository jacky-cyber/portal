package com.ifunpay.portal.controller.security;

import com.ifunpay.util.jackson.JsonUtil;
import com.jspgou.cms.entity.Product;
import com.jspgou.cms.manager.ProductMng;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by David on 2015/4/7.
 */
@RestController
@RequestMapping("/security/merchandise")
public class MerchandiseRestController {

    private static final Logger log = LoggerFactory.getLogger(MerchandiseRestController.class);

    @RequestMapping("/fetch")
    public Object fetch(@RequestBody Map<String, Object> requestParam){
        String id = (String)requestParam.get("productId");
        Long productId = null;
        String productName = null;
        String commerceName = null;
        if(null!=id){
            productId = Long.valueOf(id);
        }
         productName =(String)requestParam.get("productName");
         commerceName =(String)requestParam.get("commerceName");
        Integer start = (Integer) requestParam.getOrDefault("start", 0);
        Integer size = (Integer) requestParam.getOrDefault("size", 50);
        if(size > 200) { size = 200;}
        HashMap<String,Object> map = new HashMap<String,Object>();
        List<Product> productList = new ArrayList<Product>();
        ArrayList paths = new ArrayList<HashMap>();
        String errorMessage = null;
        try {
                productList = productMng.fetch(productId,productName,commerceName,start, size);
        }catch (Exception e){
            log.info("error",e);
            errorMessage = "fetch error productId="+productId+"productName"+productName+"commerceName"+commerceName+"start="+start+"size="+size;
        }
        for(int i = 0;i<productList.size();i++){
            HashMap<String,String> path = new HashMap();
            path.put("id",productList.get(i).getId().toString());
            path.put("path",productList.get(i).getCategory().getPath());
            paths.add(path);
        }
        map.put("size",productList.size());
        map.put("merchandises",productList);
        map.put("errorMessage",errorMessage);
        map.put("paths",paths);
        try {
            String jsonObject = JsonUtil.toJson(map);
            log.debug(jsonObject);
        }catch (Exception e){
            log.info("error",e);
        }

        return map;
    }


    @RequestMapping("/fetchCount")
    public Object fetchCount(@RequestBody Map<String, Object> requestParam){
        HashMap<String,Object> map = new HashMap<String,Object>();
        try {
            Integer  count = productMng.findCount();//
            map.put("count",count);
        }catch (Exception e){
            log.info("error",e);
            map.put("errorMessage","fetchCount false");
        }
        return map;
    }

    @RequestMapping("/check")
    public Object check(@RequestBody Map<String, Object> requestParam){
        String productId = (String) requestParam.get("id");
        boolean pass = (boolean) requestParam.get("pass");
        Map<String, Object> result = new HashMap<String, Object>();
        boolean ok = false;
       if(pass){
           try {
           Product product = productMng.findById(Long.valueOf(productId));
           product.setChecked(true);
           productMng.update(product);
           ok =  true;
           }catch (Exception e){
               log.info("error" ,e);
           }
       }
        result.put("ok",ok);
       return result;
    }

    @RequestMapping("/shelf")
    public Object shelf(@RequestBody Map<String, Object> requestParam){
        String productId = (String) requestParam.get("id");
        String active = (String) requestParam.get("active");
        Map<String, Object> result = new HashMap<String, Object>();
        boolean ok = false;
        if(null!=active) {
            try {
                Product product = productMng.findById(Long.valueOf(productId));
                if ("on".equals(active)) {
//                    if(product.getChecked()){
                        product.setOnSale(true);
                        productMng.update(product);
                        ok = true;
//                    }
                }else if ("off".equals(active)){
                    if(product.getOnSale()){
                        product.setOnSale(false);
                        productMng.update(product);
                        ok = true;
                    }
                }
            }catch (Exception e){
                log.info("error",e);
            }
        }
        result.put("ok",ok);
        return result;
    }

    @Autowired
    private ProductMng productMng;
}

