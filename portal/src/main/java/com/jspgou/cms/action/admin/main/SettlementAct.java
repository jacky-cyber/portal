package com.jspgou.cms.action.admin.main;

import com.ifunpay.portal.util.SessionUtil;
import com.jspgou.cms.entity.*;
import com.jspgou.cms.manager.SettlementMng;
import com.jspgou.common.page.Pagination;
import com.jspgou.common.util.ExcelExport;
import com.jspgou.common.web.CookieUtils;
import com.jspgou.core.utils.ExcelUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.apache.tools.ant.taskdefs.condition.Http;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.OutputStream;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.*;

import static com.jspgou.common.page.SimplePage.cpn;

/**
 * 结算报表统计
 * Created by zhengjiang on 2015/3/9.
 */
@Controller
public class SettlementAct {

    /**
     * 渠道报表
     * @param name
     * @param startTime
     * @param endTime
     * @param pageNo
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/channelReport/v_list.do")
    public String channelSettlement(String name, Date startTime, Date endTime, Integer pageNo, HttpServletRequest request, ModelMap model) {
        Long channelId = sessionUtil.getChannelId(request);
        Long commerceId = sessionUtil.getCommerceId(request);
        Pagination pagination = settlementMng.getChannelReport(name, startTime, endTime, cpn(pageNo), CookieUtils.getPageSize(request), channelId, commerceId);
        model.addAttribute("name", name);
        model.addAttribute("startTime", startTime);
        model.addAttribute("endTime", endTime);
        model.addAttribute("pagination", pagination);
        return "settlement/channelReport";
    }

    /**
     * 商户报表
     * @param name
     * @param startTime
     * @param endTime
     * @param pageNo
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/commerceReport/v_list.do")
    public String commerceSettlement(String name, String channelName, Date startTime, Date endTime, Integer pageNo, HttpServletRequest request, ModelMap model) {
        Long channelId = sessionUtil.getChannelId(request);
        Long commerceId = sessionUtil.getCommerceId(request);
        Pagination pagination = settlementMng.getCommerceReport(name, channelName, startTime, endTime, cpn(pageNo), CookieUtils.getPageSize(request), channelId, commerceId);
        model.addAttribute("name", name);
        model.addAttribute("channelName", channelName);
        model.addAttribute("startTime", startTime);
        model.addAttribute("endTime", endTime);
        model.addAttribute("pagination", pagination);
        return "settlement/new-commerceReport";
    }

    /**
     * 渠道报表
     * @param name
     * @param startTime
     * @param endTime
     * @param response
     */
    @RequestMapping(value = "channelReportToXls.do")
    public void channelReportToXls(String name, Date startTime, Date endTime, HttpServletRequest request, HttpServletResponse response) {
        Long channelId = sessionUtil.getChannelId(request);
        Long commerceId = sessionUtil.getCommerceId(request);
        List<Settlement> settlements = settlementMng.getChannelReport(name, startTime, endTime, channelId, commerceId);
        try {
            OutputStream outputStream = response.getOutputStream();
            response.setHeader("Content-disposition", "attachment; filename="+new String("渠道结算报表".getBytes("GB2312"),"8859_1")+".xls");
            //定义输出类型为excel
            response.setContentType("application/msexcel");

            ExcelUtils<Settlement> excelUtils = new ExcelUtils<Settlement>();
            List<String[]> list = new ArrayList<String[]>();
            String[] a1 = {"渠道名称", "channelName"};
            list.add(a1);
            String[] a2 = {"订单数量(笔)", "totalOrder"};
            list.add(a2);
            String[] a3 = {"总销售金额(元)", "totalPaiedAmount"};
            list.add(a3);
            String[] a4 = {"累计退款金额(元)", "totalRefundAmount"};
            list.add(a4);
            String[] a5 = {"收款总计(元)", "totalSellAmount"};
            list.add(a5);
            excelUtils.toExcelAjax(list, settlements, outputStream);
        } catch (Exception e) {
            logger.error("导出报表失败！", e);
        }
    }

    /**
     * 商户报表
     * @param name
     * @param startTime
     * @param endTime
     * @param response
     */
    @RequestMapping(value = "commerceReportToXls.do")
    public void commerceReportToXls(String name, String channelName, Date startTime, Date endTime, HttpServletRequest request, HttpServletResponse response) {
        Long channelId = sessionUtil.getChannelId(request);
        Long commerceId = sessionUtil.getCommerceId(request);
        List<Settlement> settlements = settlementMng.getCommerceReport(name, channelName, startTime, endTime, channelId, commerceId);
        try {
            OutputStream outputStream = response.getOutputStream();
            response.setHeader("Content-disposition", "attachment; filename="+new String("商户结算报表".getBytes("GB2312"),"8859_1")+".xls");
            //定义输出类型为excel
            response.setContentType("application/msexcel");

            ExcelUtils<Settlement> excelUtils = new ExcelUtils<Settlement>();
            List<String[]> list = new ArrayList<String[]>();
            String[] a1 = {"商户名称", "commerceName"};
            list.add(a1);
            String[] a2 = {"订单数量(笔)", "totalOrder"};
            list.add(a2);
            String[] a3 = {"总销售金额(元)", "totalPaiedAmount"};
            list.add(a3);
            String[] a4 = {"累计退款金额(元)", "totalRefundAmount"};
            list.add(a4);
            String[] a5 = {"收款总计(元)", "totalSellAmount"};
            list.add(a5);
            excelUtils.toExcelAjax(list, settlements, outputStream);
        } catch (Exception e) {
            logger.error("导出报表失败！", e);
        }
    }

