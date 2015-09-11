<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/pages/merchant/common/include.jsp"%>
<%@ include file="/WEB-INF/pages/merchant/common/layout.jsp"%>
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>苏州中行</title>
<meta name="viewport" content="width=device-width, initial-scale=1,user-scalable=no">
</head>

<body>
<div class="warp">
<nav><!-- <img src="${ctx}/client/images/return.png" width="20" height="16" class="fl"/> -->
<div class="head_bar"><a href="<%=request.getContextPath()%>/mvc/merchant/index.do" class="back"></a><h2>操作结果</h2></div><!--head_bar-->
</nav>
<article>
<div class="content">
   
     <div class="info_con">
      <br>
       ${result}
       <br>
       <br>
     </div>
</div><!--content-->
</article>
<div class="footer"></div><!--<div></div>-->
</div>

</body>
</html>
