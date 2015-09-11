package com.jspgou.common.hibernate3;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.type.Type;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.Map;

/**
 * sql分页查询
 * Created by zhengjiang on 2015/3/11.
 */
public class SqlFinder {
    protected SqlFinder() {
        sqlBuilder = new StringBuilder();
    }

    protected SqlFinder(String sql) {
        sqlBuilder = new StringBuilder(sql);
    }

    public static SqlFinder create() {
        return new SqlFinder();
    }

    public static SqlFinder create(String sql) {
        return new SqlFinder(sql);
    }

    public SqlFinder append(String sql) {
        sqlBuilder.append(sql);
        return this;
    }

    /**
     * 获得原始hql语句
     *
     * @return
     */
    public String getOrigSql() {
        return sqlBuilder.toString();
    }

    /**
     * 获得查询数据库记录数的hql语句。
     *
     * @return
     */
    public String getRowCountSql() {
        String sql = sqlBuilder.toString();
//        String sqlLowerCase = sql.toLowerCase();
        String rowCountSql = ROW_COUNT + "(" + sql + ") view";
        return rowCountSql;
    }

    public int getFirstResult() {
        return firstResult;
    }

    public void setFirstResult(int firstResult) {
        this.firstResult = firstResult;
    }

    public int getMaxResults() {
        return maxResults;
    }

    public void setMaxResults(int maxResults) {
        this.maxResults = maxResults;
    }

    /**
     * 是否使用查询缓存
     *
     * @return
     */
    public boolean isCacheable() {
        return cacheable;
    }

    /**
     * 设置是否使用查询缓存
     *
     * @param cacheable
     * @see org.hibernate.Query#setCacheable(boolean)
     */
    public void setCacheable(boolean cacheable) {
        this.cacheable = cacheable;
    }

    /**
     * 设置参数
     *
     * @param param
     * @param value
     * @return
     * @see org.hibernate.Query#setParameter(String, Object)
     */
    public SqlFinder setParam(String param, Object value) {
        return setParam(param, value, null);
    }

    /**
     * 设置参数。与hibernate的Query接口一致。
     *
     * @param param
     * @param value
     * @param type
     * @return
     * @see org.hibernate.Query#setParameter(String, Object, org.hibernate.type.Type)
     */
    public SqlFinder setParam(String param, Object value, Type type) {
        getParams().add(param);
        getValues().add(value);
        getTypes().add(type);
        return this;
    }

    /**
     * 设置参数。与hibernate的Query接口一致。
     *
     * @param paramMap
     * @return
     * @see org.hibernate.Query#setProperties(java.util.Map)
     */
    public SqlFinder setParams(Map<String, Object> paramMap) {
        for (Map.Entry<String, Object> entry : paramMap.entrySet()) {
            setParam(entry.getKey(), entry.getValue());
        }
        return this;
    }

    /**
     * 设置参数。与hibernate的Query接口一致。
     *
     * @param name
     * @param vals
     * @param type
     * @return
     * @see org.hibernate.Query#setParameterList(String, java.util.Collection, Type))
     */
    public SqlFinder setParamList(String name, Collection<Object> vals, Type type) {
        getParamsList().add(name);
        getValuesList().add(vals);
        getTypesList().add(type);
        return this;
    }

    /**
     * 设置参数。与hibernate的Query接口一致。
     *
     * @param name
     * @param vals
     * @return
     * @see org.hibernate.Query#setParameterList(String, Collection)
     */
    public SqlFinder setParamList(String name, Collection<Object> vals) {
        return setParamList(name, vals, null);
    }

    /**
     * 设置参数。与hibernate的Query接口一致。
     *
     * @param name
     * @param vals
     * @param type
     * @return
     * @see org.hibernate.Query#setParameterList(String, Object[], Type)
     */
    public SqlFinder setParamList(String name, Object[] vals, Type type) {
        getParamsArray().add(name);
        getValuesArray().add(vals);
        getTypesArray().add(type);
        return this;
    }

    /**
     * 设置参数。与hibernate的Query接口一致。
     *
     * @param name
     * @param vals
     * @return
     * @see org.hibernate.Query#setParameterList(String, Object[])
     */
    public SqlFinder setParamList(String name, Object[] vals) {
        return setParamList(name, vals, null);
    }