    @RequestMapping(value = "/productReport/v_list.do")
    public String productReport(String productName, String commerceName, Date startTime, Date endTime, Integer pageNo, HttpServletRequest request, ModelMap model) {
        Long channelId = sessionUtil.getChannelId(request);
        Long commerceId = sessionUtil.getCommerceId(request);
        Pagination pagination = settlementMng.getProductReport(productName, commerceName, startTime, endTime, cpn(pageNo), CookieUtils.getPageSize(request), channelId, commerceId);
        model.addAttribute("productName", productName);
        model.addAttribute("commerceName", commerceName);
        model.addAttribute("startTime", startTime);
        model.addAttribute("endTime", endTime);
        model.addAttribute("pagination", pagination);
        return "settlement/productReport";
    }

    /**
     * 商品数量报表
     * @param productName
     * @param startTime
     * @param endTime
     * @param response
     */
    @RequestMapping(value = "productReportToXls.do")
    public void productReportToXls(String productName, String commerceName, Date startTime, Date endTime,
                                   HttpServletResponse response, HttpServletRequest request) {
        List<ProductReport> productReports = settlementMng.getProductReport(productName, commerceName, startTime,
                endTime, sessionUtil.getChannelId(request), sessionUtil.getCommerceId(request));
        try {
            OutputStream outputStream = response.getOutputStream();
            response.setHeader("Content-disposition", "attachment; filename="+new String("商品结算报表".getBytes("GB2312"),"8859_1")+".xls");
            //定义输出类型为excel
            response.setContentType("application/msexcel");

            ExcelUtils<ProductReport> excelUtils = new ExcelUtils<ProductReport>();
            List<String[]> list = new ArrayList<String[]>();
            String[] a1 = {"商户名称", "commerceName"};
            list.add(a1);
            String[] a2 = {"商品名称", "productName"};
            list.add(a2);
            String[] a3 = {"商品销售数量(笔)", "totalOrder"};
            list.add(a3);
            String[] a4 = {"一拍支付销售数量(笔)", "aShotToPay"};
            list.add(a4);
            String[] a5 = {"二维码支付销售数量(笔)", "qrCode"};
            list.add(a5);
            String[] a6 = {"插卡支付销售数量(笔)", "insertCard"};
            list.add(a6);
            String[] a7 = {"闪付销售数量(笔)", "flashPay"};
            list.add(a7);
            excelUtils.toExcelAjax(list, productReports, outputStream);
        } catch (Exception e) {
            logger.error("导出报表失败！", e);
        }
    }

    @RequestMapping(value = "productReportAmountToXls.do")
    public void productReportAmountToXls(String productName, String commerceName, Date startTime, Date endTime,
                                         HttpServletResponse response, HttpServletRequest request) {
        List<ProductReportEntity> productReportEntities = settlementMng.getProductReporByRMB(productName, commerceName,
                startTime, endTime, sessionUtil.getChannelId(request), sessionUtil.getCommerceId(request));
        try {
            OutputStream outputStream = response.getOutputStream();
            response.setHeader("Content-disposition", "attachment; filename="+new String("商品结算报表".getBytes("GB2312"),"8859_1")+".xls");
            //定义输出类型为excel
            response.setContentType("application/msexcel");

            ExcelUtils<ProductReportEntity> excelUtils = new ExcelUtils<ProductReportEntity>();
            List<String[]> list = new ArrayList<String[]>();
            String[] a1 = {"商户名称", "commerceName"};
            list.add(a1);
            String[] a2 = {"商品名称", "productName"};
            list.add(a2);
            String[] a3 = {"商品销售额(元)", "totalAmount"};
            list.add(a3);
            String[] a4 = {"一拍支付销售(元)", "aShotToPay"};
            list.add(a4);
            String[] a5 = {"二维码支付支付销售(元)", "qrCode"};
            list.add(a5);
            String[] a6 = {"插卡支付销售(元)", "insertCard"};
            list.add(a6);
            String[] a7 = {"闪付销售(元)", "flashPay"};
            list.add(a7);
            excelUtils.toExcelAjax(list, productReportEntities, outputStream);
        } catch (Exception e) {
            logger.error("导出报表失败！", e);
        }
    }

    @RequestMapping(value = "/productReportByRMB/v_list.do")
    public String productReportByRMB(String productName, String commerceName, Date startTime, Date endTime,
                                     Integer pageNo, HttpServletRequest request, ModelMap model) {
        Pagination pagination = settlementMng.getProductReporByRMB(productName, commerceName, startTime, endTime,
                cpn(pageNo), CookieUtils.getPageSize(request), sessionUtil.getChannelId(request), sessionUtil.getCommerceId(request));
        model.addAttribute("productName", productName);
        model.addAttribute("commerceName", commerceName);
        model.addAttribute("startTime", startTime);
        model.addAttribute("endTime", endTime);
        model.addAttribute("pagination", pagination);
        return "settlement/productReportByRMB";
    }

