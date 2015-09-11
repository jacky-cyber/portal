package com.jspgou.cms.action.front;

import com.ifunpay.portal.ProjectXml;
import com.jspgou.cms.entity.*;
import com.jspgou.cms.manager.*;
import com.jspgou.cms.web.ShopFrontHelper;
import com.jspgou.cms.web.SiteUtils;
import com.jspgou.common.web.RequestUtils;
import com.jspgou.common.web.springmvc.MessageResolver;
import com.jspgou.core.entity.Global;
import com.jspgou.core.entity.Website;
import com.jspgou.core.web.WebErrors;
import com.jspgou.core.web.front.FrontHelper;
import com.jspgou.core.web.front.URLHelper;
import com.jspgou.core.web.front.URLHelper.URLInfo;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static com.jspgou.cms.Constants.SHOP_SYS;
import static com.jspgou.cms.Constants.TPLDIR_INDEX;
import static com.jspgou.core.web.front.URLHelper.INDEX;

/**
 * JspGou动态系统Action
 * @author liufang
 * This class should preserve.
 * @preserve
 */
@Controller
public class DynamicPageAct {
	/**
	 * 首页
	 */
	public static final String TPL_INDEX = "tpl.index";
	
	/**
	 * 品牌模板
	 */
	private static final String BRAND = "tpl.brand";
	/**
	 * 品牌详情模板
	 */
	private static final String BRAND_DETAIL = "tpl.brandDetail";
	
	/**
	 * WEBLOGIC的默认路径
	 * 
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/index.jhtml", method = RequestMethod.GET)
	public String indexForWeblogic(HttpServletRequest request, ModelMap model) {
		return index(request, model);
	}

	/**
	 * TOMCAT的默认路径
	 * 
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String index(HttpServletRequest request, ModelMap model) {
		Website web = SiteUtils.getWeb(request);
		ShopFrontHelper.setCommonData(request, model, web, 1);
		return web.getTemplate(TPLDIR_INDEX, MessageResolver.getMessage(request,TPL_INDEX));
	}

	/**
	 * 动态页入口
	 */
	@RequestMapping(value = "/**/*.*", method = RequestMethod.GET)
	public String execute(HttpServletRequest request, HttpServletResponse response, ModelMap model) {
		String url = request.getRequestURL().toString();
		Global global=SiteUtils.getWeb(request).getGlobal();
		model.addAttribute("global", global);
		URLInfo info = URLHelper.getURLInfo(url, request.getContextPath());
		String queryString = request.getQueryString();
		Website web = SiteUtils.getWeb(request);
		ShopFrontHelper.setDynamicPageData(request, model, web, url, info.getUrlPrefix(),info.getUrlSuffix(), info.getPageNo());
		String[] paths = info.getPaths();
		String[] params = info.getParams();
		int pageNo = info.getPageNo();
		int len = paths.length;
        if (len == 1) {
			// 单页
			return channel(paths[0], params, pageNo, queryString, url, web,request, response, model);
		} else if (len == 2) {
			if (paths[1].equals(INDEX)) {
				// 栏目页
				return channel(paths[0], params, pageNo, queryString, url, web,request, response, model);
			}
			try {
				Long id = Long.parseLong(paths[1]);
				// 内容页
				return content(paths[0], id, params, pageNo, queryString, url,web, request, response, model);
			} catch (NumberFormatException e) {
			}
		}
		return FrontHelper.pageNotFound(web, model, request);
	}
	
	/**
	 * 栏目页
	 */
	@SuppressWarnings("unchecked")
	public String channel(String path, String[] params, int pageNo,String queryString, String url, Website web,
			HttpServletRequest request, HttpServletResponse response,ModelMap model) {
		Category category = categoryMng.getByPath(web.getId(), path);
		if (category != null) {
			List<Exended> exendeds = exendedMng.getList(category.getType().getId());
			Map map= new HashMap(); 
			Map map1= new HashMap(); 
			int num = exendeds.size();
			for(int i=0;i<num;i++){
				map.put(exendeds.get(i).getId().toString(), exendeds.get(i).getItems());
				map1.put(exendeds.get(i).getId().toString(), exendeds.get(i));
			}
			model.addAttribute("brandId",getBrandId(request));
			model.addAttribute("map", map);
			model.addAttribute("map1", map1);
			model.addAttribute("fields", getNames(request));
			model.addAttribute("zhis", getValues(request));
			model.addAttribute("category", category);
			model.addAttribute("pageSize", getpageSize(request));
			model.addAttribute("names", getName(request));
			model.addAttribute("values", getValue(request));
			model.addAttribute("isShow", getIsShow(request));
			model.addAttribute("orderBy",getOrderBy(request));
			return category.getTplChannelRel();
		} else {
			ShopChannel channel = shopChannelMng.getByPath(web.getId(),path);
			if (channel != null) {
				model.addAttribute("channel", channel);
				return channel.getTplChannelRel();
			}
		}
		return FrontHelper.pageNotFound(web, model, request);
	}

