package com.ifunpay.portal.controller.security;

import com.fasterxml.jackson.databind.util.JSONPObject;
import com.ifunpay.util.jackson.JsonUtil;
import net.sf.json.JSONObject;
import org.apache.commons.io.IOUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.util.Map;

/**
 * 终端机出货回调
 * Created by Yu on 2015/3/20.
 */
@Controller
@RequestMapping("/security")
public class TerminalDeliverCallbackController {


    Logger logger = LoggerFactory.getLogger(TerminalDeliverCallbackController.class);

    @RequestMapping("/callback")
    @ResponseBody
    public Object callback(HttpServletRequest request){
        try {
            String jsonString = IOUtils.toString(request.getInputStream());
            Map<String, Object> map = JsonUtil.toObject(jsonString);
            return map == null || map.isEmpty() ? "empty" : map;

        } catch (IOException | RuntimeException e) {
            logger.error("", e);
        }
        return "failed";
    }
}

