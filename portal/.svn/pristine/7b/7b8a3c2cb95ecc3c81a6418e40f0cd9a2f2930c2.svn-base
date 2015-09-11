<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/pages/merchant/common/include.jsp"%>
<%@ include file="/WEB-INF/pages/merchant/common/layout.jsp"%>
<!DOCTYPE html >
<html >
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>苏州中行-订单查询</title>
<meta name="viewport" content="width=device-width, initial-scale=1,user-scalable=no">
</head>
<script type="text/javascript">


var loadFlg = true;
$(window).scroll(function(){	//自动加载
    var totalheight = parseFloat($(window).height()) + parseFloat($(window).scrollTop());
    var obj = $("#dataover"); 
	var offset = obj.offset(); 
	var down = offset.top+obj.height();
	if(down - 60 <= totalheight){
		if(loadFlg){
			loadFlg = false;
			LoadData();
		}
    }
});


var currPage = parseInt('${pageNo}');//当前页数
function LoadData(){
	var pageCount = parseInt('${pageCount}');//总页数
	var orderId = parseInt('${orderId}');
	var expressFlag = parseInt('${expressFlag}');
	console.log(orderId);
	++currPage;
	if(currPage>pageCount){
		return;
	}
	$.post('<%=request.getContextPath()%>/merchant/moreNewOrderlist?pageNo='+currPage+'&orderId='+orderId+'&expressFlag='+expressFlag,
		{currPage : currPage}, 
		function(json) {
	   		json = eval('('+json+')');
	   		var morelistsize = parseInt(json.morelistsize);
	   		console.log(morelistsize);
	   		if(morelistsize > 0) {
	   			console.log(json.htmlCode);
	   			loadFlg = true;
	   			$("#orderdiv").append(json.htmlCode);
	   		}
	});
}

function toOrderInfo (id){
	window.location.href = '<%=request.getContextPath()%>/mvc/merchant/neworderinfo?id='+id
}
//录入物流信息
function toExpress (id){
	window.location.href = '<%=request.getContextPath()%>/merchant/toPostInfo?id='+id
}
</script>
<body>
<div class="warp">
<nav>
<div class="head_bar"><a href="<%=request.getContextPath()%>/mvc/merchant/index.do" class="back"></a><h2>订单查询</h2></div><!--head_bar-->
</nav>
<article>
<div class="content">
 	 <form action="<%=request.getContextPath()%>/mvc/merchant/newOrderlist" method="post">
	    <div class="search_area box">
			 <input name="orderId" type="text" class="text flex" placeholder="请输入订单号" value="${orderId}">
	    </div>
	    <div class="search_area box">
	    	<%-- <select name="expressFlag" style="height:32px; width:150px;">
	    	 	<option value="">全部</option>
	    	 	<option 
		     		<c:if test="${expressFlag=='1'}">selected="selected"</c:if>
	    	 	value="1" >未发货</option>
	    	 	<option 
	    	 		<c:if test="${expressFlag=='2'}">selected="selected"</c:if>
	    	 	 value="2">已发货</option>
	    	 </select>--%>
		     <input type="submit" class="button" value="查询">
	    </div>
     </form>
     <div class="info_con">
         <ul class="list_goods">
        	 <div id="orderdiv">
		         <c:if test="${orderListSize gt 0 }">
			         <c:forEach var="item" items="${orders}">
				         <li>
					         <a  class="box order" href="javascript:toOrderInfo('${item.id}');">
						         <div class="g_info1 flex text_sl">
							         <p class="text_sl">订单号：${item.code} ，订单总金额：${item.productPrice/100} 元</p>
						         </div>
					        </a>
					        
					       <%-- <c:if test="${item.isPost.value eq '1' && item.postInfo.expressStatus.value eq '1'}">
						        <p class="text_sl">已提醒发货次数：${item.postInfo.remaindTotal}</p>
						        <a  class="box order" href="javascript:toExpress('${item.postInfo.id}');" style="margin-left:10px; color:red;">录入物流信息</a>
					        </c:if>--%>
				         </li>
			         </c:forEach>
		         </c:if>
		         <c:if test="${orderListSize le 0 }">
						无订单信息
				 </c:if>
			</div>
		</ul>
	</div>
</div>
     
</div><!--content-->
</article>
<div class="footer"></div><!--<div></div>-->
<div class="clear" id="dataover"></div>
</div>

</body>
</html>
