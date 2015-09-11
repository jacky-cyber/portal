<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/pages/merchant/common/include.jsp"%>
<%@ include file="/WEB-INF/pages/merchant/common/layout.jsp"%>
<%
String voucher_value = request.getParameter("voucher_value");
request.setAttribute("voucher_value", voucher_value);
%>
<!DOCTYPE html >
<html >
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>凭证号码验证</title>
<meta name="viewport" content="width=device-width, initial-scale=1,user-scalable=no">
</head>
<script type="text/javascript">

function checkForm(){

	var voucher = $("#voucher_value").val();
	if(voucher == ''){
// 		alert("");
		return false;
	}
	
	return true;
}
</script>
<body>
<div class="warp">
<nav>
<div class="head_bar"><a href="<%=request.getContextPath()%>/mvc/merchant/yz" class="back"></a><h2>验证凭证</h2></div><!--head_bar-->
</nav>
<article>
<div class="content">
 <form action="<%=request.getContextPath()%>/mvc/merchant/yz_result_new" method="post" onsubmit=" return checkForm();">
  <input name="tradeId" value="voucherInfo2" type="hidden">
     <div class="info_con1">
     <h3>凭证号码</h3>
     <div class="s_input"><input name="voucher_value" id="voucher_value" value="${voucher_value }" type="text" class="text1 flex" placeholder="请输入凭证号"></div>
     <div class="s_input">  <input type="submit" class="button" value="查询"></div>
     </div>
</form>
</div><!--content-->
</article>
<div class="footer"></div><!--<div></div>-->
</div>
</body>
</html>
