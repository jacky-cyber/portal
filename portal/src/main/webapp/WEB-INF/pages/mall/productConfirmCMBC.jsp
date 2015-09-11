<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.ifunpay.portal.ProjectXml" %>
<%@ include file="/WEB-INF/common/include.jsp"%>
<!DOCTYPE html>
<html>
<head>
    <title>金融云平台</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=0" name="viewport">
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
    .table-c table{border-right: 1px solid #dcdcdc;border-bottom:1px solid #dcdcdc}
    .table-c table td{border-left: 1px solid #dcdcdc;border-top:1px solid #dcdcdc}
    .shortselect {
        background: #fafdfe;
        height: 28px;
        width: 180px;
        line-height: 28px;
        border: 1px solid #9bc0dd;
        -moz-border-radius: 2px;
        -webkit-border-radius: 2px;
        border-radius: 2px;
    }
    .quantity{
        border: 1px solid #cfcbc5;
        margin-top: 0px;
        height: 25px;
        width: 36px;
        text-align: center;
        font-size: 14px;
        color: #a0a1a1;
    }
    table{
        color:#808080;
    }
    table tr{
        height: 40px;;
    }

    .select { width:185px; height:27px; background:none; border:none;
    }
    #sleHid { display:block; width:171px;height: 27px; overflow:hidden;
        background:url("<%=request.getContextPath()%>/images/arrowCMBC.png");
    }
    #sleBG  {
        width:185px;
        height:26px;
        border:#61AC36 0px solid;
        border-right:none;
        background:url("<%=request.getContextPath()%>/images/arrowCMBC.png") no-repeat 62px 1px;
        display:block;
    }
