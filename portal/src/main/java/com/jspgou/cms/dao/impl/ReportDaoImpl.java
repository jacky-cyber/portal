package com.jspgou.cms.dao.impl;

import com.ifunpay.util.common.ClassUtil;
import com.jspgou.cms.dao.ReportDao;
import com.jspgou.cms.model.*;
import com.jspgou.common.jdbc.JdbcBaseDao;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Repository;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by jiang on 2015/9/7.
 */
@Repository
public class ReportDaoImpl extends JdbcBaseDao implements ReportDao {

    @Override
    public Map<String, Object> fetchChannelReport(Map<String, Object> filterMap, String sortField, boolean isASC, int start, int size) {
        String sql = channelReportSql(filterMap, sortField, isASC);
        List<ChannelReport> channelReports = new ArrayList<>();
        Map<String, Object> map = new HashMap<>();
        logger.debug("sql-->" + sql);
        if (null == sql) {
            map.put("rowCount", 0);
            map.put("reports", channelReports);
            return map;
        }

        if (start < 0) start = 0;
        if (size < 0) size = 50;

        List<Map<String, Object>> list = super.getResult(sql, start, size);
        int rowCount = getCount(sql);
        for (int i=0; i<list.size(); i++){
            ChannelReport channelReport = new ChannelReport();
            channelReport.setChannelId(Integer.parseInt(list.get(i).get("channelId").toString()));
            channelReport.setChannelName(list.get(i).get("channelName").toString());
            channelReport.setTotalOrder(Integer.parseInt(list.get(i).get("totalOrder").toString()));
            channelReport.setTotalAmount((new BigDecimal(list.get(i).get("totalAmount").toString())).setScale(2, BigDecimal.ROUND_UP));
            channelReport.setReturnAmount((new BigDecimal(list.get(i).get("returnAmount").toString())).setScale(2, BigDecimal.ROUND_UP));
            channelReport.setPaiedAmount((new BigDecimal(list.get(i).get("paiedAmount").toString())).setScale(2, BigDecimal.ROUND_UP));
            channelReports.add(channelReport);
        }

        map.put("rowCount", rowCount);
        map.put("reports", channelReports);
        return map;
    }

    private String channelReportSql(Map<String, Object> filterMap, String sortField, boolean isASC) {
        StringBuffer sqlStr = new StringBuffer("SELECT a.channel_id channelId, a.channel_name channelName, \n" +
                "(SUM(CASE a.pay_status WHEN 'PaySucceeded' THEN 1 ELSE 0 END) + \n" +
                "SUM(CASE a.pay_status WHEN 'RefundSucceeded' THEN 1 ELSE 0 END)) totalOrder, \n" +
                "(SUM(CASE a.pay_status WHEN 'PaySucceeded' THEN a.total_amount ELSE 0 END) + \n" +
                "SUM(CASE a.pay_status WHEN 'RefundSucceeded' THEN a.total_amount ELSE 0 END))/100 totalAmount, \n" +
                "(SUM(CASE a.pay_status WHEN 'RefundSucceeded' THEN a.total_amount ELSE 0 END))/100 returnAmount, \n" +
                "(SUM(CASE a.pay_status WHEN 'PaySucceeded' THEN a.total_amount ELSE 0 END))/100 paiedAmount \n" +
                "FROM n_order a, n_order_product b where a.id=b.order_id \n");

        try {
            if (filterMap != null) {
                filterMap.forEach((k, v) -> {
                    if (k != null && !k.isEmpty() && null != v && "" != v ) {
                        if (k.equals("startTime")) {
                            sqlStr.append(" and a.create_time>='" + String.valueOf(v) + "'");
                        } else if (k.equals("endTime")){
                            sqlStr.append(" and a.create_time<='" + String.valueOf(v) + "'");
                        }
                    }
                });
            }
            sqlStr.append(" GROUP BY a.channel_id HAVING 1=1 ");
            if (filterMap != null) {
                filterMap.forEach((k, v) -> {
                    if (k != null && !k.isEmpty() && !k.equals("startTime") && !k.equals("endTime") && null != v && "" != v) {
                        ClassUtil.getFieldType(ChannelReport.class, k)
                                .ifPresent(type -> {
                                    if (ClassUtil.isNumberType(type) || ClassUtil.isEnumType(type)) {
                                        ClassUtil.newInstance(type, v).ifPresent(fieldValue -> {
                                            logger.info("add condition eq: " + k + " -> " + v);
                                            sqlStr.append(" and " + k + " = " + fieldValue + " ");
                                        });
                                    } else if (type == String.class) {
                                        if (null != v && "" != v) {
                                            logger.info("add condition LIKE: " + k + " -> " + v + "---->" + v.getClass());
                                            sqlStr.append(" and " + k + " like '%" + v + "%' ");
                                        }
                                    }
                                });
                    }
                });
            }
            sqlStr.append("order by 1=1");
            if (sortField != null && !sortField.isEmpty()) {
                logger.info("add sort field: " + sortField + ", ORDER: " + (isASC ? "ASC" : "DESC"));
                sqlStr.append("," + sortField + " " + (isASC ? "ASC" : "DESC"));
            }
            return sqlStr.toString();
        } catch (Exception e) {
            logger.error("组装sql错误", e);
        }
        return null;
    }

