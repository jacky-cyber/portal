package com.jspgou.cms.manager.impl;

import com.jspgou.cms.dao.ProductFavorableDao;
import com.jspgou.cms.entity.ProductFavorable;
import com.jspgou.cms.manager.ProductFavorableMng;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by David on 2015/3/18.
 */
@Service
@Transactional
public class ProductFavorableMngImpl implements ProductFavorableMng {

    public ProductFavorable save(ProductFavorable bean) {
        return dao.save(bean);
    }


    public List<ProductFavorable> getListByProduct(Long productId,Long favorableId) {
        return dao.getList(productId,favorableId,false);
    }

    @Override
    public ProductFavorable deleteById(Long id) {

        return dao.removeById(id);
    }

    @Override
    public void update(ProductFavorable productFavorable1) {
         dao.update(productFavorable1);
    }

    @Autowired
    private ProductFavorableDao dao;
}
