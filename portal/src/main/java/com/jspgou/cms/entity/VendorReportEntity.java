package com.jspgou.cms.entity;

import java.math.BigDecimal;

/**
 * Created by zhengjiang on 2015/3/12.
 */
public class VendorReportEntity {

    private String terminalId;
    private BigDecimal totalAmount;
    private BigDecimal aShotToPay;
    private BigDecimal flashPay;
    private BigDecimal insertCard;
    private BigDecimal qrCode;

    public String getTerminalId() {
        return terminalId;
    }

    public void setTerminalId(String terminalId) {
        this.terminalId = terminalId;
    }

    public BigDecimal getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(BigDecimal totalAmount) {
        this.totalAmount = totalAmount;
    }

    public BigDecimal getaShotToPay() {
        return aShotToPay;
    }

    public void setaShotToPay(BigDecimal aShotToPay) {
        this.aShotToPay = aShotToPay;
    }

    public BigDecimal getFlashPay() {
        return flashPay;
    }

    public void setFlashPay(BigDecimal flashPay) {
        this.flashPay = flashPay;
    }

    public BigDecimal getInsertCard() {
        return insertCard;
    }

    public void setInsertCard(BigDecimal insertCard) {
        this.insertCard = insertCard;
    }

    public BigDecimal getQrCode() {
        return qrCode;
    }

    public void setQrCode(BigDecimal qrCode) {
        this.qrCode = qrCode;
    }
}