    /**
     * 商品金额报表
     * @param productName
     * @param startTime
     * @param endTime
     * @param response
     */
    @RequestMapping(value = "productReportByRMBToXls.do")
    public void productReportByRMBToXls(String productName, String commerceName, Date startTime, Date endTime,
                                        HttpServletResponse response, HttpServletRequest request) {
        List<ProductReportEntity> productReportEntities = settlementMng.getProductReporByRMB(productName, commerceName,
                startTime, endTime, sessionUtil.getChannelId(request), sessionUtil.getCommerceId(request));
        try {
            OutputStream outputStream = response.getOutputStream();
            response.setHeader("Content-disposition", "attachment; filename="+new String("商品结算报表".getBytes("GB2312"),"8859_1")+".xls");
            //定义输出类型为excel
            response.setContentType("application/msexcel");

            ExcelUtils<ProductReportEntity> excelUtils = new ExcelUtils<ProductReportEntity>();
            List<String[]> list = new ArrayList<String[]>();
            String[] a1 = {"商品名称", "name"};
            list.add(a1);
            String[] a2 = {"商品销售总金额(元)", "totalAmount"};
            list.add(a2);
            String[] a3 = {"扫码支付销售(元)", "scanPayAmount"};
            list.add(a3);
            String[] a4 = {"小额支付销售(元)", "qrPayAmount"};
            list.add(a4);
            String[] a5 = {"银联支付销售(元)", "unionPayAmount"};
            list.add(a5);
            String[] a6 = {"闪付销售(元)", "quickPayAmount"};
            list.add(a6);
            excelUtils.toExcelAjax(list, productReportEntities, outputStream);
        } catch (Exception e) {
            logger.error("导出报表失败！", e);
        }
    }

    @RequestMapping(value = "/vendorReport/v_list.do")
    public String vendorReport(String name, Date startTime, Date endTime, Integer pageNo, HttpServletRequest request, ModelMap model) {
        Pagination pagination = settlementMng.getVendorReport(name, startTime, endTime, sessionUtil.getChannelId(request),
                sessionUtil.getCommerceId(request), cpn(pageNo), CookieUtils.getPageSize(request));
        model.addAttribute("name", name);
        model.addAttribute("startTime", startTime);
        model.addAttribute("endTime", endTime);
        model.addAttribute("pagination", pagination);
        return "settlement/vendorReport";
    }


    @RequestMapping(value = "/accountReport/v_list.do")
    public String accountReport(String account, Date startTime, Date endTime, Integer pageNo, HttpServletRequest request, Model model){
        if (StringUtils.isBlank(account)){
            Pagination page = new Pagination();
            page.setList(new ArrayList<AccountReport>());
            model.addAttribute("pagination", page);
            model.addAttribute("startTime", startTime);
            model.addAttribute("endTime", endTime);
            return "settlement/accountReport";
        }
        Pagination pagination = settlementMng.getAccountReport(account, startTime, endTime, cpn(pageNo), CookieUtils.getPageSize(request));
        model.addAttribute("pagination", pagination);
        model.addAttribute("account", account);
        model.addAttribute("startTime", startTime);
        model.addAttribute("endTime", endTime);
        return "settlement/accountReport";
    }

    @RequestMapping("/testing.do")
    @ResponseBody
    public String testing(){
        return "OK";
    }

    @RequestMapping(value = "/vendorReportByRMB/v_list.do")
    public String vendorReportByRMB(String name, Date startTime, Date endTime, Integer pageNo, HttpServletRequest request, ModelMap model) {
        Pagination pagination = settlementMng.getVendorReportByRMB(name, startTime, endTime, cpn(pageNo), CookieUtils.getPageSize(request));
        model.addAttribute("name", name);
        model.addAttribute("startTime", startTime);
        model.addAttribute("endTime", endTime);
        model.addAttribute("pagination", pagination);
        return "settlement/vendorReportRMB";
    }

    /**
     * 售货机数量报表
     * @param name
     * @param startTime
     * @param endTime
     * @param response
     */
    @RequestMapping(value = "vendorReportToXls.do")
    public void vendorReportToXls(String name, Date startTime, Date endTime,
                                  HttpServletResponse response, HttpServletRequest request) {
        List<VendorReport> vendorReports = settlementMng.getVendorReport(name, startTime, endTime,
                sessionUtil.getChannelId(request), sessionUtil.getCommerceId(request));
        try {
            OutputStream outputStream = response.getOutputStream();
            response.setHeader("Content-disposition", "attachment; filename="+new String("售货机结算报表".getBytes("GB2312"),"8859_1")+".xls");
            //定义输出类型为excel
            response.setContentType("application/msexcel");

            ExcelUtils<VendorReport> excelUtils = new ExcelUtils<VendorReport>();
            List<String[]> list = new ArrayList<String[]>();
            String[] a1 = {"售货机编号", "terminalId"};
            list.add(a1);
            String[] a2 = {"售货机销售总量(笔)", "totalOrder"};
            list.add(a2);
            String[] a3 = {"一拍支付销售数量(笔)", "aShotToPay"};
            list.add(a3);
            String[] a4 = {"二维码支付销售数量(笔)", "qrCode"};
            list.add(a4);
            String[] a5 = {"插卡支付销售数量(笔)", "insertCard"};
            list.add(a5);
            String[] a6 = {"闪付销售数量(笔)", "flashPay"};
            list.add(a6);
            excelUtils.toExcelAjax(list, vendorReports, outputStream);
        } catch (Exception e) {
            logger.error("导出报表失败！", e);
        }
    }

