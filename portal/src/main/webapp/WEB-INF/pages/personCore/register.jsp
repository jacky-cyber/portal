<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/include.jsp"%>
<%@ include file="/WEB-INF/common/jscss.jsp"%>
<!DOCTYPE html>
<html >
<head>
<title>注册</title>
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
<script type="text/javascript">
		var regMoblie = /^(13[0-9]|15[0-9]|18[0-9]|14[0-9])\d{8}$/;
		var mobileSuccess = false;
		var waitTime = 40;
		
        function Code() {
            var mobile = document.getElementById("mobile").value;

            if (mobile == '' || mobile == '手机号')
                document.getElementById("errMessage").innerText = "提示：手机号码不能为空！";
            else if (!regMoblie.test(mobile)) {
                document.getElementById("errMessage").innerText = "提示：请输入正确的手机号码！";
                return false;
            } else {
               ajaxCheckMobile(mobile);
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
                return;
            }
            if (!regMoblie.test(mobile)) {
                ErrMessage.innerText = "提示：请输入正确的手机号码！";
                return;
            }
            if (verifyCode == '' || verifyCode == '验证码') {
                ErrMessage.innerText = "提示：手机验证码不能为空！";
                return;
            }
            if (pwd == "" || pwd.length < 6 || pwd.length > 18) {
                ErrMessage.innerText = "提示：请输入6-16位长度的密码！";
                return;
            }
            if (pwdagin == "" || pwdagin.length < 6 || pwdagin.length > 18) {
                ErrMessage.innerText = "提示：确认密码请输入6-16位长度的密码！";
                return;
            }
            if (pwd != pwdagin) {
                ErrMessage.innerText = "提示：两次密码输入不一致，请重新输入！";
                return;
            }
			$.post('<%=request.getContextPath()%>/mvc/personCore/registering',
					{mobile : mobile,
					 mobileCode : verifyCode,
					 login_pwd : pwd,
					 confirm_pwd : pwdagin,
					 regMode : "0" },
					function(data) {
                        var obj = new Function("return" + data)();

				   		if(obj.success == "false") {
				   			 ErrMessage.innerText = obj.errorMsg;
				   		}
				   		else if(obj.success == "true") {
				   			confirm("注册成功,请登录");

				   			window.location.href="<%=request.getContextPath()%>/"+obj.url;
				   		}else{
                            ErrMessage.innerText = obj.errorMsg;
                        }
				});
			
        }

        function f_show(id) {
           	$('#'+id).css({"visibility":"hidden"});
        }
        
        function f_hidden(id){
        	$('#'+id).css({"visibility":"visible"});
        }
        
        function ajaxCheckMobile(mobile) {
        	var ErrMessage = document.getElementById("errMessage");
            $.post('<%=request.getContextPath()%>/mvc/personCore/sendMobileCode',
                    {"mobile": mobile},
                    function(json) {
            var obj = new Function("return" + json)();
            countDown(waitTime);
            if(obj.success == "false") {
                ErrMessage.innerHTML = obj.errorMsg;
                mobileSuccess = false;
            }

			});
		}
        
        function countDown(secs){ 
			var resetSend = $("#btn_hs");
			resetSend.text("重新发送("+secs+"秒)");
		  	if(--secs>0){ 
		  		setTimeout("countDown("+secs+")",1000);
		  		resetSend.attr("disabled","disabled");
		  	}else{ 
		  		resetSend.text("重新发送");
		  		resetSend.removeAttr("disabled");
		 	}
		}
        
</script>

<nav>
	<div class="tab_nav tab_nav_one">
		<a href="javascript:history.back(-1)">
			<img src="<%=request.getContextPath()%>/client/images/return.png" width="20" height="16" class="fl"/>
		</a>
		
		<div class="Hide fl">注  册</div>
    </div>
</nav>
<article>
<form name="registerForm" action="<%=request.getContextPath()%>/suzhouboc/" onsubmit="Register();">
    <input type="hidden" name="regMode" value="0"/>
	<div class="regist">
          <div>
              <input name="mobile" type="Tel" style=" width:11em; padding: 0px;" class="inp_regist" id="mobile" 
              onblur="this.style.color='#666';if(this.value=='') this.value='手机号';"
              onfocus="this.style.color='#666';if(this.value=='手机号') this.value='';" value="手机号" />
          </div>
          <div style=" overflow: hidden">
              <input name="mobileCode" style=" width:6em; padding: 0px;"type="text" id="mobileCode" class="inp_regist inp_w fl" 
              onblur="this.style.color='#666';if(this.value=='') this.value='验证码';" 
              onfocus="this.style.color='#666';if(this.value=='验证码') this.value='';" value="验证码" />
              <button type="button" id="btn_hs" class="btn_hs cur btn_yz fl f14" style=" margin-left: 3px;" onclick="Code()">获取验证码</button>
          </div>
          <div style="height:47px;position:relative;">
              <input name="login_pwd" type="password"  style=" width:11em; padding: 0px;"  id="login_pwd" class="inp_regist"   maxlength="16"
              onblur="this.style.color='#666';if(this.value=='')f_hidden('pwd'); " 
              onfocus="this.style.color='#666';if(this.value=='')f_show('pwd'); " />
              <span id="pwd" class="inp_rem">密码</span>
          </div>
          <div style="height:47px;position:relative;">
              <input name="confirm_pwd" type="password" style=" width:11em; padding: 0px;"  id="confirm_pwd" class="inp_regist"   maxlength="16"
              onblur="this.style.color='#666';if(this.value=='')f_hidden('aginpwd'); " 
              onfocus="this.style.color='#666';if(this.value=='')f_show('aginpwd'); " />
              <span id="aginpwd" class="inp_rem">确认密码</span>
          </div>
          <div>
              <button type="button" class="btn_hhs cur" id="Save" onclick="Register()">提  交</button>
              <a href="<%=request.getContextPath()%>/mall/statement" style="color: blue;float: right;">隐私声明</a>
          </div>
          <div>
              <label id="errMessage" style="color: red; margin-left: 0px;">${errorMsg}</label>
          </div>
	</div>
</form>
</article> 
</html>