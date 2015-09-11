<%@ page language="java"  pageEncoding="UTF-8"%>
<script type="text/javascript" src="<%=request.getContextPath()%>/client/js/jquery-1.4.4.min.js" charset="utf-8"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/client/js/jquery.gototop.js" charset="utf-8"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/iscroll.js" charset="utf-8"></script>
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
    }
    .get_codes
    {
        height:45px;
        width:100%;
        border:1px solid #f7ae00;
        background-color:#f7ae00;
        cursor:pointer;
        margin-top:15px;
        font-weight:500;
        color:#333;
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
    .inp_remssss {
        left: 2%;
        top: 150px;
        z-index: 2;
        font-size: 14px;
        font-family:"微软雅黑", Arial;
        color:#999;
        position: absolute;
    }
    .inp_remssss222 {
        left: 2%;
        top: 193px;
        z-index: 2;
        font-size: 14px;
        font-family:"微软雅黑", Arial;
        color:#999;
        position: absolute;
    }

</style>

<script type="text/javascript">
    var regMoblie = /^(13[0-9]|15[0-9]|18[0-9]|14[0-9]|17[0-9])\d{8}$/;
    var mobileSuccess = false;
    var waitTime = 60;
    function Code() {
        var mobile = document.getElementById("mobile").value;
        if (mobile == '' || mobile == '手机号')
            document.getElementById("errMessage").innerText = "提示：手机号码不能为空！";
        else if (!regMoblie.test(mobile)) {
            document.getElementById("errMessage").innerText = "提示：请输入正确的手机号码！";
            return false;
        } else {
            ajaxCheckMobile(mobile, true);
        }
    }

    function Register() {

        var mobile = document.getElementById("mobile").value;
        var verifyCode = document.getElementById("mobileCode").value;
        var pwd = document.getElementById("login_pwd").value;
        var pwdagin = document.getElementById("confirm_pwd").value;
        var ErrMessage = document.getElementById("errMessage");
        //验证手机号码是否合法和手机动态码
        if (mobile == '' || mobile == '手机号') {
            ErrMessage.innerText = "提示：手机号码不能为空！";
            return false;
        }
        if (!regMoblie.test(mobile)) {
            ErrMessage.innerText = "提示：请输入正确的手机号码！";
            return false;
        }
        if (verifyCode == '' || verifyCode == '验证码') {
            ErrMessage.innerText = "提示：手机验证码不能为空！";
            return false;
        }
        if (pwd == "" || pwd.length < 6 || pwd.length > 16) {
            ErrMessage.innerText = "提示：请输入6-16位长度的密码！";
            return false;
        }
        if (pwdagin == "" || pwdagin.length < 6 || pwdagin.length > 16) {
            ErrMessage.innerText = "提示：确认密码请输入6-16位长度的密码！";
            return false;
        }
        if (pwd != pwdagin) {
            ErrMessage.innerText = "提示：两次密码输入不一致，请重新输入！";
            return false;
        }

        $.post('<%=request.getContextPath()%>/mvc/personCore/updatePwd',
                {mobile : mobile,
                    mobileCode : verifyCode,
                    login_pwd : pwd,
                    confirm_pwd : pwdagin
                    /*verifiedCode : validateCode*/},
                function(json) {
                    var obj = new Function("return" + json)();
                    if(obj.success == "false") {
                        ErrMessage.innerText = obj.errorMsg;
                    }
                    else {

                        ErrMessage.innerText = '修改成功';
                        window.location.href="<%=request.getContextPath()%>/"+obj.url;
                    }
                });
    }

    function f_show(id) {
        $('#'+id).css({"visibility":"hidden"});
    }

    function f_hidden(id){
        $('#'+id).css({"visibility":"visible"});
    }

    function ajaxCheckMobile(mobile, isGetMobileFunct) {
        var ErrMessage = document.getElementById("errMessage");
        $.post('<%=request.getContextPath()%>/mvc/personCore/sendMobileCode',
                {"mobile": mobile,"checkCode":$("#code").val()},
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
<nav>
    <div STYLE="background-color: rgba(25, 0, 0, 0.89);height: 40px">
        <a  onclick="window.location.href='<%=request.getContextPath()%>/mvc/personCore/tologin.do';">
            <img src="<%=request.getContextPath()%>/client/images/return.png" width="20" height="16" style="margin-top: 10px;margin-left: 10px"  />
        </a>
    </div>
</nav>
<article>

    <body style="margin:0 auto; width:96%;">
    <table width="100%" height="45" border="0" cellpadding="3" cellspacing="0">
        <tr>
            <td style="font-family:'微软雅黑', Arial; font-size:16px; color:#333; font-weight:500; line-height:30px;">找回密码</td>
        </tr>
    </table>
    <input type="hidden" name="tradeId" value="clientResetPassSZJH"/>
    <%--<input type="reset" id="btnReset" style="display: none;" />--%>
    <div style="margin:0 auto; width:100%;" id="ctab2" style="display:none;">
        <input name="mobile" type="Tel" class="font" id="mobile" placeholder="&nbsp;输入手机号码" />
        <input type="text"  name="code" class="folat font" style=" height:45px; width:55%; border:1px solid #E1E1E1; margin-top:-1px;" id="code" placeholder="&nbsp;输入验证码" value="" required/>

    <div style="height: 43px;"><img style="margin-top: 8px; margin-left: 3px; border: 1px solid #c5c5c5;"  id ="checkCode" src="/checkcode.svl" width="77" height="29" onclick="$('#checkCode').attr('src','/checkcode.svl?d'+new Date()*1);"/></div>
    <div style=" margin-top: -25px; float: right;"><a href="javascript:void(0);" class="xieyi" onclick="$('#checkCode').attr('src','/checkcode.svl?d'+new Date()*1);return false">看不清</a></div>
        <input name="mobileCode" type="text" id="mobileCode" class="folat font"style=" height:45px; width:55%; border:1px solid #E1E1E1; margin-top:-1px;"
               placeholder="&nbsp;手机验证码" />
        <button type="button" id="btn_hs" class="get_code" style="font-family:'微软雅黑', Arial; font-size:15px; margin-top: 1px; color:#FFFFFF;" onclick="Code()">发送</button>

        <div style="height:44px;">
            <input name="login_pwd" type="password" id="login_pwd" class="font"  maxlength="16"
                   placeholder="&nbsp;新密码"/>

        </div>
        <div style="height:47px;">
            <input name="confirm_pwd" type="password" id="confirm_pwd" class="font"  maxlength="16"
                   placeholder="&nbsp;确认密码"/>

        </div>
        <div style="margin:0 auto; width:100%;">
            <button id="Save" onclick="Register()" class="get_codes" style="font-family:'微软雅黑', Arial; font-size:15px; font-weight:bold;" type="button"  >确认提交</button>
        </div>
        <div>
            <label id="errMessage" style="color: red; margin-left: 0px;"></label>
        </div>
        <div style="font-family:'微软雅黑', Arial; font-size:14px; color:#999; text-align:center; margin-top:10px;">客服热线：400-881-6633</div>
       </div>
    </body>

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
	<%--top: 172px;--%>
	<%--z-index: 2;--%>
	<%--font-size: 14px;--%>
	<%--color: #666;--%>
	<%--position: absolute;--%>
<%--}--%>
<%--.inp_remssss222 {--%>
	<%--left: 6%;--%>
	<%--top: 219px;--%>
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
		<%----%>
		<%--$(function (){--%>
			<%--$("#btnReset").click();--%>
			<%--var resetSend = $("#btn_hs");--%>
			<%--resetSend.text("发送");--%>
	  		<%--resetSend.removeAttr("disabled");--%>
		<%--});--%>
		<%----%>
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
       		<%----%>
            <%--var mobile = document.getElementById("mobile").value;--%>
            <%--var verifyCode = document.getElementById("mobileCode").value;--%>
            <%--var pwd = document.getElementById("login_pwd").value;--%>
            <%--var pwdagin = document.getElementById("confirm_pwd").value;--%>
            <%--var ErrMessage = document.getElementById("errMessage");--%>
            <%--//验证手机号码是否合法和手机动态码--%>
            <%--if (mobile == '' || mobile == '手机号') {--%>
                <%--ErrMessage.innerText = "提示：手机号码不能为空！";--%>
                <%--return false;--%>
            <%--}--%>
            <%--if (!regMoblie.test(mobile)) {--%>
                <%--ErrMessage.innerText = "提示：请输入正确的手机号码！";--%>
                <%--return false;--%>
            <%--}--%>
            <%--if (verifyCode == '' || verifyCode == '验证码') {--%>
                <%--ErrMessage.innerText = "提示：手机验证码不能为空！";--%>
                <%--return false;--%>
            <%--}--%>
            <%--if (pwd == "" || pwd.length < 6 || pwd.length > 16) {--%>
                <%--ErrMessage.innerText = "提示：请输入6-16位长度的密码！";--%>
                <%--return false;--%>
            <%--}--%>
            <%--if (pwdagin == "" || pwdagin.length < 6 || pwdagin.length > 16) {--%>
                <%--ErrMessage.innerText = "提示：确认密码请输入6-16位长度的密码！";--%>
                <%--return false;--%>
            <%--}--%>
            <%--if (pwd != pwdagin) {--%>
                <%--ErrMessage.innerText = "提示：两次密码输入不一致，请重新输入！";--%>
                <%--return false;--%>
            <%--}--%>
            <%----%>
            <%--$.post('<%=request.getContextPath()%>/mvc/personCore/updatePwd',--%>
				<%--{mobile : mobile,--%>
				 <%--mobileCode : verifyCode,--%>
				 <%--login_pwd : pwd,--%>
				 <%--confirm_pwd : pwdagin--%>
                 <%--/*verifiedCode : validateCode*/},--%>
				<%--function(json) {--%>
                    <%--var obj = new Function("return" + json)();--%>
			   		<%--if(obj.success == "false") {--%>
			   			<%--ErrMessage.innerText = obj.errorMsg;--%>
			   		<%--}--%>
			   		<%--else {--%>
                        <%--alert("密码修改成功！");--%>
			   			<%--ErrMessage.innerText = '修改成功';--%>
                        <%--window.location.href="<%=request.getContextPath()%>/"+obj.url;--%>
			   		<%--}--%>
			<%--});--%>
        <%--}--%>

        <%--function f_show(id) {--%>
           	<%--$('#'+id).css({"visibility":"hidden"});--%>
        <%--}--%>
        <%----%>
        <%--function f_hidden(id){--%>
        	<%--$('#'+id).css({"visibility":"visible"});--%>
        <%--}--%>
        <%----%>
        <%--function ajaxCheckMobile(mobile, isGetMobileFunct) {--%>
        	<%--var ErrMessage = document.getElementById("errMessage");--%>
            <%--$.post('<%=request.getContextPath()%>/mvc/personCore/sendMobileCode',--%>
                    <%--{"mobile": mobile},--%>
                    <%--function(json) {--%>
                        <%--var obj = new Function("return" + json)();--%>

                        <%--if(obj.success == "false") {--%>
                            <%--ErrMessage.innerHTML = obj.errorMsg;--%>
                            <%--mobileSuccess = false;--%>
                        <%--}else{--%>
                            <%--countDown(waitTime);--%>
                        <%--}--%>
                    <%--})--%>
		<%--}--%>
        <%----%>
        <%--function countDown(secs){ --%>
			<%--var resetSend = $("#btn_hs");--%>
			<%--resetSend.text("重新发送("+secs+"秒)");--%>
		  	<%--if(--secs>0){ --%>
		  		<%--setTimeout("countDown("+secs+")",1000);--%>
		  		<%--resetSend.attr("disabled","disabled");--%>
		  	<%--}else{ --%>
		  		<%--resetSend.text("重新发送");--%>
		  		<%--resetSend.removeAttr("disabled");--%>
		 	<%--}--%>
		<%--}--%>
        <%----%>
<%--</script>--%>

<%--<nav>--%>
	<%--<div class="tab_nav tab_nav_one">--%>
		<%--<a href="javascript:history.back(-1);">--%>
			<%--<img src="<%=request.getContextPath()%>/client/images/return.png" width="20" height="16" class="fl"/>--%>
		<%--</a>--%>
		<%----%>
		<%--<div class="Hide fl">找回密码</div>--%>
    <%--</div>--%>
<%--</nav>--%>
<%--<article>--%>
<%--<form name="findPassForm" action="<%=request.getContextPath()%>/suzhouccb/findPasswordSucc.html" method="post">--%>
    <%--<input type="hidden" name="tradeId" value="clientResetPassSZJH"/>--%>
    <%--<input type="reset" id="btnReset" style="display: none;" />--%>
	<%--<div class="regist">--%>
          <%--<div>--%>
              <%--<input name="mobile" type="Tel" class="inp_regist" id="mobile" --%>
              <%--onblur="this.style.color='#666';if(this.value=='') this.value='手机号';"--%>
              <%--onfocus="this.style.color='#666';if(this.value=='手机号') this.value='';" value="手机号" />--%>
          <%--</div>--%>
          <%--<div>--%>
              <%--<input name="mobileCode" type="text" id="mobileCode" class="inp_regist inp_w" --%>
              <%--onblur="this.style.color='#666';if(this.value=='') this.value='验证码';" --%>
              <%--onfocus="this.style.color='#666';if(this.value=='验证码') this.value='';" value="验证码" />--%>
              <%--<button type="button" id="btn_hs" class="btn_hs cur btn_yz fr f14" onclick="Code()">获取验证码</button>--%>
          <%--</div>--%>
          <%--<div style="height:47px;">--%>
              <%--<input name="login_pwd" type="password" id="login_pwd"  maxlength="16"--%>
               <%--class="inp_regist" onblur="this.style.color='#666';if(this.value=='')f_hidden('pwd'); " --%>
               <%--onfocus="this.style.color='#666';if(this.value=='')f_show('pwd'); "--%>
               <%--style="color: rgb(102, 102, 102);">--%>
              <%--<span id="pwd" class="inp_remssss">新密码</span>--%>
          <%--</div>--%>
          <%----%>
          <%----%>
          <%--<div style="height:47px;">--%>
              <%--<input name="confirm_pwd" type="password" id="confirm_pwd" class="inp_regist"  maxlength="16"--%>
				<%--onblur="this.style.color='#666';if(this.value=='')f_hidden('aginpwd'); "--%>
				<%--onfocus="this.style.color='#666';if(this.value=='')f_show('aginpwd'); " />--%>
              <%--<span id="aginpwd" class="inp_remssss222">确认密码</span>--%>
          <%--</div>--%>
          <%--<div>--%>
              <%--<button type="button" class="btn_hhs cur" id="Save" onclick="Register()">提  交</button>--%>
          <%--</div>--%>
          <%--<div>--%>
             <%--<label id="errMessage" style="color: red; margin-left: 0px;"></label>--%>
          <%--</div>--%>
	<%--</div>--%>
<%--</form>--%>
<%--</article> --%>
<%--</html>--%>