    /**
     * 售货机金额报表
     * @param name
     * @param startTime
     * @param endTime
     * @param response
     */
    @RequestMapping(value = "vendorReportByRMBToXls.do")
    public void vendorReportByRMBToXls(String name, Date startTime, Date endTime, HttpServletResponse response) {
        List<VendorReportEntity> vendorReportEntities = settlementMng.getVendorReportByRMB(name, startTime, endTime);
        try {
            OutputStream outputStream = response.getOutputStream();
            response.setHeader("Content-disposition", "attachment; filename="+new String("售货机结算报表".getBytes("GB2312"),"8859_1")+".xls");
            //定义输出类型为excel
            response.setContentType("application/msexcel");

            ExcelUtils<VendorReportEntity> excelUtils = new ExcelUtils<VendorReportEntity>();
            List<String[]> list = new ArrayList<String[]>();
            String[] a1 = {"售货机编号", "terminalId"};
            list.add(a1);
            String[] a2 = {"售货机销售总金额(元)", "totalAmount"};
            list.add(a2);
            String[] a3 = {"一拍支付销售(元)", "aShotToPay"};
            list.add(a3);
            String[] a4 = {"二维码支付销售数量(元)", "qrCode"};
            list.add(a4);
            String[] a5 = {"插卡支付销售数量(元)", "insertCard"};
            list.add(a5);
            String[] a6 = {"闪付销售数量(元)", "flashPay"};
            list.add(a6);
            excelUtils.toExcelAjax(list, vendorReportEntities, outputStream);
        } catch (Exception e) {
            logger.error("导出报表失败！", e);
        }
    }

    @RequestMapping(value = "/channelReportChart/v_list.do")
    public String channelReportChart(String name, Date startTime, Date endTime, Model model, HttpServletRequest request) {
        Long channelId = sessionUtil.getChannelId(request);
        Long commerceId = sessionUtil.getCommerceId(request);
        List<Settlement> settlements = settlementMng.getChannelReport(name, startTime, endTime, channelId, commerceId);

        StringBuffer channelName = new StringBuffer();
        StringBuffer paiedAmount = new StringBuffer();
        StringBuffer returnAmount = new StringBuffer();
        for (int i=0; i<settlements.size(); i++) {
            if (i == (settlements.size() - 1)) {
                channelName.append(settlements.get(i).getChannelName());
                paiedAmount.append(settlements.get(i).getTotalPaiedAmount());
                returnAmount.append(settlements.get(i).getTotalRefundAmount());
            } else {
                channelName.append(settlements.get(i).getChannelName()  + ",");
                paiedAmount.append(settlements.get(i).getTotalPaiedAmount()  + ",");
                returnAmount.append(settlements.get(i).getTotalRefundAmount()  + ",");
            }
        }
        model.addAttribute("returnAmount", returnAmount);
        model.addAttribute("channelName", channelName);
        model.addAttribute("paiedAmount", paiedAmount);
//        return "settlement/channelReportChart";
        return "settlement/channelReportCharts";
    }

    @RequestMapping(value = "/commerceReportChart/v_list.do")
    public String commerceReportChart(String name, String channelName, Date startTime, Date endTime, Model model, HttpServletRequest request) {
        Long channelId = sessionUtil.getChannelId(request);
        Long commerceId = sessionUtil.getCommerceId(request);
        List<Settlement> settlements = settlementMng.getCommerceReport(name, channelName, startTime, endTime, channelId, commerceId);
        StringBuffer commerceName = new StringBuffer();
        StringBuffer paiedAmount = new StringBuffer();
        StringBuffer returnAmount = new StringBuffer();
        StringBuffer totalOrder = new StringBuffer();
        for (int i=0; i<settlements.size(); i++) {
            if (i == (settlements.size() - 1)) {
                commerceName.append(settlements.get(i).getCommerceName());
                paiedAmount.append(settlements.get(i).getTotalPaiedAmount());
                returnAmount.append(settlements.get(i).getTotalRefundAmount());
                totalOrder.append(settlements.get(i).getTotalOrder());
            } else {
                commerceName.append(settlements.get(i).getCommerceName()  + ",");
                paiedAmount.append(settlements.get(i).getTotalPaiedAmount()  + ",");
                returnAmount.append(settlements.get(i).getTotalRefundAmount()  + ",");
                totalOrder.append(settlements.get(i).getTotalOrder()  + ",");
            }
        }
        model.addAttribute("commerceName", commerceName);
        model.addAttribute("totalOrder", totalOrder);
        return "settlement/commerceReportCharts";
    }

    @RequestMapping(value = "/productReportChart/v_list.do")
    public String productReportChart(String productName, String commerceName, Date startTime,
                                     Date endTime, Model model, HttpServletRequest request) {
        List<ProductReport> productReports = settlementMng.getProductReport(productName, commerceName, startTime, endTime,
                sessionUtil.getChannelId(request), sessionUtil.getCommerceId(request));
        StringBuffer pName = new StringBuffer();
        StringBuffer totalOrder = new StringBuffer();
        StringBuffer scanPayAmount = new StringBuffer();
        StringBuffer qrPayAmount = new StringBuffer();
        StringBuffer unionPayAmount = new StringBuffer();
        StringBuffer quickPayAmount = new StringBuffer();
        for (int i=0; i<productReports.size(); i++) {
            if (i == (productReports.size() - 1)) {
                pName.append(productReports.get(i).getProductName());
                totalOrder.append(productReports.get(i).getTotalOrder());
                scanPayAmount.append(productReports.get(i).getaShotToPay());
                qrPayAmount.append(productReports.get(i).getQrCode());
                unionPayAmount.append(productReports.get(i).getInsertCard());
                quickPayAmount.append(productReports.get(i).getFlashPay());
            } else {
                pName.append(productReports.get(i).getProductName()  + ",");
                totalOrder.append(productReports.get(i).getTotalOrder()  + ",");
                scanPayAmount.append(productReports.get(i).getaShotToPay()  + ",");
                qrPayAmount.append(productReports.get(i).getQrCode()  + ",");
                unionPayAmount.append(productReports.get(i).getInsertCard()  + ",");
                quickPayAmount.append(productReports.get(i).getFlashPay()  + ",");
            }
        }
        model.addAttribute("productName", pName);
        model.addAttribute("productCount", totalOrder);
        model.addAttribute("scanPayAmount", scanPayAmount);
        model.addAttribute("qrPayAmount", qrPayAmount);
        model.addAttribute("unionPayAmount", unionPayAmount);
        model.addAttribute("quickPayAmount", quickPayAmount);
        return "settlement/productReportCharts";
    }