	/**
	 * 内容页
	 */
	public String content(String chnlName, Long id, String[] params,
			int pageNo, String queryString, String url, Website web,
			HttpServletRequest request, HttpServletResponse response,
			ModelMap model) {
		Category category = categoryMng.getByPath(web.getId(), chnlName);
		if (category != null) {//商品内容
			Product product = productMng.findById(id);
			if (product != null) {
				if(product.getProductFashion()!=null){
					String[] arr = null;
					arr=product.getProductFashion().getNature().split("_");
					model.addAttribute("arr", arr);
				}

				List<ProductStandard> psList = productStandardMng.findByProductId(id);
				List<StandardType> standardTypeList = standardTypeMng.getList(category.getId());
				productMng.updateViewCount(product);
				model.addAttribute("standardTypeList",standardTypeList);
				model.addAttribute("psList",psList);
				model.addAttribute("category", category);
                List<Map<String,String>> pictureList = changePicturePath(product);
//                product.setPictures(list);
                model.addAttribute("pictureList",pictureList);
				model.addAttribute("product", product);
				return category.getTplContentRel();
			} else {
				return FrontHelper.pageNotFound(web, model, request);
			}
		} else {//文章内容
			ShopArticle article = shopArticleMng.findById(id);
			if (article != null) {
				ShopChannel channel = article.getChannel();
				model.addAttribute("article", article);
				model.addAttribute("channel", channel);
				return channel.getTplContentRel();
			} else {
				return FrontHelper.pageNotFound(web, model, request);
			}
		}
	}

	
	//GET提交方式导致enter键提交 出现分页问题
	@RequestMapping(value = "/brand.jspx", method = RequestMethod.GET)
	public String brand(Long id, HttpServletRequest request, ModelMap model) {
		String tpl;
		Website web = SiteUtils.getWeb(request);
		WebErrors errors = validateBrand(id, request);
		if (errors.hasErrors()) {
			return FrontHelper.showError(errors, web, model, request);
		}
		if (id != null) {
			model.addAttribute("brand", brandMng.findById(id));
			tpl = MessageResolver.getMessage(request, BRAND_DETAIL);
		} else {
			tpl = MessageResolver.getMessage(request, BRAND);
		}
		ShopFrontHelper.setCommonData(request, model, web, 1);
		return web.getTplSys(SHOP_SYS, tpl);
	}
	
	public Integer getBrandId(HttpServletRequest request){
		String brandId = RequestUtils.getQueryParam(request, "brandId");
		Integer id = null;
		if (!StringUtils.isBlank(brandId)) {
			id = Integer.parseInt(brandId);
		}
		return id;
	}
	
	public Integer getpageSize(HttpServletRequest request){
		String pageSize = RequestUtils.getQueryParam(request, "pageSize");
		Integer pagesize = null;
		if (!StringUtils.isBlank(pageSize)) {
			pagesize = Integer.parseInt(pageSize);
		}
		if(pagesize==null){
			pagesize = 12;
		}
		return pagesize;
	}

	public Integer getIsShow(HttpServletRequest request){
		String isShow = RequestUtils.getQueryParam(request, "isShow");
		Integer isshow = null;
		if (!StringUtils.isBlank(isShow)) {
			isshow = Integer.parseInt(isShow);
		}
		if(isshow==null){
			isshow = 0;
		}
		return isshow;
	}
	
	public Integer getOrderBy(HttpServletRequest request){
		String orderBy = RequestUtils.getQueryParam(request, "orderBy");
		Integer orderby = null;
		if (!StringUtils.isBlank(orderBy)) {
			orderby = Integer.parseInt(orderBy);
		}
		if(orderby==null){
			orderby = 0;
		}
		return orderby;
	}
	
