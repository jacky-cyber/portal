<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/pages/merchant/common/include.jsp"%>
<%@ include file="/WEB-INF/pages/merchant/common/layout.jsp"%>
<!DOCTYPE html PUBLIC "-//WAPFORUM//DTD XHTML Mobile 1.0//EN" "http://www.wapforum.org/DTD/xhtml-mobile10.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<script type="text/javascript">
		function changePwd(){
			if($("#web_login_pwd").val()!=""){
				document.getElementById('pwd').style.visibility='hidden';
			}else{
				document.getElementById('pwd').style.visibility='visible';
			}
		}
        function login() {
            document.getElementById("errMessage").innerText = "";
            var user_id = document.getElementById("user_id").value;
            var password = document.getElementById("web_login_pwd").value;
            var ErrMessage = document.getElementById("errMessage");
            if (user_id == '' || user_id == '用户名') {
                ErrMessage.innerText = "提示：用户名不能为空！";
                return;
            }
            if (password == '' || password == '密码') {
                ErrMessage.innerText = "提示：密码不能为空！";
                return;
            }
            $.post('<%=request.getContextPath()%>/mvc/merchant/merchantLogin',
				{merchant_user_id : user_id,
            	login_pwd : password}, 
				function(json) {
                    debugger;
			   		if(json.success == "false") {
			   			 ErrMessage.innerText = json.errorMsg;
			   		}
			   		else {
			   			ErrMessage.innerText = '';
			   			window.location.href = '<%=request.getContextPath()%>/'+ json.url;
			   		}
			});
            return;
        }

</script>
<nav>
	<div class="tab_nav tab_nav_one">
	<%--<a href="javascript:history.back(-1)" class="back">
		<img src="<%=request.getContextPath()%>/client/images/return.png" width="20" height="16" class="fl"/>
	</a>--%>
		<div class="Hide fl">商 户 登 录</div>
    </div>
</nav>
<article>
<form name="loginForm" action="/" method="post">
	<div class="login clear" >
       <p>&nbsp;</p>
       <div class="login_k">
           <div>
               <input name="user_id" type="text"  class="inp1" id="user_id" value="用户名"
               	onblur="this.style.color='#666';if(this.value=='') this.value='用户名';" 
               	onfocus="this.style.color='#666';if(this.value=='用户名') this.value='';" />
           </div>
           <div>
               <input name="web_login_pwd" type="password" value="" class="inp2" id="web_login_pwd" onchange="changePwd()" autocomplete="off"
               	onblur="this.style.color='#666';if(this.value=='')document.getElementById('pwd').style.visibility='visible';  " 
               	onfocus="this.style.color='#666';if(this.value=='') document.getElementById('pwd').style.visibility='hidden';" />
               <span id="pwd" style="position: relative; left: 5%; top: -35px; z-index: 2; color:#666; font-size: 18px;">密码</span>
           </div>
           <span id="errMessage" style="color: #ff8484; margin-left: 0px;">${errorMsg}</span>
           <div style="background:red">
               <input type="button" class="btn_hhs cur" onclick="login();" value="登  录">
           </div>
       </div>
	</div>
</form>
</article> 
</html>