    @RequestMapping(value = "/productReportByRMBChart/v_list.do")
    public String productReportByRMBChart(String productName, String commerceName, Date startTime,
                                          Date endTime, Model model, HttpServletRequest request) {
        List<ProductReportEntity> productReportEntities = settlementMng.getProductReporByRMB(productName, commerceName,
                startTime, endTime, sessionUtil.getChannelId(request), sessionUtil.getCommerceId(request));
        StringBuffer pName = new StringBuffer();
        StringBuffer totalAmount = new StringBuffer();
        StringBuffer scanPayAmount = new StringBuffer();
        StringBuffer qrPayAmount = new StringBuffer();
        StringBuffer unionPayAmount = new StringBuffer();
        StringBuffer quickPayAmount = new StringBuffer();
        for (int i=0; i<productReportEntities.size(); i++) {
            if (i == (productReportEntities.size() - 1)) {
                pName.append(productReportEntities.get(i).getProductName());
                totalAmount.append(productReportEntities.get(i).getTotalAmount());
                scanPayAmount.append(productReportEntities.get(i).getaShotToPay());
                qrPayAmount.append(productReportEntities.get(i).getQrCode());
                unionPayAmount.append(productReportEntities.get(i).getInsertCard());
                quickPayAmount.append(productReportEntities.get(i).getFlashPay());
            } else {
                pName.append(productReportEntities.get(i).getProductName()  + ",");
                totalAmount.append(productReportEntities.get(i).getTotalAmount()  + ",");
                scanPayAmount.append(productReportEntities.get(i).getaShotToPay()  + ",");
                qrPayAmount.append(productReportEntities.get(i).getQrCode()  + ",");
                unionPayAmount.append(productReportEntities.get(i).getInsertCard()  + ",");
                quickPayAmount.append(productReportEntities.get(i).getFlashPay()  + ",");
            }
        }
        model.addAttribute("productName", pName);
        model.addAttribute("totalAmount", totalAmount);
        model.addAttribute("scanPayAmount", scanPayAmount);
        model.addAttribute("qrPayAmount", qrPayAmount);
        model.addAttribute("unionPayAmount", unionPayAmount);
        model.addAttribute("quickPayAmount", quickPayAmount);
        return "settlement/productReportByRMBCharts";
    }

    @RequestMapping(value = "/vendorReportChart/v_list.do")
    public String vendorReportChart(String name, Date startTime, Date endTime, Model model, HttpServletRequest request) {
        List<VendorReport> vendorReports = settlementMng.getVendorReport(name, startTime, endTime,
                sessionUtil.getChannelId(request), sessionUtil.getCommerceId(request));
        StringBuffer vendorName = new StringBuffer();
        StringBuffer totalAmount = new StringBuffer();
        StringBuffer scanPayAmount = new StringBuffer();
        StringBuffer qrPayAmount = new StringBuffer();
        StringBuffer unionPayAmount = new StringBuffer();
        StringBuffer quickPayAmount = new StringBuffer();
        for (int i=0; i<vendorReports.size(); i++) {
            if (i == (vendorReports.size() - 1)) {
                vendorName.append(vendorReports.get(i).getTerminalId());
                totalAmount.append(vendorReports.get(i).getTotalOrder());
                scanPayAmount.append(vendorReports.get(i).getaShotToPay());
                qrPayAmount.append(vendorReports.get(i).getQrCode());
                unionPayAmount.append(vendorReports.get(i).getInsertCard());
                quickPayAmount.append(vendorReports.get(i).getFlashPay());
            } else {
                vendorName.append(vendorReports.get(i).getTerminalId() + ",");
                totalAmount.append(vendorReports.get(i).getTotalOrder()  + ",");
                scanPayAmount.append(vendorReports.get(i).getaShotToPay()  + ",");
                qrPayAmount.append(vendorReports.get(i).getQrCode()  + ",");
                unionPayAmount.append(vendorReports.get(i).getInsertCard()  + ",");
                quickPayAmount.append(vendorReports.get(i).getFlashPay()  + ",");
            }
        }
        model.addAttribute("vendorName", vendorName);
        model.addAttribute("totalAmount", totalAmount);
        model.addAttribute("scanPayAmount", scanPayAmount);
        model.addAttribute("qrPayAmount", qrPayAmount);
        model.addAttribute("unionPayAmount", unionPayAmount);
        model.addAttribute("quickPayAmount", quickPayAmount);
        return "settlement/vendorReportCharts";
    }