    @Override
    public Map<String, Object> fetchMerchantReport(Map<String, Object> filters, String sortField, boolean isASC, int start, int size) {
        String sql = merchantReportSql(filters, sortField, isASC);
        List<MerchantReport> merchantReports = new ArrayList<>();
        Map<String, Object> map = new HashMap<>();
        logger.info("sql-->" + sql);
        if (null == sql) {
            map.put("rowCount", 0);
            map.put("reports", merchantReports);
            return map;
        }

        if (start < 0) start = 0;
        if (size < 0) size = 50;

        List<Map<String, Object>> list = super.getResult(sql, start, size);
        int rowCount = getCount(sql);
        for (int i=0; i<list.size(); i++){
            MerchantReport merchantReport = new MerchantReport();
            merchantReport.setMerchantId(Integer.parseInt(list.get(i).get("merchantId").toString()));
            merchantReport.setMerchantName(list.get(i).get("merchantName").toString());
            merchantReport.setChannelId(Integer.parseInt(list.get(i).get("channelId").toString()));
            merchantReport.setChannelName(list.get(i).get("channelName").toString());
            merchantReport.setTotalOrder(Integer.parseInt(list.get(i).get("totalOrder").toString()));
            merchantReport.setTotalAmount((new BigDecimal(list.get(i).get("totalAmount").toString())).setScale(2, BigDecimal.ROUND_UP));
            merchantReport.setReturnAmount((new BigDecimal(list.get(i).get("returnAmount").toString())).setScale(2, BigDecimal.ROUND_UP));
            merchantReport.setPaiedAmount((new BigDecimal(list.get(i).get("paiedAmount").toString())).setScale(2, BigDecimal.ROUND_UP));
            merchantReports.add(merchantReport);
        }

        map.put("rowCount", rowCount);
        map.put("reports", merchantReports);
        return map;
    }

