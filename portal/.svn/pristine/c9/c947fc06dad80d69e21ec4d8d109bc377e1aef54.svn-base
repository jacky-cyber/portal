<%@ page import="com.ifunpay.portal.ProjectXml" %>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/include.jsp"%>
<%@ include file="/WEB-INF/common/jscss.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head>
<title>我的订单</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=0" name="viewport">
	<meta content="yes" name="apple-mobile-web-app-capable">
	<meta content="black" name="apple-mobile-web-app-status-bar-style">
	<meta content="telephone=no" name="format-detection">
	<meta http-equiv="Access-Control-Allow-Origin" content="*">
</head>
	<link rel="stylesheet" href="<%=request.getContextPath()%>/css/s/scrollbar.css" type="text/css" />
    <script type="text/javascript" src="<%=request.getContextPath()%>/js/iscroll.js" charset="utf-8" ></script>
    
 <style type="text/css">
 .popUp{position:fixed; top:0px; left:0px; width:100%; height:100%; background:rgba(0,0,0,0.5); z-index:99;}
 .popUpK{ margin:0px auto; display:block; background:rgba(255,255,255,1); position:fixed; width:200px; padding:0; color:#5e5e5e; position:relative; top:20%; border-top-left-radius:8px;border-top-right-radius:8px;z-index:100;}
 .popUpCon{ margin:0 auto; width:80%; padding:30px 15px;}
 
 .tabOne{background: #f5f5f5;width: 100%;height: 40px;line-height: 40px;font-size:12px;color: #666;text-align: left; border-bottom: 1px solid #e3e3e3;padding: 0px;margin-top: 4px;display: -webkit-box;text-align: center;}
.tabOne a{color: #666;padding: 0 8px;display: block; height: 40px;-webkit-box-flex: 1;}
.tabSel{background: #ffd401; border-radius: 5px 5px 0px 0px;color: #fff;}
</style>
<script type="text/javascript">

	$(document).ready(function(){
		
		$("#checkTicket").hide();
		
		var statusDeduct_s = '${statusDeduct}';
    	var statusOrder_s = '${statusOrder}';
    	var statusDeliver_s = '${statusDeliver}';
    	
    	if(statusDeduct_s == '1' && statusOrder_s == '1'){
    		$("#condit1").attr("class","tabSel");
    	}
    	if(statusDeduct_s == '2' && statusDeliver_s == '1'){
    		$("#condit2").attr("class","tabSel");
    	}
    	if(statusDeduct_s == '2' && statusDeliver_s == '2'){
    		$("#condit3").attr("class","tabSel");
    	}
    	if(statusOrder_s == '3'){
    		$("#condit4").attr("class","tabSel");
    	}
    	
	});
	
//		var loadFlg = true;
//		$(window).scroll(function(){	//自动加载
//		    var totalheight = parseFloat($(window).height()) + parseFloat($(window).scrollTop());
//		    var obj = $("#dataover");
//			var offset = obj.offset();
//			var down = offset.top+obj.height();
//			if(down - 60 <= totalheight){
//				if(loadFlg){
//					loadFlg = false;
//					LoadData();
//				}
//		    }
//		});
        

        
        function toDetail(order_id){
        	window.location.href='<%=request.getContextPath()%>/mvc/personCore/orderDetail.html?order_id='+order_id;
        }
        
        <%--var currPage = parseInt('${currPage}');--%>
        <%--function LoadData(){--%>
        	<%--var pageCount = parseInt('${pageCount}');--%>
        	<%--++currPage;--%>
        	<%--if(currPage>pageCount){--%>
        		<%--$("#pullUp").css({"display":"none"});--%>
        		<%--return;--%>
        	<%--}--%>
        	<%----%>
        	<%--var statusDeduct = '${statusDeduct}';--%>
        	<%--var status = '${status}';--%>
        	<%----%>
        	<%--$.post('<%=request.getContextPath()%>/mallszccb/moreOrders.html', --%>
        		<%--{currPage : currPage,--%>
        		<%--flag:'szccb',--%>
        		<%--status:status,--%>
        		<%--statusDeduct:statusDeduct},--%>
				<%--function(json) {--%>
			   		<%--json = eval('('+json+')');--%>
			   		<%--var moreOrderListSize = parseInt(json.moreOrderListSize);--%>
			   		<%--if(moreOrderListSize > 0) {--%>
			   			<%--loadFlg = true;--%>
			   			<%--$("#orderdiv").append(json.htmlcode);--%>
			   		<%--}--%>
			<%--});--%>
        <%--}--%>
        <%--var  web_server_url = '<%=ProjectXml.getValue("web_server_static") %>';--%>
        function showVoucherImg(sta,urldb){
        	
        	var  url = web_server_url +"/"+urldb;
//         	var url = "http://183.62.101.197:4105/ReqVoucher.ashx?type=1&id=11710191968191510&sign=4057B93C1D38A9A4D69632458F700979";
        	
        	if(urldb.indexOf("http:")!=-1 || urldb.indexOf("https:")!=-1 ){
        		url = urldb;
        	}else if(urldb == "-1"){
        		url = "";
        	}
        	$("#imgurl").attr("src",url);
        	if(sta == '1'){
        		$("#checkTicket").hide();
        	}
        	if(sta == '2'){
        		$("#checkTicket").show();
        	}
        }
</script>
<script type="text/javascript">
	function promptdelivery(order_id){
		//Remind
    	var now = getNowFormatDate();
		
		$.post('<%=request.getContextPath()%>/consignee/post_remaind', 
        		{orderId : order_id,
				 times : now },
				function(json) {
			   		//json = eval('('+json+')');
			   		
			   		var code = json.code;
			   		if(code == "1001"){
			   			alert(code);
			   		}else if(code == "1002"){
			   			alert(code);
			   		}else{
			   			alert(code);
			   		}
			   		
			});
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
<nav>
	<div class="tab_nav tab_nav_one">
		<a onclick="window.location.href='<%=request.getContextPath()%>/mvc/personCore/myAccount.do';">
			<img src="<%=request.getContextPath()%>/client/images/return.png" width="20" height="16" class="fl"/>
		</a>
		<div class="Hide fl">我的订单</div>
    </div>
</nav>
<article>
	<div class="HideStatus">
    	<div class="order" id="orderdiv">
        	<span id="errMessage" class="mg_l_20" style="color: red;">${errorMsg}</span>
            <c:if test="${orderListSize gt 0 }">
				<c:forEach var="accOrder" items="${orderList}">
				<div class="order_muban">
                    <div class="order_top fl">

                        <ul>
                            <li class="fl" onclick="toDetail('${accOrder.id }');">订单号：<span class="hsz cur">${accOrder.code }</span><span class="hsz fr">
                            <c:if test="${accOrder.status eq 'NotConfirm'}">
								未确认
	                            <c:choose>
	                            	<c:when test="${accOrder.paymentStatus eq 'NotPay'}">未支付</c:when>
	                            </c:choose>
								<c:choose>
									<c:when test="${accOrder.paymentStatus eq 'PaySucceeded'}">已支付</c:when>
								</c:choose>
	                    	</c:if>

	                    	<c:if test="${accOrder.status eq 'Confirmed'}">
	                            <c:choose>
	                            	<c:when test="${accOrder.paymentStatus eq 'PaySucceeded'}">已支付</c:when>
	                            </c:choose>
	                    	</c:if>

	                    	<c:if test="${accOrder.status eq 'Cancelled'}">
	                    	      已过期
							</c:if>
							<c:if test="${accOrder.status eq 'Finished'}">
								已完成
							</c:if>
                            &nbsp;&nbsp;</span></li>

                            <li class="fl">
                            	下单时间：${fn:substring(accOrder.createTime,0,19)}
	                    	</li>
	                    	<li class="fl">总价：${accOrder.totalAmount/100}元
	                    		<span class="hsz fr" ><a href="javascript:void(0)" style="color: #666;"  onclick="toDetail('${accOrder.id}');">查看订单详情</a></span>
	                    	</li>
                        </ul>
                    </div>

                    <div class="clear"></div>
				</div>
				</c:forEach>
			</c:if>
			<c:if test="${orderListSize le 0 }">
				<div class="order_muban">
	                     <div class="order_top fl">
	                        <ul>
	                            <li  style="text-align:center">无订单信息</li> 
	                        </ul>
	                     </div>
                    <div class="clear"></div>
				</div>
			</c:if>
            <!--我的订单样式结束-->
    	</div>
    </div>

	<div class="popUp"  id="checkTicket"  onclick="showVoucherImg(1,'-1')">
	    <img src=""  width="200px" id="imgurl"  height="200px" class="popUpK"  />
	</div>
	<div class="clear" id="dataover"></div>
</article> 
</html>