</style>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/s/c_client.css" type="text/css"></link>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/s/c_layout.css" type="text/css"></link>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/s/c_public.css" type="text/css"></link>
<script type="text/javascript" src="<%=request.getContextPath()%>/client/js/jquery-1.4.4.min.js" charset="utf-8"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/client/js/jquery.gototop.js" charset="utf-8"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/iscroll.js" charset="utf-8"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/res/common/js/city.js" charset="utf-8"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/cmbcForClient.js"></script>
<script type="text/javascript">
    var title = { "title" : "订单确认","leftButton" : {"exist" : "true","func" : "goBack()"}};
    setTitleBar(title);
    var canBuy = true; //是否可以购买
    var sign_hui = "";
    $(function() {
        var is_post = 0;
        // 扫描码图  无善融会员  add20140320
        if(sign_hui != '5'){
            $("#srswDiv").hide();
            $("#confirmDiv").attr("style","");
        }

        if(is_post==1){
            showAreaLevel2();
        }
        $("#quantity").val(1);
    });
    function changeQuantity(){
        canBuy = true;
        changePrice();
        $('#ajaxErrorMsg').html('&nbsp;');
        var quantity = document.getElementById('quantity').value;
        var product_id = document.getElementById('product_id').value;
        var url="<%=request.getContextPath()%>/tuan/orderPay.html";
        ajax_post(url, {'tradeId':'webValidateBuy','product_id':product_id, 'quantity':quantity },
                function(responseText){
                    var  obj = eval('('+responseText+')');
                    if(obj.code !="0000"){
                        $('#ajaxErrorMsg').html(obj.msg);
                        canBuy = false;
                    }
                }
        );
    }
    function changePrice(){
        var amount = getTotalAmount();
        document.getElementById('total_price_1').innerHTML = amount.toFixed(2)+'元';
    }
    function getTotalAmount(){
        var price = parseFloat('${product.price}');
        var quantity = document.getElementById('quantity').value;
        quantity = parseInt(quantity);
        $("#quantity_str").text(quantity);
        return Math.round(price * quantity * 100) / 100;
    }

    function submitOrder(){
        var regMoblie = /^(13[0-9]|15[0-9]|18[0-9]|14[0-9]||17[0-9])\d{8}$/;
        var is_post = '${prodType}';
        var is_vip = $(":hidden[name=is_vip]").val();
        console.log(is_vip+"=======");
        // 扫描码图  无善融会员 add20140320
        /*if(sign_hui =='5'){
         if(is_vip != '1'){ //如果是善融商务电子券
         *//*var user_name_sr = '${userCcb.userName}';
         if(user_name_sr==""){
         $("#errMessage").text("您尚未绑定善融商务会员信息，请先到个人中心完成绑定。");
         return;
         }*//*

         $("#errMessage").text("您尚未绑定善融商务会员信息，请到个人中心完成绑定。");
         return;

         }
         }*/
        if(is_post == '2'){
            /*var mobile = $("input[name=mobile]").val();
             if(mobile==""){
             $("#errMessage").text("请填写手机号码");
             return;
             }
             if (!regMoblie.test(mobile)) {
             $("#errMessage").text("请输入正确的手机号码");
             return;
             }*/
        }else if(is_post == '3'){
            var mobile = $("input[name=consignee_phone]").val();
            if($("input[name=consignee]").val()=="" || $("input[name=consignee]").val()=="请输入收货人"){
                $("#errMessage").text("请填写收货人信息");
                return;
            }
            if(mobile==""){
                $("#errMessage").text("请填写手机号码");
                return;
            }
            if (!regMoblie.test(mobile)) {
                $("#errMessage").text("请输入正确的手机号码");
                return;
            }
            var pro = $("select[name=pro]").val();
            var city = $("select[name=city]").val();

            if(pro ==""){
                $("#errMessage").text("请选择省份");
                return;
            }
            if(city ==""){
                $("#errMessage").text("请选择城市");
                return;
            }

            if($("input[name=consignee_address]").val()==""||$("input[name=consignee_address]").val()=="请输入详细地址"){
                $("#errMessage").text("请填写详细地址");
                return;
            }

            var zip_t =  /^[1-9][0-9]{5}$/;
            var consignee_zip = $("input[name=consignee_zip]").val();
            if(consignee_zip==""){
                $("#errMessage").text("请填写邮政编号");
                return;
            }
            /*if(!zip_t.test(consignee_zip)){
             $("#errMessage").text("请填写正确的邮政编号");
             return;
             }*/

        }
        $("#orderform").submit();
    }

    function ReduceCount(elem){
        //var currElem = $(elem).next("input[name=quantity]");
        var currElem = $("input[name='quantity']");
        var count = parseInt(currElem.val());
        if(count>1){
            count--;
        }
        currElem.val(count);
        calcPrice(count);
        if(count<=1){
            $("#subtraction").css('color','#808080');
        }
        if(count>1){
            $("#add").css('color','#449aec');
            return;
        }
    }

    function addCount(elem){
        //var currElem = $(elem).prev("input[name=quantity]");
        var currElem = $("input[name='quantity']");
        var count = parseInt(currElem.val());
        if(count>=10){
            //alert("max number is 10");
            return;
        }
        count++;
        currElem.val(count);
        calcPrice(count);
        if(count>1){
            $("#subtraction").css('color','#449aec');
        }
        if(count>9){
            $("#add").css('color','#808080');
            return;
        }
    }

    //计算每条记录价格
    function calcPrice(count){
        var currPrice = parseFloat('${product.price}');
        var calcPrice = parseFloat(currPrice * count).toFixed(2);
        $("#total_price_1").text(calcPrice+"元");
    }
    /*
     function changeIsVip(){
     var checked = $("#isVip").attr("checked");
     if(checked){
     $(":hidden[name=is_vip]").val("1");
     }else{
     $(":hidden[name=is_vip]").val("0");
     }
     }
     */