    private String merchantReportSql(Map<String, Object> filterMap, String sortField, boolean isASC) {
        StringBuffer sqlStr = new StringBuffer("SELECT b.commerce_id merchantId, b.commerce_name merchantName, a.channel_id channelId, a.channel_name channelName, \n" +
                "(SUM(CASE a.pay_status WHEN 'PaySucceeded' THEN 1 ELSE 0 END) + SUM(CASE a.pay_status WHEN 'RefundSucceeded' THEN 1 ELSE 0 END)) totalOrder, \n" +
                "(SUM(CASE a.pay_status WHEN 'PaySucceeded' THEN a.total_amount ELSE 0 END) + SUM(CASE a.pay_status WHEN 'RefundSucceeded' THEN a.total_amount ELSE 0 END))/100 totalAmount,  \n" +
                "(SUM(CASE a.pay_status WHEN 'RefundSucceeded' THEN a.total_amount ELSE 0 END))/100 returnAmount, \n" +
                "(SUM(CASE a.pay_status WHEN 'PaySucceeded' THEN a.total_amount ELSE 0 END))/100 paiedAmount \n" +
                "FROM n_order a, n_order_product b WHERE a.id=b.order_id \n");

        try {
            if (filterMap != null) {
                filterMap.forEach((k, v) -> {
                    if (k != null && !k.isEmpty() && null != v && "" != v ) {
                        if (k.equals("startTime")) {
                            sqlStr.append(" and a.create_time>='" + String.valueOf(v) + "'");
                        } else if (k.equals("endTime")){
                            sqlStr.append(" and a.create_time<='" + String.valueOf(v) + "'");
                        }
                    }
                });
            }
            sqlStr.append(" GROUP BY b.commerce_id HAVING 1=1 ");
            if (filterMap != null) {
                filterMap.forEach((k, v) -> {
                    if (k != null && !k.isEmpty() && !k.equals("startTime") && !k.equals("endTime") && null != v && "" != v) {
                        ClassUtil.getFieldType(MerchantReport.class, k)
                                .ifPresent(type -> {
                                    if (ClassUtil.isNumberType(type) || ClassUtil.isEnumType(type)) {
                                        ClassUtil.newInstance(type, v).ifPresent(fieldValue -> {
                                            logger.info("add condition eq: " + k + " -> " + v);
                                            sqlStr.append(" and " + k + " = " + fieldValue + " ");
                                        });
                                    } else if (type == String.class) {
                                        if (null != v && "" != v) {
                                            logger.info("add condition LIKE: " + k + " -> " + v + "---->" + v.getClass());
                                            sqlStr.append(" and " + k + " like '%" + v + "%' ");
                                        }
                                    }
                                });
                    }
                });
            }
            sqlStr.append("order by 1=1");
            if (sortField != null && !sortField.isEmpty()) {
                logger.info("add sort field: " + sortField + ", ORDER: " + (isASC ? "ASC" : "DESC"));
                sqlStr.append("," + sortField + " " + (isASC ? "ASC" : "DESC"));
            }
            return sqlStr.toString();
        } catch (Exception e) {
            logger.error("组装sql错误", e);
        }
        return null;
    }

    @Override
    public Map<String, Object> fetchProductReport(Map<String, Object> filters, String sortField, boolean isASC, int start, int size) {
        String sql = productReportSql(filters, sortField, isASC);
        Map<String, Object> map = new HashMap<>();
        logger.info("sql-->" + sql);
        if (null == sql) {
            map.put("rowCount", 0);
            map.put("reports", new ArrayList<>());
            return map;
        }

        if (start < 0) start = 0;
        if (size < 0) size = 50;

        int rowCount = getCount(sql);
        map.put("rowCount", rowCount);
        map.put("reports", (List<ProductReport>) super.getResult(sql, start, size));
        return map;
    }

    private String productReportSql(Map<String, Object> filterMap, String sortField, boolean isASC) {
        StringBuffer sqlStr = new StringBuffer("SELECT b.product_id productId, b.product_name productName, b.commerce_id merchantId, \n" +
                "b.commerce_name merchantName, a.channel_id channelId, a.channel_name channelName, COUNT(a.id) totalOrder, \n" +
                "SUM(CASE a.pay_method WHEN 'AShotToPay' THEN 1 ELSE 0 END) oneShotToPay, \n" +
                "SUM(CASE a.pay_method WHEN 'FlashPay' THEN 1 ELSE 0 END) flashPay, \n" +
                "SUM(CASE a.pay_method WHEN 'InsertCard' THEN 1 ELSE 0 END) insertCard, \n" +
                "SUM(CASE a.pay_method WHEN 'QrCode' THEN 1 ELSE 0 END) qrCode \n" +
                "FROM n_order a, n_order_product b WHERE a.id=b.order_id AND a.pay_status IN ('PaySucceeded', 'RefundSucceeded') \n");

        try {
            if (filterMap != null) {
                filterMap.forEach((k, v) -> {
                    if (k != null && !k.isEmpty() && null != v && "" != v ) {
                        if (k.equals("startTime")) {
                            sqlStr.append(" and a.create_time>='" + String.valueOf(v) + "'");
                        } else if (k.equals("endTime")){
                            sqlStr.append(" and a.create_time<='" + String.valueOf(v) + "'");
                        }
                    }
                });
            }
            sqlStr.append(" GROUP BY b.product_id HAVING 1=1 ");
            if (filterMap != null) {
                filterMap.forEach((k, v) -> {
                    if (k != null && !k.isEmpty() && !k.equals("startTime") && !k.equals("endTime") && null != v && "" != v) {
                        ClassUtil.getFieldType(ProductReport.class, k)
                                .ifPresent(type -> {
                                    if (ClassUtil.isNumberType(type) || ClassUtil.isEnumType(type)) {
                                        ClassUtil.newInstance(type, v).ifPresent(fieldValue -> {
                                            logger.info("add condition eq: " + k + " -> " + v);
                                            sqlStr.append(" and " + k + " = " + fieldValue + " ");
                                        });
                                    } else if (type == String.class) {
                                        if (null != v && "" != v) {
                                            logger.info("add condition LIKE: " + k + " -> " + v + "---->" + v.getClass());
                                            sqlStr.append(" and " + k + " like '%" + v + "%' ");
                                        }
                                    }
                                });
                    }
                });
            }
            sqlStr.append("order by 1=1");
            if (sortField != null && !sortField.isEmpty()) {
                logger.info("add sort field: " + sortField + ", ORDER: " + (isASC ? "ASC" : "DESC"));
                sqlStr.append("," + sortField + " " + (isASC ? "ASC" : "DESC"));
            }
            return sqlStr.toString();
        } catch (Exception e) {
            logger.error("组装sql错误", e);
        }
        return null;
    }

