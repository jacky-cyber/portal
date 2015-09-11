package com.ifunpay.portal.controller.security;

import com.jspgou.cms.manager.SettlementMng;
import com.jspgou.common.page.Pagination;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

import static com.jspgou.common.page.SimplePage.checkSize;
import static com.jspgou.common.page.SimplePage.cpn;

/**
 * Created by zhengjiang on 2015/4/7.
 */
@RestController
@RequestMapping(value = "/security/report")
public class ReportRestController {

    /**
     * 商户报表接口
     * @param requestParam
     * @return
     */
    @RequestMapping(value = "/merchant")
    public Object merchantReport(@RequestBody Map<String, Object> requestParam) {
        String commerceName = (String) requestParam.get("commerceName");
        String channelName = (String) requestParam.get("channelName");
        String startDate = (String) requestParam.get("startDate");
        String endDate = (String) requestParam.get("endDate");
        Integer type = (Integer) requestParam.get("type");
        Integer start = (Integer) requestParam.get("start");
        Integer size = (Integer) requestParam.get("size");

        DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
        Date sd = null;
        Date ed = null;
        if (!("").equals(startDate) && null != startDate) {
            try {
                sd = df.parse(startDate);
            } catch (ParseException e) {
                logger.error("parseException" + e);
            }
        }
        if (!("").equals(endDate) && null != endDate) {
            try {
                ed = df.parse(endDate);
            } catch (ParseException e) {
                logger.error("parseException" + e);
            }
        }

        Pagination page = new Pagination();
        Map<String, Object> map = new HashMap<>();
        if (0 == type) {
            page = settlementMng.getCommerceReport(commerceName, channelName, sd, ed, cpn(start), checkSize(size), null, null);
        } else if (1 == type) {
            page = settlementMng.getCommerceReportByPayMethod(commerceName, sd, ed, cpn(start), checkSize(size));
        } else if (2 == type) {
            page = settlementMng.getCommerceReportByPayMethodAmount(commerceName, sd, ed, cpn(start), checkSize(size));
        }
        map.put("reports", page.getList());
        map.put("totalCount", page.getTotalCount());
        return map;
    }

    /**
     *
     * @param requestParam
     * @return
     */
    @RequestMapping(value = "/merchantDetails")
    public Object merchantDetails(@RequestBody Map<String, Object> requestParam) {
        String commerceId = (String) requestParam.get("commerceId");
        String commerceName = (String) requestParam.get("commerceName");
        String channelName = (String) requestParam.get("channelName");
        String startDate = (String) requestParam.get("startDate");
        String endDate = (String) requestParam.get("endDate");
        Integer start = (Integer) requestParam.get("start");
        Integer size = (Integer) requestParam.get("size");

        DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
        Date sd = null;
        Date ed = null;
        if (!("").equals(startDate) && null != startDate) {
            try {
                sd = df.parse(startDate);
            } catch (ParseException e) {
                logger.error("parseException" + e);
            }
        }
        if (!("").equals(endDate) && null != endDate) {
            try {
                ed = df.parse(endDate);
            } catch (ParseException e) {
                logger.error("parseException" + e);
            }
        }

        Pagination page = new Pagination();
        Map<String, Object> map = new HashMap<>();
        Long id = null;
        if (StringUtils.isNotBlank(commerceId)){
            id = Long.parseLong(commerceId);
        }
        page = settlementMng.getCommerceReportDetails(id, commerceName, channelName, sd, ed, cpn(start), checkSize(size), null);
        map.put("reports", page.getList());
        map.put("totalCount", page.getTotalCount());
        return map;
    }

