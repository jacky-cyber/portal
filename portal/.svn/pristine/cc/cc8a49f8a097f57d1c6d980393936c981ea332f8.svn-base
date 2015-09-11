package com.ifunpay.portal.dao;

import com.ifunpay.util.common.ClassUtil;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.hibernate.*;
import org.hibernate.criterion.*;
import org.hibernate.metadata.ClassMetadata;
import org.hibernate.search.FullTextSession;
import org.hibernate.search.Search;
import org.springframework.context.annotation.EnableAspectJAutoProxy;
import org.springframework.context.annotation.Scope;
import org.springframework.context.annotation.ScopedProxyMode;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.io.Serializable;
import java.util.Arrays;
import java.util.List;
import java.util.Optional;

/**
 * Created by Yu on 2015/3/2.
 */
@Service
@EnableAspectJAutoProxy(proxyTargetClass = true)
public class BaseDao {

    Logger logger = Logger.getLogger(BaseDao.class);

    @Resource
    SessionFactory sessionFactory;


    /**
     * 获取Hibernate的Session。
     *
     * @return 返回Hibernate的Session。
     */
    public Session getSession() {
        return sessionFactory.getCurrentSession();
    }

    public Session openSession() {
        return sessionFactory.openSession();
    }

    /**
     * 获取Hibernate的全文搜索Session。
     *
     * @return 返回Hibernate的全文搜索Session。
     */
    public FullTextSession getFullTextSession() {
        return Search.getFullTextSession(getSession());
    }

    /**
     * 根据指定的ID加载业务实体。
     *
     * @param id 实体ID
     * @return 返回指定的ID加载业务实体，如果对象不存在抛出异常。
     */
    public <T> T load(Serializable id, Class<T> clazz) {
        return (T) getSession().load(clazz, id);
    }

    /**
     * 根据指定的ID获取业务实体。
     *
     * @param id 实体ID
     * @return 返回指定ID的业务实体，如果没有找到则返回null。
     */
    public <T> Optional<T> get(Class<T> clazz, Serializable id) {
        try {
            return Optional.ofNullable((T) getSession().get(clazz, id));
        } catch (Throwable e) {
            logger.error("", e);
            return Optional.empty();
        }
    }

    public <T> T get(String columnName, Object value, Class<T> clazz) {
        return (T) getSession().createCriteria(clazz).setCacheable(true).add(Restrictions.eq(columnName, value)).uniqueResult();
    }

    public <T> List<T> list(String columnName, Object value, Class<T> clazz) {
        return getSession().createCriteria(clazz).setCacheable(true).add(Restrictions.eq(columnName, value)).list();
    }

    /**
     * 持久化业务实体。
     *
     * @param entity 待持久化业务实体
     */
    public void persist(Object entity) {
        getSession().persist(entity);
    }

    /**
     * 保存
     *
     * @param entity 待保存业务实体
     */
    @Transactional
    public void save(Object entity) {
        getSession().save(entity);
    }


    /**
     * 保存或更新业务实体。
     *
     * @param entity 待保存业务实体
     */
    @Transactional
    public void saveOrUpdate(Object entity) {
        getSession().saveOrUpdate(entity);
    }

    /**
     * 更新业务实体。
     *
     * @param entity 待更新业务实体
     */
    @Transactional
    public void update(Object entity) {
        getSession().update(entity);
    }

    /**
     * 合并业务实体。
     *
     * @param entity 待更新业务实体
     * @return 返回更新后的业务实体（持久状态的）。
     */
    @SuppressWarnings("unchecked")
    public <T> T merge(T entity) {
        return (T) getSession().merge(entity);
    }

    /**
     * 保存业务实体。（复用已有的ID键值时使用）
     *
     * @param entity 待保存的业务实体
     */
    public void replicate(Object entity) {
        getSession().replicate(entity, ReplicationMode.EXCEPTION);
    }

    /**
     * 删除业务实体。
     *
     * @param entity 待删除业务实体
     */
    @Transactional
    public void delete(Object entity) {
        logger.info("deleting user: " + entity);
        getSession().delete(entity);
    }

    /**
     * 根据指定的ID获取业务实体。
     *
     * @param id 实体ID
     * @return 返回指定ID的业务实体，如果没有找到则返回null。
     */
    public <T> T get(Serializable id, Class<T> clazz) {
        if (clazz.isAnnotationPresent(org.hibernate.annotations.Cache.class)) {
        }
        return (T) getSession().get(clazz, id);
    }

    /**
     * 根据ID删除业务实体。
     *
     * @param id 待删除业务实体ID
     */
    public <T> void delete(Serializable id, Class<T> clazz) {
        delete(get(id, clazz));
    }

