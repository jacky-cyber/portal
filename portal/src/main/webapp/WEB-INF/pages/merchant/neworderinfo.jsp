<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/pages/merchant/common/include.jsp"%>
<%@ include file="/WEB-INF/pages/merchant/common/layout.jsp"%>
<!DOCTYPE html >
<html >
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>苏州中行-订单详情</title>
<meta name="viewport" content="width=device-width, initial-scale=1,user-scalable=no">
</head>

<body>
<div class="warp"><div class="warp">
<nav>
<div class="head_bar"><a href="javascript:history.back(-1)" class="back"></a><h2>订单信息</h2></div><!--head_bar-->
</nav>
<article>
<div class="content">

					<div class="info_con">
						<ul class="sh_info">
							<li><span>订单号：</span> ${order.code }</li>
							<li><span>商户名称：</span> ${commerce.name}</li>
							<li><span>商户联系电话：</span> ${commerce.mobilePhone}</li>
							<li><span>商户地址：</span>${commerce.address}</li>
							<li><span>用户手机：</span> ${order.member.mobile }</li>
							<li><span>商品名称：</span>${order.product.name }</li>
							<li><span>商品购买原价： </span><em class="ft18 orange bold">￥ 
									${order.productPrice/100} 元
							</em></li>
							<li><span>商品总价：</span><em class="ft18 orange bold">￥
								 ${order.productPrice/100 } 元</em>

                            <li><span>支付状态： </span>
                                <c:if test="${order.status == '1' }">未支付</c:if>
                                <c:if test="${order.status == '2' }">支付成功</c:if>
                                <c:if test="${order.status == '3' }">退款成功</c:if>
                            </li>





                        <%--	<c:if test="${order.isPost.value == '1' }">
                                    <li><span>邮费： </span><em class="ft18 orange bold">￥${order.postInfo.postage }</em></li>
                                    <li><span>收件人姓名：</span>${order.postInfo.consignee }</li>
                                    <li><span>收件人地址： </span>${order.postInfo.consigneeAddress }</li>
                                    <li><span>收件人电话： </span>${order.postInfo.consigneePhone }</li>
                                    <li><span> 发状态货： </span>
                                        ${order.postInfo.expressStatus.text}
                                    </li>
                                    <li><span> 发货时间： </span>${order.postInfo.expressTime}</li>
                                </c:if>--%>
						</ul>
					</div>

				</div><!--content-->
</article>
<div class="footer"></div><!--<div></div>-->
</div>


</body>
</html>
