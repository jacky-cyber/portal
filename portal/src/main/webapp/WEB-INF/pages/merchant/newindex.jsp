<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/pages/merchant/common/include.jsp"%>
<%@ include file="/WEB-INF/pages/merchant/common/layout.jsp"%>
<!DOCTYPE html >
<html >
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1,user-scalable=no">
</head>

<body>
<div class="warp">
<nav>
<div class="head_bar">
<%--<a href="<%=request.getContextPath()%>/suzhouboc" class="back"></a>--%>
<h2>商户管理</h2></div><!--head_bar-->
</nav>
<article>
<div class="content">
   <div class="con_w">
      <div class="menu_1 box">
       <a href="<%=request.getContextPath()%>/mvc/merchant/merchantInfo"> <span class="icon  icon1"></span><h3 class="flex">商户信息</h3><span class="arrowc"></span></a>
      </div>
      <div class="menu_1 box">
       <a href="<%=request.getContextPath()%>/mvc/merchant/yz"> <span class="icon  icon2"></span><h3 class="flex">凭证验证</h3><span class="arrowc"></span></a>
      </div>
      <div class="menu_1 box">
       <a href="<%=request.getContextPath()%>/mvc/merchant/newOrderlist" > <span class="icon  icon3"></span><h3 class="flex">新订单查询</h3>
       <c:if test="${orderSize ge 1}">
	       <c:choose> 
		       	<c:when test="${orderSize ge 999}">
		       	<span class="yqsz">999</span>
		       	</c:when>
		       	<c:otherwise>
			       <span class="yqsz">${orderSize}</span>
		       	</c:otherwise>
	       </c:choose>
       </c:if>
       <span class="arrowc"></span></a>
      </div>
      <div class="menu_1 box">
       <a href="<%=request.getContextPath()%>/mvc/merchant/productlistForNewOrder"> <span class="icon  icon4"></span><h3 class="flex">商品管理</h3><span class="arrowc"></span></a>
      </div>
      
     <%--  <div class="menu_1 box">
	     <a href="<%=request.getContextPath()%>/merchant/feedbacklist"> <span class="icon  icon4"></span><h3 class="flex">反馈建议</h3><span class="arrowc"></span></a>
	   </div>--%>
      <div class="menu_1 box">
       <a href="<%=request.getContextPath()%>/mvc/merchant/pass_change"> <span class="icon  icon4"></span><h3 class="flex">修改密码</h3><span class="arrowc"></span></a>
      </div>
   </div>
</div><!--content-->
	
	<footer class="foot clear">
		<div>
		    <span class="fl">
		    	<c:if test="${isLogin eq 'no'}">
		    		<a href="<%=request.getContextPath()%>/mvc/merchant/login.html">登录</a>
		    	</c:if>
		    	<c:if test="${isLogin eq 'yes'}">
					<a href="<%=request.getContextPath()%>/mvc/merchant/logoutmerchant">注销</a>
				</c:if>
		    </span>
	    </div>
	</footer>
	
</article> 
</div>
</body>
</html>