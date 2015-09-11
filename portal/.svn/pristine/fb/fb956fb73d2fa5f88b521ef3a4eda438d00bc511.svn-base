package com.jspgou.cms.action.admin.main;

import com.ifunpay.portal.entity.Channel;
import com.ifunpay.portal.entity.Commerce;
import com.ifunpay.portal.service.commerce.ChannelService;
import com.ifunpay.portal.service.commerce.CommerceService;
import com.ifunpay.util.jackson.JsonUtil;
import com.jspgou.cms.entity.ShopAdmin;
import com.jspgou.cms.manager.ShopAdminMng;
import com.jspgou.common.page.Pagination;
import com.jspgou.common.web.CookieUtils;
import com.jspgou.common.web.ResponseUtils;
import com.jspgou.common.web.session.SessionProvider;
import com.jspgou.core.entity.Role;
import com.jspgou.core.entity.Website;
import com.jspgou.core.manager.AdminMng;
import com.jspgou.core.manager.RoleMng;
import com.jspgou.core.manager.UserMng;
import com.jspgou.core.web.SiteUtils;
import com.jspgou.core.web.WebErrors;
import lombok.extern.log4j.Log4j;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import static com.jspgou.common.page.SimplePage.cpn;

/**
* This class should preserve.
* @preserve
*/
@Controller
@Log4j
public class ShopAdminAct {
    public static ArrayList<HashMap<String,String>> channel= new ArrayList<HashMap<String,String>>();
    public static ArrayList<HashMap<String,String>> commerce=new ArrayList<HashMap<String,String>>();

	@RequestMapping("/admin/v_list.do")
	public String list(Integer pageNo, HttpServletRequest request,
			ModelMap model) {
		Pagination pagination = manager.getPage(SiteUtils.getWebId(request),cpn(pageNo), CookieUtils.getPageSize(request));
		model.addAttribute(pagination);
		return "admin/list";
	}

	@RequestMapping("/admin/v_add.do")
	public String add(ModelMap model,HttpServletRequest request) {
		List<Role> roleList = roleMng.getAdminList();
		model.addAttribute("roleList", roleList);
		return "admin/add";
	}


    @RequestMapping("/admin/v_channel_add.do")
    public String addForChannel(String channelId,ModelMap model,HttpServletRequest request) {
        List<Role> roleList = roleMng.getList();
        model.addAttribute("roleList", roleList);

       log.debug("channelId =="+channelId);
        model.addAttribute("channelId",channelId);

        java.util.List<Channel> channelList = channelService.getAllChannel();
        Channel chan = new Channel();
		chan.setId(Long.parseLong("-1"));
        chan.setChannelName("请选择");
        channelList.add(0,chan);


        java.util.List<Commerce> commerceList = commerceService.getAllCommerces();
        Commerce com = new Commerce();
        com.setId(new Long(-1));
        com.setName("请选择");
        commerceList.add(0,com);

        model.addAttribute("channelList", channelList);
        model.addAttribute("commerceList", commerceList);
        return "admin/channel_add";
    }

	@RequestMapping("/admin/v_edit.do")
	public String edit(Long id, HttpServletRequest request, ModelMap model) {
		WebErrors errors = validateEdit(id, request);
		if (errors.hasErrors()) {
			return errors.showErrorPage(model);
		}
		List<Role> roleList = roleMng.getAdminList();
		model.addAttribute("roleList", roleList);
		model.addAttribute("admin", manager.findById(id));
		Integer roleId = 1;
		if (0 < manager.findAdminId(id).getRoleIds().length){
			roleId = manager.findAdminId(id).getRoleIds()[0];
		}
		model.addAttribute("roleId", roleId);
		return "admin/edit";
	}

	@RequestMapping("/admin/o_save.do")
	public String save(ShopAdmin bean, String username, String password,Boolean viewonlyAdmin,
			String email, Boolean disabled,Integer[] roleIds,HttpServletRequest request, ModelMap model) {
		WebErrors errors = validateSave(bean, request);
		if (errors.hasErrors()) {
			return errors.showErrorPage(model);
		}
		Website web = SiteUtils.getWeb(request);

		bean = manager.register(username, password,viewonlyAdmin, email, request.getRemoteAddr(), disabled, web.getId(), bean, null,null,null,null,null);
		adminMng.addRole(bean.getAdmin(), roleIds);
		log.info("save ShopAdmin id={}" + bean.getId());
		return "redirect:v_list.do";
	}