    /**
     * 根据ID批量删除业务实体。
     *
     * @param ids 待删除业务实体ID数组
     */
    public <T> void delete(Serializable[] ids, Class<T> clazz) {
        for (Serializable id : ids) {
            delete(id, clazz);
        }
    }


    public <T> void delete(Class<T> clazz, Serializable id) {
        get(clazz, id).ifPresent(this::delete);
    }

    /**
     * 根据ID批量删除业务实体。
     *
     * @param ids 待删除业务实体ID数组
     */
    @Transactional
    public <T> void delete(Class<T> clazz, Serializable... ids) {
        Arrays.asList(ids).forEach(id -> delete(clazz, id));
    }

    /**
     * 删除多个业务实体。
     *
     * @param entities 待删除的业务实体列表
     */
    public void remove(List<?> entities) {
        entities.forEach(this::delete);
    }

    /**
     * 根据属性批量删除业务实体
     *
     * @param name  属性名
     * @param value 属性值
     */
    public void removeBy(String name, Object value, Class<?> clazz) {
        Query query = createQuery("delete from " + clazz.getName() + " where "
                + name + "=?", value);
        query.executeUpdate();
    }

    /**
     * 清理当前Session。
     */
    public void clear() {
        getSession().clear();
    }

    /**
     * 创建一个绑定实体类型的查询条件。
     *
     * @param criterions 查询条件
     * @return 返回一个查询条件。
     */
    public Criteria createCriteria(Class<?> clazz, Criterion... criterions) {
        Criteria criteria = getSession().createCriteria(clazz);
        for (Criterion c : criterions) {
            criteria.add(c);
        }
        return criteria;
    }

    /**
     * 创建一个查询对象。
     *
     * @param hql    HQL语句
     * @param values 参数值
     * @return 返回一个查询对象。
     */
    public Query createQuery(String hql, Object... values) {
        Query query = getSession().createQuery(hql);
        for (int i = 0; i < values.length; i++) {
            query.setParameter(i, values[i]);
        }
        return query;
    }

    /**
     * 创建一个SQL查询对象。
     *
     * @param sql    SQL语句
     * @param values 参数值
     * @return 返回一个SQL查询对象。
     */
    public Query createSQLQuery(String sql, Object... values) {
        Query query = getSession().createSQLQuery(sql);
        for (int i = 0; i < values.length; i++) {
            query.setParameter(i, values[i]);
        }
        return query;
    }

    /**
     * 创建一个绑定实体并设定了排序的查询条件。
     *
     * @param orderBy    排序属性
     * @param isAsc      是否升序
     * @param criterions 查询条件
     * @return 返回一个已设定排序的查询条件。
     */
    public Criteria createCriteria(Class<?> clazz, String orderBy, Boolean isAsc,
                                   Criterion... criterions) {
        Criteria criteria = createCriteria(clazz, criterions);
        if (isAsc) {
            criteria.addOrder(Order.asc(orderBy));
        } else {
            criteria.addOrder(Order.desc(orderBy));
        }
        return criteria;
    }

    /**
     * 获取指定类型的所有业务实体。
     *
     * @return 返回指定类型的所有业务实体。
     */
    @SuppressWarnings("unchecked")
    public <T> List<T> getAll(Class<T> clazz) {
        Criteria criteria = createCriteria(clazz);
        criteria.setCacheable(true);
        return criteria.list();
    }

    /**
     * 获取指定类型的所有业务实体并进行排序。
     *
     * @param orderBy 排序的属性名
     * @param isAsc   是否升序
     * @return 返回排序后的指定类型的所有业务实体。
     */
    @SuppressWarnings("unchecked")
    public <T> List<T> getAll(String orderBy, Boolean isAsc, Class<T> clazz) {
        Criteria criteria = createCriteria(clazz, orderBy, isAsc);
        return criteria.list();
    }

    /**
     * 根据属性的值查找业务实体。
     *
     * @param name  属性名
     * @param value 属性值
     * @return 返回属性值相符的业务实体集合，如果没有找到返回一个空的集合。
     */
    @SuppressWarnings("unchecked")
    public <T> List<T> findBy(String name, Object value, Class<T> clazz) {
        Criteria criteria = createCriteria(clazz);
        if (value == null) {
            criteria.add(Restrictions.isNull(name));
        } else {
            criteria.add(Restrictions.eq(name, value));
        }
        return criteria.list();
    }

    /**
     * 根据属性的值查找业务实体并进行排序。
     *
     * @param name    属性名
     * @param value   属性值
     * @param orderBy 排序属性
     * @param isAsc   是否升序
     * @return 返回排序后的属性值相符的业务实体集合，如果没有找到返回一个空的集合。
     */
    @SuppressWarnings("unchecked")
    public <T> List<T> findBy(String name, Object value, String orderBy,
                              boolean isAsc, Class<T> clazz) {
        Criteria criteria = createCriteria(clazz, orderBy, isAsc);
        if (value == null) {
            criteria.add(Restrictions.isNull(name));
        } else {
            criteria.add(Restrictions.eq(name, value));
        }
        return criteria.list();
    }

