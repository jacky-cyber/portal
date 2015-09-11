<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/include.jsp"%>
<%@ include file="/WEB-INF/common/jscss.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head>
<title>订单详情</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=0" name="viewport">
	<meta content="yes" name="apple-mobile-web-app-capable">
	<meta content="black" name="apple-mobile-web-app-status-bar-style">
	<meta content="telephone=no" name="format-detection">
	<meta http-equiv="Access-Control-Allow-Origin" content="*">
</head>
<style type="text/css">
 .popUp{position:fixed; top:0px; left:0px; width:100%; height:100%; background:rgba(0,0,0,0.5); z-index:99;}
 .popUpK{ margin:50px auto; display:block; background:rgba(255,255,255,1); position:fixed; width:200px; padding:0; color:#5e5e5e; position:relative; top:20%; border-top-left-radius:8px;border-top-right-radius:8px;z-index:100;}
 .popUpCon{ margin:0 auto; width:80%; padding:30px 15px;}
</style>
<script type="text/javascript">

$(document).ready(function(){
	
	$("#voucherImgPop").hide();
});

function showVoucherImg(sta,voucherImageUrl){
	
	if(sta == '2'){
		$("#voucherImg").attr('src','');
		$("#voucherImgPop").hide();
	}
	if(sta == '1'){
		$("#voucherImg").attr('src',voucherImageUrl);
		$("#voucherImgPop").show();
	}
}

</script>
<nav class="fixed" style=" width: 100%">
	<div class="tab_nav tab_nav_one">
		<a onclick="window.location.href='<%=request.getContextPath()%>/mvc/personCore/myOrders.do';" >
			<img src="<%=request.getContextPath()%>/client/images/return.png" width="20" height="16" class="fl"/>
		</a>
		
		<div class="Hide fl">订单详情</div>
    </div>
</nav>
<article class="mt51">
		<div class="div_a order_inf" >
			<div>
				<span class="mind_info3">主订单号：</span>
				<span class="">${orderDetail.code}</span>
			</div>
			<div class="mg_t_10">
				<span class="mind_info3">商品名称：</span>
				<span class="">${productName}</span>
			</div>
			<div></div>
			<div class="mg_t_10">
				<span class="mind_info3">下单时间：</span>
				<span class="">
					 <c:if test="${orderDetail.createTime !=null && orderDetail.createTime!=''}">
                   		${fn:substring(orderDetail.createTime,0,4)}年
                   		${fn:substring(orderDetail.createTime,5,7)}月
                   		${fn:substring(orderDetail.createTime,8,10)}日
                   		${fn:substring(orderDetail.createTime,11,19) }
                   	</c:if>
				</span>
			</div>
			<div class="mg_t_10">
				<span class="mind_info3">手&nbsp;机&nbsp;&nbsp;号：</span>
				<span class="">${phone}</span>
			</div>
			<div class="mg_t_10">
				<span class="mind_info3">总&nbsp;价&nbsp;&nbsp;格：</span>
				<span class=""><fmt:formatNumber value="${orderDetail.totalAmount/100}" pattern="#0.00#"></fmt:formatNumber>元</span>
			</div>

			<div class="mg_t_10">
				<span class="mind_info3">购买总数：</span>
				<span class="">${totals}</span>
			</div>

		</div>
		 <c:if test="${isPost}">
			<div class="div_a order_inf" style="height: ${postHight};">
<!-- 				<div class="" >收货信息</div> -->
				<div style="margin-top: 0px;">
					<span class="mind_info3">收货人：</span>
					<span class="">${postInfo.consignee}</span>
				</div>
				<div class="mind_info" >
					<span class="mind_info3">收货电话：</span>
					<span class="">${postInfo.consigneePhone}</span>
				</div>
				<div class="mind_info" >
					<span class="mind_info3">收货地址：</span>
					<span class="">${postInfo.consigneeAddress}</span>
				</div>
				<div class="mind_info" >
					<span class="mind_info3">发票抬头：</span>
 					<span class="">${postInfo.receiptRise}</span>
				</div>
				<div class="mind_info" >
					<span class="mind_info3">发货状态：</span> 
					<span class=""> 
					 <c:choose>
					 	<c:when test="${postInfo.expressStatus.value == '2'}">已发货</c:when>
					 	<c:otherwise>未发货</c:otherwise>
					 </c:choose>
					</span>
				</div>
				<c:if test="${postInfo.expressStatus.value == '2' }">
				 	<div class="mind_info" >
						<span class="mind_info3">快递公司：</span>
						<span class="">${postInfo.expressCompany}</span>
					</div>
				 	<div class="mind_info" >
						<span class="mind_info3">快递单号：</span>
						<span class="">${postInfo.expressNo}</span>
					</div>
				</c:if>
			</div>
		</c:if> 
		<div class="address fl mg_t_10" style="margin-bottom: 20px;">
             <ul>
                 <li class="ShowStatus">
                     <button type="button" class="btn_hhs cur ShowStatus" onclick="javascript:history.back(-1);">返回我的订单</button></li>
             </ul>
         </div>
	   
 	<div class="popUp"  id="voucherImgPop"  onclick="showVoucherImg('2','')">
			<div>
				<img src="" id="voucherImg" width="200px"   height="200px" class="popUpK"  />
			</div>
	</div>	 
	   
</article> 

<script type="text/javascript">
	function promptdelivery(order_id){
		//Remind
    	var now = getNowFormatDate();
		
		$.post('<%=request.getContextPath()%>/consignee/post_remaind', 
        		{orderId : order_id,
				 times : now},
				function(json) {
			   		//json = eval('('+json+')');
			   		
			   		var success = json.success;
			   		if(success == "true"){
			   			toDetail(order_id);
			   		}else{
			   			alert("提示失败.您已经超过次数或者商品已经发货中.");
			   		}
			   		
			});
	}
	function toDetail(order_id){
    	window.location.href='<%=request.getContextPath()%>/mall/orderDetail.html?order_id='+order_id;
    }
	
	function getNowFormatDate()
	{
	   var day = new Date();
	   var Year = 0;
	   var Month = 0;
	   var Day = 0;
	   var CurrentDate = "";
	   //初始化时间
	   //Year       = day.getYear();//2位年份 2008
	   Year       = day.getFullYear();//ie火狐下都可以
	   Month      = day.getMonth()+1;
	   Day        = day.getDate();
	  
	   //CurrentDate += Year + "-";
	   CurrentDate += Year;
	   if (Month >= 10 )
	   {
	    //CurrentDate += Month + "-";
		  CurrentDate += Month;
	   }
	   else
	   {
	    //CurrentDate += "0" + Month + "-";
		CurrentDate += "0" + Month;
	   }
	   if (Day >= 10 )
	   {
	    CurrentDate += Day ;
	   }
	   else
	   {
	    CurrentDate += "0" + Day ;
	   }
	   return CurrentDate;
	}
</script>

</html>