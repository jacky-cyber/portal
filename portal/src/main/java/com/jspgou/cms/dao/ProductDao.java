package com.jspgou.cms.dao;

import com.jspgou.cms.entity.Product;
import com.jspgou.cms.entity.ProductTag;
import com.jspgou.common.hibernate3.Updater;
import com.jspgou.common.page.Pagination;
import org.apache.lucene.index.CorruptIndexException;
import org.apache.lucene.index.IndexWriter;

import java.io.IOException;
import java.util.Date;
import java.util.HashSet;
import java.util.List;

/**
* This class should preserve.
* @preserve
*/
public interface ProductDao {
	
	public List<Product> getList(Long typeId,Long brandId,String productName,boolean cacheable);
	
	public Pagination getPage(int orderBy,int pageNo, int pageSize, boolean cacheable);

	public Pagination getPageByCategory(Long ctgId, String productName,String brandName,
			Boolean isOnSale,Boolean isRecommend,Boolean isSpecial,Boolean isHotsale,
			Boolean isNewProduct,Long typeId,Double startSalePrice,Double endSalePrice,
			Integer startStock,Integer endStock, int pageNo, int pageSize, boolean cacheable,String channelId,String channelName,String commerceId,String commerceName,Integer productStamp,Long productId,Date startTime,Date endTime);

    public Pagination getPageByCategory(Long ctgId, String productName,String brandName,
                                        Boolean isOnSale,Boolean isRecommend,Boolean isSpecial,Boolean isHotsale,
                                        Boolean isNewProduct,Long typeId,Double startSalePrice,Double endSalePrice,
                                        Integer startStock,Integer endStock, int pageNo, int pageSize, boolean cacheable);
	public Pagination getPageByWebsite(Long webId,String productName,String brandName,
			Boolean isOnSale,Boolean isRecommend,Boolean isSpecial,Boolean isHotsale,
			Boolean isNewProduct,Long typeId,Double startSalePrice,Double endSalePrice,
			Integer startStock,Integer endStock, int pageNo, int pageSize, boolean cacheable,String channelId,String channelName,String commerceId,String commerceName,Integer productStamp,Long productId,Date startTime,Date endTime);

    public Pagination getPageByWebsite(Long webId,String productName,String brandName,
                                       Boolean isOnSale,Boolean isRecommend,Boolean isSpecial,Boolean isHotsale,
                                       Boolean isNewProduct,Long typeId,Double startSalePrice,Double endSalePrice,
                                       Integer startStock,Integer endStock, int pageNo, int pageSize, boolean cacheable);
	public Pagination getPageByTag(Long tagId, Long ctgId, Boolean isRecommend,
			Boolean isSpecial, int pageNo, int pageSize, boolean cacheable);
	
	public Pagination getPageByStockWarning(Long webId,Integer count,Boolean status,int pageNo, int pageSize);

	public List<Product> getListByCategory(Long ctgId, Boolean isRecommend,
			Boolean isSpecial, int firstResult, int maxResults,
			boolean cacheable);

	public List<Product> getListByWebsite(Long webId, Boolean isRecommend,
			Boolean isSpecial, int firstResult, int maxResults,
			boolean cacheable);

	public List<Product> getListByTag(Long tagId, Long ctgId,
			Boolean isRecommend, Boolean isSpecial, int firstResult,
			int maxResults, boolean cacheable);

	public int luceneWriteIndex(IndexWriter writer, Long webId, Date start,
			Date end) throws CorruptIndexException, IOException;
	public List<Product> getListByWebsite1(Long webId, Boolean isRecommend,
			Boolean isSpecial,Boolean isHostSale,Boolean isNewProduct, int firstResult, int maxResults,
			boolean cacheable) ;
	public int deleteTagAssociation(ProductTag[] tags);

	public Product findById(Long id);

	public Product save(Product bean);

	public Product updateByUpdater(Updater<Product> updater);

	public Product deleteById(Long id);
	
	public Pagination getPageByCategoryChannel(Long brandId, Long ctgId,
			Boolean isRecommend, String[] names,String[] values,//栏目页商品分页manager(wangzewu)
			Boolean isSpecial,int orderBy, int pageNo, int pageSize, boolean cacheable);
	public List<Product> getIsRecommend(Boolean isRecommend,int count);
	
	public Integer[] getProductByTag(Long webId);
	
	public List<Product> getHistoryProduct(HashSet<Long> set,Integer count);

    public List<Product> getListByCommerceId(String commerceId);

    public List<Product> fetchLocalProductByChannelId(Long productId, String productName, String commerceName, Integer start, Integer size);

    List<Product> fetchLocalProductByChannelId(String channelId);
	List<Product> fetchLocalProductByCommerceId(String commerceId);

    public Integer findCount();

	public Pagination getPageForChannel(String channelId, int pageNo, int pageSize,Long productId,String productName ,String commerceName);

	public Integer getProduct(String productName, String commerceId);


}