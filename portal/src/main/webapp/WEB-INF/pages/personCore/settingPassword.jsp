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
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <meta content="yes" name="apple-mobile-web-app-capable">
  <meta content="black" name="apple-mobile-web-app-status-bar-style">
  <meta content="telephone=no" name="format-detection">
  <meta http-equiv="Access-Control-Allow-Origin" content="*">
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
    .folat {float:left;}
    .td {
      width:100%;
      height:45px;
    }
    .get_code
    {
      height:44px;
      width:30%;
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
    .select { width:185px; height:27px; background:none; border:none;}
  </style>
</head>

<script type="text/javascript">
  var settingP ='${settingP}';
  $(function(){
    if(settingP ==1){
      alert(settingP);
      $("#viewOldPwd").show();
    }

  })
  function validateFrom() {
    $("#errMessage").text("");
    var pwd = $("#pwd").val();
    var confirm_pwd = $("#confirm_pwd").val();
    var oldPwd = $("#oldPwd").val();
    if(settingP==1){
      if (oldPwd == '' || oldPwd == '初始密码') {
        $("#errMessage").text("初始密码不能为空");
        return;
      }
    }
    if (pwd == '' || pwd == '密码') {
      $("#errMessage").text("密码不能为空");
      return;
    }
    if (confirm_pwd == '' || confirm_pwd == '确认密码') {
      $("#errMessage").text("确认密码不能为空");
      return;
    }
    if (pwd !=confirm_pwd ) {
      $("#errMessage").text("两次密码不一致");
      return;
    }
    $.ajax({
      type : "post",
      url : "<%=request.getContextPath()%>/mvc/personCore/savePwd.do",
      data: "oldPwd="+oldPwd+"&pwd="+pwd+"&settingP="+settingP,
      dataType:"json",
      success : function(msg) {
        var success = msg.success;
        if(success == "success"){
          $("#errMessage").text("修改成功");
        }else{
          $("#errMessage").text("修改失败");
        }
      }
    });
  }


</script>
<body style="margin:0 auto; width:100%;">
<nav>
  <div STYLE="background-color: rgba(24, 24, 24, 0.87);height: 40px">
    <a href="javascript:history.back(-1);">
      <img src="<%=request.getContextPath()%>/client/images/return.png" width="20" height="16" style="margin-top: 10px;margin-left: 10px"  />

    </a><span style="margin-top:-14px ;   display: block;text-align: center;font-size: 20px;font-weight: bold;font-style: normal;color: #fff;"  >设置/修改密码</span>
  </div>
</nav>
<article>

  <div style="margin:0 auto; width:96%;">
    <form action="<%=request.getContextPath()%>/mvc/personCore/savePwd.do" id="myform" method="post">
      <table style="border:1px solid gainsboro; width:100%;font-size: 18px;background-color: white;"  cellspacing=0 frame="hsides" rules="rows" cellpadding=0>

        <div>&nbsp;</div>
        <div>&nbsp;</div>
        <tr id="viewOldPwd" style="display: none">
          <td class="tddg">&nbsp;初始密码：</td>
          <td><input type="password" name="oldPwd" id="oldPwd" value="" style="border-style:solid; border-width: 0;width: 97%;height: 26px;font-size: 16px;color: #808080;"  placeholder="&nbsp;初始密码" >
          </td>

        </tr>
        <tr>
          <td class="tddg">&nbsp;密&nbsp;&nbsp;码：</td>
          <td><input type="password" name="pwd" id="pwd" value="${pwd}" style="border-style:solid; border-width: 0;width: 97%;height: 26px;font-size: 16px;color: #808080;"  placeholder="&nbsp;密码" >
          </td>

        </tr>
        <tr>
          <td class="tddg">&nbsp;确认密码：</td>
          <td><input name="confirm_pwd" type="password" style="border-style:solid; border-width: 0;width: 97%;height: 26px;font-size: 16px;color: #808080;" maxlength="10" id="confirm_pwd"
                     placeholder="&nbsp;确认密码" />
          </td>

        </tr>
      </table>
      <div>&nbsp;</div>
      <div style="width: 300px;text-align: center;">
        <span id="errMessage" style="color: red;font-size: 16px;line-height: 28px;">${errorMsg}</span>
      </div>
      <div>
        <input name =settingP value="${settingP}" style="display: none"/>
        <button class="get_codes" type="button" style=" font-family:'微软雅黑', Arial; font-weight:bold; font-size:16px; color:#333;" onclick="validateFrom();" >提交</button>

      </div>
      <div>&nbsp;</div>


    </form>
  </div>

</article>
</body>

</html>
