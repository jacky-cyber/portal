package com.jspgou.cms.dao;

import java.util.Map;

/**
 * Created by jiang on 2015/9/7.
 */
public interface ReportDao {

    /**
     * Get channel's report, filter by channelReport's properties
     * @param filters
     * @param sortField
     * @param isASC
     * @param start
     * @param size
     * @return
     */
    Map<String, Object> fetchChannelReport(Map<String, Object> filters, String sortField, boolean isASC, int start, int size);

    /**
     * Get merchant's report, filter by MerchantReport's properties
     * @param filters
     * @param sortField
     * @param isASC
     * @param start
     * @param size
     * @return
     */
    Map<String,Object> fetchMerchantReport(Map<String, Object> filters, String sortField, boolean isASC, int start, int size);

    /**
     * Get vendor's report, filter by VendorReport's property
     * @param filters
     * @param sortField
     * @param isASC
     * @param start
     * @param size
     * @return
     */
    Map<String,Object> fetchVendorReport(Map<String, Object> filters, String sortField, boolean isASC, int start, int size);

    /**
     * Get product's report, filter by ProductReport's property
     * @param filters
     * @param sortField
     * @param isASC
     * @param start
     * @param size
     * @return
     */
    Map<String,Object> fetchProductReport(Map<String, Object> filters, String sortField, boolean isASC, int start, int size);

    /**
     * Get Product's report, filter by ProductReportRMB's property
     * @param filters
     * @param sortField
     * @param isASC
     * @param start
     * @param size
     * @return
     */
    Map<String,Object> fetchProductReportRMB(Map<String, Object> filters, String sortField, boolean isASC, int start, int size);

    Map<String,Object> fetchVendorReportRMB(Map<String, Object> filters, String sortField, boolean isASC, int start, int size);
}
