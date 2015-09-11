<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/pages/merchant/common/include.jsp"%>
<%@ include file="/WEB-INF/pages/merchant/common/layout.jsp"%>

<!DOCTYPE html >
<html >
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>修改密码</title>
<meta name="viewport" content="width=device-width, initial-scale=1,user-scalable=no">
</head>

<body>
<div class="warp">
<nav>
<div class="head_bar"><a href="<%=request.getContextPath()%>/mvc/merchant/index.do" class="back"></a><h2>修改密码</h2></div><!--head_bar-->
</nav>
<article>
<div class="content">
     <div class="info_con1">
     <form action="<%=request.getContextPath()%>/mvc/merchant/result" method="post">
     <input type="hidden"  name="tradeId" value="passwordchangeszboc">
	     <h3>旧密码</h3>
	     <div class="s_input"><input name="old_pwd" type="password" class="text1 flex" placeholder="请输入您的原密码"></div>
	      <h3>新密码</h3>
	     <div class="s_input"><input name="new_pwd" maxlength="16" type="password" class="text1 flex" placeholder="请输入您的新密码 6-16位数字/字母"></div>
	     
	      <h3>再次密码</h3>
	     <div class="s_input"><input name="new_pwd_confirm"  maxlength="16" type="password" class="text1 flex" placeholder="请再次输入确认6-16位数字/字母"></div>
	     <div class="s_input">
	     <input type="submit" value="确认修改" class="inpbtn">
	     </div>
     </form>
     </div>

</div><!--content-->
<div class="footer"></div><!--<div></div>-->
<article>
</div>




</body>
</html>
