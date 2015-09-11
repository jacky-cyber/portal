<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/3/4
  Time: 14:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title></title>
</head>
<body onload="MBC_PAY()">
${scripts}
<form name="mbcpay_b2c">
    <input type="hidden" name="TXCODE" value="${txCode}" />
    <input type="hidden" name="WAPVER" value="1.2" />
    <input type="hidden" name="MERCHANTID" value="${merchantId}" />
    <input type="hidden" name="ORDERID" value="${orderId}" />
    <input type="hidden" name="PAYMENT" value="${amount}" />
    <input type="hidden" name="MAGIC" value="${magic}" />
    <input type="hidden" name="BRANCHID" value="442000000" />
    <input type="hidden" name="POSID" value="${posId}" />
    <input type="hidden" name="CURCODE" value="01" />
    <input type="hidden" name="REMARK1" value="${remark1}" />
    <input type="hidden" name="REMARK2" value="${remark2}" />
</form>
<input style="display: none" id="pay" type="button" value="1" onclick=" MBC_PAY()" />
</body>
<a id="rback" href="javascript:history.back(-1);">
</a>
页面过期，请重新扫码
</html>
