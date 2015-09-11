package com.jspgou.cms.action.directive;

import com.ifunpay.portal.ProjectXml;
import com.jspgou.cms.entity.Poster;
import com.jspgou.cms.manager.PosterMng;
import com.jspgou.common.web.freemarker.DirectiveUtils;
import com.jspgou.core.entity.Website;
import freemarker.core.Environment;
import freemarker.template.ObjectWrapper;
import freemarker.template.TemplateDirectiveBody;
import freemarker.template.TemplateException;
import freemarker.template.TemplateModel;
import org.springframework.beans.factory.annotation.Autowired;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static com.jspgou.cms.Constants.SHOP_SYS;

/**
* This class should preserve.
* @preserve
*/
public class PosterListDirective extends ProductAbstractDirective {
	/**
	 * 模板名称
	 */
	public static final String TPL_NAME = "ProductList";

	@SuppressWarnings("unchecked")
	public void execute(Environment env, Map params, TemplateModel[] loopVars,
			TemplateDirectiveBody body) throws TemplateException, IOException {
		Website web = getWeb(env, params, websiteMng);
		List<Poster> list=manager.getPage();
        String baseUrl = ProjectXml.getValue("base_path_upload");
        List<Map<String,Object>> list1 = new ArrayList<>();
        if(list.size()>0){
            for (Poster poster:list){
                Map<String,Object> map = new HashMap<>();
                if(null!=poster.getPicUrl()&&!"".equals(poster.getPicUrl())){
                    map.put("picUrl",baseUrl+poster.getPicUrl());
                }else {
                    map.put("picUrl","/images/no_image.jpg");
                }

                map.put("id",poster.getId());
                map.put("interUrl",poster.getInterUrl());
                map.put("time",poster.getTime());
                list1.add(map);
            }
        }

		Map<String, TemplateModel> paramWrap = new HashMap<String, TemplateModel>(
				params);
//		paramWrap.put(OUT_LIST, ObjectWrapper.DEFAULT_WRAPPER.wrap(list));
        paramWrap.put(OUT_LIST, ObjectWrapper.DEFAULT_WRAPPER.wrap(list1));
		Map<String, TemplateModel> origMap = DirectiveUtils
				.addParamsToVariable(env, paramWrap);
		if (isInvokeTpl(params)) {
			includeTpl(SHOP_SYS, TPL_NAME, web, params, env);
		} else {
			renderBody(env, loopVars, body);
		}
		DirectiveUtils.removeParamsFromVariable(env, paramWrap, origMap);
	}
	
	@Autowired
	private PosterMng manager;
}