	@RequestMapping("/admin/o_update.do")
	public String update(ShopAdmin bean, String password, Boolean viewonlyAdmin,String email,
			Boolean disabled, Integer[] roleIds, Integer pageNo,HttpServletRequest request, ModelMap model) {
		WebErrors errors = validateUpdate(bean.getId(), request);
		if (errors.hasErrors()) {
			return errors.showErrorPage(model);
		}
		bean = manager.update(bean, password, disabled, email, viewonlyAdmin, null, null, null, null, null);
		adminMng.updateRole(bean.getAdmin(), roleIds);
		log.info("update ShopAdmin id={}." + bean.getId());
		return list(pageNo, request, model);
	}

	@RequestMapping("/admin/o_delete.do")
	public String delete(Long[] ids, Integer pageNo,
			HttpServletRequest request, ModelMap model) {
		WebErrors errors = validateDelete(ids, request);
		if (errors.hasErrors()) {
			return errors.showErrorPage(model);
		}
		ShopAdmin[] beans = manager.deleteByIds(ids);
		for (ShopAdmin bean : beans) {
			log.info("delete ShopAdmin id={}" + bean.getId());
		}
		return list(pageNo, request, model);
	}

	@RequestMapping("/admin/v_check_username.do")
	public String checkUsername(String username, HttpServletRequest request,
			HttpServletResponse response) {
		if (StringUtils.isBlank(username) || userMng.usernameExist(username)) {
			ResponseUtils.renderJson(response, "false");
		} else {
			ResponseUtils.renderJson(response, "true");
		}
		return null;
	}

	@RequestMapping("/admin/v_check_email.do")
	public String checkEmail(String email, HttpServletRequest request,
			HttpServletResponse response) {
		if (StringUtils.isBlank(email) || userMng.emailExist(email)) {
			ResponseUtils.renderJson(response, "false");
		} else {
			ResponseUtils.renderJson(response, "true");
		}
		return null;
	}

	private WebErrors validateSave(ShopAdmin bean,
			HttpServletRequest request) {
		WebErrors errors = WebErrors.create(request);
		return errors;
	}

	private WebErrors validateEdit(Long id, HttpServletRequest request) {
		WebErrors errors = WebErrors.create(request);
		errors.ifNull(id, "id");
		vldExist(id, errors);
		return errors;
	}

	private WebErrors validateUpdate(Long id,
			HttpServletRequest request) {
		WebErrors errors = WebErrors.create(request);
		if (vldExist(id, errors)) {
			return errors;
		}
		return errors;
	}

	private WebErrors validateDelete(Long[] ids, HttpServletRequest request) {
		WebErrors errors = WebErrors.create(request);
		errors.ifEmpty(ids, "ids");
		for (Long id : ids) {
			vldExist(id, errors);
		}
		return errors;
	}

	private boolean vldExist(Long id, WebErrors errors) {
		ShopAdmin entity = manager.findById(id);
		return errors.ifNotExist(entity, ShopAdmin.class, id);
	}

	@ResponseBody
	@RequestMapping(value = "/admin/getMerchantByChannelId.do", produces = {"application/json"},
			consumes = {"application/json"})
	public Object getMerchantByChannelId(Long channelId){
		List<Commerce> list = commerceService.getCommerces(channelId, null);
		return JsonUtil.toJson(list);
	}

    @Autowired
	private ShopAdminMng manager;
	@Autowired
	private UserMng userMng;
	@Autowired
	protected RoleMng roleMng;
	@Autowired
	protected AdminMng adminMng;
    @Autowired
    private SessionProvider session;

    @Resource
    private CommerceService commerceService;

    @Resource
    private ChannelService channelService;

    public SessionProvider getSession() {
        return session;
    }

    public void setSession(SessionProvider session) {
        this.session = session;
    }
}