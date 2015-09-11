<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<script type="text/javascript" src="<%=request.getContextPath()%>/client/js/jquery-1.4.4.min.js" charset="utf-8"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/client/js/jquery.gototop.js" charset="utf-8"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/iscroll.js" charset="utf-8"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/res/common/js/city.js" type="text/javascript"></script>
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

<style type="text/css">
    @media screen and (max-device-width: 96%) {
        #divMain{
            float: none;
            width:auto;
        }
        #divSidebar {
            display:none;
        }
    }
    .menu2 {
        font-size: 16px;
        color: #FFFFFF;
        width:50%;
        text-decoration: none;
        background-color:#E1E1E1;
        cursor:hand;
        border:1px solid #E1E1E1;
        text-align:center;
        font-family:"微软雅黑", Arial;
    }
    .menu1 {
        font-size: 16px;
        color: #FFFFFF;
        text-decoration: none;
        background-color: #f7ae00;
        cursor:hand;
        border:1px solid #f7ae00;
        text-align:center;
        font-family:"微软雅黑", Arial;
    }
    .folat {float:left;}
    .td {
        width:100%;
        height:45px;
    }
    .get_code
    {
        height:44px;
        width:45%;
        border:1px solid #f7ae00;
        background-color:#f7ae00;
        cursor:pointer;
        margin-top: 1px;
    }
    .get_codes
    {
        height:45px;
        width:100%;
        border:1px solid #f7ae00;
        background-color:#f7ae00;
        cursor:pointer;
        font-weight:500;
        color:#666;
    }
    .font
    {
        font-family:"微软雅黑", Arial;
        color:#999;
        font-size:15px;
        height:45px;
        width: 100%;
        border:1px solid #E1E1E1;
        margin-top:-1px;
    }
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
    .zc {
        font-family:'微软雅黑', Arial;
        font-size:15px; height:30px;
        width:100%;
        border:1px solid #E2E2E2;
        background-color:#F1F1F1;
        cursor:pointer;
        margin-top:10px;
        font-weight:500;
        color:#ABABAB;
    }
    table{
        color:#808080;
    }
    table tr{
        height: 40px;;
    }

    .select { width:97%; height:27px; background:none; border:none;
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

    .app{
        font-family:"微软雅黑", Arial;
        font-size:14px;
        color:#CCC;
        margin-left:5%;
        line-height: 40px;
    }
    .tddg{
        width: 115px;
    }
</style>
<script type="text/javascript">



    function submitOrder(){
        var needLogin = "${needLogin}";
        if("0"==needLogin){
            if(false ==login()){
                return false;
            };
        }
        var is_post = '${prodType}';// 商品类型  1 本地商品 2 虚拟商品  3 商城商品
        if(is_post == '2'){
        }else if(is_post == '3'){
            var consignee_phone = $("input[name=consignee_phone]").val();
            if($("input[name=consignee]").val()=="" || $("input[name=consignee]").val()=="请输入收货人"){
                $("#errMessage").text("请填写收货人信息");
                return;
            }
            if(consignee_phone==""){
                $("#errMessage").text("请填写收货人手机号码");
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
        }
        $("#orderform").submit();
        $("#confirmOrder").removeAttr("onclick");
    }



    //计算每条记录价格
    function calcPrice(count){
        var currPrice = parseFloat('${productPrice}');
        var calcPrice = parseFloat(currPrice * count).toFixed(2);
        $("#total_price_1").text(calcPrice+"元");
    }

    function login(){

        var loginName = $("#loginName").val();
        var loginPassword = $("#loginPassword").val();
        var mobileCode = $("#mobileCode").val();
        var loginType = $("#loginType").val();

        if("1"==loginType){
            if (loginName == '' || loginName == '手机号') {
                $("#errMessage").text( "提示：登录手机号不能为空！");
                return false;
            }
            if (loginPassword == '' || loginPassword == '密码') {
                $("#errMessage").text( "提示：密码不能为空！");
                return false;
            }
            mobileCode ="";
        }else{
            loginName = $("#loginName2").val();
            if (loginName == '' || loginName == '手机号') {
                $("#errMessage").text( "提示：登录手机号不能为空！");
                return false;
            }
            if (mobileCode == '' || mobileCode == '动态密码') {
                $("#errMessage").text("提示：动态密码不能为空！");
                return false;
            }
            loginPassword = "";
        }
        $.ajax({
            type : "post",
            url : "<%=request.getContextPath()%>/mvc/personCore/orderLogin.do",
            data: "username="+loginName+"&password="+loginPassword+"&mobileCode="+mobileCode+"&apId="+$("#apId").val()+"&productId="+'${productId}',
            dataType:"json",
            async: false, //设为false就是同步请求
            cache: false,
            success : function(msg) {

                var success = msg.success;
                var original = msg.original;
                var buyLimit = msg.buyLimit;
                if("success"==success){
                    if(true==buyLimit){
                        $("#errMessage").text("该用户购买量已达到上限");
                        $("#loginSuccess").val(0);

                    }else{

                        $("#loginSuccess").val(1);
                        $("#errMessage").text("登录成功");
                        $("#confirmOrder").attr("disabled",false).css('color','#000000');


                    }

                }else{
                    $("#errMessage").text("登录失败");
                    $("#loginSuccess").val(0);

                }
            }

        });
        var  loginSuccess = $("#loginSuccess").val();
        if(loginSuccess==1){
            return true;
        }else{
            return false;
        }


    }
</script>
<body style="margin:0 auto; width:96%;"  >
<article>
    <form name="orderform" id="orderform" class="orderform" method="post"  action="<%=request.getContextPath()%>/mvc/orderConfirm_v2" >
        <input type="hidden" name="apId" id="apId" value="${productId}"/>
        <input type="hidden" name="isPost"  value="${isPost}"/>
        <input type="hidden" name="token" value ="<%=session.getAttribute("token") %>" />
        <div style="width:100%;">
            <span style="float: left;font-family: '微软雅黑', Arial; font-size: 17px; line-height: 40px;color: #666;">订单信息</span>
            <span class="app">该商品只能通过建行手机APP购买</span>
        </div>
        <div >
            <table style="border:1px solid gainsboro; font-family: '微软雅黑', Arial; font-size: 16px; width:100%;background-color: white; "cellspacing=0 frame="hsides" rules="rows" cellpadding=0>

                <tr>
                    <td class="tddg">&nbsp;商品名称：</td>
                    <td>${productName}</td>
                </tr>

                <tr>
                    <td class="tddg">&nbsp;商品单价：</td>
                    <td id="productPrice" style="color: red;">${productPrice}元</td>
                </tr>
                <%--<c:if test="${prodType == 1}">--%>
                    <tr style="display: none;">
                        <td class="tddg">&nbsp;购买数量：</td>
                        <td>
                            <table border="1 solid white" cellpadding="0" cellspacing="0" style="border-collapse:collapse;border-color:gainsboro">
                                <tr style="height: 35px;">
                                    <td width="35px;"><a href="javascript:void(0)" id ="subtraction" class="minus" style="width:35px;margin-top: 5px;margin-right:-7px;color:#808080;border: 0px;background: none;">-</a></td>
                                    <td width="35px;"><input type="text" name="quantity" class="quantity" value="1" readonly style="height: 30px;border: 0px;" /></td>
                                    <td width="35px;"><a href="javascript:void(0)"  id="add" style="margin-top: 7px;margin-left:0px; color:#449aec;border: 0px;background: none;" >+</a></td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                <tr>
                    <td class="tddg">&nbsp;支付金额：</td>
                    <td style="color: red;">
                        <span id="total_price_1">${productPrice}元</span>
                    </td>
                </tr>
            </table>
        </div>
        <c:if test="${prodType == 3}">
            <div>
                <span style="float: left; width:100%; line-height: 40px;color: #666;font-size: 18px;">收货地址</span>
            </div>
            <div>
                <table style="border:1px solid gainsboro; width:100%;font-size: 18px;background-color: white;"  cellspacing=0 frame="hsides" rules="rows" cellpadding=0>

                    <tr>
                        <td class="tddg">&nbsp;收货人：</td>
                        <td>
                            <input  type="text" name="consignee"  placeholder="&nbsp; 请输入收货人" value="" style="border-style:solid; border-width: 0;width: 97%;height: 26px;font-size: 16px;color: #808080;" />
                        </td>
                    </tr>

                    <tr>
                        <td>&nbsp;手机号：</td>
                        <td>
                            <input  type="Tel" maxLength = "11" name="consignee_phone" placeholder="&nbsp;请输入手机号码" value="" style="border-style: solid; border-width: 0;width: 97%;height: 26px;font-size: 16px;color: #808080;" />
                        </td>
                    </tr>

                    <tr>
                        <td style="width: 115px">&nbsp;省&nbsp;份：</td>
                        <td>
                         <span>
                              <span id="sleBG">
                                <div >
                                    <select onchange="initcity();" class="select" name="pro" id="pro" style="font-size: 16px;color: #808080;"  >
                                        <SCRIPT>creatprovince();</SCRIPT>
                                    </select>
                                </div>
                              </span>
                        </span>
                        </td>
                    </tr>


                    <tr>
                        <td>&nbsp;城&nbsp;市：</td>
                        <td>
                        <span id="sleBG">
                        <span >
                            <select name="city" class="select" id="city" style="font-size: 16px;color: #808080;" >
                                <option value="">选择城市</option>
                            </select>
                            </span>
                        </span>
                        </td>
                    </tr>

                    <tr>
                        <td>&nbsp;详细地址：</td>
                        <td>
                            <input type="text"  name="detail" placeholder="&nbsp; 请输入详细地址" value="" style="border-style: solid; border-width: 0;width: 97%; height: 26px;font-size: 16px;color: #808080;"  />
                        </td>
                    </tr>

                </table>
            </div>
        </c:if>
    </form>
    <c:if test="${needLogin == '0'}">
        <table width="100%" height="45" border="0" cellpadding="3" cellspacing="0">
            <tr>
                <td style="font-family:'微软雅黑', Arial; font-size:16px; color:#333; font-weight:500; line-height:30px;">用户登录</td>
            </tr>
            <tr>
                <td height="45" class="menu1" id="tab1" onclick="passwordLogin()">用户登录</td>
                <td height="45" class="menu2" id="tab2" onclick="codeLogin()">验证码登录
                    <input id="loginType" value="1"style="display: none">
                </td>
            </tr>
        </table>
        <div style="margin:0 auto; width:100%;" id="ctab1" style="display:none;">
            <input  type="text" name="loginName" id="loginName" value=""  placeholder="&nbsp;输入手机号码" class="font" />
            <input   type="password" maxLength = "11" name="loginPassword" placeholder="&nbsp;输入密码" id="loginPassword"  class="font" />
        </div>
        <div style="margin:0 auto; width:100%; display: none" id="ctab2" >
            <input  type="text" name="loginName2" id="loginName2" placeholder="&nbsp;输入手机号码" value="" class="font" />

            <input type="text"  name="code" class="folat font" style=" height:45px; width:55%; border:1px solid #E1E1E1; margin-top:-1px;" id="code" placeholder="&nbsp;输入验证码" value="" required/>
            <div style="height: 43px;"><img style="margin-top: 8px; margin-left: 3px; border: 1px solid #c5c5c5;"  id ="checkCode" src="/checkcode.svl" width="77" height="29" onclick="$('#checkCode').attr('src','/checkcode.svl?d'+new Date()*1);"/></div>
            <div style=" margin-top: -25px; float: right;"><a href="javascript:void(0);" class="xieyi" onclick="$('#checkCode').attr('src','/checkcode.svl?d'+new Date()*1);return false">看不清</a></div>

            <input   type="text" maxLength = "11" name="mobileCode" id="mobileCode" placeholder="&nbsp;手机验证码" class="folat font" style=" height:45px; width:55%; border:1px solid #E1E1E1; margin-top:-1px;" />
            <button id="btn_hs"  onclick="code()" class="get_code" style="font-family:'微软雅黑', Arial; font-size:15px; color:#FFFFFF;" type="button">发送</button>
        </div>
        <div style="height: 20px"></div>
    </c:if>
    <div style="margin:0 auto; width:100%;">
        <input  type="text"  id="loginSuccess" value="0"  style="display:none;"/>
        <button id="confirmOrder"onclick="submitOrder();return false;" class="get_codes" style="font-family:'微软雅黑', Arial; font-size:16px; font-weight:bold;" type="button" >确认订单</button>
    </div>

    <div style="margin:0 auto; width:100%;">
        <span id="errMessage" style="color: red;font-size: 16px;line-height: 28px;">&nbsp;${errorMsg}</span>
    </div>

    <div style="font-family:'微软雅黑', Arial; font-size:14px; color:#999; text-align:center; margin-top:10px;">客服热线：400-881-6633</div>
</article>
</body>
<script>
    var waitTime = 60;

    var buyLimit = "${buyLimit}";
    var onSale = "${onSale}";
    var productCount ="${productCount}";

    if("true"==onSale){
        if("0"!=productCount){
                if("true"==buyLimit){
                    $("#errMessage").text("该用户购买量已达到上限");
                    $("#confirmOrder").attr("disabled",true).css('color','#DDDDDD');
            }
        }else{
            $("#errMessage").text("该商品库存不足，不能进行购买");
            $("#confirmOrder").removeAttr("onclick");
        }

    }else{
        $("#errMessage").text("该商品未上架，不能进行购买");
        $("#confirmOrder").removeAttr("onclick");
    }


    function passwordLogin(){
        $("#tab1").attr("class","menu1");
        $("#ctab1").show();
        $("#tab2").attr("class","menu2");
        $("#ctab2").hide();
        $("#loginType").val("").val("1");
        $("#errMessage").text("");
    }
    function codeLogin(){
        $("#tab2").attr("class","menu1");
        $("#tab1").attr("class","menu2");
        $("#ctab2").show();
        $("#ctab1").hide();
        $("#loginType").val("").val("2");
        $("#errMessage").text("");
    }





    function code() {
        var loginName2 = $("#loginName2").val();
        if (loginName2 == '' || loginName2 == '手机号'){
            document.getElementById("errMessage").innerText = "提示：手机号码不能为空！";
        } else {
            document.getElementById("errMessage").innerText = "";
            ajaxCheckMobile(loginName2, true);
        }
    }

    function ajaxCheckMobile(loginName2, isGetMobileFunct) {
        var ErrMessage = document.getElementById("errMessage");
        $.post('<%=request.getContextPath()%>/mvc/personCore/sendMobileCode',
                {"mobile": loginName2,"checkCode":$("#code").val()},
                function(json) {
                    var obj = new Function("return" + json)();

                    if(obj.success == "false") {
                        ErrMessage.innerHTML = obj.errorMsg;
                        mobileSuccess = false;
                    }else{
                        countDown(waitTime);
                    }
                })
    }

    function countDown(secs){
        var resetSend = $("#btn_hs");
        resetSend.text("发送("+secs+"s)");
        if(--secs>0){
            setTimeout("countDown("+secs+")",1000);
            resetSend.attr("disabled","disabled");
        }else{
            resetSend.text("发送");
            resetSend.removeAttr("disabled");
        }
    }
</script>
</html>

