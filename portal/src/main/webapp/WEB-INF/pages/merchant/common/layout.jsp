<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML>
<html>
  <head>
  	<title>商户端</title>
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
	
	
	
	<link rel="stylesheet" href="<%=request.getContextPath()%>/css/s/c_client.css" type="text/css"></link>
	<link rel="stylesheet" href="<%=request.getContextPath()%>/css/s/c_layout.css" type="text/css"></link>
	<link rel="stylesheet" href="<%=request.getContextPath()%>/css/s/c_public.css" type="text/css"></link>
	<link href="<%=request.getContextPath()%>/css/reset-min.css" rel="stylesheet" type="text/css">
	<link href="<%=request.getContextPath()%>/css/main.css" rel="stylesheet" type="text/css">

	<script type="text/javascript" src="<%=request.getContextPath()%>/client/js/jquery-1.4.4.min.js" charset="utf-8"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/client/js/jquery.gototop.js" charset="utf-8"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/client/js/json2.js" charset="utf-8"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/client/js/cm_ajax.js" charset="utf-8"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/client/js/jht.common.js" charset="utf-8"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/client/js/slides.min.jquery.js" charset="utf-8"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/client/js/check.js" charset="utf-8" ></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/client/js/base.js" charset="utf-8" ></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/client/js/pop.js" charset="utf-8" ></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/client/js/util.js" charset="utf-8" ></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/client/js/merchant_common.js" charset="utf-8" ></script>
	<body>
		
	</body>
</html>