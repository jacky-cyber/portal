package com.ifunpay.portal.controller.interact;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.ifunpay.portal.service.OrderCertificateService;
import com.ifunpay.portal.service.ProcessPriceService;
import com.ifunpay.portal.service.TerminalCreateOrderService;
import com.ifunpay.portal.service.interact.MerchandiseService;
import com.ifunpay.util.common.StringUtil;
import com.ifunpay.util.enums.InteractType;
import com.ifunpay.util.mongo.MongoUtil;
import net.sf.json.JSONObject;
import org.apache.commons.io.IOUtils;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.ByteArrayOutputStream;
import java.io.IOException;

/**
 * Created by Yu on 2014/11/21.
 */
@Controller
public class InteractAction {
    Logger logger = Logger.getLogger(InteractAction.class);
    @Resource
    MerchandiseService merchandiseService;
    @Resource
    TerminalCreateOrderService terminalCreateOrderService;
    @Resource
    OrderCertificateService orderCertificateService;
    @Resource
    ProcessPriceService processPriceService;

    private String appCode = null;

    @RequestMapping(value = "/interact")
    @ResponseBody
    public Object interact(HttpServletRequest request, HttpServletResponse response) {
        ResponseContent responseContent = new ResponseContent();
        ResponseContentHeader header = new ResponseContentHeader();
        responseContent.setHeader(header);
        try {
            String requestJson = IOUtils.toString(request.getReader());
            logger.debug("request json: " + requestJson);
            MongoUtil.saveObjectsIfPossible("portalInteract", requestJson);
            JSONObject jsonHeader = JSONObject.fromObject(requestJson).getJSONObject("header");
            try {
                header.setSequence_id(jsonHeader.getInt("sequence_id"));
            } catch (RuntimeException e) {
                header.setSequence_id(0);
            }
            if (isRequestSignatureOk(request, requestJson)) {
                header.setStatus(0);
                InteractType messageType = InteractType.valueOf(jsonHeader.getString("message_type"));
                logger.debug("request type: " + messageType);
                switch (messageType) {
                    // 获取商品信息
                    case MERCHANDISE:
                        merchandiseService.getMerchandises(requestJson, responseContent);
                        break;
                    // 同步订单
                    case CREATE_ORDER:
                        terminalCreateOrderService.createOrderForTerminal(requestJson, responseContent, header);
                        break;
                    // 凭证
                    case VOUCHER:
                        orderCertificateService.reqInteract(requestJson, responseContent, header);
                        break;
                    // 终端修改商品价格
                    case PRICE:
                        processPriceService.processPrice(requestJson, responseContent, header);
                        //TODO
                        break;
                    default:
                        break;
                }
                //
            } else {
                header.setStatus(1);
                header.setError_message("签名不对");
            }
        } catch (Throwable e) {
            logger.info("illegal request: " + e.getMessage());
            logger.debug("", e);
            header.setStatus(1);
            header.setError_message("请求内容不合法");
        }
        try {
            //set response body md5
            if (responseContent.getBody() == null) {
                header.setBody_md5(null);
            } else {
                String bodyJson = getSpringMvcJsonByObject(responseContent.getBody());
                logger.debug("response body json: " + bodyJson);
                String bodyMd5 = StringUtil.getMd5Hex(bodyJson.getBytes());
                logger.debug("response body md5: " + bodyMd5);
                header.setBody_md5(bodyMd5);
            }

            //set http response header 'signature'
            String responseJson = getSpringMvcJsonByObject(responseContent);
            //        String sign = StringUtil.getMd5Hex((responseJson + appCode).getBytes("UTF-8"));
            logger.debug("response json: " + responseJson);
            //        logger.debug("sign: " + sign);
            //        response.setHeader("signature", sign);
        } catch (IOException e) {
            logger.error("", e);
        }
        return responseContent;
    }

    //
    private boolean isRequestSignatureOk(HttpServletRequest request, String requestJson) {
        return true;
    }

    public static String getSpringMvcJsonByObject(Object object) throws IOException {
        if (object == null) {
            return "{}";
        }
        ObjectMapper objectMapper = new ObjectMapper();
        try (ByteArrayOutputStream out = new ByteArrayOutputStream();) {
            objectMapper.writeValue(out, object);
            String json = out.toString("UTF-8");
            return json;
        }
    }

}
