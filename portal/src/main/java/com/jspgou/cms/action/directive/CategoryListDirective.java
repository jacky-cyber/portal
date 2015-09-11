package com.jspgou.cms.action.directive;

import com.ifunpay.portal.ProjectXml;
import com.jspgou.cms.action.directive.abs.WebDirective;
import com.jspgou.cms.entity.Category;
import com.jspgou.cms.manager.CategoryMng;
import com.jspgou.common.web.freemarker.DirectiveUtils;
import com.jspgou.core.entity.Website;
import com.jspgou.core.manager.WebsiteMng;
import freemarker.core.Environment;
import freemarker.template.*;
import org.springframework.beans.factory.annotation.Autowired;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static com.jspgou.cms.Constants.TPLDIR_TAG;

/**
* This class should preserve.
* @preserve
*/
public class CategoryListDirective extends WebDirective {
	/**
	 * 模板名称
	 */
	public static final String TPL_NAME = "category_list";

	@SuppressWarnings("unchecked")
	public void execute(Environment env, Map params, TemplateModel[] loopVars,
			TemplateDirectiveBody body) throws TemplateException, IOException {
		Long webId = getWebId(params);
		Website web;
		if (webId == null) {
			web = getWeb(env, params, websiteMng);
		} else {
			web = websiteMng.findById(webId);
		}
		if (web == null) {
			throw new TemplateModelException("webId=" + webId + " not exist!");
		}
		Long parentId = DirectiveUtils.getLong(PARAM_PARENT_ID, params);
		List<Category> list;
		if (parentId != null) {
			Category category = categoryMng.findById(parentId);
			if (category != null) {
				list = new ArrayList<Category>(category.getChild());
			} else {
				list = new ArrayList<Category>();
			}
		}else{
			list = categoryMng.getTopListForTag(web.getId());
		}
        String baseUrl = ProjectXml.getValue("base_path_upload");
        List<Map<String,Object>> list1 = new ArrayList<>();
 		if(list.size()>0){
            for (Category category : list) {
                Map<String, Object> map = new HashMap<>();
                map.put("path",category.getPath());
                map.put("website",category.getWebsite());
                map.put("type",category.getType());
                map.put("brandIds",category.getBrandIds());
                map.put("categoryList",category.getCategoryList());
                map.put("deep",category.getDeep());
                map.put("lftName",category.getLftName());
                map.put("parentId",category.getParentId());
                map.put("parentName",category.getParentName());
                map.put("rgtName",category.getRgtName());
                map.put("rgt",category.getRgt());
                map.put("standardTypeIds",category.getStandardTypeIds());
                map.put("topCategory",category.getTopCategory());
                map.put("tplChannelRel",category.getTplChannelRel());
                map.put("tplChannel",category.getTplChannel());
                map.put("standardType",category.getStandardType());
                map.put("tplContentRel",category.getTplContentRel());
                map.put("treeCondition",category.getTreeCondition());
                map.put("tplContent",category.getTplContent());
                map.put("url",category.getUrl());
                map.put("parent",category.getParent());
                map.put("child",category.getChild());
                map.put("colorsize",category.getColorsize());
                map.put("attr",category.getAttr());
                map.put("description",category.getDescription());
                map.put("keywords",category.getKeywords());
                map.put("title",category.getTitle());
                map.put("priority",category.getPriority());
                map.put("name",category.getName());
                map.put("id",category.getId());
                if(null!=baseUrl+category.getImagePath()&&!"".equals(baseUrl+category.getImagePath())){
                    map.put("imagePath",baseUrl+category.getImagePath());
                }else {
                    map.put("imagePath","/images/no_image.jpg");
                }

                list1.add(map);
            }
        }
		Map<String, TemplateModel> paramsWrap = new HashMap<String, TemplateModel>(
				params);
//		paramsWrap.put(OUT_LIST, ObjectWrapper.DEFAULT_WRAPPER.wrap(list));
        paramsWrap.put(OUT_LIST, ObjectWrapper.DEFAULT_WRAPPER.wrap(list1));
		Map<String, TemplateModel> origMap = DirectiveUtils
				.addParamsToVariable(env, paramsWrap);
		if (isInvokeTpl(params)) {
			includeTpl(TPLDIR_TAG, TPL_NAME, web, params, env);
		} else {
			renderBody(env, loopVars, body);
		}
		DirectiveUtils.removeParamsFromVariable(env, paramsWrap, origMap);
	}

	private void renderBody(Environment env, TemplateModel[] loopVars,
			TemplateDirectiveBody body) throws TemplateException, IOException {
		body.render(env.getOut());
	}

	private CategoryMng categoryMng;
	private WebsiteMng websiteMng;

	@Autowired
	public void setCategoryMng(CategoryMng categoryMng) {
		this.categoryMng = categoryMng;
	}

	@Autowired
	public void setWebsiteMng(WebsiteMng websiteMng) {
		this.websiteMng = websiteMng;
	}
}