	public String[] getNames(HttpServletRequest request){
		Map<String, String> attr = RequestUtils.getRequestMap(request, "exended_");
		List li=new ArrayList(attr.keySet());
	    String name= "";
	    for(int i=0;i<li.size();i++){
	    	if(i+1==li.size()){
	    		name+=(String) li.get(i);
	    	}else{
	    		name+=(String) li.get(i)+",";
	    	}
	    }
	    String[] names= StringUtils.split(name, ',');
		return names;
	}
	
	public String[] getValues(HttpServletRequest request){
		Map<String, String> attr = RequestUtils.getRequestMap(request, "exended_");
		List li=new ArrayList(attr.keySet());
	    String value= "";
	    for(int i=0;i<li.size();i++){
	    	if(i+1==li.size()){
	    		if(StringUtils.isBlank(attr.get(li.get(i)))){
	    			value+="0";
	    		}else{
	    			value+=attr.get(li.get(i));
	    		}
	    	}else{
	    		if(StringUtils.isBlank(attr.get(li.get(i)))){
	    			value+="0,";
	    		}else{
	    			value+=attr.get(li.get(i))+",";
	    		}
	    	}
	    }
		String[] values= StringUtils.split(value, ',');
		return values;
	}
	
	
	public String getName(HttpServletRequest request){
		Map<String, String> attr = RequestUtils.getRequestMap(request, "exended_");
		List li=new ArrayList(attr.keySet());
	    String name= "";
	    for(int i=0;i<li.size();i++){
	    	if(i+1==li.size()){
	    		name+=(String) li.get(i);
	    	}else{
	    		name+=(String) li.get(i)+",";
	    	}
	    }
	    
		return name;
	}
	
	public String getValue(HttpServletRequest request){
		Map<String, String> attr = RequestUtils.getRequestMap(request, "exended_");
		List li=new ArrayList(attr.keySet());
	    String value= "";
	    for(int i=0;i<li.size();i++){
	    	if(i+1==li.size()){
	    		if(StringUtils.isBlank(attr.get(li.get(i)))){
	    			value+="0";
	    		}else{
	    			value+=attr.get(li.get(i));
	    		}
	    	}else{
	    		if(StringUtils.isBlank(attr.get(li.get(i)))){
	    			value+="0,";
	    		}else{
	    			value+=attr.get(li.get(i))+",";
	    		}
	    	}
	    }
		return value;
	}
	
   private WebErrors validateBrand(Long id, HttpServletRequest request) {
		WebErrors errors = WebErrors.create(request);
		if (id != null) {
			Brand brand = brandMng.findById(id);
			if (errors.ifNotExist(brand, Brand.class, id)) {
				return errors;
			}
		}
		return errors;
	}

    private List<Map<String,String>> changePicturePath(Product product){
        List<ProductPicture> listPicture = product.getPictures();
        List<Map<String,String>> list = new ArrayList<>();
        if(listPicture.size()>0){
            String baseUrl = ProjectXml.getValue("base_path_upload");
            for (ProductPicture productPicture : listPicture){
                Map<String,String> map=new HashMap<>();
                if(null!=productPicture.getAppPicturePath()&&!"".equals(productPicture.getAppPicturePath())){
                    map.put("appPicturePath",baseUrl+productPicture.getAppPicturePath());
                }else {
                    map.put("appPicturePath","/images/no_image.jpg");
                }
                if(null!=productPicture.getBigPicturePath()&&!"".equals(productPicture.getBigPicturePath())){
                    map.put("bigPicturePath",baseUrl+productPicture.getBigPicturePath());
                }else {
                    map.put("bigPicturePath","/images/no_image.jpg");
                }
                if(null!=productPicture.getPicturePath()&&!"".equals(productPicture.getPicturePath())){
                    map.put("picturePath",baseUrl+productPicture.getPicturePath());
                }else {
                    map.put("picturePath","/images/no_image.jpg");
                }
                list.add(map);
            }
        }else {
            Map<String,String> map=new HashMap<>();
            map.put("appPicturePath","/images/no_image.jpg");
            map.put("bigPicturePath","/images/no_image.jpg");
            map.put("picturePath","/images/no_image.jpg");
            list.add(map);
        }
        return list;
    }
	@Autowired
	private CategoryMng categoryMng;
	@Autowired
	private ProductMng productMng;
	@Autowired
	private ShopChannelMng shopChannelMng;
	@Autowired
	private ShopArticleMng shopArticleMng;
	@Autowired
	private BrandMng brandMng;
	@Autowired
	private StandardTypeMng standardTypeMng;
	@Autowired
	private ProductStandardMng productStandardMng;
	@Autowired
	private ExendedMng exendedMng;

}
