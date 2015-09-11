package com.ifunpay.portal.dao.simple;

import com.ifunpay.portal.dao.BaseDao;
import com.ifunpay.portal.entity.order.OrderEntity;
import com.ifunpay.util.common.ClassUtil;
import lombok.extern.log4j.Log4j;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.Map;

/**
 * Created by yu on 15-8-31.
 */
@Component
@Log4j
public class SimpleOrderDao extends BaseDao {

    public List<OrderEntity> fetchOrders(Map<String, Object> filterMap, String sortField, boolean isASC, int start, int size) {
        Session session = getSessionFactory().getCurrentSession();
        Criteria criteria = session.createCriteria(OrderEntity.class);
        if (filterMap != null) {
            filterMap.forEach((k, v) ->
            {
                if (k != null && !k.isEmpty())
                    log.debug("got field: " + k + " -> " + v);
                    ClassUtil.getFieldType(OrderEntity.class, k)
                            .ifPresent(type -> {
                                if (ClassUtil.isNumberType(type) || ClassUtil.isEnumType(type)) {
                                    ClassUtil.newInstance(type, v).ifPresent(fieldValue -> {
                                        log.debug("add restriction eq: " + k + " -> " + v);
                                        criteria.add(Restrictions.eq(k, fieldValue));
                                    });
                                } else if (type == String.class) {
                                    log.debug("add restriction LIKE: " + k + " -> " + v);
                                    criteria.add(Restrictions.like(k, v.toString(), MatchMode.ANYWHERE));
                                }
                            });
            });
        }
        if (sortField != null && !sortField.isEmpty()) {
            log.debug("add sort field: " + sortField + ", ORDER: " + (isASC ? "ASC" : "DESC"));
            Order order = isASC ? Order.asc(sortField) : Order.desc(sortField);
            criteria.addOrder(order);
        }
        if (start < 0) start = 0;
        if (size < 0) size = 50;
        return criteria.setFirstResult(start).setMaxResults(size).list();
    }

}
