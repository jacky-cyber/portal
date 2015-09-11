<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/common/include.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>金融云平台</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=0"
          name="viewport">
    <meta content="yes" name="apple-mobile-web-app-capable">
    <meta content="black" name="apple-mobile-web-app-status-bar-style">
    <meta content="telephone=no" name="format-detection">
    <meta http-equiv="Access-Control-Allow-Origin" content="*">
</head>
    <%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<style>
    .quantity {
        border: 1px solid #cfcbc5;
        height: 30px;
        width: 40px;
        text-align: center;
        font-size: 14px;
        color: #a0a1a1;
    }
</style>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/s/c_client.css" type="text/css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/s/c_layout.css" type="text/css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/s/c_public.css" type="text/css">
<script type="text/javascript" src="<%=request.getContextPath()%>/client/js/jquery-1.4.4.min.js"
        charset="utf-8"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/client/js/jquery.gototop.js" charset="utf-8"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/iscroll.js" charset="utf-8"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/res/common/js/city.js" charset="utf-8"></script>
<script type="text/javascript">

    function submitOrder() {
        var regMoblie = /^1[34578]\d{9}$/;

        var is_post = '0';
        var is_vip = $(":hidden[name=is_vip]").val();

        if (is_post == '0') {

        } else if (is_post == '1') {
            var mobile = $("input[name=consignee_phone]").val();
            if ($("input[name=consignee]").val() == "") {
                $("#errMessage").text("请填写收货人信息");
                return;
            }
            if (mobile == "") {
                $("#errMessage").text("请填写手机号码");
                return;
            }
            if (!regMoblie.test(mobile)) {
                $("#errMessage").text("请输入正确的手机号码");
                return;
            }
            if ($("input[name=consignee_address]").val() == "") {
                $("#errMessage").text("请填写详细地址");
                return;
            }

            var zip_t = /^[1-9][0-9]{5}$/;
            var consignee_zip = $("input[name=consignee_zip]").val();
            if (consignee_zip == "") {
                $("#errMessage").text("请填写邮政编号");
                return;
            }

        } else {
            return;
        }
        $("#orderform").submit();
    }

    function ReduceCount(elem) {
        var currElem = $(elem).next("input[name=quantity]");
        var count = parseInt(currElem.val());
        if (count > 1) {
            count--;
        }
        currElem.val(count);
        calcPrice(count);
    }

    function addCount(elem) {
        var currElem = $(elem).prev("input[name=quantity]");
        var count = parseInt(currElem.val());
        if (count >= 10) {
            alert("max number is 10")
            return;
        }
        count++;
        currElem.val(count);
        calcPrice(count);
    }

    //计算每条记录价格
    function calcPrice(count) {
        var currPrice = parseFloat('${product.scanningPrice}');
        var calcPrice = parseFloat(currPrice * count).toFixed(2);
        $("#total_price_1").text(calcPrice + "元");
    }

</script>
<body>
<html>

<nav>
    <div class="tab_nav tab_nav_one">
        <a href="javascript:history.back(-1);">
            <img src="<%=request.getContextPath()%>/client/images/return.png" width="20" height="16" class="fl"/>
        </a>

        <div class="Hide fl">订单确认</div>
    </div>
</nav>