    @Override
    public Map<String, Object> fetchProductReportRMB(Map<String, Object> filters, String sortField, boolean isASC, int start, int size) {
        String sql = productReportSqlByRMB(filters, sortField, isASC);
        Map<String, Object> map = new HashMap<>();
        logger.info("sql-->" + sql);
        if (null == sql) {
            map.put("rowCount", 0);
            map.put("reports", new ArrayList<>());
            return map;
        }

        if (start < 0) start = 0;
        if (size < 0) size = 50;

        int rowCount = getCount(sql);
        map.put("rowCount", rowCount);
        map.put("reports", (List<ProductReportRMB>) super.getResult(sql, start, size));
        return map;
    }

    private String productReportSqlByRMB(Map<String, Object> filterMap, String sortField, boolean isASC) {
        StringBuffer sqlStr = new StringBuffer("SELECT b.product_id productId, b.product_name productName, b.commerce_id merchantId, \n" +
                "b.commerce_name merchantName, a.channel_id channelId, a.channel_name channelName, SUM(a.total_amount)/100 totalAmount, \n" +
                "SUM(CASE a.pay_method WHEN 'AShotToPay' THEN a.total_amount ELSE 0 END)/100 oneShotToPay, \n" +
                "SUM(CASE a.pay_method WHEN 'FlashPay' THEN a.total_amount ELSE 0 END)/100 flashPay, \n" +
                "SUM(CASE a.pay_method WHEN 'InsertCard' THEN a.total_amount ELSE 0 END)/100 insertCard, \n" +
                "SUM(CASE a.pay_method WHEN 'QrCode' THEN a.total_amount ELSE 0 END)/100 qrCode \n" +
                "FROM n_order a, n_order_product b WHERE a.id=b.order_id AND a.pay_status IN ('PaySucceeded', 'RefundSucceeded') \n");

        try {
            if (filterMap != null) {
                filterMap.forEach((k, v) -> {
                    if (k != null && !k.isEmpty() && null != v && "" != v ) {
                        if (k.equals("startTime")) {
                            sqlStr.append(" and a.create_time>='" + String.valueOf(v) + "'");
                        } else if (k.equals("endTime")){
                            sqlStr.append(" and a.create_time<='" + String.valueOf(v) + "'");
                        }
                    }
                });
            }
            sqlStr.append(" GROUP BY b.product_id HAVING 1=1 ");
            if (filterMap != null) {
                filterMap.forEach((k, v) -> {
                    if (k != null && !k.isEmpty() && !k.equals("startTime") && !k.equals("endTime") && null != v && "" != v) {
                        ClassUtil.getFieldType(ProductReportRMB.class, k)
                                .ifPresent(type -> {
                                    if (ClassUtil.isNumberType(type) || ClassUtil.isEnumType(type)) {
                                        ClassUtil.newInstance(type, v).ifPresent(fieldValue -> {
                                            logger.info("add condition eq: " + k + " -> " + v);
                                            sqlStr.append(" and " + k + " = " + fieldValue + " ");
                                        });
                                    } else if (type == String.class) {
                                        if (null != v && "" != v) {
                                            logger.info("add condition LIKE: " + k + " -> " + v + "---->" + v.getClass());
                                            sqlStr.append(" and " + k + " like '%" + v + "%' ");
                                        }
                                    }
                                });
                    }
                });
            }
            sqlStr.append("order by 1=1");
            if (sortField != null && !sortField.isEmpty()) {
                logger.info("add sort field: " + sortField + ", ORDER: " + (isASC ? "ASC" : "DESC"));
                sqlStr.append("," + sortField + " " + (isASC ? "ASC" : "DESC"));
            }
            return sqlStr.toString();
        } catch (Exception e) {
            logger.error("组装sql错误", e);
        }
        return null;
    }