</script>
<nav>
</nav>
<article>
    <form name="orderform" id="orderform" class="orderform" method="post"  action="<%=request.getContextPath()%>/mvc/mall/generalbuy-ashot" >
        <input type="hidden" name="apId" id="apId" value="${product.id}"/>
        <input type="hidden" name="isPost"  value="${isPost}"/>
        <input type="hidden" name="token" value ="<%=session.getAttribute("token") %>" />
        <c:if test="${prodType == 1 || prodType == 2 || prodType == 4}">
            <div style="margin: 0px auto;width:300px;">
                <span style="float: left;font-size: 18px; line-height: 40px;color: #608fbd;">订单信息</span>
            </div>
            <div style="margin: 0px auto;width: 300px;">
                <table style="border:1px solid gainsboro;width: 300px; font-size: 18px;background-color: white; "cellspacing=0 frame="hsides" rules="rows" cellpadding=0>

                    <tr>
                        <td style="width: 115px">&nbsp;商品名称：</td>
                        <td>${product.name}</td>
                    </tr>

                    <tr>
                        <td style="width: 115px">&nbsp;商品单价：</td>
                        <td style="color: red;"><fmt:formatNumber value="${product.price}"
                                                                  type="currency" pattern="#.##"  minFractionDigits="2" />元</td>
                    </tr>
                    <tr style="display: none;">
                        <td style="width: 115px">&nbsp;购买数量：</td>
                        <td>
                            <table border="1 solid white" cellpadding="0" cellspacing="0" style="border-collapse:collapse;border-color:gainsboro">
                                <tr style="height: 35px;">
                                    <td width="35px;"><a href="javascript:void(0)" onclick="ReduceCount(this)" id ="subtraction" class="minus" style="width:35px;margin-top: 5px;margin-right:-7px;color:#808080;border: 0px;background: none;">-</a></td>
                                    <td width="35px;"><input type="text" name="quantity" class="quantity" value="1" readonly="readonly" style="height: 30px;border: 0px;" /></td>
                                    <td width="35px;"><a href="javascript:void(0)" onclick="addCount(this)" class="plus" id="add" style="margin-top: 7px;margin-left:0px; color:#449aec;border: 0px;background: none;" >+</a></td>
                                </tr>
                            </table>
                        </td>
                    </tr>

                    <tr>
                        <td  style="width: 115px">&nbsp;支付金额：</td>
                        <td style="color: red;">
                            <%--<fmt:formatNumber value="${activityProduct.scanPayPrice}" type="currency" pattern="#.##"  minFractionDigits="2" />元--%>
                            <span id="total_price_1">${product.price}元</span>
                        </td>
                    </tr>

                </table>
                </br>
                <button class="btn_hhs_cmbc cur" onclick="submitOrder();return false;">确认订单</button>
            </div>

            </div>

            <div class="mg_t_10 login_zhuce" style="position:relative; " >
                <div style="position:absolute;width: 130px; margin-top: 7px;" id="srswDiv">
                    <input type="hidden" name="is_vip"
                    <c:if test="${userCcb.operators eq '1'}">value="1"</c:if>
                    <c:if test="${userCcb.operators ne '1'}">value="0"</c:if>
                    />
                </div>
                客服电话:<%=ProjectXml.getValue("service-phone")%>
            </div>
        </c:if>
        <c:if test="${prodType == 3}">
            <div style="margin: 0px auto;width:300px;">
                <span style="float: left;font-size: 18px; line-height: 40px;color: #608fbd;">订单信息</span>
            </div>
            <div style="margin: 0px auto;width: 300px;">
                <table style="border:1px solid gainsboro; width:300px; font-size: 18px;background-color: white; "cellspacing=0 frame="hsides" rules="rows" cellpadding=0>

                    <tr>
                        <td style="width: 115px">&nbsp;商品名称：</td>
                        <td>${product.name}</td>
                    </tr>

                    <tr>
                        <td style="width: 115px">&nbsp;商品单价：</td>
                        <td style="color: red;"><fmt:formatNumber value="${product.price}"
                                                                  type="currency" pattern="#.##"  minFractionDigits="2" />元</td>
                    </tr>

                    <tr style="height: 47px;">
                        <td style="width: 115px;">&nbsp;购买数量：</td>
                        <td>
                            <div class="table-c">
                                <table border="0" cellpadding="0" cellspacing="0">
                                    <tr style="height: 33px;">
                                        <td width="35px;"><a href="javascript:void(0)" onclick="ReduceCount(this)" id ="subtraction" class="minus" style="width:35px;margin-top: 5px;margin-right:-7px;color:#808080;border: 0px;background: none;">-</a></td>
                                        <td width="35px;"><input type="text" name="quantity" class="quantity" value="1" readonly="readonly" style="height: 30px;border: 0px;background: none;" /></td>
                                        <td width="35px;"><a href="javascript:void(0)" onclick="addCount(this)" class="plus" id="add" style="margin-top: 7px;margin-left:0px; color:#449aec;border: 0px;background: none;" >+</a></td>
                                        <%--<td>1</td>
                                            <td>2</td>
                                            <td>3</td>--%>
                                    </tr>
                                </table>
                            </div>
                        </td>
                    </tr>


                    <tr>
                        <td  style="width: 115px">&nbsp;支付金额：</td>
                        <td style="color: red;">
                            <%--<fmt:formatNumber value="${activityProduct.scanPayPrice}" type="currency" pattern="#.##"  minFractionDigits="2" />元--%>
                            <span id="total_price_1">${product.price}元</span>
                        </td>
                    </tr>

                </table>
            </div>
            <div style="margin: 0px auto;width: 300px;">
                <span style="float: left; line-height: 40px;color: #608fbd;font-size: 18px;">收货地址</span>
            </div>
            <div style="margin: 0px auto;width: 300px;">
                <table style="border:1px solid gainsboro;font-size: 18px;background-color: white;"  cellspacing=0 frame="hsides" rules="rows" cellpadding=0>

                    <tr>
                        <td style="width: 115px">&nbsp;收货人：</td>
                        <td><input onclick="clearContext(this.name);" type="text" name="consignee" value="请输入收货人" style="border-style: solid; border-width: 0;width: 185px;height: 26px;font-size: 16px;color: #808080;" /></td>
                    </tr>

                    <tr>
                        <td style="width: 115px">&nbsp;手机号：</td>
                        <td><input onclick="clearContext(this.name);" type="Tel" maxLength = "11" name="consignee_phone" value="请输入手机号码" style="border-style: solid; border-width: 0;width: 185px;height: 26px;font-size: 16px;color: #808080;" /></td>
                    </tr>

                    <tr>
                        <td style="width: 115px">&nbsp;省&nbsp;&nbsp;&nbsp;份：</td>
                        <td>
                    <span id="sleBG">
                        <div id="sleHid">
                            <select onchange="initcity();" class="select" name="pro" id="pro" style="font-size: 16px;color: #808080;"  >
                                <SCRIPT>creatprovince();</SCRIPT>
                            </select>
                        </div>
                    </span>
                        </td>
                    </tr>


                    <tr>
                        <td style="width: 115px">&nbsp;城&nbsp;&nbsp;&nbsp;市：</td>
                        <td>
                    <span id="sleBG">
                        <span id="sleHid">
                            <select name="city" class="select" id="city" style="font-size: 16px;color: #808080;" >
                                <option value="">&nbsp;选择城市</option>
                            </select>
                            </span>
                        </span>
                        </td>
                    </tr>

                    <tr>
                        <td style="width: 115px">&nbsp;详细地址：</td>
                        <td>
                            <input type="text" onclick="clearContext(this.name);" name="consignee_address" value="请输入详细地址" style="border-style: solid; border-width: 0;width: 185px;height: 26px;font-size: 16px;color: #808080;"  />
                        </td>
                    </tr>

                </table>
                <div style="width: 300px;text-align: center;">
                    <span id="errMessage" style="color: red;font-size: 16px;line-height: 28px;">&nbsp;${errorMsg}</span>
                </div>
                <button class="btn_hhs_cmbc cur" onclick="submitOrder();return false;">确认订单</button>
            </div>

            <div class="mg_t_10 login_zhuce" style="position:relative; " >
                <div style="position:absolute;width: 130px; margin-top: 7px;" id="srswDiv">
                    <input type="hidden" name="is_vip"
                    <c:if test="${userCcb.operators eq '1'}">value="1"</c:if>
                    <c:if test="${userCcb.operators ne '1'}">value="0"</c:if>
                    />
                </div>
                客服电话:<%=ProjectXml.getValue("service-phone")%>
            </div>
            <br>

            </div>
        </c:if>

    </form>
</article>
<script>
    function clearContext(name){
        $("input[name='"+name+"']").val("");
    }

    function showCity(index){
        var parentId = index.value;
        jQuery.ajax({
            url: "<%=request.getContextPath()%>/mallszccb/showCity.html",
            type: "post",
            data: {parentId:parentId},
            dataType: "json",
            success: function(data){
                jQuery("select[name='city'] option[index !='0']").remove();

                for(var i =0; i<data.length;i++){
                    if(i ==0 ){
                        jQuery("select[name='city']").append("<option value='"+data[i].id+"' selected = 'true' >"+data[i].areaName+"</option>");
                    }else{
                        jQuery("select[name='city']").append("<option value='"+data[i].id+"'>"+data[i].areaName+"</option>");
                    }

                }

            }
        });
    }

    function showPostInfo(current){
        var addr = current.value.split(" ");

        jQuery("input[name='consignee']").val(addr[0]);
        jQuery("input[name ='consignee_phone']").val(addr[1]);
        jQuery("select[name='pro']").val(addr[2]);
        jQuery("select[name='city']").val(addr[3]);
        jQuery("input[name='consignee_address']").val(addr[4]);
        jQuery("input[name='consignee_zip']").val(addr[5]);

    }
</script>
</html>