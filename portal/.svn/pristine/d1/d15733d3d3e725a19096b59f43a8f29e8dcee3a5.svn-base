package com.ifunpay.portal.dao.order;

import com.ifunpay.portal.dao.BaseDao;
import com.ifunpay.portal.dao.CommerceDao;
import com.ifunpay.portal.entity.order.OrderEntity;
import com.ifunpay.portal.entity.order.OrderProduct;
import com.ifunpay.util.enums.PaymentStatusEnum;
import com.ifunpay.portal.util.Arith;
import com.jspgou.cms.entity.Product;
import com.jspgou.common.hibernate3.HibernateBaseDao;
import org.hibernate.Query;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by CongLong Xie on 2015/7/24.
 */
@Service
public class OrderProductDao extends HibernateBaseDao<OrderProduct,Long>{

    @Resource
    private BaseDao baseDao;

    @Resource
    private CommerceDao commerceDao;

    public void buildOrderProduct(Product product,OrderEntity orderEntity,int qty){
        OrderProduct orderProduct = new OrderProduct();
        orderProduct.setEntity(orderEntity);
        orderProduct.setOrderNumber(orderEntity.getCode());
        orderProduct.setProduct(product);
        orderProduct.setProductName(product.getName());
        orderProduct.setProductPrice(new Double(Arith.mul(product.getScanningPrice(), 100)).longValue());
        orderProduct.setProductQty(qty);
        orderProduct.setCommerceName(product.getCommerceName());
        orderProduct.setCommerce(commerceDao.getCommerceById(Long.parseLong(product.getCommerceId())));
        baseDao.save(orderProduct);
    }

    public List<OrderProduct> getOrderProductByOrderId(String  orderNumber){
        Query query = getSession().createQuery("from OrderProduct where orderNumber ='"+orderNumber+"'");
        return query.list();
    }

    public int CountTotalSaleOut(Long productId){
        StringBuffer sql = new StringBuffer("from OrderProduct bean where bean.product.id ="+productId+" and bean.entity.del = 0 and bean.entity.paymentStatus = '"+ PaymentStatusEnum.PaySucceeded+"'");
        log.info("CountTotalSaleOut sql = "+sql.toString());
        Query query = getSession().createQuery(sql.toString());
        return query!=null?query.list().size():0;
    }

    public int CountTotalOrder(Long productId){
        StringBuffer sql = new StringBuffer("from OrderProduct bean where bean.product.id ="+productId);
        log.info("CountTotalSaleOut sql = "+sql.toString());
        Query query = getSession().createQuery(sql.toString());
        return query!=null?query.list().size():0;
    }
    @Override
    protected Class<OrderProduct> getEntityClass() {
        return null;
    }
}
