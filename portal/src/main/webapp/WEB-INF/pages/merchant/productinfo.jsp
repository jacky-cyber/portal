<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/pages/merchant/common/include.jsp"%>
<%@ include file="/WEB-INF/pages/merchant/common/layout.jsp"%>
<!DOCTYPE html >
<html >
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>商品信息</title>
<meta name="viewport" content="width=device-width, initial-scale=1,user-scalable=no">
</head>

<body>
<div class="warp">
<nav>
<div class="head_bar"><a href="javascript:history.back(-1);" class="back"></a><h2>商品信息</h2></div><!--head_bar-->
</nav>
<article>
<div class="content">
   
     <div class="info_con">
         <ul class="sh_info">
         <li><span>商品ID：</span> ${productInfo.id }</li>
         <li><span>商品名称：</span>${productInfo.name }</li>
         <li><span>商品购买原价： </span><em class="ft18 orange bold">￥${productInfo.costPrice }</em></li>
         <%--<li><span>商品折扣价： </span>${productInfo.price}</li>--%>
             <li><span>购买状态： </span>
                 <c:if test="${productInfo.onSale == 'true' }">上架</c:if>
                 <c:if test="${productInfo.onSale == 'false' }">下架</c:if>
             </li>
         <li><span>购买开始时间： </span>${fn:substring(productInfo.createTime,0,19)}</li>
    	 <li><span>购买结束时间： </span>${fn:substring(productInfo.expireTime,0,19)}</li>
        <%--<li><span> 购买人数： </span>${productInfo.saleCount }</li>--%>
		</ul>
     </div>

</div><!--content-->
</article>
<div class="footer"></div><!--<div></div>-->
</div>

</body>
</html>