    @RequestMapping(value = "/vendorReportByRMBChart/v_list.do")
    public String vendorReportByRMBChart(String name, Date startTime, Date endTime, Model model) {
        List<VendorReportEntity> vendorReports = settlementMng.getVendorReportByRMB(name, startTime, endTime);
        StringBuffer vendorName = new StringBuffer();
        StringBuffer totalAmount = new StringBuffer();
        StringBuffer scanPayAmount = new StringBuffer();
        StringBuffer qrPayAmount = new StringBuffer();
        StringBuffer unionPayAmount = new StringBuffer();
        StringBuffer quickPayAmount = new StringBuffer();
        for (int i=0; i<vendorReports.size(); i++) {
            if (i == (vendorReports.size() - 1)) {
                vendorName.append(vendorReports.get(i).getTerminalId());
                totalAmount.append(vendorReports.get(i).getTotalAmount());
                scanPayAmount.append(vendorReports.get(i).getaShotToPay());
                qrPayAmount.append(vendorReports.get(i).getQrCode());
                unionPayAmount.append(vendorReports.get(i).getInsertCard());
                quickPayAmount.append(vendorReports.get(i).getFlashPay());
            } else {
                vendorName.append(vendorReports.get(i).getTerminalId() + ",");
                totalAmount.append(vendorReports.get(i).getTotalAmount()  + ",");
                scanPayAmount.append(vendorReports.get(i).getaShotToPay() + ",");
                qrPayAmount.append(vendorReports.get(i).getQrCode() + ",");
                unionPayAmount.append(vendorReports.get(i).getInsertCard() + ",");
                quickPayAmount.append(vendorReports.get(i).getFlashPay() + ",");
            }
        }
        model.addAttribute("vendorName", vendorName);
        model.addAttribute("totalAmount", totalAmount);
        model.addAttribute("scanPayAmount", scanPayAmount);
        model.addAttribute("qrPayAmount", qrPayAmount);
        model.addAttribute("unionPayAmount", unionPayAmount);
        model.addAttribute("quickPayAmount", quickPayAmount);
        return "settlement/vendorReportByRMBCharts";
    }

    @RequestMapping(value = "/commerceMethodByRMBReport/v_list.do")
    public String commerceReportByPayMethod(String name, Date startTime, Date endTime, Integer pageNo, HttpServletRequest request, ModelMap model) {
        Pagination pagination = settlementMng.getCommerceReportByPayMethodAmount(name, startTime, endTime, cpn(pageNo), CookieUtils.getPageSize(request));
        model.addAttribute("pagination", pagination);
        return "settlement/commerceMethodAmount";
    }

    /**
     * 商户的四种支付方式报表
     * @param name
     * @param startTime
     * @param endTime
     * @param response
     */
    @RequestMapping(value = "commerceMethodAmountToXls.do")
    public void commerceMethodAmountToXls(String name, Date startTime, Date endTime, HttpServletResponse response) {
        List<ReportByAmountEntity> reportByAmountEntities = settlementMng.getCommerceReportByPayMethodAmount(name, startTime, endTime);
        try {
            OutputStream outputStream = response.getOutputStream();
            response.setHeader("Content-disposition", "attachment; filename="+new String("商户结算报表".getBytes("GB2312"),"8859_1")+".xls");
            //定义输出类型为excel
            response.setContentType("application/msexcel");

            ExcelUtils<ReportByAmountEntity> excelUtils = new ExcelUtils<ReportByAmountEntity>();
            List<String[]> list = new ArrayList<String[]>();
            String[] a1 = {"商户名称", "name"};
            list.add(a1);
            String[] a2 = {"总营利(元)", "totalAmount"};
            list.add(a2);
            String[] a3 = {"扫码支付销售(元)", "scanPayAmount"};
            list.add(a3);
            String[] a4 = {"小额支付销售(元)", "qrPayAmount"};
            list.add(a4);
            String[] a5 = {"银联支付销售(元)", "unionPayAmount"};
            list.add(a5);
            String[] a6 = {"闪付销售(元)", "quickPayAmount"};
            list.add(a6);
            excelUtils.toExcelAjax(list, reportByAmountEntities, outputStream);
        } catch (Exception e) {
            logger.error("导出报表失败！", e);
        }
    }

    @RequestMapping(value = "/commerceMethodReport/v_list.do")
    public String commerceReportByMethod(String name, Date startTime, Date endTime, Integer pageNo, HttpServletRequest request, ModelMap model) {
        Pagination pagination = settlementMng.getCommerceReportByPayMethod(name, startTime, endTime, cpn(pageNo), CookieUtils.getPageSize(request));
        model.addAttribute("name", name);
        model.addAttribute("startTime", startTime);
        model.addAttribute("endTime", endTime);
        model.addAttribute("pagination", pagination);
        return "settlement/commerceMethod";
    }

    @RequestMapping(value = "commerceMethodToXls.do")
    public void commerceMethodToXls(String name, Date startTime, Date endTime, HttpServletResponse response) {
        List<ReportEntity> reportEntities = settlementMng.getCommerceReportByPayMethod(name, startTime, endTime);
        try {
            OutputStream outputStream = response.getOutputStream();
            response.setHeader("Content-disposition", "attachment; filename="+new String("商户结算报表".getBytes("GB2312"),"8859_1")+".xls");
            //定义输出类型为excel
            response.setContentType("application/msexcel");

            ExcelUtils<ReportEntity> excelUtils = new ExcelUtils<ReportEntity>();
            List<String[]> list = new ArrayList<String[]>();
            String[] a1 = {"商户名称", "name"};
            list.add(a1);
            String[] a2 = {"总销售数量(件)", "totalAmount"};
            list.add(a2);
            String[] a3 = {"扫码支付销售(件)", "scanPayAmount"};
            list.add(a3);
            String[] a4 = {"小额支付销售(件)", "qrPayAmount"};
            list.add(a4);
            String[] a5 = {"银联支付销售(件)", "unionPayAmount"};
            list.add(a5);
            String[] a6 = {"闪付销售(件)", "quickPayAmount"};
            list.add(a6);
            excelUtils.toExcelAjax(list, reportEntities, outputStream);
        } catch (Exception e) {
            logger.error("导出报表失败！", e);
        }
    }

