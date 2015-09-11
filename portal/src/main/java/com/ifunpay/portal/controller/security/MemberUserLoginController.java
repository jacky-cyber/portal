package com.ifunpay.portal.controller.security;

import com.ifunpay.portal.service.security.ShiroSecurityService;
import org.apache.log4j.Logger;
import org.apache.shiro.SecurityUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import  org.apache.shiro.web.util.SavedRequest;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;

/**
 * Created by yu on 15-6-11.
 */
@Controller
public class MemberUserLoginController {

    Logger logger = Logger.getLogger(MemberUserLoginController.class);


    @Resource
    ShiroSecurityService shiroSecurityService;

    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public void login() {
        logger.info("login");
    }

    @RequestMapping(value = "/login", method = RequestMethod.POST)
    public String auth(@RequestParam String username,
                     @RequestParam String password) {
        try {
            SavedRequest savedRequest = (SavedRequest) SecurityUtils.getSubject().getSession().getAttribute("shiroSavedRequest");
            String uri = savedRequest.getRequestURI();
            shiroSecurityService.auth(username, password);
            logger.info("login success"+uri);
            return "redirect:"+uri;
        } catch (Exception e) {
            logger.error("", e);
            return "redirect:/mvc/errorLogin?msg="+e.getMessage();
        }
    }

    @RequestMapping("/errorLogin")
    public ModelAndView loginError(String msg,ModelAndView mav){
        mav.addObject("errMsg",msg);
        mav.setViewName("mall/error");
        return mav;
    }
}
