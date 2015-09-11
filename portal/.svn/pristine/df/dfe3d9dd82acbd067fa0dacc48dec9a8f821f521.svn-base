<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/3/5
  Time: 11:53
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title></title>
</head>
<body>
<script type="text/javascript" src="${ctx}/res/common/js/payment/cmbcForClient.js"></script>
<form name="test2" action="" method="post">
    <input type="hidden" id="orderInfo" name="orderInfo" value="${orderInfo}"/>
    <input type="button" value="支付" id="pay" onclick="submitForm(document.test2.orderInfo.value)"/>
</form>
</body>
<script>
    document.getElementById("pay").click();
    function submitForm(orderinfo) {
        submitOrderForCash(orderinfo);
    }
</script>
</html>
