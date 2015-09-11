package com.jspgou.cms.dao.impl;

import com.jspgou.cms.dao.ProductDao;
import com.jspgou.cms.entity.Product;
import com.jspgou.cms.entity.ProductTag;
import com.jspgou.cms.lucene.LuceneProduct;
import com.jspgou.common.hibernate3.Finder;
import com.jspgou.common.hibernate3.HibernateBaseDao;
import com.jspgou.common.page.Pagination;
import org.apache.commons.lang.StringUtils;
import org.apache.lucene.index.CorruptIndexException;
import org.apache.lucene.index.IndexWriter;
import org.hibernate.*;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Repository;

import java.io.IOException;
import java.util.*;

/**
* This class should preserve.
* @preserve
*/
@Repository
public class ProductDaoImpl extends HibernateBaseDao<Product, Long> implements
		ProductDao {
	
	//不能动
	public Pagination getPageByCategory(Long ctgId, String productName,String brandName,
			Boolean isOnSale,Boolean isRecommend,Boolean isSpecial,Boolean isHotsale,
			Boolean isNewProduct,Long typeId,Double startSalePrice,Double endSalePrice,
			Integer startStock,Integer endStock,int pageNo, int pageSize, boolean cacheable,String channelId,String channelName,String commerceId,String commerceName,Integer productStamp,Long productId,Date startTime,Date endTime) {
		Finder f = getFinderForCategory(ctgId, productName,brandName,isOnSale,
				isRecommend, isSpecial,isHotsale,isNewProduct,typeId,startSalePrice,endSalePrice,
				startStock,endStock,cacheable, channelId,channelName, commerceId,commerceName,productStamp, productId, startTime, endTime);
		return find(f, pageNo, pageSize);
	}
    public Pagination getPageByCategory(Long ctgId, String productName,String brandName,
                                        Boolean isOnSale,Boolean isRecommend,Boolean isSpecial,Boolean isHotsale,
                                        Boolean isNewProduct,Long typeId,Double startSalePrice,Double endSalePrice,
                                        Integer startStock,Integer endStock,int pageNo, int pageSize, boolean cacheable) {
        return getPageByCategory(ctgId, productName, brandName,
				isOnSale, isRecommend, isSpecial, isHotsale,
				isNewProduct, typeId, startSalePrice, endSalePrice,
				startStock, endStock, pageNo, pageSize, cacheable, null, null, null, null, null, null, null, null);
    }

	public Pagination getPageByCategoryChannel(Long brandId,Long ctgId,
			Boolean isRecommend,String[] names,String[] values,//栏目页商品分页manager(wangzewu)
			Boolean isSpecial,int orderBy, int pageNo, int pageSize, boolean cacheable) {
		Finder f = getFinderForCategoryChannel(brandId, ctgId, isRecommend,
				names,values, isSpecial,orderBy,cacheable);	
		return find(f, pageNo, pageSize);
	}
	
	public Pagination getPageByStockWarning(Long webId,Integer count,
			Boolean status,int pageNo, int pageSize){
		Finder f = Finder.create("select bean from Product bean");
		f.append(" where bean.website.id=:webId").setParam("webId", webId);
		f.append(" and bean.stockCount <=:count").setParam("count", count);
		f.append(" and bean.lackRemind=:status").setParam("status", status);
		f.append(" order by bean.stockCount asc");
		return find(f, pageNo, pageSize);
	}

	public Pagination getPageForChannel(String channelId,int pageNo, int pageSize,Long productId,String productName ,String commerceName){
		Finder f = Finder.create("select bean from Product bean");
		f.append(" where bean.channelId=:channelId").setParam("channelId", channelId);
		if(null!=productId){
			f.append(" and bean.id=:productId").setParam("productId", productId);
		}
		if(!"".equals(productName) && productName!=null){
			f.append(" and bean.name like:productName").setParam("productName", "%"+productName+"%");
		}
		if(!"".equals(commerceName) && commerceName!=null){
			f.append(" and bean.commerceName like:commerceName").setParam("commerceName", "%"+commerceName+"%");
		}
		f.append(" order by bean.stockCount asc");
		return find(f, pageNo, pageSize);
	}

	@Override
	public Integer getProduct(String productName, String commerceId) {

		Finder f = Finder.create("select bean from Product bean where 1=1");
		f.append(" and bean.commerceId=:commerceId").setParam("commerceId", commerceId);
		f.append(" and bean.name=:productName").setParam("productName", productName);
		f.append(" order by bean.id desc");
		return find(f).size();
	}

	@SuppressWarnings("unchecked")//返回历史记录(wang ze wus)
	public List<Product> getHistoryProduct(HashSet<Long> set,Integer count){
		if(set.size()>0){
			return this.getSession().createQuery("from Product bean where bean.id in (:ids)")
			.setParameterList("ids", set).setMaxResults(count).list();
		}else{
			return new ArrayList();
		}
	}


    public List<Product> getListByCommerceId(String commerceId) {
        Finder f = Finder.create("select bean from Product bean where 1=1");
        f.append(" and bean.commerceId=:commerceId").setParam("commerceId", commerceId);
        f.append(" order by bean.id desc");
        return find(f);
    }


    public List<Product> fetchLocalProductByChannelId(Long productId, String productName, String commerceName, Integer start, Integer size) {
        Criteria criteria = getSession().createCriteria(Product.class);
        if (null!=productId) {
            criteria.add(Restrictions.eq("id", productId));
        }
        if (null!=productName){
            criteria.add(Restrictions.like("name", productName, MatchMode.ANYWHERE));
        }
        if(null != commerceName){
            criteria.add(Restrictions.like("commerceName", commerceName,MatchMode.ANYWHERE));
        }
        return criteria.setFirstResult(start).setMaxResults(size).list();
    }


    public Integer findCount() {
        String hql = "select count(*)  from Product ";
        Query query = getSession().createQuery(hql);
        int count = ((Long) query.iterate().next()).intValue();
        return count;
    }
    public List<Product> fetchLocalProductByChannelId(String channelId) {
        Criteria criteria = getSession().createCriteria(Product.class);
        if (null!=channelId) {
            criteria.add(Restrictions.eq("channelId", channelId));
        }
        criteria.add(Restrictions.eq("productStamp", 1));
        criteria.add(Restrictions.eq("onSale", true));
        return criteria.list();
    }

	public List<Product> fetchLocalProductByCommerceId(String commerceId){
		return getSession().createCriteria(Product.class)
				.add(Restrictions.eq("commerceId", commerceId))
				.add(Restrictions.eq("productStamp", 1))
				.add(Restrictions.eq("onSale", true))
				.list();
	}

    //不能动
	public Pagination getPageByWebsite(Long webId, String productName,String brandName,
			Boolean isOnSale,Boolean isRecommend,Boolean isSpecial,Boolean isHotsale,
			Boolean isNewProduct,Long typeId,Double startSalePrice,Double endSalePrice,
			Integer startStock,Integer endStock, int pageNo, int pageSize, boolean cacheable,String channelId,String channelName, String commerceId,String commerceName,Integer productStamp,Long productId,Date startTime,Date endTime) {
		Finder f = getFinderForWebsite(webId, productName,brandName,isOnSale,
				isRecommend, isSpecial,isHotsale,isNewProduct,typeId,startSalePrice,endSalePrice,
				startStock,endStock,cacheable,channelId,channelName,commerceId,commerceName,productStamp, productId, startTime, endTime);
		return find(f, pageNo, pageSize);
	}
    public Pagination getPageByWebsite(Long webId, String productName,String brandName,
                                       Boolean isOnSale,Boolean isRecommend,Boolean isSpecial,Boolean isHotsale,
                                       Boolean isNewProduct,Long typeId,Double startSalePrice,Double endSalePrice,
                                       Integer startStock,Integer endStock, int pageNo, int pageSize, boolean cacheable) {
        return getPageByWebsite( webId,  productName, brandName,
                 isOnSale, isRecommend, isSpecial, isHotsale,
                 isNewProduct, typeId, startSalePrice, endSalePrice,
                 startStock, endStock,  pageNo,  pageSize,  cacheable,null,null,null,null,null,null,null,null);
    }
	public Pagination getPageByTag(Long tagId, Long ctgId, Boolean isRecommend,
			Boolean isSpecial, int pageNo, int pageSize, boolean cacheable) {
		Finder f = getFinderForTag(ctgId, tagId, isRecommend, isSpecial,
				cacheable);
		return find(f, pageNo, pageSize);
	}

	@SuppressWarnings("unchecked")
	public List<Product> getListByCategory(Long ctgId, Boolean isRecommend,
			Boolean isSpecial, int firstResult, int maxResults,
			boolean cacheable) {
		Finder f = getFinderForCategory(ctgId, null,null,true,isRecommend, isSpecial,
				null,null,null,null,null,null,null,cacheable);
		f.setFirstResult(firstResult);
		f.setMaxResults(maxResults);
		return find(f);
	}

	@SuppressWarnings("unchecked")
	public List<Product> getListByWebsite(Long webId, Boolean isRecommend,
			Boolean isSpecial, int firstResult, int maxResults,
			boolean cacheable) {
		Finder f = getFinderForWebsite(webId,  null,null,null,isRecommend, isSpecial, 
				null,null,null,null,null,null,null,cacheable);
		f.setFirstResult(firstResult);
		f.setMaxResults(maxResults);
		return find(f);                                                                                                                                                    
	}
	
	@SuppressWarnings("unchecked")
	public List<Product> getListByWebsite1(Long webId, Boolean isRecommend,
			Boolean isSpecial,Boolean isHostSale,Boolean isNewProduct, int firstResult, int maxResults,
			boolean cacheable) {
		Finder f = getFinderForWebsite1(webId, isRecommend, isSpecial,isHostSale,isNewProduct, cacheable);
		f.setFirstResult(firstResult);
		f.setMaxResults(maxResults);
		return find(f);
	}

	@SuppressWarnings("unchecked")
	public List<Product> getListByTag(Long tagId, Long ctgId,
			Boolean isRecommend, Boolean isSpecial, int firstResult,
			int maxResults, boolean cacheable) {
		Finder f = getFinderForTag(tagId, ctgId, isRecommend, isSpecial,cacheable);
		f.setFirstResult(firstResult);
		f.setMaxResults(maxResults);
		return find(f);
	}
	
	//不能动
	private Finder getFinderForCategory(Long ctgId, String productName,String brandName,
			Boolean isOnSale,Boolean isRecommend,Boolean isSpecial,Boolean isHotsale,
			Boolean isNewProduct,Long typeId,Double startSalePrice,Double endSalePrice,
			Integer startStock,Integer endStock, boolean cacheable,String channelId,String channelName,String commerceId,String commerceName,Integer productStamp,Long productId,Date startTime,Date endTime) {
		Finder f = Finder.create("select bean from Product bean");
		f.append(" inner join bean.category node,Category parent");
		f.append(" where node.lft between parent.lft and parent.rgt");
		f.append(" and parent.id=:ctgId");
		if (!StringUtils.isBlank(productName)) {
			f.append(" and bean.name like:productName");
			f.setParam("productName", "%"+productName+"%");
		}
		if (!StringUtils.isBlank(brandName)) {
			f.append(" and bean.brand.name like:brandName");
			f.setParam("brandName", "%"+brandName+"%");
		}
		if (isOnSale != null) {
			f.append(" and bean.onSale=:isOnSale");
			f.setParam("isOnSale", isOnSale);
		}
		if (isRecommend != null) {
			f.append(" and bean.recommend=:isRecommend");
			f.setParam("isRecommend", isRecommend);
		}
		if (isSpecial != null) {
			f.append(" and bean.special=:isSpecial");
			f.setParam("isSpecial", isSpecial);
		}
		if (isHotsale != null) {
			f.append(" and bean.hotsale=:isHotsale");
			f.setParam("isHotsale", isHotsale);
		}
		if (isNewProduct != null) {
			f.append(" and bean.newProduct=:isNewProduct");
			f.setParam("isNewProduct", isNewProduct);
		}
		if (typeId != null) {
			f.append(" and bean.type.id=:typeId");
			f.setParam("typeId", typeId);
		}
		if (startSalePrice != null) {
			f.append(" and bean.salePrice>:startSalePrice");
			f.setParam("startSalePrice", startSalePrice);
		}
		if (endSalePrice != null) {
			f.append(" and bean.salePrice<:endSalePrice");
			f.setParam("endSalePrice", endSalePrice);
		}
		if (startStock != null) {
			f.append(" and bean.stockCount>:startStock");
			f.setParam("startStock", startStock);
		}
		if (endStock != null) {
			f.append(" and bean.stockCount<:endStock");
			f.setParam("endStock", endStock);
		}
        if (channelId != null&&!"1".equals(channelId)) {
            f.append(" and bean.channelId=:channelId");
            f.setParam("channelId", channelId);
        }
		if (channelName != null&&!"".equals(channelName)) {
			f.append(" and bean.channelName like:channelName");
			f.setParam("channelName","%"+channelName+"%");
		}
        if (commerceId != null&&!"1".equals(commerceId)) {
            f.append(" and bean.commerceId=:commerceId");
            f.setParam("commerceId", commerceId);
        }
		if (commerceName != null&&!"".equals(commerceName)) {
			f.append(" and bean.commerceName like:commerceName");
			f.setParam("commerceName", "%"+commerceName+"%");
		}
        if(productStamp!=null){
            f.append(" and bean.productStamp=:productStamp");
            f.setParam("productStamp", productStamp);
        }
        if(productId!=null){
            f.append(" and bean.id=:id");
            f.setParam("id", productId);
        }
        if(startTime!=null){
            f.append(" and bean.createTime>:startTime");
            f.setParam("startTime", startTime);
        }
        if(endTime!=null){
            f.append(" and bean.createTime<:endTime");
            f.setParam("endTime", endTime);
        }
		f.append(" order by bean.id desc");
		f.setParam("ctgId", ctgId);
		f.setCacheable(cacheable);
		return f;
	}
    private Finder getFinderForCategory(Long ctgId, String productName,String brandName,
                                        Boolean isOnSale,Boolean isRecommend,Boolean isSpecial,Boolean isHotsale,
                                        Boolean isNewProduct,Long typeId,Double startSalePrice,Double endSalePrice,
                                        Integer startStock,Integer endStock, boolean cacheable) {
        return getFinderForCategory(ctgId, productName,brandName,isOnSale,
                isRecommend, isSpecial,isHotsale,isNewProduct,typeId,startSalePrice,endSalePrice,
                startStock,endStock,cacheable,null,null,null,null,null,null,null,null);

    }
	
	@SuppressWarnings("unchecked")
	public List<Product> getList(Long typeId,Long brandId,String productName,boolean cacheable) {
		Finder f = Finder.create("from Product bean where 1=1");
		if (typeId != null) {
			f.append(" and bean.type.id=:typeId");
			f.setParam("typeId", typeId);
		}
		if (brandId != null) {
			f.append(" and bean.brand.id=:brandId");
			f.setParam("brandId",brandId);
		}
		if (!StringUtils.isBlank(productName)) {
			f.append(" and bean.name like:productName");
			f.setParam("productName", "%"+productName+"%");
		}
		f.setCacheable(cacheable);
		return find(f);
	}
	
	public Pagination getPage(int orderBy,int pageNo, int pageSize, boolean cacheable) {
		Finder f = Finder.create("from Product bean where 1=1");
		appendOrder(f, orderBy);
		f.setCacheable(cacheable);
		return find(f, pageNo, pageSize);
	}
	
	
	
	
	private Finder getFinderForCategoryChannel(Long brandId,Long ctgId, Boolean isRecommend,
		    String[] names,String[] values,Boolean isSpecial,int orderBy, boolean cacheable) {
		Finder f = Finder.create("select distinct bean from Product bean");
		f.append(" join bean.category node,Category parent");
		String[] exendeds = null;
		if(names!=null){
			exendeds=new String[names.length];
	    	for(int i=0,j=names.length;i<j;i++){
	    		String exended="exended"+i;
	    		exendeds[i]=exended;
	    		f.append(" inner join bean.exendeds "+exended);
	    	}
		}
		f.append(" where node.lft between parent.lft and parent.rgt and bean.onSale=true");
		f.append(" and parent.id=:ctgId");
		f.setParam("ctgId", ctgId);
		if (isRecommend != null) {
			f.append(" and node.recommend=:recommend");
			f.setParam("recommend", isRecommend);
		}
		if (isSpecial != null) {
			f.append(" and node.special=:special");
			f.setParam("special", isSpecial);
		}
		if(brandId!=null){//品牌
			f.append(" and bean.brand.id=:id");
			f.setParam("id", brandId);
		}
		if(names!=null){
	    	for(int i=0;i<names.length;i++){
	    	  String an="attr_name"+i;
	    	  String av="attr_value"+i;
			  if(!values[i].equals("0")){
			   f.append(" and "+exendeds[i]+".name=:"+an).setParam(an, names[i]);
		   	   f.append(" and "+exendeds[i]+".value=:"+av).setParam(av,values[i]);
		 	  }
		  }
		}
		appendOrder(f, orderBy);
		f.setCacheable(cacheable);
		return f;
	}
	
	
	private void appendOrder(Finder f, int orderBy) {
		switch (orderBy) {
		case 1:
			// ID升序
			f.append(" order by bean.id asc");
			break;
		case 2:
			// 上架时间降序
			f.append(" order by bean.createTime desc");
			break;
		case 3:
			// 上架时间升序
			f.append(" order by bean.createTime asc");
			break;
		case 4:
			//销售量降序、发布时间降序
			f.append(" order by bean.saleCount desc, bean.createTime desc");
			break;
		case 5:
			// 销售量降序、发布时间升序
			f.append(" order by bean.saleCount desc, bean.createTime asc");
			break;
		case 6:
			// 销售价降序
			f.append(" order by bean.salePrice desc, bean.id desc");
			break;
		case 7:
			// 销售价升序
			f.append(" order by bean.salePrice asc,bean.id desc");
			break;
		case 8:
			//利润降序
			f.append(" order by bean.liRun desc");
			break;
		case 9:
			//访问
			f.append(" order by bean.viewCount desc");
			break;
		default:
			// 默认： ID降序
			f.append(" order by bean.id desc");
		}
	}
	
	//不能动
	private Finder getFinderForWebsite(Long webId, String productName,String brandName,
			Boolean isOnSale,Boolean isRecommend,Boolean isSpecial,Boolean isHotsale,
			Boolean isNewProduct,Long typeId,Double startSalePrice,Double endSalePrice,
			Integer startStock,Integer endStock,boolean cacheable,String channelId,String channelName,String commerceId,String commerceName,Integer productStamp,Long productId,Date startTime,Date endTime) {
		Finder f = Finder.create("select bean from Product bean");
		f.append(" where bean.website.id=:webId");
		if (!StringUtils.isBlank(productName)) {
			f.append(" and bean.name like:productName");
			f.setParam("productName", "%"+productName+"%");
		}
		if (!StringUtils.isBlank(brandName)) {
			f.append(" and bean.brand.name like:brandName");
			f.setParam("brandName", "%"+brandName+"%");
		}
		if (isOnSale != null) {
			f.append(" and bean.onSale=:isOnSale");
			f.setParam("isOnSale", isOnSale);
		}
		if (isRecommend != null) {
			f.append(" and bean.recommend=:isRecommend");
			f.setParam("isRecommend", isRecommend);
		}
		if (isSpecial != null) {
			f.append(" and bean.special=:isSpecial");
			f.setParam("isSpecial", isSpecial);
		}
		if (isHotsale != null) {
			f.append(" and bean.hotsale=:isHotsale");
			f.setParam("isHotsale", isHotsale);
		}
		if (isNewProduct != null) {
			f.append(" and bean.newProduct=:isNewProduct");
			f.setParam("isNewProduct", isNewProduct);
		}
		if (typeId != null) {
			f.append(" and bean.type.id=:typeId");
			f.setParam("typeId", typeId);
		}
		if (startSalePrice != null) {
			f.append(" and bean.salePrice>:startSalePrice");
			f.setParam("startSalePrice", startSalePrice);
		}
		if (endSalePrice != null) {
			f.append(" and bean.salePrice<:endSalePrice");
			f.setParam("endSalePrice", endSalePrice);
		}
		if (startStock != null) {
			f.append(" and bean.stockCount>:startStock");
			f.setParam("startStock", startStock);
		}
		if (endStock != null) {
			f.append(" and bean.stockCount<:endStock");
			f.setParam("endStock", endStock);
		}
        if (channelId != null&&!"1".equals(channelId)) {
            f.append(" and bean.channelId=:channelId");
            f.setParam("channelId", channelId);
        }
        if ( commerceId != null&&!"1".equals(commerceId)) {
            f.append(" and bean.commerceId=:commerceId");
            f.setParam("commerceId", commerceId);
        }
		if (channelName != null&&!"".equals(channelName)) {
			f.append(" and bean.channelName like:channelName");
			f.setParam("channelName", "%"+channelName+"%");
		}
		if ( commerceName != null&&!"".equals(commerceName)) {
			f.append(" and bean.commerceName like:commerceName");
			f.setParam("commerceName", "%"+commerceName+"%");
		}
        if(productStamp!=null){
            f.append(" and bean.productStamp=:productStamp");
            f.setParam("productStamp", productStamp);
        }
        if(productId!=null){
            f.append(" and bean.id=:id");
            f.setParam("id", productId);
        }
        if(startTime!=null){
            f.append(" and bean.createTime>:startTime");
            f.setParam("startTime", startTime);
        }
        if(endTime!=null){
            f.append(" and bean.createTime<:endTime");
            f.setParam("endTime", endTime);
        }
		f.append(" order by bean.id desc");
		f.setParam("webId", webId);
		f.setCacheable(cacheable);
		return f;
	}
    private Finder getFinderForWebsite(Long webId, String productName,String brandName,
                                       Boolean isOnSale,Boolean isRecommend,Boolean isSpecial,Boolean isHotsale,
                                       Boolean isNewProduct,Long typeId,Double startSalePrice,Double endSalePrice,
                                       Integer startStock,Integer endStock,boolean cacheable) {
        return getFinderForWebsite(webId, productName,brandName,isOnSale,
                isRecommend, isSpecial,isHotsale,isNewProduct,typeId,startSalePrice,endSalePrice,
                startStock,endStock,cacheable,null,null,null,null,null,null,null,null);
    }
	
	@SuppressWarnings("unchecked")
	public List<Product> getIsRecommend(Boolean isRecommend,int count){
		Finder f=Finder.create("from Product bean where bean.recommend=:recommend").setParam("recommend", isRecommend);
		f.setMaxResults(count);
		return this.find(f);
	}


	private Finder getFinderForWebsite1(Long webId, Boolean isRecommend,
			Boolean isSpecial,Boolean isHostSale,Boolean isNewProduct, boolean cacheable) {
		Finder f = Finder.create("from Product bean");
		f.append(" where bean.website.id=:webId and bean.onSale=true");
		if (isRecommend != null) {
			f.append(" and bean.recommend=:recommend");
			f.setParam("recommend", isRecommend);
		}
		if (isSpecial != null) {
			f.append(" and bean.special=:special");
			f.setParam("special", isSpecial);
		}
		if (isHostSale != null) {
			f.append(" and bean.hotsale=:hotsale");
			f.setParam("hotsale", isHostSale);
		}
		if (isNewProduct != null) {
			f.append(" and bean.newProduct=:newProduct");
			f.setParam("newProduct", isNewProduct);
		}
		f.append(" order by bean.id desc");
		f.setParam("webId", webId);
		f.setCacheable(cacheable);
		return f;
	}
   //商品标签:tagId,产品类别：ctgid
	private Finder getFinderForTag(Long tagId, Long ctgId, Boolean isRecommend,
			Boolean isSpecial, boolean cacheable) {
		Finder f = Finder.create("select bean from Product bean");
		f.append(" inner join bean.tags tag with tag.id=:tagId");
		f.append(" where bean.onSale=true");
		f.setParam("tagId", tagId);
		if (ctgId != null) {
			f.append(" and bean.category.id=:ctgId");
			f.setParam("ctgId", ctgId);
		}
		if (isRecommend != null) {
			f.append(" and bean.recommend=:recommend");
			f.setParam("recommend", isRecommend);
		}
		if (isSpecial != null) {
			f.append(" and bean.special=:special");
			f.setParam("special", isSpecial);
		}
		f.append(" order by bean.id desc");
		f.setCacheable(cacheable);
		return f;
	}

	public int luceneWriteIndex(IndexWriter writer, Long webId, Date start,
			Date end) throws CorruptIndexException, IOException {
		Session session = getSession();
		Finder f = Finder.create("from Product bean where 1=1");
		if (webId != null) {
			f.append(" and bean.website.id=:webId");
			f.setParam("webId", webId);
		}
		if (start != null) {
			f.append(" and bean.createTime >= :start");
			f.setParam("start", start);
		}
		if (end != null) {
			f.append(" and bean.createTime >= :end");
			f.setParam("end", end);
		}

		ScrollableResults products = f.createQuery(session).setCacheMode(
				CacheMode.IGNORE).scroll(ScrollMode.FORWARD_ONLY);
		Product product;
		int count = 0;
		while (products.next()) {
			product = (Product) products.get(0);
			writer.addDocument(LuceneProduct.createDocument(product));
			if (++count % 20 == 0) {
				session.clear();
			}
		}
		return count;
	}

	public int deleteTagAssociation(ProductTag[] tags) {
		Long[] tagIds = new Long[tags.length];
		for (int i = 0, len = tags.length; i < len; i++) {
			tagIds[i] = tags[i].getId();
		}
		Session session = getSession();
		String hql = "from Product bean inner join bean.tags tag where tag.id in (:tagIds)";
		ScrollableResults products = session.createQuery(hql).setParameterList(
				"tagIds", tagIds).setCacheMode(CacheMode.IGNORE).scroll(
				ScrollMode.FORWARD_ONLY);
		int count = 0;
		while (products.next()) {
			Product product = (Product) products.get(0);
			product.getTags().removeAll(Arrays.asList(tags));
			if (++count % 20 == 0) {
				session.flush();
				session.clear();
			}
		}
		return count;
	}
	
	public Integer[] getProductByTag(Long webId){//新品，特价，热卖(wang ze wu)
		Long newProduct=(Long)this.getSession().createQuery("select count(*) from Product bean where bean.website.id=:webId  and bean.newProduct=true")
		.setParameter("webId", webId).uniqueResult();
		Long hotProduct=(Long)this.getSession().createQuery("select count(*) from Product bean where bean.website.id=:webId  and bean.hotsale=true")
		.setParameter("webId", webId).uniqueResult();
		Long speProduct=(Long)this.getSession().createQuery("select count(*) from Product bean where bean.website.id=:webId   and bean.special=true")
		.setParameter("webId", webId).uniqueResult();
		Integer[] p = new Integer[3];
		p[0] = newProduct.intValue();
		p[1] = hotProduct.intValue();
		p[2] = speProduct.intValue();
		return p;
	}

	public Product findById(Long id) {
		Product entity = get(id);
		return entity;
	}

	public Product save(Product bean) {
		getSession().save(bean);
		return bean;
	}

	public Product deleteById(Long id) {
		Product entity = super.get(id);
		if (entity != null) {
			getSession().delete(entity);
		}
		return entity;
	}

	@Override
	protected Class<Product> getEntityClass() {
		return Product.class;
	}

}