    @Override
    public Map<String, Object> fetchVendorReport(Map<String, Object> filters, String sortField, boolean isASC, int start, int size) {
        String sql = vendorReportSql(filters, sortField, isASC);
        Map<String, Object> map = new HashMap<>();
        logger.info("sql-->" + sql);
        if (null == sql) {
            map.put("rowCount", 0);
            map.put("reports", new ArrayList<>());
            return map;
        }

        if (start < 0) start = 0;
        if (size < 0) size = 50;

        int rowCount = getCount(sql);
        map.put("rowCount", rowCount);
        map.put("reports", (List<VendorReport>) super.getResult(sql, start, size));
        return map;
    }

    private String vendorReportSql(Map<String, Object> filterMap, String sortField, boolean isASC) {
        StringBuffer sqlStr = new StringBuffer("SELECT a.terminal_id vendorId, b.commerce_id merchantId, \n" +
                "b.commerce_name merchantName, a.channel_id channelId, a.channel_name channelName, COUNT(a.id) totalOrder, \n" +
                "SUM(CASE a.pay_method WHEN 'AShotToPay' THEN 1 ELSE 0 END) oneShotToPay, \n" +
                "SUM(CASE a.pay_method WHEN 'FlashPay' THEN 1 ELSE 0 END) flashPay, \n" +
                "SUM(CASE a.pay_method WHEN 'InsertCard' THEN 1 ELSE 0 END) insertCard, \n" +
                "SUM(CASE a.pay_method WHEN 'QrCode' THEN 1 ELSE 0 END) qrCode \n" +
                "FROM n_order a, n_order_product b where a.id=b.order_id and a.pay_status IN ('PaySucceeded', 'RefundSucceeded') \n") ;

        try {
            if (filterMap != null) {
                filterMap.forEach((k, v) -> {
                    if (k != null && !k.isEmpty() && null != v && "" != v ) {
                        if (k.equals("startTime")) {
                            sqlStr.append(" and a.create_time>='" + String.valueOf(v) + "'");
                        } else if (k.equals("endTime")){
                            sqlStr.append(" and a.create_time<='" + String.valueOf(v) + "'");
                        }
                    }
                });
            }
            sqlStr.append(" GROUP BY a.terminal_id HAVING 1=1 ");
            if (filterMap != null) {
                filterMap.forEach((k, v) -> {
                    if (k != null && !k.isEmpty() && !k.equals("startTime") && !k.equals("endTime") && null != v && "" != v) {
                        ClassUtil.getFieldType(VendorReport.class, k)
                                .ifPresent(type -> {
                                    if (ClassUtil.isNumberType(type) || ClassUtil.isEnumType(type)) {
                                        ClassUtil.newInstance(type, v).ifPresent(fieldValue -> {
                                            logger.info("add condition eq: " + k + " -> " + v);
                                            sqlStr.append(" and " + k + " = " + fieldValue + " ");
                                        });
                                    } else if (type == String.class) {
                                        if (null != v && "" != v) {
                                            logger.info("add condition LIKE: " + k + " -> " + v + "---->" + v.getClass());
                                            sqlStr.append(" and " + k + " like '%" + v + "%' ");
                                        }
                                    }
                                });
                    }
                });
            }
            sqlStr.append("order by 1=1");
            if (sortField != null && !sortField.isEmpty()) {
                logger.info("add sort field: " + sortField + ", ORDER: " + (isASC ? "ASC" : "DESC"));
                sqlStr.append("," + sortField + " " + (isASC ? "ASC" : "DESC"));
            }
            return sqlStr.toString();
        } catch (Exception e) {
            logger.error("组装sql错误", e);
        }
        return null;
    }

