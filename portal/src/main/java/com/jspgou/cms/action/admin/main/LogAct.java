package com.jspgou.cms.action.admin.main;

import static com.jspgou.common.page.SimplePage.cpn;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import com.jspgou.common.page.Pagination;
import com.jspgou.common.web.CookieUtils;
import com.jspgou.core.entity.Website;
import com.jspgou.core.web.SiteUtils;
import com.jspgou.core.web.WebErrors;
import com.jspgou.core.entity.Log;
import com.jspgou.core.manager.LogMng;

import java.util.Date;

/**
* This class should preserve.
* @preserve
*/
@Controller
public class LogAct {
	private static final Logger log = LoggerFactory.getLogger(LogAct.class);

	@RequestMapping("/log/v_list.do")
	public String list(Integer pageNo, HttpServletRequest request, ModelMap model, Date startTime, Date endTime, String userId, String moduleId, String relateId) {
		//Pagination pagination = manager.getPage(cpn(pageNo), CookieUtils.getPageSize(request));
		Pagination pagination = manager.getPageOfOperateLog(cpn(pageNo), CookieUtils.getPageSize(request), startTime, endTime, userId, moduleId, relateId);
		model.addAttribute("pagination",pagination);
		model.addAttribute("startTime", startTime);
		model.addAttribute("endTime", endTime);
		model.addAttribute("userId", userId);
		model.addAttribute("moduleId", moduleId);
		model.addAttribute("relateId", relateId);
		return "log/list";
	}

	@RequestMapping("/log/v_add.do")
	public String add(ModelMap model) {
		return "log/add";
	}

	@RequestMapping("/log/v_edit.do")
	public String edit(Long id, HttpServletRequest request, ModelMap model) {
		WebErrors errors = validateEdit(id, request);
		if (errors.hasErrors()) {
			return errors.showErrorPage(model);
		}
		model.addAttribute("log", manager.findById(id));
		return "log/edit";
	}

	@RequestMapping("/log/o_save.do")
	public String save(Log bean, HttpServletRequest request, ModelMap model) {
		WebErrors errors = validateSave(bean, request);
		if (errors.hasErrors()) {
			return errors.showErrorPage(model);
		}
		bean = manager.save(bean);
		log.info("save Log id={}", bean.getId());
		return "redirect:v_list.do";
	}

	@RequestMapping("/log/o_update.do")
	public String update(Log bean, Integer pageNo, HttpServletRequest request,
			ModelMap model) {
		bean = manager.update(bean);
		log.info("update Log id={}.", bean.getId());
		return list(pageNo, request, model, null, null, null, null, null);
	}

	@RequestMapping("/log/o_delete.do")
	public String delete(Long[] ids, Integer pageNo, HttpServletRequest request,
			ModelMap model) {
		WebErrors errors = validateDelete(ids, request);
		if (errors.hasErrors()) {
			return errors.showErrorPage(model);
		}
		Log[] beans = manager.deleteByIds(ids);
		for (Log bean : beans) {
			log.info("delete Log id={}", bean.getId());
		}
		return list(pageNo, request, model, null, null, null, null, null);
	}

	private WebErrors validateSave(Log bean, HttpServletRequest request) {
		WebErrors errors = WebErrors.create(request);
		Website web = SiteUtils.getWeb(request);
		bean.setSite(web);
		return errors;
	}
	
	private WebErrors validateEdit(Long id, HttpServletRequest request) {
		WebErrors errors = WebErrors.create(request);
		Website web = SiteUtils.getWeb(request);
		if (vldExist(id, web.getId(), errors)) {
			return errors;
		}
		return errors;
	}

	private WebErrors validateUpdate(Long id, HttpServletRequest request) {
		WebErrors errors = WebErrors.create(request);
		Website web = SiteUtils.getWeb(request);
		if (vldExist(id, web.getId(), errors)) {
			return errors;
		}
		return errors;
	}

	private WebErrors validateDelete(Long[] ids, HttpServletRequest request) {
		WebErrors errors = WebErrors.create(request);
		Website web = SiteUtils.getWeb(request);
		errors.ifEmpty(ids, "ids");
		for (Long id : ids) {
			vldExist(id, web.getId(), errors);
		}
		return errors;
	}

	private boolean vldExist(Long id, Long webId, WebErrors errors) {
		if (errors.ifNull(id, "id")) {
			return true;
		}
		Log entity = manager.findById(id);
		if(errors.ifNotExist(entity, Log.class, id)) {
			return true;
		}
		return false;
	}
	
	@Autowired
	private LogMng manager;
}