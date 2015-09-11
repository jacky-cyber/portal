<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<script type="text/javascript" src="<%=request.getContextPath()%>/client/js/jquery-1.4.4.min.js" charset="utf-8"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/client/js/jquery.gototop.js" charset="utf-8"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/iscroll.js" charset="utf-8"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/res/common/js/city.js" type="text/javascript"></script>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>登录</title>
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
        height:45px;
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
</style>


<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<script type="text/javascript">
    function tabit(id,cid) {
        tab1.className="menu2";
        tab2.className="menu2";
        id.className="menu1";
        ctab1.style.display="none";
        ctab2.style.display="none";
        cid.style.display="block";
    }
    var regMoblie = /^(13[0-9]|15[0-9]|18[0-9]|14[0-9]|17[0-9])\d{8}$/;
    var mobileSuccess = false;
    var waitTime = 60;
        function login() {
        	var moblieRule = /^(13[0-9]|15[0-9]|18[0-9]|14[0-9]|17[0-9])\d{8}$/;
            document.getElementById("errMessage").innerText = "";
            var user_id = "";

            var password = $("#web_login_pwd").val();
            var mobileCode = $("#mobileCode").val();
            var loginType = $("#loginType").val();
            var ErrMessage = document.getElementById("errMessage");

            if("1"==loginType){
                if (password == '' || password == '密码') {
                    ErrMessage.innerText = "提示：密码不能为空！";
                    return;
                }
                 user_id = $("#user_id1").val();
                if (user_id == '' || user_id == '手机号') {
                    ErrMessage.innerText = "提示：手机号不能为空！";
                    return;
                }
                    mobileCode ="";
            }else{
                if (mobileCode == '' || mobileCode == '动态密码') {
                    ErrMessage.innerText = "提示：动态密码不能为空！";
                    return;
                }
                user_id = $("#user_id2").val();
                if (user_id == '' || user_id == '手机号') {
                    ErrMessage.innerText = "提示：手机号不能为空！";
                    return;
                }
                    password = "";
            }


            var forword = '${forword}';
            $.ajax({  
		        type : "post",  
		        url : "<%=request.getContextPath()%>/mvc/personCore/login.do",
		        data: "username="+user_id+"&password="+password+"&mobileCode="+mobileCode,
		        dataType:"json",  
		        success : function(msg) {
                    var success = msg.success;
		        	if(success == "success"){
                            window.location.href="<%=request.getContextPath()%>/"+msg.url;
		            }else{
		            	ErrMessage.innerText = msg.errorMsg;
		            }
		        }
		    });
            
            return;
        }
    function passwordLogin(){
        $("#tab1").attr("class","menu1");
        $("#ctab1").show();
        $("#tab2").attr("class","menu2");
        $("#ctab2").hide();
        $("#loginType").val("").val("1");
        document.getElementById("errMessage").innerText = "";
    }
        function DpasswordLogin(){
            $("#tab2").attr("class","menu1");
            $("#tab1").attr("class","menu2");
            $("#ctab2").show();
            $("#ctab1").hide();
            $("#loginType").val("").val("2");
            document.getElementById("errMessage").innerText = "";
        }
        function Code() {
            var mobile = $("#user_id2").val();
            if (mobile == '' || mobile == '手机号')
                document.getElementById("errMessage").innerText = "提示：手机号码不能为空！";
            else if (!regMoblie.test(mobile)) {
                document.getElementById("errMessage").innerText = "提示：请输入正确的手机号码！";
                return false;
            } else {
                document.getElementById("errMessage").innerText = "";
                ajaxCheckMobile(mobile, true);
            }
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


<article>
    <form name="loginForm" action="<%=request.getContextPath()%>/mvc/personCore/myAccount.html" onsubmit="login();" method="post">
    <body style="margin:0 auto; width:96%;" onLoad="tabit(tab1,ctab1)">
    <table width="100%" height="45" border="0" cellpadding="3" cellspacing="0">
        <tr>
            <td style="font-family:'微软雅黑', Arial; font-size:16px; color:#333; font-weight:500; line-height:30px;">用户登录</td>
        </tr>
        <tr>
            <td height="45" class="menu1" id="tab1" onclick="passwordLogin();">账户登录</td>
            <td height="45" class="menu2" id="tab2" onclick="DpasswordLogin();">动态密码登录</td>
        </tr>
    </table>
    <div style="margin:0 auto; width:100%;" id="ctab1" style="display:block;">

            <input name="user_id1" type="text" class="font" id="user_id1" placeholder="&nbsp;输入手机号码" value="" required>
            <input name="web_login_pwd" type="password" class="font" id="web_login_pwd" placeholder="&nbsp;输入密码" value="" required>

    </div>
    <div style="margin:0 auto; width:100%;" id="ctab2" style="display:none;">

            <input name="user_id2" type="text" class="font" id="user_id2" placeholder="&nbsp;输入手机号码" value="" required>

        <input type="text"  name="code" class="folat font" style=" height:45px; width:55%; border:1px solid #E1E1E1; margin-top:-1px;" id="code" placeholder="&nbsp;输入验证码" value="" required/>

    <div style="height: 43px;"><img style="margin-top: 8px; margin-left: 3px; border: 1px solid #c5c5c5;"  id ="checkCode" src="/checkcode.svl" width="77" height="29" onclick="$('#checkCode').attr('src','/checkcode.svl?d'+new Date()*1);"/></div>
    <div style=" margin-top: -25px; float: right;"><a href="javascript:void(0);" class="xieyi" onclick="$('#checkCode').attr('src','/checkcode.svl?d'+new Date()*1);return false">看不清</a></div>

            <input name="mobileCode" type="text" class="folat font" style=" height:45px; width:55%; border:1px solid #E1E1E1; margin-top:-1px;" id="mobileCode" placeholder="&nbsp;手机验证码" value="" required>
            <button class="get_code" style="font-family:'微软雅黑', Arial; font-size:15px; color:#FFFFFF;"id="btn_hs"  type="button"  onclick="Code()" >发送</button>

    </div>
    <span id="errMessage" style="color: #ff8484; margin-left: 0px;">${errorMsg}</span>
    <div style="margin:0 auto; width:100%;">
            <input id="loginType" value="1" style="display: none">
            <button class="get_codes" style="font-family:'微软雅黑', Arial; font-size:15px;" type="button" onclick="login();"  >确认登录</button>
    </div>
    <span style="display:block; width: 100%; text-align: center; font-family: '微软雅黑'; font-size: 12px; color: #C5c5c5;">
			<a href="<%=request.getContextPath()%>/mvc/personCore/findPassword.html" class="hsz">忘记密码</a></span>
    <div style="font-family:'微软雅黑', Arial; font-size:14px; color:#999; text-align:center; margin-top:10px;">客服热线：400-881-6633</div>
    </body>
  </form>
</article>
</html>









<%--<nav>--%>
	<%--<div class="tab_nav tab_nav_one">--%>
		<%--<a href="javascript:history.back(-1);">--%>
			<%--<img src="<%=request.getContextPath()%>/client/images/return.png" width="20" height="16" class="fl"/>--%>
		<%--</a>--%>
		<%--<div class="Hide fl">登 录</div>--%>
    <%--</div>--%>
<%--</nav>--%>
<%--<article>--%>
<%--<form name="loginForm" action="<%=request.getContextPath()%>/suzhouboc/myAccount.html" onsubmit="login();" method="post">--%>
	<%--<input type="hidden" name="tradeId" value="client_Login" />--%>
	<%--<div class="login clear" >--%>
       <%--<p style="font-size: 17px;">用户登陆</p>--%>
       <%--<div class="login_k">--%>
           <%--<div style="width: 100%">--%>
               <%--<input type="button" style="width: 50%" onclick="passwordLogin();" value="密码登录">--%>
               <%--<input type="button" style="width: 50%" onclick="DpasswordLogin();" value="动态密码登录">--%>
           <%--</div>--%>
           <%--<div>--%>
               <%--<input name="user_id" type="Tel" class="inp1" id="user_id"  placeholder="手机号"--%>
               	<%--/>--%>
           <%--</div>--%>
           <%--<div id="DpasswordLogin" style="display: none">--%>
               <%--<input name="mobileCode" type="text" id="mobileCode" class="inp_regist inp_w"--%>
                      <%--onblur="this.style.color='#666';if(this.value=='') this.value='动态密码';"--%>
                      <%--onfocus="this.style.color='#666';if(this.value=='动态密码') this.value='';" value="动态密码" />--%>
               <%--<button type="button" id="btn_hs" class="btn_hs cur btn_yz fr f14" onclick="Code()">获取动态密码</button>--%>
           <%--</div>--%>
           <%--<div id="passwordLogin">--%>
               <%--<input name="web_login_pwd" placeholder="密码" type="password" value="" class="inp2" id="web_login_pwd"  autocomplete="off"--%>
               	<%--onblur="this.style.color='#666';if(this.value=='')this.value='密码';"--%>
               	<%--onfocus="this.style.color='#666';if(this.value=='密码') this.value='';" value="密码" />--%>
           <%--</div>--%>
           <%--<span id="errMessage" style="color: #ff8484; margin-left: 0px;">${errorMsg}</span>--%>
           <%--<div>--%>
               <%--<input id="loginType" value="1" style="display: none">--%>
               <%--<input type="button" class="btn_hhs cur" onclick="login();" value="登  录">--%>
           <%--</div>--%>
			<%--<span style="display:block; width: 100%; text-align: center;">--%>
			<%--<a href="<%=request.getContextPath()%>/mvc/personCore/findPassword.html" class="hsz">忘记密码</a></span>--%>
       <%--</div>--%>
       <%--<input type="button" class="login_zhuce btn_hs cur" --%>
       	<%--onclick="window.location.href='<%=request.getContextPath()%>/mvc/personCore/toregister.do';" value="注册仅需10秒，我要注册">--%>
	<%--</div>--%>
<%--</form>--%>
<%--</article> --%>
<%--</html>--%>