package com.jspgou.common.web;

import org.apache.log4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.View;
import org.springframework.web.servlet.ViewResolver;

/**
 * Created by Administrator on 2015/3/2.
 */
public class ViewResolverDelegate implements ViewResolver{
    static Logger logger = Logger.getLogger(ViewResolverDelegate.class);

    private ViewResolver freeMarkerResolver;
    private ViewResolver jspResolver;

    public void setJspResolver(ViewResolver jspResolver) {
        this.jspResolver = jspResolver;
    }

    public void setFreeMarkerResolver(ViewResolver freeMarkerResolver) {
        this.freeMarkerResolver = freeMarkerResolver;
    }

    public View resolveViewName(String viewName, java.util.Locale locale) throws Exception {
        if (isFreemarkerView(viewName)) {
            return freeMarkerResolver.resolveViewName(viewName, locale);
        } else {
            return jspResolver.resolveViewName(viewName, locale);
        }
    }

    private boolean isFreemarkerView(String viewName) {
        logger.debug("delegate view name is :" + viewName);
        if (viewName.endsWith(".jsp")) {
            logger.debug("false");
           return false;
        }else {
            return true;
        }

    }
}