<article>
    <form name="orderform" id="orderform" class="orderform" method="post"
          action="<%=request.getContextPath()%>/mvc/mall/generalbuy-ashot">
        <input type="hidden" name="apId" id="apId" value="${product.id}"/>
        <input type="hidden" name="isPost" value="${isPost}"/>
        <input type="hidden" name="flag" value="${flag}"/>
        <input type="hidden" name="terminalId" value="${terminalId}"/>
        <input type="hidden" name="needLogin" value="${needLogin}"/>
        <input type="hidden" name="serialNo" value="${serialNo}"/>

        <c:if test="${isPost == '0'}">
            <div class="div_a order_inf" style="height: 90px; font-size: 15px;">
                <div>商品名称：
					<span class="mg_l_20">

					<input type="hidden" name="mobile" value="${product.name}" class="inp_text"/>
					${product.name}
					</span>
                </div>
                <div class="mind_info mg_t_30">商品单价：
					<span class="mg_l_10 hsz"><fmt:formatNumber value="${product.scanningPrice}"
                                                                type="currency" pattern="#.##" minFractionDigits="2"/>元
					</span>
                </div>
                <input type="hidden" name="quantity" class="quantity" value="1" readonly="readonly">
                <div class="mg_t_10">
                    支付金额：
					<span id="total_price_1" class="mg_l_10 hsz f20">
						<fmt:formatNumber value="${product.scanningPrice}" type="currency" pattern="#.##"
                                          minFractionDigits="2"/>元
					</span>
                </div>
            </div>
        </c:if>
        <c:if test="${isPost == '1'}">
            <div class="div_a order_inf" style="height: 150px;font-size: 17px;">
                <div>商品名称：
					<span class="mg_l_20">
					<input type="hidden" name="mobile" value="${product.name}" class="inp_text"/>
					${product.name}
					</span>
                </div>
                <div class="mind_info mg_t_15">商品单价：
					<span class="mg_l_10 hsz"><fmt:formatNumber value="${product.scanningPrice}"
                                                                type="currency" pattern="#.##" minFractionDigits="2"/>元
					</span>
                </div>
                <div class="mind_info ">
                    购买数量：
					<span class="mg_l_10">
						<a href="javascript:void(0)" onclick="ReduceCount(this)" class="minus">-</a>
						<input type="text" name="quantity" class="quantity" value="1" readonly="readonly">
						<a href="javascript:void(0)" onclick="addCount(this)" class="plus">+</a>
					</span>
                </div>
                <div class="mg_t_10">
                    支付金额：
					<span id="total_price_1" class="mg_l_10 hsz f20">
						<fmt:formatNumber value="${product.scanningPrice}" type="currency" pattern="#.##"
                                          minFractionDigits="2"/>元
					</span>
                </div>
            </div>
            <div class="div_a order_inf" style="height: 280px;">
                <div class="huisz title_mind" style="font-size: 18px;">收货地址

                </div>
                <div class="mg_t_15">
                    <span class="mind_info3" style="font-size: 18px;">收货人：</span>
                    <span class="mg_l_10"><input type="text" name="consignee" value="${user.username}"
                                                 class="inp_text"/></span>
                </div>
                <div class="mind_info">
                    <span class="mind_info3" style="font-size: 18px;">手机号：</span>
                    <span class="mg_l_10"><input type="Tel" maxLength="11" name="consignee_phone" value="${user.mobile}"
                                                 class="inp_text"/></span>
                </div>

                <div class="mind_info">
                    <span class="mind_info3" style="font-size: 18px;">省&nbsp;&nbsp;&nbsp;份：</span>
					<span class="mg_l_10">
							<select onchange="initcity();" name="pro" id="pro" class="inp_text">
                                <SCRIPT>creatprovince();</SCRIPT>
                            </select>
					</span>
                </div>


                <div class="mind_info">
                    <span class="mind_info3" style="font-size: 18px;">城&nbsp;&nbsp;&nbsp;市：</span>
					<span class="mg_l_10">
							<select name="city" class="inp_text" id="city">
                                <option value="">选择城市</option>
                            </select>
					</span>
                </div>

                <div class="mind_info">
                    <span class="mind_info3" style="font-size: 16px;">详细地址：</span>
                    <span class="mg_l_10"><input type="text" name="consignee_address" value="" class="inp_text"/></span>
                    </span>
                </div>
                <br>
                <span id="errMessage" style="color: red;font-size: 16px;">${errorMsg}</span>
            </div>
        </c:if>
        <div class="mg_t_10 login_zhuce" style="position:relative; ">
            <div style="position:absolute;width: 130px; margin-top: 7px;" id="srswDiv">
                <input type="hidden" name="is_vip"
                       <c:if test="${userCcb.operators eq '1'}">value="1"</c:if>
                       <c:if test="${userCcb.operators ne '1'}">value="0"</c:if>
                        />
            </div>

            <div class="login_zhuce" id="confirmDiv">
                <button class="btn_hhs cur" onclick="submitOrder();return false;">确认订单</button>
                <br>
                客服电话:${servicePhone}
            </div>
        </div>

    </form>
</article>


</html>
</body>