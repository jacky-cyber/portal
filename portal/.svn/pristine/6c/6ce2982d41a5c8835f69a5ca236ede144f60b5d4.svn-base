package com.jspgou.cms.action.directive;

import com.ifunpay.portal.ProjectXml;
import com.jspgou.cms.entity.Product;
import com.jspgou.common.web.freemarker.DirectiveUtils;
import com.jspgou.core.entity.Website;
import freemarker.core.Environment;
import freemarker.template.ObjectWrapper;
import freemarker.template.TemplateDirectiveBody;
import freemarker.template.TemplateException;
import freemarker.template.TemplateModel;

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
public class ProductListDirective extends ProductAbstractDirective {
	/**
	 * 模板名称
	 */
	public static final String TPL_NAME = "ProductList";

	@SuppressWarnings("unchecked")
	public void execute(Environment env, Map params, TemplateModel[] loopVars,
			TemplateDirectiveBody body) throws TemplateException, IOException {
		Website web = getWeb(env, params, websiteMng);
		Long ctgId = getCategoryId(params);
		Long tagId = getTagId(params);
		List<Product> list = productMng.getListForTag(web.getId(), ctgId,
				tagId, isRecommend(params), isSpecial(params),this.isHostSale(params),this.isNewProduct(params), 0,
				getCount(params));
		Map<String, TemplateModel> paramWrap = new HashMap<String, TemplateModel>(
				params);
        List<Map<String,Object>> list1 = new ArrayList<>();
        String baseUrl = ProjectXml.getValue("base_path_upload");
        if(list.size()>0) {
            for (Product product:list) {
                Map<String, Object> map = new HashMap<>();
                map.put("text2",product.getText2());
                if(null!=product.getCoverImgUrl()&&!"".equals(product.getCoverImgUrl())){
                    map.put("coverImgUrl",baseUrl+product.getCoverImgUrl());
                }else {
                    map.put("coverImgUrl","/images/no_image.jpg");
                }

                map.put("coverImg",product.getCoverImg());
                map.put("category",product.getCategory());
                map.put("name",product.getName());
                map.put("text",product.getText());
                map.put("id",product.getId());
                map.put("price",product.getPrice());
                map.put("brand",product.getBrand());
                map.put("brandId",product.getBrandId());
                map.put("brandName",product.getBrandName());
                map.put("categoryIdArray",product.getCategoryIdArray());
                map.put("categoryList",product.getCategoryList());
                map.put("categoryNameArray",product.getCategoryNameArray());
                map.put("detailImg",product.getDetailImg());
                map.put("detailImgUrl",product.getDetailImgUrl());
                map.put("keywordArray",product.getKeywordArray());
                map.put("listImg",product.getListImg());
                map.put("listImgUrl",product.getListImgUrl());
                map.put("mdescription",product.getMdescription());
                map.put("memberPrice",product.getMemberPrice());
                map.put("minImg",product.getMinImg());
                map.put("minImgUrl",product.getMinImgUrl());
                map.put("mkeywords",product.getMkeywords());
                map.put("mtitle",product.getMtitle());
                map.put("price",product.getPrice());
                map.put("productFashion",product.getProductFashion());
                map.put("productTotalSaleCount",product.getProductTotalSaleCount());
                map.put("productTotalStockCount",product.getProductTotalStockCount());
                map.put("tagArray",product.getTagArray());
                map.put("tagIds",product.getTagIds());
                map.put("text1",product.getText1());
                map.put("unit",product.getUnit());
                map.put("url",product.getUrl());
                map.put("weight",product.getWeight());
                map.put("alertInventory",product.getAlertInventory());
                map.put("attr",product.getAttr());
                map.put("channelId",product.getChannelId());
                map.put("channelName",product.getChannelName());
                map.put("checked",product.getChecked());
                map.put("commerceId",product.getCommerceId());
                map.put("commerceName",product.getCommerceName());
                map.put("config",product.getConfig());
                map.put("costPrice",product.getCostPrice());
                map.put("exendeds",product.getExendeds());
                map.put("expireTime",product.getExpireTime());
                map.put("fashions",product.getFashions());
                map.put("flashPrice",product.getFlashPrice());
                map.put("hotsale",product.getHotsale());
                map.put("lackRemind",product.getLackRemind());
                map.put("liRun",product.getLiRun());
                map.put("littlePrice",product.getLittlePrice());
                map.put("marketPrice",product.getMarketPrice());
                map.put("newProduct",product.getNewProduct());
                map.put("onSale",product.getOnSale());
                map.put("pictures",product.getPictures());
                map.put("popularityGroups",product.getPopularityGroups());
                map.put("productExt",product.getProductExt());
                map.put("productStamp",product.getProductStamp());
                map.put("productText",product.getProductText());
                map.put("recommend",product.getRecommend());
                map.put("saleCount",product.getSaleCount());
                map.put("scanningPrice",product.getScanningPrice());
                map.put("score",product.getScore());
                map.put("sendMassage",product.getSendMassage());
                map.put("screenPrice",product.getScreenPrice());
                map.put("shareContent",product.getShareContent());
                map.put("special",product.getSpecial());
                map.put("stockCount",product.getStockCount());
                map.put("tags",product.getTags());
                map.put("type",product.getType());
                map.put("website",product.getWebsite());
                list1.add(map);
            }
        }
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
}