    @RequestMapping(value = "/commerceMethodChart/v_list.do")
    public String commerceReportMethodChart(String name, Date startTime, Date endTime, Model model) {
        List<ReportEntity> reportEntities = settlementMng.getCommerceReportByPayMethod(name, startTime, endTime);
        StringBuffer commerceName = new StringBuffer();
        StringBuffer totalAmount = new StringBuffer();
        StringBuffer scanPayAmount = new StringBuffer();
        StringBuffer qrPayAmount = new StringBuffer();
        StringBuffer unionPayAmount = new StringBuffer();
        StringBuffer quickPayAmount = new StringBuffer();
        for (int i=0; i<reportEntities.size(); i++) {
            if (i == (reportEntities.size() - 1)) {
                commerceName.append(reportEntities.get(i).getName());
                totalAmount.append(reportEntities.get(i).getTotalAmount());
                scanPayAmount.append(reportEntities.get(i).getScanPayAmount());
                qrPayAmount.append(reportEntities.get(i).getUnionPayAmount());
                unionPayAmount.append(reportEntities.get(i).getUnionPayAmount());
                quickPayAmount.append(reportEntities.get(i).getQuickPayAmount());
            } else {
                commerceName.append(reportEntities.get(i).getName()  + ",");
                totalAmount.append(reportEntities.get(i).getTotalAmount()  + ",");
                scanPayAmount.append(reportEntities.get(i).getScanPayAmount()  + ",");
                qrPayAmount.append(reportEntities.get(i).getUnionPayAmount()  + ",");
                unionPayAmount.append(reportEntities.get(i).getUnionPayAmount()  + ",");
                quickPayAmount.append(reportEntities.get(i).getQuickPayAmount()  + ",");
            }
        }
        model.addAttribute("commerceName", commerceName);
        model.addAttribute("totalAmount", totalAmount);
        model.addAttribute("scanPayAmount", scanPayAmount);
        model.addAttribute("qrPayAmount", qrPayAmount);
        model.addAttribute("unionPayAmount", unionPayAmount);
        model.addAttribute("quickPayAmount", quickPayAmount);
        return "settlement/commerceMethodCharts";
    }

    @RequestMapping(value = "/commerceReportByMethodChart/v_list.do")
    public String commerceReportMethodAmountChart(String name, Date startTime, Date endTime, Model model) {
        List<ReportByAmountEntity> reportByAmountEntities = settlementMng.getCommerceReportByPayMethodAmount(name, startTime, endTime);
        StringBuffer commerceName = new StringBuffer();
        StringBuffer totalAmount = new StringBuffer();
        StringBuffer scanPayAmount = new StringBuffer();
        StringBuffer qrPayAmount = new StringBuffer();
        StringBuffer unionPayAmount = new StringBuffer();
        StringBuffer quickPayAmount = new StringBuffer();
        for (int i=0; i<reportByAmountEntities.size(); i++) {
            if (i == (reportByAmountEntities.size() - 1)) {
                commerceName.append(reportByAmountEntities.get(i).getName());
                totalAmount.append(reportByAmountEntities.get(i).getTotalAmount());
                scanPayAmount.append(reportByAmountEntities.get(i).getScanPayAmount());
                qrPayAmount.append(reportByAmountEntities.get(i).getUnionPayAmount());
                unionPayAmount.append(reportByAmountEntities.get(i).getUnionPayAmount());
                quickPayAmount.append(reportByAmountEntities.get(i).getQuickPayAmount());
            } else {
                commerceName.append(reportByAmountEntities.get(i).getName()  + ",");
                totalAmount.append(reportByAmountEntities.get(i).getTotalAmount()  + ",");
                scanPayAmount.append(reportByAmountEntities.get(i).getScanPayAmount()  + ",");
                qrPayAmount.append(reportByAmountEntities.get(i).getUnionPayAmount()  + ",");
                unionPayAmount.append(reportByAmountEntities.get(i).getUnionPayAmount()  + ",");
                quickPayAmount.append(reportByAmountEntities.get(i).getQuickPayAmount()  + ",");
            }
        }
        model.addAttribute("commerceName", commerceName);
        model.addAttribute("totalAmount", totalAmount);
        model.addAttribute("scanPayAmount", scanPayAmount);
        model.addAttribute("qrPayAmount", qrPayAmount);
        model.addAttribute("unionPayAmount", unionPayAmount);
        model.addAttribute("quickPayAmount", quickPayAmount);
        return "settlement/commerceMethodAmountCharts";
    }

    @RequestMapping(value = "/commerceReport/v_details.do")
    public String commerceReportDetails(Long commerceId, String name, String channelName, Date startTime,
                                        Date endTime, Integer pageNo, HttpServletRequest request, ModelMap modelMap){
        Pagination pagination = settlementMng.getCommerceReportDetails(commerceId, name, channelName, startTime,
                endTime, cpn(pageNo), CookieUtils.getPageSize(request), sessionUtil.getChannelId(request));
        modelMap.addAttribute("pagination", pagination);
        return "settlement/commerceReportDetails";
    }

