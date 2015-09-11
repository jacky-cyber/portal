package com.ifunpay.portal.util;

import com.jspgou.common.web.session.SessionProvider;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import static com.jspgou.core.web.Constants.CHANNELID;
import static com.jspgou.core.web.Constants.COMMERCEID;

/**
 * Created by zj on 15-8-10.
 */
@Component
public class SessionUtil {

    public Long getCommerceId(HttpServletRequest request){
        Object commerceId = session.getAttribute(request, COMMERCEID);
        if (null != commerceId){
            return Long.parseLong(commerceId.toString());
        }
        return null;
    }

    public Long getChannelId(HttpServletRequest request){
        Object channelId = session.getAttribute(request, CHANNELID);
        if (null != channelId){
            return Long.parseLong(channelId.toString());
        }
        return null;
    }

    @Resource
    private SessionProvider session;
}
