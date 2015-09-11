/**
 * Created by Administrator on 2014/12/16.
 */
function MBC_PAY(){
    window.location="/mbcpay.b2c ";

}
function MBC_PAYINFO(){
    var orderinfo =
        "TXCODE="+mbcpay_b2c.TXCODE.value+","+
        "WAPVER="+mbcpay_b2c.WAPVER.value+","+
        "MERCHANTID="+mbcpay_b2c.MERCHANTID.value+","+
        "ORDERID="+mbcpay_b2c.ORDERID.value+","+
        "PAYMENT="+mbcpay_b2c.PAYMENT.value+","+
        "MAGIC="+mbcpay_b2c.MAGIC.value+","+
        "BRANCHID="+mbcpay_b2c.BRANCHID.value+","+
        "POSID="+mbcpay_b2c.POSID.value+","+
        "CURCODE="+mbcpay_b2c.CURCODE.value+","+
        "REMARK1="+mbcpay_b2c.REMARK1.value+","+
        "REMARK2="+mbcpay_b2c.REMARK2.value;
    return "{" + orderinfo + "}";
}