    @RequestMapping(value = "/commerceReport/commerceDetailReportToXls.do")
    public void exportCommerceDetail(String commerceName, String channelName, Date startTime, Date endTime, HttpServletResponse response, HttpServletRequest request){
        Long channelId = sessionUtil.getChannelId(request);
        Long commerceId = sessionUtil.getCommerceId(request);
        List<ProductReportDetail> list = settlementMng.getCommerceReportDetails(commerceName, channelName, startTime, endTime, channelId, commerceId);
        if (0 == list.size()) {
            logger.error("查询到零条数据");
            return;
        }

        Set<String> titles = new HashSet<>();
        for (int i=0; i<list.size(); i++){
            titles.add(list.get(i).getCommerceName());
        }

        String time = setTimeStr(startTime, endTime);
        ExcelExport<BaseProductReport> ex = new ExcelExport<BaseProductReport>();
        Map<String, Collection<String[]>> headers = setExcelHeader(titles, time);
        Map<String, Collection<BaseProductReport>> dataSets = new HashMap<>();

        Iterator it1 = titles.iterator();
        while (it1.hasNext()){
            String cName = it1.next().toString();
            List<BaseProductReport> dataSet = setProductReportData(list, cName);
            dataSets.put(cName, dataSet);
        }

        try{
            Integer[] array= new Integer[]{0, 0, 1, 4, 0, 0, 6, 9};
            OutputStream outputStream = response.getOutputStream();
            response.setHeader("Content-disposition", "attachment; filename="+new String("商户统计报表".getBytes("GB2312"),"8859_1")+".xls");
            //定义输出类型为excel
            response.setContentType("application/msexcel");
            ex.exportExcel(titles, headers, dataSets, outputStream, array);
            outputStream.close();
        } catch (Exception e){
            logger.error("", e);
        }
    }

    private List<BaseProductReport> setProductReportData(List<ProductReportDetail> list, String merchantName){
        List<BaseProductReport> dataSet = new ArrayList<>();

        int sumSell = 0;
        int sumRefund = 0;
        int sumOrder = 0;
        int sumUsed = 0;
        BigDecimal sumUsedAmount = new BigDecimal("0");
        BigDecimal sumReceivedAmount = new BigDecimal("0");
        BigDecimal sumRefundAmount = new BigDecimal("0");
        BigDecimal sumRealReceivedAmount = new BigDecimal("0");

        for (int i=0; i<list.size(); i++){
            if (merchantName.equals(list.get(i).getCommerceName())){
                sumSell = sumSell + list.get(i).getSell();
                sumRefund = sumRefund + list.get(i).getRefund();
                sumOrder = sumOrder + list.get(i).getOrder();
                sumUsed = sumUsed + list.get(i).getUsed();
                sumUsedAmount = sumUsedAmount.add(list.get(i).getUsedAmount());
                sumReceivedAmount = sumReceivedAmount.add(list.get(i).getRealReceivedAmount());
                sumRefundAmount = sumRefundAmount.add(list.get(i).getRefundAmount());
                sumRealReceivedAmount = sumRealReceivedAmount.add(list.get(i).getRealReceivedAmount());

                BaseProductReport baseReport = new BaseProductReport(list.get(i).getProductName(), list.get(i).getPrice(), list.get(i).getSell(), list.get(i).getRefund(),
                        list.get(i).getOrder(), list.get(i).getUsed(), list.get(i).getUsedAmount(), list.get(i).getReceivedAmount(),
                        list.get(i).getRefundAmount(), list.get(i).getRealReceivedAmount());
                dataSet.add(baseReport);
            }
        }
        BaseProductReport sumReport = new BaseProductReport("合计", null, sumSell, sumRefund, sumOrder, sumUsed,
                sumUsedAmount, sumReceivedAmount, sumRefundAmount, sumRealReceivedAmount);
        dataSet.add(sumReport);
        return dataSet;
    }

    private String setTimeStr(Date startTime, Date endTime){
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String sTime = null;
        String eTime = null;
        try {
            if (null != startTime){
                sTime = sdf.format(startTime);
            }
        } catch (Exception e){
            logger.error("", e);
        }
        try {
            if (null != endTime){
                eTime = sdf.format(endTime);
            }
        } catch (Exception e){
            logger.error("", e);
        }

        String time = "-";

        if (StringUtils.isNotBlank(sTime)){
            if (StringUtils.isNotBlank(sTime)){
                time = sTime + " 到 " + eTime;
            }else {
                time = sTime + " 到 " + sdf.format(new Date());
            }
        }else {
            if (StringUtils.isNotBlank(eTime)){
                time = "开始营业" + " 到 " + eTime;
            } else {
                time = "开始营业" + " 到 " + sdf.format(new Date());
            }
        }
        return time;
    }

    private Map<String, Collection<String[]>> setExcelHeader(Set<String> titles, String time){
        Map<String, Collection<String[]>> headers = new HashMap<>();
        String[] header = { "商品名称", "单价(元)", "销售的数量", "退款订单数量", "订单数量", "已消费数量", "消费总额", "收款总额", "退款总额", "应收款" };
        Iterator it = titles.iterator();
        while (it.hasNext()){
            List<String[]> headerList = new ArrayList<String[]>();
            String title = it.next().toString();
            String[] header1 = {"商户", title, null, null, null, "结算时间段", time, null, null, null};
            headerList.add(header1);
            headerList.add(header);
            headers.put(title, headerList);
        }
        return headers;
    }

    private void deleteFile(File file) {
        if (file.exists()) {
            if (file.isFile()) {
                file.delete();
            } else if (file.isDirectory()) {
                File[] files = file.listFiles();
                for (int i=0; i<files.length; i++) {
                    this.deleteFile(files[i]);
                }
            }
            file.delete();
        } else {

        }
    }

    private Logger logger = Logger.getLogger(SettlementAct.class);
    @Autowired
    private SettlementMng settlementMng;
    @Resource
    private SessionUtil sessionUtil;
}
