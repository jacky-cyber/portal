package com.jspgou.cms.action.directive;

import static com.jspgou.cms.Constants.SHOP_SYS;
import static freemarker.template.ObjectWrapper.DEFAULT_WRAPPER;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;

import com.jspgou.common.page.Pagination;
import com.jspgou.common.web.freemarker.DirectiveUtils;
import com.jspgou.core.entity.Website;
import com.jspgou.core.manager.WebsiteMng;
import com.jspgou.cms.action.directive.abs.WebDirective;
import com.jspgou.cms.manager.OrderItemMng;

import freemarker.core.Environment;
import freemarker.template.ObjectWrapper;
import freemarker.template.TemplateDirectiveBody;
import freemarker.template.TemplateException;
import freemarker.template.TemplateModel;

/**
* This class should preserve.
* @preserve
*/
public class BargainPageDirective extends WebDirective {
	/**
	 * 商品购买记录
	 */
	public static final String TPL_NAME = "bargainPage";
	

	@SuppressWarnings("unchecked")
	public void execute(Environment env, Map params, TemplateModel[] loopVars,
			TemplateDirectiveBody body) throws TemplateException, IOException {
		Website web = getWeb(env, params, websiteMng);
		Long productId=getLong("productId", params);
		Pagination pagination = orderItemMng.getOrderItem(getPageNo(env), getCount(params), productId);
		Map<String, TemplateModel> paramWrap = new HashMap<String, TemplateModel>(
				params);
		paramWrap.put(OUT_PAGINATION, ObjectWrapper.DEFAULT_WRAPPER
				.wrap(pagination));
		paramWrap.put(OUT_LIST, DEFAULT_WRAPPER.wrap(pagination.getList()));
		Map<String, TemplateModel> origMap = DirectiveUtils
				.addParamsToVariable(env, paramWrap);
		if (isInvokeTpl(params)) {
			includeTpl(SHOP_SYS, TPL_NAME, web, params, env);
		} else {
			renderBody(env, loopVars, body);
		}
		DirectiveUtils.removeParamsFromVariable(env, paramWrap, origMap);
	}

	private void renderBody(Environment env, TemplateModel[] loopVars,
			TemplateDirectiveBody body) throws TemplateException, IOException {
		body.render(env.getOut());
	}

	private WebsiteMng websiteMng;

	@Autowired
	private OrderItemMng orderItemMng;

	@Autowired
	public void setWebsiteMng(WebsiteMng websiteMng) {
		this.websiteMng = websiteMng;
	}

}
