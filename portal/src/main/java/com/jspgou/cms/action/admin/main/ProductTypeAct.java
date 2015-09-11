package com.jspgou.cms.action.admin.main;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import com.ifunpay.portal.service.log.OperationLogService;
import com.jspgou.common.web.session.SessionProvider;
import com.jspgou.core.entity.Admin;
import com.jspgou.core.manager.AdminMng;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import com.jspgou.core.web.WebErrors;
import com.jspgou.cms.entity.ProductType;
import com.jspgou.cms.manager.BrandMng;
import com.jspgou.cms.manager.ProductTypeMng;
import com.jspgou.cms.web.SiteUtils;

/**
* This class should preserve.
* @preserve
*/
@Controller
public class ProductTypeAct {
	private static final Logger log = LoggerFactory
			.getLogger(ProductTypeAct.class);

	@RequestMapping("/type/v_list.do")
	public String list(HttpServletRequest request, ModelMap model) {
		List<ProductType> list = manager.getList(SiteUtils.getWebId(request));
		model.addAttribute("list", list);
		return "type/list";
	}

	@RequestMapping("/type/v_add.do")
	public String add(ModelMap model) {
		return "type/add";
	}

	@RequestMapping("/type/v_edit.do")
	public String edit(Long id, HttpServletRequest request, ModelMap model) {
		WebErrors errors = validateEdit(id, request);
		if (errors.hasErrors()) {
			return errors.showErrorPage(model);
		}
		model.addAttribute("productType", manager.findById(id));
		return "type/edit";
	}

	@RequestMapping("/type/o_save.do")
	public String save(ProductType bean, 
			HttpServletRequest request, ModelMap model) {
		WebErrors errors = validateSave(bean, request);
		if (errors.hasErrors()) {
			return errors.showErrorPage(model);
		}
		bean = manager.save(bean);
		log.info("save ProductType. id={}", bean.getId());
		long adminId = (long)session.getAttribute(request,"_admin_id_key");
		log.info("adminId = " + adminId);
		Admin admin = adminMng.findById(adminId);
		operationLogService.typeManageAdd(admin.getUsername(), bean.getId() + "", bean.getId() + "");
		return list(request, model);
	}

	@RequestMapping("/type/o_update.do")
	public String update(ProductType bean, 
			HttpServletRequest request, ModelMap model) {
		long adminId = (long)session.getAttribute(request,"_admin_id_key");
		log.info("adminId = " + adminId);
		Admin admin = adminMng.findById(adminId);
		operationLogService.typeManageEdit(admin.getUsername(),  bean.getId()+"",  bean.getId()+"");
		WebErrors errors = validateUpdate(bean.getId(), request);
		if (errors.hasErrors()) {
			return errors.showErrorPage(model);
		}
		bean = manager.update(bean);
		log.info("update ProductType. id={}.", bean.getId());
		return list(request, model);
	}

	@RequestMapping("/type/o_delete.do")
	public String delete(Long[] ids, HttpServletRequest request, ModelMap model) {
		//删除只显示前五个id
		String idCollection = "";
		if(ids.length>5){
			for (int i = 0; i < 5; i++) {
				if(i==4){
					idCollection +=ids[i];
				}else {
					idCollection +=ids[i]+",";
				}
			}
		}else {
			for (int i = 0; i < ids.length; i++) {
				if(i==ids.length-1){
					idCollection +=ids[i];
				}else {
					idCollection +=ids[i]+",";
				}
			}
		}

		try{
			long adminId = (long)session.getAttribute(request,"_admin_id_key");
			log.info("adminId = " + adminId);
			Admin admin = adminMng.findById(adminId);
			operationLogService.typeManageDelete(admin.getUsername(), idCollection, idCollection);
		}catch (Exception e){
			log.error("add log fail",e);
		}
		WebErrors errors = validateDelete(ids, request);
		if (errors.hasErrors()) {
			return errors.showErrorPage(model);
		}
		ProductType[] beans = manager.deleteByIds(ids);
		for (ProductType bean : beans) {
			log.info("delete ProductType. id={}", bean.getId());
		}
		return list(request, model);
	}

	private WebErrors validateSave(ProductType bean, HttpServletRequest request) {
		WebErrors errors = WebErrors.create(request);
		bean.setWebsite(SiteUtils.getWeb(request));
		return errors;
	}

	public WebErrors validateEdit(Long id, HttpServletRequest request) {
		WebErrors errors = WebErrors.create(request);
		errors.ifNull(id, "id");
		vldExist(id, errors);
		return errors;
	}

	public WebErrors validateUpdate(Long id, HttpServletRequest request) {
		WebErrors errors = WebErrors.create(request);
		errors.ifNull(id, "id");
		vldExist(id, errors);
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

	private void vldExist(Long id, WebErrors errors) {
		if (errors.hasErrors()) {
			return;
		}
		ProductType entity = manager.findById(id);
		errors.ifNotExist(entity, ProductType.class, id);
	}

	@Autowired
	private BrandMng brandMng;
	@Autowired
	private ProductTypeMng manager;
	@Resource
	private OperationLogService operationLogService;
	@Resource
	private SessionProvider session;
	@Resource
	private AdminMng adminMng;
}