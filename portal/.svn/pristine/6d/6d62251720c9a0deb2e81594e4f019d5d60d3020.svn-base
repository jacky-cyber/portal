package com.ifunpay.portal.controller;

import com.ifunpay.front.TerminalFrontRemoteControl;
import com.ifunpay.portal.dao.BaseDao;
import com.ifunpay.portal.entity.MemberUserEntity;
import com.ifunpay.portal.service.TestService;
import com.ifunpay.util.cache.CacheService;
import com.ifunpay.util.common.ThreadUtil;
import com.ifunpay.util.sdk.oms.TerminalChannelClient;
import org.apache.shiro.SecurityUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.ServletContext;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;
import java.util.Optional;

/**
 * Created by Yu on 2015/3/3.
 */
@Controller
@RequestMapping("/test")
public class TestController {

    @Resource
    BaseDao baseDao;

    @Resource
    TestService testService;

    @Resource
    private TerminalFrontRemoteControl terminalFrontRemoteControl;

    @Resource
    private ServletContext servletContext;

    private Logger logger = LoggerFactory.getLogger(ServletContext.class);

    HttpSession session;

    @RequestMapping("/test")
    @ResponseBody
    public Object test(HttpServletRequest request, HttpServletResponse response) {
        Map map = new HashMap<>();
        map.put("hello", "world");
        return map;
    }

    @RequestMapping("/testWeb")
    public String web(HttpServletRequest request, HttpServletResponse response) {
        ThreadUtil.printTrace();
        Cookie cookie = new Cookie("hello", "world");
        response.addCookie(cookie);
        return "web";
    }

    @RequestMapping("/testSession")
    @ResponseBody
    public Object testSession(HttpServletRequest request, HttpServletResponse response) {
        if (this.session == null) {
            this.session = request.getSession();
        } else {
            System.out.println(this.session == request.getSession());
        }
        p(request.getSession().getAttribute("test"));
        request.getSession().setAttribute("test", "hello!");
        p(request.getSession().getClass().getName());
        return "OK";
    }

    @RequestMapping("/testFront")
    @ResponseBody
    public Object testFront(HttpServletRequest request, HttpServletResponse response) {
        p(terminalFrontRemoteControl);
        return "OK";
    }

    @RequestMapping("/user")
    @ResponseBody
    public Object testUser(HttpServletRequest request, HttpServletResponse response) {
        logger.debug("OK");
        Optional<MemberUserEntity> memberUserEntity = baseDao.get(MemberUserEntity.class, "1000000000");
        memberUserEntity.filter(u -> u.getRegisterIp() != "0").isPresent();
        return memberUserEntity.isPresent();
    }

    @RequestMapping("/testRedirect")
    public String testRedirect() {
        String viewName = "redirect:/mvc/mallszccb/generate-voucher?orderId=123456";
        return viewName;
    }

    @RequestMapping("/currentUser")
    @ResponseBody
    public Object currentUser() {
        try {
            String username = SecurityUtils.getSubject().getPrincipal().toString();
            return username;
        } catch (Exception e) {
            return e.toString();
        }
    }

    public static void p(Object... args) {
        Arrays.asList(args).forEach(System.out::println);
    }


    @RequestMapping("/testChannel")
    @ResponseBody
    public Object testGetChannelId() {
        Object result = Optional.empty();
        try {
            TerminalChannelClient terminalChannelClient = new TerminalChannelClient();
            result = terminalChannelClient.getMerchantId("0755CCB00000019").toString();
        } catch (RuntimeException e) {
            logger.error("", e);
        }
        return result;
    }

    @Resource
    CacheService cacheService;

    @RequestMapping("/testRedis")
    @ResponseBody
    public Object testRedis() {
        return cacheService.keysStartWith("a");
    }


}
