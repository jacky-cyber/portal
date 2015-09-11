<%@page import="java.net.URLEncoder"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/pages/merchant/common/include.jsp"%>
<%@ include file="/WEB-INF/pages/merchant/common/layout.jsp"%>
<!DOCTYPE html >
<html >
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>苏州中行-凭证验证</title>
<meta name="viewport" content="width=device-width, initial-scale=1,user-scalable=no">
</head>

<body>
<div class="warp">
<nav>
<div class="head_bar"><a href="<%=request.getContextPath()%>/mvc/merchant/index.do" class="back"></a><h2>凭证验证</h2></div><!--head_bar-->
</nav>
<article>
<div class="content">
   
   <div class="con_w">
      <div class="menu_1 box">
       <a href="<%=request.getContextPath()%>/mvc/merchant/yz_input.html"> <span class="icon  icon5"></span><h3 class="flex">输入凭证号验证</h3><span class="arrowc"></span></a>
      </div>
      <div class="menu_1 box">
       <a href="mopon://?action=scan&callback=<%=URLEncoder.encode(basePath+"merchant/yz_result?voucher_value=", "UTF-8") %>"> <span class="icon  icon6"></span><h3 class="flex">扫描二维码验证</h3><span class="arrowc"></span></a>
      </div>
   </div>

</div><!--content-->
<div class="footer"></div><!--<div></div>-->
</article>
</div>
</body>
</html>
