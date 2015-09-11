<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/pages/merchant/common/include.jsp"%>
<%@ include file="/WEB-INF/pages/merchant/common/layout.jsp"%>
<!DOCTYPE html >
<html >
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>商品查询</title>
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


var currPage = parseInt('${currPage}');
function LoadData(){
	var pageCount = parseInt('${pageCount}');
	++currPage;
	if(currPage>pageCount){
		return;
	}
	$.post('<%=request.getContextPath()%>/merchant/moreProductForNew',
		{currPage : currPage}, 
		function(json) {
			json = eval('('+json+')');
	   		var moreListSize = parseInt(json.moreListSize);
	   		if(moreListSize > 0) {
	   			loadFlg = true;
	   			$("#productdiv").append(json.htmlCode);
	   		}
	});
}

function toProductinfo (apId){
	window.location.href = '<%=request.getContextPath()%>/mvc/merchant/productinfo?id='+apId;
}

</script>
<body>
<div class="warp">
<nav>
<div class="head_bar"><a href="<%=request.getContextPath()%>/mvc/merchant/index.do" class="back"></a><h2>商品查询</h2></div><!--head_bar-->
</nav>
<article>
<div class="content">

	    <form action="<%=request.getContextPath()%>/mvc/merchant/productlistForNewOrder" method="post">
		    <div class="search_area box">
				    <input name="id" type="text" class="text flex" placeholder="请输入商品ID" >
				    <input name="commerceId" type="hidden" value="${commerceId}"/>
				    <input type="submit" class="button" value="查询">
		    </div>
	    </form>
     <div class="info_con">
         <ul class="list_goods" id="productdiv">
        	 <c:if test="${productListSize gt 0 }">
		          <c:forEach var="item" items="${products}">
			         <li>
				         <a  class="box" href="javascript:toProductinfo('${item.id}');" >
				         <div class="flex text_sl">
				         <p class="text_sl">商品ID：${item.id}</p>
				         <p class="text_sl">商品名称：${item.name}</p>
				         <p class="text_sl">销售数：${item.saleCount}</p>
				         <p class="text_sl">库存剩余数：${item.stockCount}</p>
                         <p class="text_sl">有效期：${fn:substring(item.createTime,0,19)} ~${fn:substring(item.expireTime,0,19)} </p>
				         </div>
				        <%-- <span class="arrowc1"></span>
				            <img src="${item.imgPath}" class="pic" >--%>
				        </a>
			         </li>
		         </c:forEach>
	         </c:if>
	          <c:if test="${productListSize le 0 }">
						无商品信息
			</c:if>
		</ul>
     </div>
</div><!--content-->
</article> 
<div class="footer"></div><!--<div></div>-->
<div class="clear" id="dataover"></div>
</div>

</body>
</html>
