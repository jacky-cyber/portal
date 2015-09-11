package com.jspgou.core.web;

import javax.servlet.http.HttpServletRequest;

import com.jspgou.core.entity.Website;
import org.apache.log4j.Logger;

import java.util.Arrays;

/**
* This class should preserve.
* @preserve
*/
public abstract class SiteUtils{

    static Logger logger = Logger.getLogger(SiteUtils.class);

    public static Website getWeb(HttpServletRequest request){
        if(logger.isDebugEnabled()){
            //Arrays.asList(Thread.currentThread().getStackTrace()).forEach(System.out::println);
        }
        Website website = (Website)request.getAttribute("_web_key");
        if(website == null){
            throw new IllegalStateException("Website not found in Request Attribute '_web_key'");
        }else{
            return website;
        }
    }

    public static Long getWebId(HttpServletRequest request){
        return getWeb(request).getId();
    }
}
