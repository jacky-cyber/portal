package com.jspgou.cms.dao.impl;

import com.jspgou.cms.dao.ProductFavorableDao;
import com.jspgou.cms.entity.ProductFavorable;
import com.jspgou.common.hibernate3.Finder;
import com.jspgou.common.hibernate3.HibernateBaseDao;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by David on 2015/3/18.
 */
@Repository
public class ProductFavorableDaoImpl extends HibernateBaseDao<ProductFavorable, Long> implements ProductFavorableDao {

    public ProductFavorable save(ProductFavorable bean) {
        getSession().save(bean);
        return bean;
    }


    public List<ProductFavorable> getList(Long productId ,Long favorableId,Boolean cacheable) {
            Finder f = Finder.create("from ProductFavorable bean where 1=1");
            if (productId != null) {
                f.append(" and bean.productId=:productId");
                f.setParam("productId", productId);
            }
            if (favorableId != null) {
                f.append(" and bean.favorableId=:favorableId");
                f.setParam("favorableId", favorableId);
            }
            f.setCacheable(cacheable);
            return find(f);
    }

    public ProductFavorable findById(Long id) {
        ProductFavorable entity = get(id);
        return entity;
    }
    public ProductFavorable removeById(Long id) {
        ProductFavorable entity = super.get(id);
        if (entity != null) {
            getSession().delete(entity);
        }
        return entity;
    }


    public void update(ProductFavorable productFavorable1) {
        getSession().update(productFavorable1);
    }

    @Override
    protected Class<ProductFavorable> getEntityClass() {
        return ProductFavorable.class;
    }


}
