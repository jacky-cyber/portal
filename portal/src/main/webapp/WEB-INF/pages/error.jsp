<%@ page language="java"  pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>

  <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  <meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=0" name="viewport">
  <meta content="yes" name="apple-mobile-web-app-capable">
  <meta content="black" name="apple-mobile-web-app-status-bar-style">
  <meta content="telephone=no" name="format-detection">
  <meta http-equiv="Access-Control-Allow-Origin" content="*">
  <meta charset="UTF-8">
  <style>
    #dom_Big{
      background-color: #f9f9f9;
      width: 98%;
      margin: auto;
      height: 90px;
    }
    #dom_img{
      float: left;
      height: 90px;
      width: 10%;
      text-align: center;
      margin-top: 20px;
    }
    #dom_word{
      float: left;
      color: #555555;
      font-family: "微软雅黑";
      height: 90px;
      width: 80%;
      text-align: left;
      margin-top: 10px;
      margin-left: 15px;
    }
    img{
      height: 50px;
      width: 50px;
    }
    p{
      margin-left: 15px;
    }
  </style>
  <title>CsTips</title>
</head>
<body>
<div id="dom_Big">
  <div id="dom_img">
    <img src="<%=request.getContextPath()%>/client/images/0001.png" alt="exclamatory mark">
  </div>
  <div id="dom_word">
    <p>${msg}</p>
  </div>
</div>
</body>
</html>