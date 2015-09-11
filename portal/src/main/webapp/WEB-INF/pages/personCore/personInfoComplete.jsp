
<%@ page language="java"  pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/include.jsp"%>
<%@ include file="/WEB-INF/common/jscss.jsp"%>
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

<style>
    .inp_remssss {
        left: 6%;
        top: 44px;
        z-index: 2;
        font-size: 14px;
        color: #666;
        position: absolute;
    }
    .inp_remssss222 {
        left: 6%;
        top: 90px;
        z-index: 2;
        font-size: 14px;
        color: #666;
        position: absolute;
    }
</style>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<script type="text/javascript">










    function Register() {
        var pwd = $("#login_pwd").val();
        var pwdagin = $("#confirm_pwd").val();

        var ErrMessage = document.getElementById("errMessage");
        //验证手机号码是否合法和手机动态码

        if (pwd == "" || pwd.length < 6 || pwd.length > 18) {
            ErrMessage.innerText = "提示：请输入6-16位长度的密码！";
            return false;
        }
        if (pwdagin == "" || pwdagin.length < 6 || pwdagin.length > 18) {
            ErrMessage.innerText = "提示：确认密码请输入6-16位长度的密码！";
            return false;
        }
        if (pwd != pwdagin) {
            ErrMessage.innerText = "提示：两次密码输入不一致，请重新输入！";
            return false;
        }
        $.post('<%=request.getContextPath()%>/mvc/personCore/personInfoSave',
                {
                    login_pwd : pwd,
                    confirm_pwd : pwdagin
                },
                function(json) {
                    var obj = new Function("return" + json)();
                    if(obj.success == "false") {
                        ErrMessage.innerText = obj.errorMsg;
                    }
                    else {
                        ErrMessage.innerText = '修改成功';
                        window.location.href="<%=request.getContextPath()%>/"+obj.url;
                    }
                }
        )
    };
    function noRegister() {
        window.location.href = "<%=request.getContextPath()%>/" +"mvc/personCore/myAccount.do";
    }


</script>

<nav>
    <div class="tab_nav tab_nav_one">
        <a href="javascript:history.back(-1);">
            <img src="<%=request.getContextPath()%>/client/images/return.png" width="20" height="16" class="fl"/>
        </a>
    </div>
</nav>
<article>
    <form name="findPassForm" action="" method="post">
        <%--<input type="hidden" name="tradeId" value="clientResetPassSZJH"/>--%>
        <%--<input type="reset" id="btnReset" style="display: none;" />--%>
        <div class="regist">
            <div id="personInfo" > <h3>设置个人密码</h3>
                <div style="height:20px;">
                    &nbsp;&nbsp;&nbsp;
                </div>
                <div style="height:47px;">
                    <input name="login_pwd" type="password" id="login_pwd" style="width: 100%" maxlength="16" placeholder="&nbsp;输入密码">
                </div>


                <div style="height:47px;">
                    <input name="confirm_pwd" type="password" id="confirm_pwd" style="width: 100%"  maxlength="16" placeholder="&nbsp;再次输入密码"/>
                </div>
            </div>
            <button type="button" class="btn_hhs cur" id="Save" onclick="Register()">提  交</button>
            <div style="height:20px;">
                &nbsp;&nbsp;&nbsp;
            </div>
            <button type="button" class="btn_hhs cur" id="" onclick="noRegister()">下次再设置</button>
        </div>
        <div>
            <label id="errMessage" style="color: red; margin-left: 0px;"></label>
        </div>
        </div>
    </form>
</article>
</html>



<%--<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>--%>
<%--<%@ include file="/WEB-INF/common/include.jsp"%>--%>
<%--<%@ include file="/WEB-INF/common/jscss.jsp"%>--%>
<%--<!DOCTYPE html>--%>
<%--<html>--%>
<%--<head>--%>
    <%--<title>艾丰宝商城</title>--%>
    <%--<meta http-equiv="Content-Type" content="text/html; charset=utf-8">--%>
    <%--<meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=0" name="viewport">--%>
    <%--<meta content="yes" name="apple-mobile-web-app-capable">--%>
    <%--<meta content="black" name="apple-mobile-web-app-status-bar-style">--%>
    <%--<meta content="telephone=no" name="format-detection">--%>
    <%--<meta http-equiv="Access-Control-Allow-Origin" content="*">--%>
<%--</head>--%>

<%--<style>--%>
    <%--.inp_remssss {--%>
        <%--left: 6%;--%>
        <%--top: 44px;--%>
        <%--z-index: 2;--%>
        <%--font-size: 14px;--%>
        <%--color: #666;--%>
        <%--position: absolute;--%>
    <%--}--%>
    <%--.inp_remssss222 {--%>
        <%--left: 6%;--%>
        <%--top: 90px;--%>
        <%--z-index: 2;--%>
        <%--font-size: 14px;--%>
        <%--color: #666;--%>
        <%--position: absolute;--%>
    <%--}--%>
<%--</style>--%>
<%--<%--%>
    <%--String path = request.getContextPath();--%>
    <%--String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";--%>