    @Override
    public Map<String, Object> fetchVendorReportRMB(Map<String, Object> filters, String sortField, boolean isASC, int start, int size) {
        String sql = vendorReportSqlRMB(filters, sortField, isASC);
        Map<String, Object> map = new HashMap<>();
        logger.info("sql-->" + sql);
        if (null == sql) {
            map.put("rowCount", 0);
            map.put("reports", new ArrayList<>());
            return map;
        }

        if (start < 0) start = 0;
        if (size < 0) size = 50;

        int rowCount = getCount(sql);
        map.put("rowCount", rowCount);
        map.put("reports", (List<VendorReportRMB>) super.getResult(sql, start, size));
        return map;
    }

    private String vendorReportSqlRMB(Map<String, Object> filterMap, String sortField, boolean isASC) {
        StringBuffer sqlStr = new StringBuffer("SELECT a.terminal_id vendorId, b.commerce_id merchantId, \n" +
                "b.commerce_name merchantName, a.channel_id channelId, a.channel_name channelName, SUM(a.total_amount)/100 totalAmount, \n" +
                "SUM(CASE a.pay_method WHEN 'AShotToPay' THEN a.total_amount ELSE 0 END)/100 oneShotToPay, \n" +
                "SUM(CASE a.pay_method WHEN 'FlashPay' THEN a.total_amount ELSE 0 END)/100 flashPay, \n" +
                "SUM(CASE a.pay_method WHEN 'InsertCard' THEN a.total_amount ELSE 0 END)/100 insertCard, \n" +
                "SUM(CASE a.pay_method WHEN 'QrCode' THEN a.total_amount ELSE 0 END)/100 qrCode \n" +
                "FROM n_order a, n_order_product b where a.id=b.order_id and a.pay_status IN ('PaySucceeded', 'RefundSucceeded') ");

        try {
            if (filterMap != null) {
                filterMap.forEach((k, v) -> {
                    if (k != null && !k.isEmpty() && null != v && "" != v ) {
                        if (k.equals("startTime")) {
                            sqlStr.append(" and a.create_time>='" + String.valueOf(v) + "'");
                        } else if (k.equals("endTime")){
                            sqlStr.append(" and a.create_time<='" + String.valueOf(v) + "'");
                        }
                    }
                });
            }
            sqlStr.append(" GROUP BY a.terminal_id HAVING 1=1 ");
            if (filterMap != null) {
                filterMap.forEach((k, v) -> {
                    if (k != null && !k.isEmpty() && !k.equals("startTime") && !k.equals("endTime") && null != v && "" != v) {
                        ClassUtil.getFieldType(VendorReport.class, k)
                                .ifPresent(type -> {
                                    if (ClassUtil.isNumberType(type) || ClassUtil.isEnumType(type)) {
                                        ClassUtil.newInstance(type, v).ifPresent(fieldValue -> {
                                            logger.info("add condition eq: " + k + " -> " + v);
                                            sqlStr.append(" and " + k + " = " + fieldValue + " ");
                                        });
                                    } else if (type == String.class) {
                                        if (null != v && "" != v) {
                                            logger.info("add condition LIKE: " + k + " -> " + v + "---->" + v.getClass());
                                            sqlStr.append(" and " + k + " like '%" + v + "%' ");
                                        }
                                    }
                                });
                    }
                });
            }
            sqlStr.append("order by 1=1");
            if (sortField != null && !sortField.isEmpty()) {
                logger.info("add sort field: " + sortField + ", ORDER: " + (isASC ? "ASC" : "DESC"));
                sqlStr.append("," + sortField + " " + (isASC ? "ASC" : "DESC"));
            }
            return sqlStr.toString();
        } catch (Exception e) {
            logger.error("组装sql错误", e);
        }
        return null;
    }

    private static final Logger logger = Logger.getLogger(ReportDaoImpl.class);
}
