package com.ifunpay.portal.service.payment;

import CCBSign.RSASig;
import com.ifunpay.portal.ProjectXml;
import com.ifunpay.portal.dao.BaseDao;
import com.ifunpay.portal.entity.BankPayInfo;
import com.ifunpay.util.enums.PaymentStatusEnum;
import com.ifunpay.portal.model.BankAppEnum;
import com.ifunpay.portal.model.PaidInfo;
import com.ifunpay.portal.model.payment.BankPaymentManager;
import com.ifunpay.portal.service.ThreadPoolService;
import com.ifunpay.util.common.StringUtil;
import com.ifunpay.util.enums.OperatingSystems;
import com.ifunpay.util.function.OptionalConsumer;
import com.ifunpay.util.jackson.JsonUtil;
import com.ifunpay.util.network.ServletRequestUtil;
import com.ifunpay.util.network.SimpleHttpClient;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.util.Arrays;

/**
 * Created by Yu on 2015/3/4.
 */
@Component
public class CcbBankPaymentManager implements BankPaymentManager {

    private Logger logger = Logger.getLogger(CcbBankPaymentManager.class);

    @Resource
    BaseDao baseDao;

    @Resource
    private ThreadPoolService threadPoolService;

    public void pay(ModelAndView modelAndView, HttpServletRequest request, String orderId, BankPayInfo bankPayInfo, String amountStr) {
        String ctx = request.getSession().getServletContext().getContextPath();
        BankAppEnum app = bankPayInfo.getApp();
        final String HTTP_USER_AGENT = request.getHeader("User-Agent");
        OperatingSystems os = ServletRequestUtil.getServletRequestOperateSystem(HTTP_USER_AGENT);
        logger.debug("OS is: " + os);
        String scripts = getScriptsByBankAndOs(ctx, app, os);
        if (scripts != null && scripts.length() > 0) {
            modelAndView.addObject("scripts", scripts);
            logger.debug("add script: " + scripts);
        } else {
            logger.debug("script is empty");
        }
        modelAndView.addObject("orderId", orderId);
        modelAndView.addObject("amount", amountStr);
        String posId = bankPayInfo.getMobileCounter();
        modelAndView.addObject("posId", posId);
        String txCode = "SP7010";
        modelAndView.addObject("txCode", txCode);
        String merchantId = bankPayInfo.getMerchantId();
        modelAndView.addObject("merchantId", merchantId);
        String forMd5 = txCode + merchantId + orderId + amountStr;
        String magic = StringUtil.getMd5Hex(forMd5.getBytes()).toLowerCase();
        modelAndView.addObject("magic", magic);
        modelAndView.addObject("remark1", ProjectXml.getValue("shenzhen_ccb_mobile_pay_remark1"));
        modelAndView.addObject("remark2", bankPayInfo.getId());
        modelAndView.setViewName("payment/mobilePay");
    }


