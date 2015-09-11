<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/include.jsp"%>
<!DOCTYPE html PUBLIC "-//WAPFORUM//DTD XHTML Mobile 1.0//EN" "http://www.wapforum.org/DTD/xhtml-mobile10.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<head>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/s/c_layout.css" type="text/css"></link>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/s/c_client.css" type="text/css"></link>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/s/c_public.css" type="text/css"></link>
    <link href="<%=request.getContextPath()%>/css/reset-min.css" rel="stylesheet" type="text/css"></link>
    <link href="<%=request.getContextPath()%>/css/main.css" rel="stylesheet" type="text/css"></link>

</head>
<body>
<nav>
<div class="tab_nav tab_nav_one">
	<div class="Hide">支付结果</div>
    </div>
    </nav>
	<div class="product_in error">
        订单${orderId}不存在
	</div>
<script type="text/javascript" src="<%=request.getContextPath()%>/client/js/jquery-1.8.0.js" charset="utf-8"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/client/js/jquery-1.8.0.min.js" charset="utf-8"></script>
<script>
	var regMoblie = /^1\d{10}$/;

	var count = 60 ;

	$("input[name='fillMobile']").click(function(){
		$("#showMobile").show();
		$("input[name='fillMobile']").attr("disabled",true);
	});

	$("input[name='confirm']").click(function(){
		var flag = true;

		var code ='${voucherCode}';
		var mobile =$("input[name='mobile']").val();
		var orderId ='${orderId}';
		var url = '<%=request.getContextPath()%>/client/sendVoucher';

		if(mobile == ''){
			$("#errMsg").html('提示:手机号码不能为空！');
			flag = false;
			return;
		}

		if (!regMoblie.test(mobile)) {
			$("#errMsg").html('提示：请输入正确的手机号码！');
			flag = false;
			return;
		}

		if(flag){
			$.ajax({
						type:'POST',
						url:url,
						data:{voucherCode:code,mobile:mobile,orderId:orderId},
						success:function(data){
							countDown(count);
							$("input[name='confirm']").attr("disabled",false);
							$("input[name='mobile']").val("");
							$("#errMsg").html('');
							$("input[name='fillMobile']").attr("disabled",false);
							$("#showMobile").hide();
						},
						dataType:'text'
					}
			);
		}
	});

	function countDown(secs){

		var resetSend = document.getElementById("confirm");
		resetSend.text=""+secs+"秒";
		resetSend.value= resetSend.text;
		if(--secs>0){
			setTimeout("countDown("+secs+")",1000);
			resetSend.disabled ="disabled";
		}else{
			resetSend.text = "重新发送";
			resetSend.value= resetSend.text;
			resetSend.disabled =false;
		}
	}
</script>
</body>
</html>