<%--%>--%>
<%--<script type="text/javascript">--%>
    <%--var regMoblie = /^(13[0-9]|15[0-9]|18[0-9]|14[0-9]|17[0-9])\d{8}$/;--%>
    <%--var mobileSuccess = false;--%>
    <%--var waitTime = 40;--%>
    <%--//        var validateCode = "";--%>

    <%--var completeType = '${completeType}';--%>

    <%--$(function (){--%>
        <%--$("#btnReset").click();--%>
        <%--var resetSend = $("#btn_hs");--%>
        <%--resetSend.text("发送");--%>
        <%--resetSend.removeAttr("disabled");--%>

        <%--if(2 == completeType){--%>
            <%--$("#personInfo").hide();--%>
        <%--}--%>
    <%--});--%>

    <%--function Code() {--%>
        <%--var mobile = document.getElementById("mobile").value;--%>
        <%--if (mobile == '' || mobile == '手机号')--%>
            <%--document.getElementById("errMessage").innerText = "提示：手机号码不能为空！";--%>
        <%--else if (!regMoblie.test(mobile)) {--%>
            <%--document.getElementById("errMessage").innerText = "提示：请输入正确的手机号码！";--%>
            <%--return false;--%>
        <%--} else {--%>
            <%--ajaxCheckMobile(mobile, true);--%>
        <%--}--%>
    <%--}--%>

    <%--function Register() {--%>

       <%--var pwd = $("#login_pwd").val();--%>
       <%--var pwdagin = $("#confirm_pwd").val();--%>

        <%--var ErrMessage = document.getElementById("errMessage");--%>
        <%--//验证手机号码是否合法和手机动态码--%>

            <%--if (pwd == "" || pwd.length < 6 || pwd.length > 18) {--%>
                <%--ErrMessage.innerText = "提示：请输入6-16位长度的密码！";--%>
                <%--return false;--%>
            <%--}--%>
            <%--if (pwdagin == "" || pwdagin.length < 6 || pwdagin.length > 18) {--%>
                <%--ErrMessage.innerText = "提示：确认密码请输入6-16位长度的密码！";--%>
                <%--return false;--%>
            <%--}--%>
            <%--if (pwd != pwdagin) {--%>
                <%--ErrMessage.innerText = "提示：两次密码输入不一致，请重新输入！";--%>
                <%--return false;--%>
            <%--}--%>





        <%--$.post('<%=request.getContextPath()%>/mvc/personCore/personInfoSave',--%>
                <%--{--%>
                    <%--login_pwd : pwd,--%>
                    <%--confirm_pwd : pwdagin,--%>
                    <%--completeType:completeType--%>
                    <%--/*verifiedCode : validateCode*/},--%>
                <%--function(json) {--%>
                    <%--var obj = new Function("return" + json)();--%>
                    <%--if(obj.success == "false") {--%>
                        <%--ErrMessage.innerText = obj.errorMsg;--%>
                    <%--}--%>
                    <%--else {--%>
                        <%--alert("修改成功！");--%>
                        <%--ErrMessage.innerText = '修改成功';--%>
                        <%--window.location.href="<%=request.getContextPath()%>/"+obj.url;--%>
                    <%--}--%>
                <%--});--%>
    <%--}--%>

    <%--function f_show(id) {--%>
        <%--$('#'+id).css({"visibility":"hidden"});--%>
    <%--}--%>

    <%--function f_hidden(id){--%>
        <%--$('#'+id).css({"visibility":"visible"});--%>
    <%--}--%>





<%--</script>--%>

<%--<nav>--%>

<%--</nav>--%>
<%--<article>--%>
    <%--<form name="findPassForm" action="<%=request.getContextPath()%>/suzhouccb/findPasswordSucc.html" method="post">--%>
        <%--<input type="hidden" name="tradeId" value="clientResetPassSZJH"/>--%>
        <%--<input type="reset" id="btnReset" style="display: none;" />--%>
        <%--<div class="regist">--%>
            <%--<div id="personInfo" > <h3>设置个人密码</h3>--%>
            <%--<div style="height:47px;">--%>
                <%--密码<input name="login_pwd" type="password" id="login_pwd"  maxlength="16"--%>
                       <%--class="inp_regist" onblur="this.style.color='#666';if(this.value=='')f_hidden('pwd'); "--%>
                       <%--onfocus="this.style.color='#666';if(this.value=='')f_show('pwd'); "--%>
                       <%--style="color: rgb(102, 102, 102);">--%>
                <%--<span id="pwd" class="inp_remssss">密码</span>--%>
            <%--</div>--%>


            <%--<div style="height:47px;">--%>
                <%--确认密码<input name="confirm_pwd" type="password" id="confirm_pwd" class="inp_regist"  maxlength="16"--%>
                       <%--onblur="this.style.color='#666';if(this.value=='')f_hidden('aginpwd'); "--%>
                       <%--onfocus="this.style.color='#666';if(this.value=='')f_show('aginpwd'); " />--%>
                <%--<span id="aginpwd" class="inp_remssss222">确认密码</span>--%>
            <%--</div>--%>
            <%--</div>--%>

                <%--<button type="button" class="btn_hhs cur" id="Save" onclick="Register()">提  交</button>--%>

            <%--<div>--%>
                <%--<label id="errMessage" style="color: red; margin-left: 0px;"></label>--%>
            <%--</div>--%>
        <%--</div>--%>
    <%--</form>--%>
<%--</article>--%>
<%--</html>--%>