    public void paidCallback(HttpServletRequest request, PaidInfo paidInfo) {
        String MERCHANTID = request.getParameter("MERCHANTID");
        String ORDERID = request.getParameter("ORDERID");
        String PAYMENT = request.getParameter("PAYMENT");
        long amount = 0l;
        try {
            double d = new Double(PAYMENT) * 100;
            amount = Math.round(d);
        } catch (RuntimeException e) {
            logger.info("CCB MOBILE CALLBACK unknown PAYMENT is not a number but [" + PAYMENT + "]");
        }
        long finalAmount = amount;
        String BJOURNAL = request.getParameter("BJOURNAL");//银行流水
        String SUCCESS = request.getParameter("SUCCESS");
        PaymentStatusEnum status;
        if ("Y".equals(SUCCESS)) {
            status = PaymentStatusEnum.PaySucceeded;
        } else if ("N".equals(SUCCESS)) {
            status = PaymentStatusEnum.PayFailed;
        } else {
            status = PaymentStatusEnum.Unknown;
            if (!"U".equals(SUCCESS)) {
                logger.warn("CCB MOBILE CALLBACK unknown SUCCESS value: [" + SUCCESS + "]");
            }
        }
        String SIGNBANK = request.getParameter("SIGNBANK");
        String USERACCNO = request.getParameter("USERACCNO");
        String USERNAME = request.getParameter("USERNAME");
        String BRANCHID = request.getParameter("BRANCHID");
        String POSID = request.getParameter("POSID");
        String remark1 = request.getParameter("REMARK1");
        String remark2 = request.getParameter("REMARK2");//remark2 is bankPayInfo's id
        OptionalConsumer.of(baseDao.get(BankPayInfo.class, remark2)).ifPresent(bankPayInfo -> {
            String src = "MERCHANTID=" + MERCHANTID;
            src += "&";
            src += "ORDERID=" + ORDERID;
            src += "&";
            src += "PAYMENT=" + PAYMENT;
            src += "&";
            src += "BJOURNAL=" + BJOURNAL;
            src += "&";
            src += "SUCCESS=" + SUCCESS;
            logger.debug("src -> [" + src + "]");
            RSASig rsaSig = new RSASig();
            rsaSig.setPublicKey(bankPayInfo.getPublicKey());
            Boolean b = rsaSig.verifySigature(SIGNBANK, src);

            if (!b) {
                logger.debug("paid sign failed.");
                throw new RuntimeException("验证签名失败");
            } else {
                logger.debug("Paid sign success.");
            }
            paidInfo.setAccount(USERACCNO);
            paidInfo.setUserName(USERNAME);
            paidInfo.setSerialNumber(BJOURNAL);
            paidInfo.setBranchId(BRANCHID);
            paidInfo.setAmount(finalAmount);
            paidInfo.setStatus(status);
            paidInfo.setBank(BankAppEnum.CCB);
            paidInfo.setOrderId(ORDERID);
            paidInfo.setPosId(POSID);
            paidInfo.setRemarks(Arrays.asList(remark1, remark2));
            logger.debug("build paidInfo OK");
        }).ifNotPresent(() -> {
            logger.warn("NO BankPayInfo FOR CALLBACK");
        });
    }

    @Override
    public BankAppEnum getBankApp() {
        return BankAppEnum.CCB;
    }

    @Override
    public boolean ifNeedToProcessCallback(boolean isFromUser, HttpServletRequest request, ModelAndView modelAndView) {
        logger.debug("remote address is: " + request.getRemoteAddr());
        return !(processRedirect("/paid/" + getBankApp() + "/" + isFromUser, request, isFromUser, modelAndView));
    }

    @Override
    public boolean isRefundable() {
        return false;
    }

    /**
     * ============================================
     * ============= private methods ==============
     * ============================================
     */


    private boolean processRedirect(String requestPath, HttpServletRequest request, boolean isFromUser, ModelAndView modelAndView) {
        if (isWantRedirect(request)) {
            String redirectHost = request.getParameter("REMARK1");
            String queryString;
            if (request.getMethod().equalsIgnoreCase("POST")) {
                queryString = JsonUtil.toJson(request.getParameterMap());
            } else {
                queryString = request.getQueryString();
            }
            String redirectUrl = redirectHost + requestPath + "/?" + queryString + "&redirect=true";

            if (isFromUser) {
                //Redirect user callback
                logger.info("let browser redirect to [" + redirectUrl + "]");
                modelAndView.setViewName("redirect:" + redirectUrl);
            } else {
                //Redirect background callback info
                threadPoolService.execute(() -> {
                    SimpleHttpClient client = new SimpleHttpClient();
                    try {
                        logger.info("redirect paid info to " + redirectUrl);
                        String response = client.doGet(redirectUrl);
                        logger.info("redirect paid info get response: " + response);
                    } catch (IOException e) {
                        logger.error("Redirect Url caught an error: ", e);
                    }
                });
            }
            return true;
        }
        return false;
    }

    private boolean isWantRedirect(HttpServletRequest request) {
        String redirectHost = request.getParameter("REMARK1");
        String configHost = ProjectXml.getValue("shenzhen_ccb_mobile_pay_remark1");
        boolean isRedirected = new Boolean(request.getParameter("redirect"));
        return !isRedirected && redirectHost != null && redirectHost.toLowerCase().startsWith("http") && !redirectHost.equals(configHost);
    }

    public String getScriptsByBankAndOs(String contextPath, BankAppEnum bankApp, OperatingSystems os) {
        String scripts = "";
        switch (bankApp) {
            case CCB:
                switch (os) {
                    case iOS:
                        scripts = "ccb_ios";
                        break;
                    case Android:
                        scripts = "ccb_android";
                        break;
                }
            case BOC:
        }
        if (scripts.length() > 0) {
            scripts = "<script src='" + contextPath + "/res/common/js/payment/" + scripts + ".js'></script>";
        }
        return scripts;
    }


}
