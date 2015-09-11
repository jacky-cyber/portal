package com.ifunpay.portal.service;

import com.ifunpay.portal.entity.BankPayInfo;
import com.ifunpay.util.enums.PaymentStatusEnum;
import com.ifunpay.portal.model.BankAppEnum;
import com.ifunpay.portal.model.PaidInfo;
import com.ifunpay.portal.model.payment.BankPaymentManager;
import org.apache.log4j.Logger;
import org.springframework.context.annotation.Lazy;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Observable;
import java.util.stream.Collectors;


/**
 * Manage bank payment, include PAY, PAID CALLBACK
 * Created by Yu on 2014/12/24.
 */
@Service
@Lazy(false)
public class PaymentManageService extends Observable {

    private Logger logger = Logger.getLogger(PaymentManageService.class);

    @Resource
    List<BankPaymentManager> bankPaymentManagerList;

    public void pay(ModelAndView modelAndView, HttpServletRequest request, String orderId, BankPayInfo bankPayInfo, String amountStr) {
        logger.debug("pay START");
        BankPaymentManager bankPaymentManager = getSuitBankPaymentManager(bankPayInfo.getApp());
        bankPaymentManager.pay(modelAndView, request, orderId, bankPayInfo, amountStr);
        logger.debug("pay END");
    }


    public boolean ifNeedToProcessCallback(BankAppEnum app, boolean isFromUser, HttpServletRequest request, ModelAndView modelAndView) {
        logger.debug("check if need redirect");
        return getSuitBankPaymentManager(app).ifNeedToProcessCallback(isFromUser, request, modelAndView);
    }


    public boolean isSuitPaymentRefundable(BankAppEnum app) {
        return getSuitBankPaymentManager(app).isRefundable();
    }

    public void refund(BankAppEnum app, String orderId, int amountFen, String refundId) {
        BankPaymentManager manager = getSuitBankPaymentManager(app);
        manager.refund(orderId, amountFen, refundId);
    }

    public PaidInfo payCallback(BankAppEnum bank, HttpServletRequest request, ModelAndView modelAndView, boolean isFromUser) {
        PaidInfo paidInfo = new PaidInfo();
        paidInfo.setModelAndView(modelAndView);
        paidInfo.setFromUser(isFromUser);
        paidInfo.setBank(bank);
        BankPaymentManager bankPaymentManager = getSuitBankPaymentManager(bank);
        bankPaymentManager.paidCallback(request, paidInfo);

        if (paidInfo.getStatus() == PaymentStatusEnum.PaySucceeded) {
            logger.info("paid success.");
            super.setChanged();
            super.notifyObservers(paidInfo);
        }else{
            logger.info("paid failed");
        }
        return paidInfo;
    }


    public BankPaymentManager getSuitBankPaymentManager(BankAppEnum app) {
        try {
            return bankPaymentManagerList.stream().filter(item -> item.getBankApp() == app).collect(Collectors.toList()).get(0);
        } catch (RuntimeException e) {
            logger.info("no suit bank payment for app: " + app);
            logger.debug("", e);
            return null;
        }
    }

}
