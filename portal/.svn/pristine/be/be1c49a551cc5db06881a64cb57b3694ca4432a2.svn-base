<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/include.jsp"%>
<%@ include file="/WEB-INF/common/jscss.jsp"%>
<html>
<head>
<title>我的帐户</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=0" name="viewport">
	<meta content="yes" name="apple-mobile-web-app-capable">
	<meta content="black" name="apple-mobile-web-app-status-bar-style">
	<meta content="telephone=no" name="format-detection">
	<meta http-equiv="Access-Control-Allow-Origin" content="*">
</head>
<script type="text/javascript">

$(document).ready(function(){
// 	jumpIndex();
 if('${firLogin}' == '1'){
   window.setTimeout("jumpIndex()",5000); 
 }
});

//  5s 后自动 跳转至 客户端首页
function jumpIndex(){
	
   window.location.href = "<%=request.getContextPath()%>/indexapp/clientIndexszboc.html";
}


</script>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%--<nav>--%>
	<%--<div class="tab_nav tab_nav_one">--%>
		<%--<a  onclick="window.location.href='<%=request.getContextPath()%>/mvc/personCore/tologin.do';">--%>
			<%--<img src="<%=request.getContextPath()%>/client/images/return.png" width="20" height="16" class="fl"/>--%>
		<%--</a>--%>
		<%----%>
		<%--<div class="Hide fl">我的帐户</div>--%>
    <%--</div>--%>
<%--</nav>--%>
<article> 
	<div class="div_b myacc_div" style="height: 60px;">
		<div class="title" style="line-height: 25px; font-size: 15px;">
			<span class="fl">账户信息</span> <a class="fr" onclick="window.location.href='<%=request.getContextPath()%>/mvc/personCore/loginOff.do';" >[注销]</a>
		</div>
		<div class="clear" style="text-align: center;">
			<%--<img src="<%=request.getContextPath()%>/client/images/myacc_person.jpg" width="90" height="95"/>--%>
		</div>
		<div>
			<div class="mind_div">
				<span class="t_info">手机号：</span>
				<span class="mg_l_5">
					${member}
				</span>
			</div>
		</div>
	</div>
	<div class="div_b myacc_ot_div cur" onclick="window.location.href='<%=request.getContextPath()%>/mvc/personCore/settingPassword.do';">
		设置/修改密码<img src="<%=request.getContextPath()%>/client/images/u5_normal.png" width="21" height="21" class="fr" />
	</div>
	<div class="div_b myacc_ot_div cur" onclick="window.location.href='<%=request.getContextPath()%>/mvc/personCore/changeinfo.do';">
		收货地址<img src="<%=request.getContextPath()%>/client/images/u5_normal.png" width="21" height="21" class="fr" />
	</div>
	<div class="div_b myacc_ot_div cur" onclick="window.location.href='<%=request.getContextPath()%>/mvc/personCore/myOrders.do';">
		我的订单<img src="<%=request.getContextPath()%>/client/images/u5_normal.png" width="21" height="21" class="fr" />
	</div>
	
	<%--<div class="div_b myacc_ot_div cur" onclick="window.location.href='<%=request.getContextPath()%>/client/cart-list';">--%>
		<%--我的购物车<img src="<%=request.getContextPath()%>/client/images/u5_normal.png" width="21" height="21" class="fr" />--%>
	<%--</div>--%>
	<%----%>
	<%--<div class="div_b myacc_ot_div cur" onclick="window.location.href='<%=request.getContextPath()%>/mall/myFeedbacks.html?currPage=1';">--%>
		<%--反馈建议<img src="<%=request.getContextPath()%>/client/images/u5_normal.png" width="21" height="21" class="fr" />--%>
	<%--</div>--%>
	
</article> 
</html>