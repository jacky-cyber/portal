package com.jspgou.cms.action.member;

import static com.jspgou.core.web.Constants.MESSAGE;
import static com.jspgou.core.web.Constants.RETURN_URL;
import static com.jspgou.cms.Constants.MEMBER_SYS;
import static com.jspgou.cms.Constants.TPLDIR_INDEX;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import com.jspgou.common.security.BadCredentialsException;
import com.jspgou.common.security.UserNotAcitveException;
import com.jspgou.common.security.UsernameNotFoundException;
import com.jspgou.common.web.springmvc.MessageResolver;
import com.jspgou.core.entity.User;
import com.jspgou.core.entity.Website;
import com.jspgou.core.manager.UserMng;
import com.jspgou.core.security.UserNotInWebsiteException;
import com.jspgou.core.web.WebErrors;
import com.jspgou.cms.entity.ShopMember;
import com.jspgou.cms.service.LoginSvc;
import com.jspgou.cms.web.ShopFrontHelper;
import com.jspgou.cms.web.SiteUtils;

/**
* This class should preserve.
* @preserve
*/
@Controller
public class LoginAct {
	private static final Logger log = LoggerFactory.getLogger(LoginAct.class);
	
	private static final String LOGIN_INPUT = "tpl.loginInput";
	
	public static final String TPL_INDEX = "tpl.index";
	
	@RequestMapping(value = "/login.jspx", method = RequestMethod.GET)
	public String loginInput(String returnUrl, String message,
			HttpServletRequest request, ModelMap model) {
		Website web = SiteUtils.getWeb(request);
		if (!StringUtils.isBlank(returnUrl)) {
			model.addAttribute(RETURN_URL, returnUrl);
			if (!StringUtils.isBlank(message)) {
				model.addAttribute(MESSAGE, message);
			}
		}
		ShopFrontHelper.setCommonData(request, model, web, 1);
		return web.getTplSys(MEMBER_SYS, MessageResolver.getMessage(request,
				LOGIN_INPUT));
	}

	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/login.jspx", method = RequestMethod.POST)
	public String loginSubmit(String username, String password,
			String returnUrl, String redirectUrl, HttpServletRequest request,
			HttpServletResponse response, ModelMap model) {
		Website web = SiteUtils.getWeb(request);
		WebErrors errors = WebErrors.create(request);
		ShopMember member;
		try {
			member = loginSvc.memberLogin(request, response, web, username,password);
			if(member==null){
				return "redirect:/";
			}
			log.info("member '{}' login success.", username);
			if (!StringUtils.isBlank(returnUrl)) {
				return "redirect:" + returnUrl;
			} else if (!StringUtils.isBlank(redirectUrl)) {
				return "redirect:" + redirectUrl;
			} else {
				model.addAttribute("member", member);
				ShopFrontHelper.setCommonData(request, model, web, 1);
				//登录成功跳转到首页
				return web.getTemplate(TPLDIR_INDEX, MessageResolver.getMessage(request,
						TPL_INDEX));
			}
		} catch (UsernameNotFoundException e) {
			errors.addErrorCode("error.usernameNotExist");
			log.info(e.getMessage());
		} catch (BadCredentialsException e) {
			errors.addErrorCode("error.passwordInvalid");
			log.info(e.getMessage());
		} catch (UserNotInWebsiteException e) {
			errors.addErrorCode("error.usernameNotInWebsite");
			log.info(e.getMessage());
		}catch(UserNotAcitveException e){
			errors.addErrorCode("error.usernameNotActivated");
			log.info(e.getMessage());
		}	
		errors.toModel(model);
		ShopFrontHelper.setCommonData(request, model, web, 1);
		return web.getTplSys(MEMBER_SYS, MessageResolver.getMessage(request,LOGIN_INPUT));
	}
	
	public Integer errorRemaining(String username) {
		if (StringUtils.isBlank(username)) {
			return null;
		}
		User user = userMng.getByUsername(username);
		if (user == null) {
			return null;
		}
		return  null;
	}
	

	@RequestMapping("/logout.jspx")
	public String logout(String redirectUrl, HttpServletRequest request,
			HttpServletResponse response) {
		loginSvc.logout(request, response);
		if (!StringUtils.isBlank(redirectUrl)) {
			return "redirect:" + redirectUrl;
		} else {
			return "redirect:/";
		}
	}

	@Autowired
	private LoginSvc loginSvc;
	@Autowired
	private UserMng userMng;
}
