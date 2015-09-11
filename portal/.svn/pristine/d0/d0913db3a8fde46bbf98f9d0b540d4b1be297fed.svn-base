package com.ifunpay.portal.controller.log;

import com.ifunpay.util.mongo.MongoUtil;
import org.bson.Document;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import java.util.stream.Collectors;

/**
 * Created by yu on 15-7-21.
 */
@RestController
@RequestMapping("/logging")
public class LoggingRequestController {


    @RequestMapping("/{category}/{rtn}")
    public String log(HttpServletRequest request, @PathVariable String category, @PathVariable String rtn) {
        Document document = new Document(request.getParameterMap().entrySet().stream().collect(Collectors.toMap(
                e -> e.getKey(),
                e -> e.getValue()[0])))
                .append("category", category)
                .append("remoteIP", request.getRemoteAddr());
        MongoUtil.insertIfPossible("httpLog", document);
        return rtn;
    }
}
