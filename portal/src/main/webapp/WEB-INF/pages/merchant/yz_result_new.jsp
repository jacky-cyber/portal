<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="/WEB-INF/pages/merchant/common/include.jsp"%>
<%@ include file="/WEB-INF/pages/merchant/common/layout.jsp"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>苏州中行-凭证验证结果</title>
<meta name="viewport" content="width=device-width, initial-scale=1,user-scalable=no">
</head>
<script type="text/javascript">

function validateVoucher(){
	
	var voucher_value = '${voucherInfo.voucherCode}';

	$.post('<%=request.getContextPath()%>/mvc/merchant/validateVoucherNew',
			{voucher_value : voucher_value}, 
			function(json) {
		   		json = eval('('+json+')');
		   		if(json.errorMsg == 'success'){ // 验证成功
		   			$("#empDiv").html('<span style=\"color:red\">验证通过、此二维码不可再次使用 '+"</span>");
		   		}else{
		   			$("#empDiv").html("<span style=\"color:red\">"+json.errorMsg+"</span>");
		   		}
		});
}
</script>
<body>
<div class="warp">
<nav>
<div class="head_bar"><a href="javascript:history.back(-1)" class="back"></a><h2>凭证信息</h2></div><!--head_bar-->
</nav>
<article>
<div class="content">
   
     <div class="info_con">
         <ul class="sh_info">
             <li><span>订单ID：</span> ${voucherInfo.code }</li>
         <li><span>凭证ID：</span> ${voucherInfo.voucherCode}</li>
         <li><span>商户ID：</span> ${voucherInfo.orderProduct.commerce.id}</li>
         <li><span>商户名称：</span>${voucherInfo.orderProduct.commerce.name}</li>
          <li><span>商品ID：</span> ${voucherInfo.orderProduct.product.id}</li>
           <li><span>商品名称：</span> ${voucherInfo.productName}</li>
          <li><span>凭证状态： </span>
            ${voucherInfo.status.displayName}
          </li>

          <li><span>有效开始时间： </span>
          <fmt:formatDate value="${voucherInfo.startTime}" pattern="yyyy-MM-dd HH:mm:ss"/> </li>
          <li><span>有效结束时间： </span>
              <fmt:formatDate value="${voucherInfo.endTime}" pattern="yyyy-MM-dd HH:mm:ss"/></li>
			</ul>
     </div>

	 <div id="empDiv" class="btn2">
         <c:choose>
             <c:when test="${voucherInfo.status == 'NotUsed'&& expire =='1' }">
                 <a href="javascript:void(0)" onclick="validateVoucher()"  class="btn2">马上消费</a>
            </c:when>
             <c:when test="${expire =='0'}">
                 <span class="btn2">凭证已过期</span>
             </c:when>
             <c:when test="${voucherInfo.status == 'Used'}">
                 <span class="btn2">凭证已使用</span>
             </c:when>
         </c:choose>
     </div>

</div><!--content-->
</article>
<div class="footer"></div>
</div>

</body>
</html>