    /**
     * 渠道接口
     *
     * @param requestParam
     * @return
     */
    @RequestMapping(value = "/channel")
    public Object channel(@RequestBody Map<String, Object> requestParam) {
        String name = (String) requestParam.get("name");
        String startDate = (String) requestParam.get("startDate");
        String endDate = (String) requestParam.get("endDate");
        Integer start = (Integer) requestParam.get("start");
        Integer size = (Integer) requestParam.get("size");

        DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
        Date sd = null;
        Date ed = null;
        if (!("").equals(startDate) && null != startDate) {
            try {
                sd = df.parse(startDate);
            } catch (ParseException e) {
                logger.error("parseException" + e);
            }
        }
        if (!("").equals(endDate) && null != endDate) {
            try {
                ed = df.parse(endDate);
            } catch (ParseException e) {
                logger.error("parseException" + e);
            }
        }
        Pagination page = settlementMng.getChannelReport(name, sd, ed, cpn(start), checkSize(size), null, null);
        Map<String, Object> map = new HashMap<>();
        map.put("reports", page.getList());
        map.put("totalCount", page.getTotalCount());
        return map;
    }

    @RequestMapping(value = "/fetchChannelReport")
    public Object channelReport(@RequestBody Map<String,Object> requestParam) {
        Map<String, Object> filters = (Map<String, Object>) requestParam.get("filters");
        String sortField = (String) requestParam.get("sortField");
        boolean isASC = "ASC".equalsIgnoreCase((String) requestParam.get("sortOrder"));
        int start = (int) requestParam.get("start");
        int size = (int) requestParam.get("size");
        return settlementMng.fetchChannelReport(filters, sortField, isASC, start, size);
    }

    @RequestMapping(value = "/fetchMerchantReport")
    public Object fetchMerchantReport(@RequestBody Map<String, Object> requestParam) {
        Map<String, Object> filters = (Map<String, Object>) requestParam.get("filters");
        String sortField = (String) requestParam.get("sortField");
        boolean isASC = "ASC".equalsIgnoreCase((String) requestParam.get("sortOrder"));
        int start = (int) requestParam.get("start");
        int size = (int) requestParam.get("size");
        return settlementMng.fetchMerchantReport(filters, sortField, isASC, start, size);
    }

    @RequestMapping(value = "/fetchProductReport")
    public Object fetchProductReport(@RequestBody Map<String, Object> requestParam) {
        Map<String, Object> filters = (Map<String, Object>) requestParam.get("filters");
        String sortField = (String) requestParam.get("sortField");
        boolean isASC = "ASC".equalsIgnoreCase((String) requestParam.get("sortOrder"));
        int start = (int) requestParam.get("start");
        int size = (int) requestParam.get("size");
        return settlementMng.fetchProductReport(filters, sortField, isASC, start, size);
    }

    @RequestMapping(value = "/fetchProductReportRmb")
    public Object fetchProductReportRMB(@RequestBody Map<String, Object> requestParam) {
        Map<String, Object> filters = (Map<String, Object>) requestParam.get("filters");
        String sortField = (String) requestParam.get("sortField");
        boolean isASC = "ASC".equalsIgnoreCase((String) requestParam.get("sortOrder"));
        int start = (int) requestParam.get("start");
        int size = (int) requestParam.get("size");
        return settlementMng.fetchProductReportRMB(filters, sortField, isASC, start, size);
    }

    @RequestMapping(value = "/fetchVendorReport")
    public Object fetchVendorReport(@RequestBody Map<String, Object> requestParam) {
        Map<String, Object> filters = (Map<String, Object>) requestParam.get("filters");
        String sortField = (String) requestParam.get("sortField");
        boolean isASC = "ASC".equalsIgnoreCase((String) requestParam.get("sortOrder"));
        int start = (int) requestParam.get("start");
        int size = (int) requestParam.get("size");
        return settlementMng.fetchVendorReport(filters, sortField, isASC, start, size);
    }

    @RequestMapping(value = "/fetchVendorReportRmb")
    public Object fetchVendorReportRMB(@RequestBody Map<String, Object> requestParam) {
        Map<String, Object> filters = (Map<String, Object>) requestParam.get("filters");
        String sortField = (String) requestParam.get("sortField");
        boolean isASC = "ASC".equalsIgnoreCase((String) requestParam.get("sortOrder"));
        int start = (int) requestParam.get("start");
        int size = (int) requestParam.get("size");
        return settlementMng.fetchVendorReportRMB(filters, sortField, isASC, start, size);
    }