    /**
     * 判断是否存在属性重复的业务实体。
     *
     * @param entity    待判断的业务实体
     * @param propNames 属性名，可以多个属性名用","分割
     * @return 如果存在重复的业务实体返回false，否则返回true。
     */
    public <T> Boolean isUnique(T entity, String propNames, Class<T> clazz) {
        Criteria criteria = createCriteria(clazz).setProjection(
                Projections.rowCount());
        String[] nameList = propNames.split(",");
        try {
            for (String name : nameList) {
                criteria.add(Restrictions.eq(name,
                        ClassUtil.getFieldValue(entity, name)));
            }
            // 更新实体类时应该排除自身
            String idName = getPkName(clazz);
            Serializable id = getId(entity, clazz);
            if (id != null) {
                criteria.add(Restrictions.not(Restrictions.eq(idName, id)));
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return Integer.parseInt(criteria.uniqueResult().toString()) == 0;
    }

    /**
     * 查找唯一业务实体。
     *
     * @param criteria 查询条件
     * @return 返回唯一业务实体，如果没有找到返回null。
     */
    @SuppressWarnings("unchecked")
    public <T> T findUnique(Criteria criteria) {
        return (T) criteria.uniqueResult();
    }

    /**
     * 根据属性的值查找唯一的业务实体。
     *
     * @param name  属性名
     * @param value 属性值
     * @return 返回指定唯一的业务实体，如果没有找到则返回null。
     */
    public <T> T findUnique(String name, Object value, Class<T> clazz) {
        Criteria criteria = createCriteria(clazz, Restrictions.eq(name, value));
        return findUnique(criteria);
    }


    /**
     * 重建全文索引。
     *
     * @param sync 是否同步创建
     */
    public void rebuildIndex(Boolean sync, Class<?> clazz) {
        try {
            logger.info("开始重建" + clazz.getSimpleName() + "全文索引...");
            Long startTime = System.currentTimeMillis();
            if (sync) {
                getFullTextSession().createIndexer(clazz).startAndWait();
            } else {
                getFullTextSession().createIndexer(clazz).start();
            }
            Long endTime = System.currentTimeMillis();
            logger.info("完成重建" + clazz.getSimpleName() + "全文索引...耗时" + (endTime
                    - startTime) + "毫秒。");
        } catch (Exception e) {
            throw new RuntimeException("重建全文索引时发生异常。", e);
        }
    }

    /**
     * 执行count查询获得本次Hql查询所能获得的对象总数。<br/>
     * 本函数只能自动处理简单的hql语句,复杂的hql查询请另行编写count语句查询。
     *
     * @param hql    查询语句
     * @param values 查询参数
     * @return 返回查询结果总数
     */
    public Integer countHqlResult(String hql, Object... values) {
        String fromHql = hql;
        fromHql = "from " + StringUtils.substringAfter(fromHql, "from");
        fromHql = StringUtils.substringBefore(fromHql, "order by");
        String countHql = "select count(*) " + fromHql;
        int count = Integer.parseInt(createQuery(countHql, values)
                .uniqueResult().toString());
        return count;
    }


    /**
     * 执行count查询获得记录总数。
     *
     * @return 返回记录总数。
     */
    public Integer count(Class<?> clazz) {
        Criteria criteria = createCriteria(clazz);
        return Integer.parseInt(criteria.setProjection(Projections.rowCount()).uniqueResult().toString());
    }

    /**
     * 获取实体类的主键值。
     *
     * @param entity 业务实体
     * @return 返回实体类的主键值。
     */
    private <T> Serializable getId(T entity, Class<T> clazz) {
        return (Serializable) ClassUtil.getFieldValue(entity, getPkName(clazz));
    }

    /**
     * 获取实体类的主键名。
     *
     * @return 返回实体类的主键名。
     */
    private String getPkName(Class<?> clazz) {
        ClassMetadata meta = sessionFactory.getClassMetadata(clazz);
        return meta.getIdentifierPropertyName();
    }

    protected SessionFactory getSessionFactory() {
        return sessionFactory;
    }


    /**
     * 查询前统计查询数量
     *
     * @param sql
     * @param values
     * @return
     */
    private Integer countSqlResult(String sql, Object... values) {
        String fromSql = sql;
        fromSql = "from " + StringUtils.substringAfter(fromSql, "from");
        fromSql = StringUtils.substringBefore(fromSql, "order by");
        String countSql = "select count(*) " + fromSql;
        int count = Integer.parseInt(createQuery(countSql, values).uniqueResult().toString());
        return count;
    }

}