    /**
     * 将finder中的参数设置到query中。
     *
     * @param query
     */
    public Query setParamsToQuery(Query query) {
        if (params != null) {
            for (int i = 0; i < params.size(); i++) {
                if (types.get(i) == null) {
                    query.setParameter(params.get(i), values.get(i));
                } else {
                    query.setParameter(params.get(i), values.get(i), types
                            .get(i));
                }
            }
        }
        if (paramsList != null) {
            for (int i = 0; i < paramsList.size(); i++) {
                if (typesList.get(i) == null) {
                    query
                            .setParameterList(paramsList.get(i), valuesList
                                    .get(i));
                } else {
                    query.setParameterList(paramsList.get(i),
                            valuesList.get(i), typesList.get(i));
                }
            }
        }
        if (paramsArray != null) {
            for (int i = 0; i < paramsArray.size(); i++) {
                if (typesArray.get(i) == null) {
                    query.setParameterList(paramsArray.get(i), valuesArray
                            .get(i));
                } else {
                    query.setParameterList(paramsArray.get(i), valuesArray
                            .get(i), typesArray.get(i));
                }
            }
        }
        return query;
    }

    public Query createQuery(Session s) {
        Query query = setParamsToQuery(s.createSQLQuery(getOrigSql()));
        if (getFirstResult() > 0) {
            query.setFirstResult(getFirstResult());
        }
        if (getMaxResults() > 0) {
            query.setMaxResults(getMaxResults());
        }
        if (isCacheable()) {
            query.setCacheable(true);
        }
        return query;
    }

    private List<String> getParams() {
        if (params == null) {
            params = new ArrayList<String>();
        }
        return params;
    }

    private List<Object> getValues() {
        if (values == null) {
            values = new ArrayList<Object>();
        }
        return values;
    }

    private List<Type> getTypes() {
        if (types == null) {
            types = new ArrayList<Type>();
        }
        return types;
    }

    private List<String> getParamsList() {
        if (paramsList == null) {
            paramsList = new ArrayList<String>();
        }
        return paramsList;
    }

    private List<Collection<Object>> getValuesList() {
        if (valuesList == null) {
            valuesList = new ArrayList<Collection<Object>>();
        }
        return valuesList;
    }

    private List<Type> getTypesList() {
        if (typesList == null) {
            typesList = new ArrayList<Type>();
        }
        return typesList;
    }

    private List<String> getParamsArray() {
        if (paramsArray == null) {
            paramsArray = new ArrayList<String>();
        }
        return paramsArray;
    }

    private List<Object[]> getValuesArray() {
        if (valuesArray == null) {
            valuesArray = new ArrayList<Object[]>();
        }
        return valuesArray;
    }

    private List<Type> getTypesArray() {
        if (typesArray == null) {
            typesArray = new ArrayList<Type>();
        }
        return typesArray;
    }

    private StringBuilder sqlBuilder;

    private List<String> params;
    private List<Object> values;
    private List<Type> types;

    private List<String> paramsList;
    private List<Collection<Object>> valuesList;
    private List<Type> typesList;

    private List<String> paramsArray;
    private List<Object[]> valuesArray;
    private List<Type> typesArray;

    private int firstResult = 0;

    private int maxResults = 0;

    private boolean cacheable = false;

    public static final String ROW_COUNT = "select count(*) from ";

    public static void main(String[] args) {
        StringBuffer sqlStr = new StringBuffer("select b.channelId, b.channelName, count(a.order_id) totalOrder, " +
                "(sum(case a.payment_status when 1 then a.product_price else 0 end) + sum(case a.payment_status when 3 then a.product_price else 0 end)) totalSellAmount, " +
                "sum(case a.payment_status when 3 then a.product_price else 0 end) totalRefundAmount, " +
                "sum(case a.payment_status when 1 then a.product_price else 0 end) totalPaiedAmount " +
                "from jc_shop_order a, jc_shop_product b  " +
                "where a.product_id=b.product_id");
        SqlFinder find = SqlFinder.create(sqlStr.toString());
        System.out.println(find.getRowCountSql());
        System.out.println(find.getOrigSql());
    }
}
