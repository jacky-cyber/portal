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
<style type="text/css">
	.h4{
		font-size:14px;
	}
	.float{
		float:left;
	}
	.left{
		margin-left:10.5%;
		margin-top:15px;
	}
	.left1{
		margin-left:12px;
		margin-top:26px;
	}
	.font{
		font-family:"微软雅黑", Arial;
		color:#56a319;
		font-size:24px;
	}
	.mallxian{
		width:100%;;
		margin:0 auto;
		height:1px;
		background-color:#CCC;
		margin-top:8px;
	}
	.fontnoe{
		font-family:"微软雅黑", Arial;
		margin-left:10%;
		margin-top:15px;
		font-size:15px;
	}
	.yb{
		color:#56a319;
	}
	.margin{margin-top:30px;
		font-weight:bold;
		color:#56a319;
	}

</style>
</head>
<body style="background-color:#f8f9fa;">
<div style="background-color:#fff; width:100%; height:220px; margin-left:-10px; margin-top:-10px; ">
			<div>
				<div>
					<c:choose>
					<c:when test="${payStatus=='PaySucceeded'}">
					<div style="height:10px;"></div>
					<div class="fontnoe margin">
						订单已支付成功！
					</div>
					<div class="fontnoe float">订单号：${orderId}</div>
					<div class="fontnoe float">提示：你购买的<span class="yb">&nbsp;${productName}&nbsp;</span>已付款成功！
						<c:if test="${proType==1}">
						请从体验机下方取货口取货。
						</c:if>
					</div>
					<div class="fontnoe float">客服电话：400-881-6633</div>
					<div class="mallxian"></div>
					<div style="height:15px;"></div>
					</c:when>
					<c:otherwise>
						<div style="height:10px;"></div>
						<div class="fontnoe margin">
							订单支付失败！
						</div>
						<div class="fontnoe float">订单号：${orderId}</div>
						<div class="fontnoe float">提示：你购买的<span class="yb">&nbsp;${productName}&nbsp;</span>支付失败！
						</div>
						<div class="fontnoe float">客服电话：400-881-6633</div>
						<div class="mallxian"></div>
						<div style="height:15px;"></div>
					</c:otherwise>
					</c:choose>
				</div>
	</div>
	</div>
</body>
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