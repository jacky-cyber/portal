package com.ifunpay.portal.model.payment;

import com.ifunpay.portal.entity.BankPayInfo;
import com.ifunpay.portal.model.BankAppEnum;
import com.ifunpay.portal.model.PaidInfo;
import org.apache.log4j.Logger;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;

/**
 * Created by Yu on 2015/3/5.
 */
public interface BankPaymentManager {

    public static Logger LOGGER = Logger.getLogger(BankPaymentManager.class);

    public BankAppEnum getBankApp();
    public void pay(ModelAndView modelAndView, HttpServletRequest request,  String orderId, BankPayInfo bankPayInfo, String amountStr);
    public void paidCallback(HttpServletRequest request, PaidInfo paidInfo);
    public boolean isRefundable();

    public default RefundResult refund(String orderId, int amount, String refundId){
        if(isRefundable()){
            throw new RuntimeException("this payment is refundable, but not override refund method yet.");
        }else{
            throw new RuntimeException("this payment is not refundable");
        }
    }

    /**
     * run before process callback. Use for check if need to process callback.
     * WARN: this is a hook
     * @return is need to continue?
     */
    default public boolean ifNeedToProcessCallback(boolean isFromUser, HttpServletRequest request, ModelAndView modelAndView){
        LOGGER.debug("default method");
        return true;
    }
}
