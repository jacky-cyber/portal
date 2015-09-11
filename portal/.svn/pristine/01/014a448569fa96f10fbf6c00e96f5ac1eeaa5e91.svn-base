package com.jspgou.cms.manager;

import com.jspgou.cms.entity.Product;
import com.jspgou.cms.entity.ProductExt;
import com.jspgou.cms.entity.ProductTag;
import com.jspgou.common.page.Pagination;
import org.springframework.web.multipart.MultipartFile;

import java.util.*;

/**
* This class should preserve.
* @preserve
*/
public interface ProductMng {
	public Pagination getPage(int orderBy,int pageNo, int pageSize);
	
	public List<Product> getList(Long typeId,Long brandId,String productName);
	
    //商品列表标签
	public List<Product> getListForTag(Long webId, Long ctgId, Long tagId,
			Boolean isRecommend, Boolean isSpecial,Boolean isHostSale,Boolean isNewProduct, int firstResult,
			int maxResults);
    //后台
 	public Pagination getPage(Long webId, Long ctgId,String productName,String brandName,
			Boolean isOnSale,Boolean isRecommend,
			Boolean isSpecial,Boolean isHotsale,Boolean isNewProduct,
			Long typeId,Double startSalePrice,Double endSalePrice,
			Integer startStock,Integer endStock,int pageNo, int pageSize,String channelId ,String channelName,String commerceId,String commerceName,Integer productStamp,Long productId,Date startTime,Date endTime);
	
	//库存预警
	public Pagination getPageByStockWarning(Long webId, Integer count,Boolean status,int pageNo, int pageSize); 

	//商品分页标签
	public Pagination getPageForTag(Long webId, Long ctgId, Long tagId,Boolean isRecommend, Boolean isSpecial, int pageNo, int pageSize);

	public Product findById(Long id);
	
	public Product updateByUpdater(Product bean);

	/**
	 * 删除商品级联的tag
	 * 
	 * @param tags
	 * @return 级联的商品数量
	 */
	public int deleteTagAssociation(ProductTag[] tags);

	public Product save(Product bean, ProductExt ext, Long webId, Long categoryId,
			Long brandId, Long[] tagIds, String[] keywords,String[] names,
			String[] values,String fashionSwitchPic[],String fashionBigPic[],String fashionAmpPic[],
			MultipartFile file);

	public Product update(Product bean, ProductExt ext, Long ctgId,
			Long brandId, Long[] tagIds, String[] keywords,String[] names,
			String[] values,Map<String, String> attr,
			String fashionSwitchPic[],String fashionBigPic[],String fashionAmpPic[],
			MultipartFile file);
	
	public Product update(Product bean);
	
	public void resetSaleTop();

	public Product[] deleteByIds(Long[] ids);
	
 	public Pagination getPageForTagChannel(Long brandId, Long webId, Long ctgId, Long tagId,//栏目页商品分页manager(wangzewu)
			Boolean isRecommend, String[] names,String[] values,Boolean isSpecial, int orderBy,int pageNo, int pageSize); 
	
	public Integer getStoreByProductPattern(Long id,Long fashId);
	
	public Integer getTotalStore(Long productId);


	public List<Product> getIsRecommend(Boolean isRecommend,int count);
	
	public Integer[] getProductByTag(Long webId);
	
	public List<Product> getHistoryProduct(HashSet<Long> set,Integer count);

	public void resetProfitTop();

	public void updateViewCount(Product product);

    public List<Product> getListByCommerceId(String commerceId);

    public List<Product> fetch(Long productId,String productName,String commerceName,Integer start, Integer size);
    List<Product> fetchLocalProductByChannelId(String channelId);
	List<Product> fetchLocalProductByCommerceId(String commerceId);

    public Integer findCount();

    public Product saveOldProduct(Product product, String imgPathCover,ArrayList<String> img);

	public void reduceInventory(Long[] prods,Integer[] quantity);

	public Pagination getPageForChannel(int pageNo, int pageSize,String channelId,Long productId,String productName,String commerceName);

	public Integer getProduct(String productName, String commerceId);
}