    /**
     * 商品接口
     *
     * @param requestParam
     * @return
     */
    @RequestMapping(value = "/merchandise")
    public Object merchandiseReport(@RequestBody Map<String, Object> requestParam) {
        String productName = (String) requestParam.get("productName");
        String commerceName = (String) requestParam.get("commerceName");
        String startDate = (String) requestParam.get("startDate");
        String endDate = (String) requestParam.get("endDate");
        Integer type = (Integer) requestParam.get("type");
        Integer start = (Integer) requestParam.get("start");
        Integer size = (Integer) requestParam.get("size");

        DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
        Date sd = null;
        Date ed = null;
        if (!("").equals(startDate) && null != startDate) {
            try {
                sd = df.parse(startDate);
            } catch (ParseException e) {
                logger.error("parseException" + e);
            }
        }
        if (!("").equals(endDate) && null != endDate) {
            try {
                ed = df.parse(endDate);
            } catch (ParseException e) {
                logger.error("parseException" + e);
            }
        }

        Pagination page = new Pagination();
        Map<String, Object> map = new HashMap<>();
        if (1 == type) {
            page = settlementMng.getProductReport(productName, commerceName, sd, ed, cpn(start), checkSize(size), null, null);
        } else if (2 == type) {
            page = settlementMng.getProductReporByRMB(productName, commerceName, sd, ed, cpn(start), checkSize(size), null, null);
        }
        map.put("reports", page.getList());
        map.put("totalCount", page.getTotalCount());
        return map;
    }

    /**
     * 设备接口
     *
     * @param requestParam
     * @return
     */
    @RequestMapping(value = "/device")
    public Object deviceReport(@RequestBody Map<String, Object> requestParam) {
        String name = (String) requestParam.get("name");
        String startDate = (String) requestParam.get("startDate");
        String endDate = (String) requestParam.get("endDate");
        Integer type = (Integer) requestParam.get("type");
        Integer start = (Integer) requestParam.get("start");
        Integer size = (Integer) requestParam.get("size");

        DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
        Date sd = null;
        Date ed = null;
        if (!("").equals(startDate) && null != startDate) {
            try {
                sd = df.parse(String.valueOf(startDate));
            } catch (ParseException e) {
                logger.error("parseException" + e);
            }
        }
        if (!("").equals(endDate) && null != endDate) {
            try {
                ed = df.parse(String.valueOf(endDate));
            } catch (ParseException e) {
                logger.error("parseException" + e);
            }
        }

        Pagination page = new Pagination();
        Map<String, Object> map = new HashMap<>();
        if (1 == type) {
            page = settlementMng.getVendorReport(name, sd, ed, null, null, cpn(start), checkSize(size));
        } else if (2 == type) {
            page = settlementMng.getVendorReportByRMB(name, sd, ed, cpn(start), checkSize(size));
        }
        map.put("reports", page.getList());
        map.put("totalCount", page.getTotalCount());
        return map;
    }

    /**
     * account pay query
     * @param requestParam
     * @return
     */
    @RequestMapping(value = "/account")
    public Object accountReport(@RequestBody Map<String, Object> requestParam){
        String account = (String) requestParam.get("account");
        String startDate = (String) requestParam.get("startDate");
        String endDate = (String) requestParam.get("endDate");
        Integer start = (Integer) requestParam.get("start");
        Integer size = (Integer) requestParam.get("size");
        DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
        Date sd = null;
        Date ed = null;
        if (!("").equals(startDate) && null != startDate) {
            try {
                sd = df.parse(String.valueOf(startDate));
            } catch (ParseException e) {
                logger.error("parseException" + e);
            }
        }
        if (!("").equals(endDate) && null != endDate) {
            try {
                ed = df.parse(String.valueOf(endDate));
            } catch (ParseException e) {
                logger.error("parseException" + e);
            }
        }
        Map<String, Object> map = new HashMap<>();
        Pagination page = settlementMng.getAccountReport(account, sd, ed, cpn(start), checkSize(size));
        map.put("reports", page.getList());
        map.put("totalCount", page.getTotalCount());
        return map;
    }

    @Autowired
    private SettlementMng settlementMng;
    private static final Logger logger = Logger.getLogger(ReportRestController.class);
}
