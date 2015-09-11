<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<script type="text/javascript" src="<%=request.getContextPath()%>/client/js/jquery-1.8.0.min.js" charset="utf-8"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/client/js/jquery.gototop.js" charset="utf-8"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/iscroll.js" charset="utf-8"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/client/js/idangerous.swiper.min.js"></script>
<link rel="stylesheet" href="http://code.jquery.com/mobile/1.3.2/jquery.mobile-1.3.2.min.css" />
<script src="http://code.jquery.com/mobile/1.3.2/jquery.mobile-1.3.2.min.js"></script>
<%--<script type="text/javascript" src="<%=request.getContextPath()%>/js/city.js" type="text/javascript"></script>--%>
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
    .bodycolor{
        background-color:#fbfbfb;
        margin:0 auto;
        width:100%;
        font-family:"微软雅黑", Arial;
    }
    .folat {float:left;}
    .font{
        color:red;
        font-size:16px;
        font-weight:bold;
    }

    *{margin:0;padding:0;}
    body{font-size:14px;font-family:"Microsoft YaHei";}
    ul,li{list-style:none;}

    #tab{position:relative;}
    #tab .tabList ul li{
        float:left;
        background:#fefefe;
        background:-moz-linear-gradient(top, #fefefe, #ededed);
        background:-o-linear-gradient(left top,left bottom, from(#fefefe), to(#ededed));
        background:-webkit-gradient(linear,left top,left bottom, from(#fefefe), to(#ededed));
        border:1px solid #ccc;
        padding:5px 0;
        width:100px;
        text-align:center;
        position:relative;
        cursor:pointer;
    }
    #tab .tabCon{
        position: absolute;
        top: 35px;
        border: 1px solid #ccc;
        border-top: none;
        width: 98%;
        height: 200px;
        left: -6px;
    }
    #tab .tabCon div{
        padding:10px;
        position:absolute;
        opacity:0;
        filter:alpha(opacity=0);
    }
    #tab .tabList li.cur{
        border-bottom:none;
        background:#fff;
    }
    #tab .tabCon div.cur{
        opacity:1;
        filter:alpha(opacity=100);
    }

    ul,ol,li       	{ list-style:none; }
    .ofh{overflow:hidden;}
    .pagination{
        width: 100px;;
        margin:0 auto;
    }
    .pagination ul li{float:left; width:10px; height:10px; margin:0 5px; background-color:#aaa; border-radius:10px;  }
    .pagination ul li.cur{background-color:#FC0;}

    body{margin:0;font-family:"microsoft yahei";font-size:13px;line-height:1.5;}
    .wrap{margin:10px auto 0 auto; border:1px solid #CCC;}
    .tabs{height:40px;}
    .tabs a{display:block;float:left;width:31.00%;color:#333;text-align:center;background:#E9E9E9;line-height:40px;font-size:16px;text-decoration:none; border-left: 1px solid #FF0000;
        margin-right: -1px;
        padding-left: 5px;}
    .tabs a.active{color:#333;background:#FFF; background-color:red; height:2px;}
    .swiper-container{background:#FFF; width:100%;border-top:0; }
    .swiper-slide{width:100%;background:none;color:#333;}
    .content-slide{padding:7px;}
    .content-slide p{text-indent:2em;line-height:1.9;}
    .swiper-container {margin:0 auto;position:relative;overflow:hidden;-webkit-backface-visibility:hidden;-moz-backface-visibility:hidden;-ms-backface-visibility:hidden;-o-backface-visibility:hidden;backface-visibility:hidden;/* Fix of Webkit flickering */	z-index:1;}
    .swiper-wrapper {position:relative;width:100%;
        -webkit-transition-property:-webkit-transform, left, top;
        -webkit-transition-duration:0s;
        -webkit-transform:translate3d(0px,0,0);
        -webkit-transition-timing-function:ease;

        -moz-transition-property:-moz-transform, left, top;
        -moz-transition-duration:0s;
        -moz-transform:translate3d(0px,0,0);
        -moz-transition-timing-function:ease;

        -o-transition-property:-o-transform, left, top;
        -o-transition-duration:0s;
        -o-transform:translate3d(0px,0,0);
        -o-transition-timing-function:ease;
        -o-transform:translate(0px,0px);

        -ms-transition-property:-ms-transform, left, top;
        -ms-transition-duration:0s;
        -ms-transform:translate3d(0px,0,0);
        -ms-transition-timing-function:ease;

        transition-property:transform, left, top;
        transition-duration:0s;
        transform:translate3d(0px,0,0);
        transition-timing-function:ease;

        -webkit-box-sizing: content-box;
        -moz-box-sizing: content-box;
        box-sizing: content-box;
    }
    .swiper-free-mode > .swiper-wrapper {
        -webkit-transition-timing-function: ease-out;
        -moz-transition-timing-function: ease-out;
        -ms-transition-timing-function: ease-out;
        -o-transition-timing-function: ease-out;
        transition-timing-function: ease-out;
        margin: 0 auto;
    }
    .swiper-slide {
        float: left;
        -webkit-box-sizing: content-box;
        -moz-box-sizing: content-box;
        box-sizing: content-box;
    }
</style>
</head>


<div data-role="page" id="pageone">
<body class="bodycolor"  oncontextmenu='return false' ondragstart='return false'>
<div style="width:97%; height:390px; background-color:#FFF; border:1px solid #E0E0E0; margin:0 auto; margin-top:10px;">
    <%--<div style="margin:0 auto; margin-top:5px; text-align:center;">--%>
        <%--<img src="${imageUrl}" width="280" height="260">--%>
    <%--</div>--%>
    <div style="margin:0 auto; margin-top:5px; text-align:center;">
        <input  id="pictureSelect" value="1" style="display: none">
        <%--<img id = "upper"  style="width: 30px;height: 30px;margin-bottom: 100px; display: none" src="<%=request.getContextPath()%>/client/images/upper.png" />--%>
        <c:forEach items="${listPictures}" var="pic" varStatus="vs">
            　 <img  name="imageUrls" id="image${vs.count}"  src="${pic.picture}" width="192px" height="220px" />

        </c:forEach>
        <%--<img  id="next"  style="width: 30px;height: 30px; margin-bottom: 100px; z-index: 1000;" src="<%=request.getContextPath()%>/client/images/next.png" />--%>

    </div>
    <div class="pagination" style="margin-left:45%; margin-top:5px;">
        <ul class="ofh">
            <c:forEach items="${listPictures}" var="dian" varStatus="dian">
                <li class="switch" id="switch${dian.count}"></li>
            </c:forEach>

        </ul>
    </div>
    <div style="margin-left:3%; margin-top:5px; width:95%; font-size:15px;">
        ${product.name}
    </div>
    <div style="margin-left:3%; width:130px; margin-top:15px;">
        <div>
            <samp>市场价：</samp>
            <samp style="text-decoration:line-through;">${product.salePrice} 元</samp>
        </div>
        <div>
            <samp>销售价：</samp>
            <samp class="font"></samp>
            <samp>${product.scanningPrice}元</samp>
        </div>
    </div>
    <div style="width:118px;height: 44px; margin-top:-62px; margin-left: 58%">
        <%--<div style="text-align:right;">--%>
            <%--<samp class="font">${product.baseSale}</samp>--%>
            <%--<samp>人已购买</samp>--%>
        <%--</div>--%>
        <div align="right">
            <input  style="width:118px;height: 44px; background-color:#FC0; border:1px solid #FC0;" type="button" id="toConfirm" value="立即抢购">
        </div>
    </div>
</div>

<div class="wrap" style="width:97%;">
    <div class="tabs">
        <a href="#" hidefocus="true" class="active" id="scription">商品详情</a>
        <a href="#" hidefocus="true" id="activit">活动说明</a>
        <a href="#" hidefocus="true"id="shopkeeper" >店铺信息</a>
    </div>
    <div class="swiper-container">
        <div class="swiper-wrapper">
            <div class="swiper-slide" id="1scription">
                <div class="content-slide" >
                ${product.productExt.mdescription}
                </div>
            </div>
            <div class="swiper-slide" id="1activit" style="display: none">
                <div class="content-slide">
                </div>
            </div>
            <div class="swiper-slide" id="1shopkeeper" style="display: none" >
                <div class="content-slide">
                </div>
            </div>
        </div>
    </div>
</div>

</body>
</div>
</html>

<script>
    var tabsSwiper = new Swiper('.swiper-container',{
        speed:500,
        onSlideChangeStart: function(){
            $(".tabs .active").removeClass('active');
            $(".tabs a").eq(tabsSwiper.activeIndex).addClass('active');
        }
    });

    $(".tabs a").on('touchstart mousedown',function(e){
        e.preventDefault()
        $(".tabs .active").removeClass('active');
        $(this).addClass('active');
        tabsSwiper.swipeTo($(this).index());
        var name = $('.tabs .active').eq(0).attr('id');
        $(".swiper-slide").hide();
        $("#1"+name).show();
    });

    $(".tabs a").click(function(e){
        e.preventDefault();
    });


         $("#toConfirm").click(function(){
            window.location.href = "<%=request.getContextPath()%>/" +'${url}';
        })



    var pictureCount = parseInt('${pictureCount}');

    $(document).on("pageinit","#pageone",function() {
        $("img[name='imageUrls']").on("swiperight", function () {
            var pictureSelect = parseInt($("#pictureSelect").val());
            if(1<pictureSelect){
                var pictureShow = pictureSelect-1;
                if(2<pictureSelect){
                    $("#upper").show();
                    $("#next").show();
                    $("[name='imageUrls']").hide();
                    $("#image"+pictureShow).show();
                    $("li.switch").removeClass("cur");
                    $("#switch"+pictureShow).addClass("cur");
                    $("#pictureSelect").val("").val(pictureSelect-1);
                }else{
                    $("#upper").show();
                    $("#next").hide();
                    $("[name='imageUrls']").hide();
                    $("#image"+pictureShow).show();
                    $("li.switch").removeClass("cur");
                    $("#switch"+pictureShow).addClass("cur");
                    $("#pictureSelect").val("").val(pictureSelect-1);
                }
            }

        });
    })
    $(document).on("pageinit","#pageone",function() {
        $("img[name='imageUrls']").on("swipeleft", function () {
            var pictureSelect = parseInt($("#pictureSelect").val());
            if(pictureCount>pictureSelect){
                var pictureShow = pictureSelect+1;
                if(pictureCount-1>pictureSelect){
                    $("#upper").show();
                    $("#next").show();
                    $("[name='imageUrls']").hide();
                    $("#image"+pictureShow).show();
                    $("li.switch").removeClass("cur");
                    $("#switch"+pictureShow).addClass("cur");
                    $("#pictureSelect").val("").val(pictureSelect+1);
                }else{
                    $("#upper").hide();
                    $("#next").show();
                    $("[name='imageUrls']").hide();
                    $("#image"+pictureShow).show();
                    $("li.switch").removeClass("cur");
                    $("#switch"+pictureShow).addClass("cur");
                    $("#pictureSelect").val("").val(pictureSelect+1);
                }
            }


        });
    })
    $(document).ready(function() {
        $("#upper").click(function () {
            debugger
            var pictureSelect = parseInt($("#pictureSelect").val());
            if(1<pictureSelect){
                var pictureShow = pictureSelect-1;
                if(2<pictureSelect){
                    $("#upper").show();
                    $("#next").show();
                    $("[name='imageUrls']").hide();
                    $("#image"+pictureShow).show();
                    $("#pictureSelect").val("").val(pictureSelect-1);
                }else{
                    $("#upper").hide();
                    $("#next").show();
                    $("[name='imageUrls']").hide();
                    $("#image"+pictureShow).show();
                    $("#pictureSelect").val("").val(pictureSelect-1);
                }
            }
        });

        $("#next").click(function () {
            var pictureSelect = parseInt($("#pictureSelect").val());
            if(pictureCount>pictureSelect){
                var pictureShow = pictureSelect+1;
                if(pictureCount-1>pictureSelect){
                    $("#upper").show();
                    $("#next").show();
                    $("[name='imageUrls']").hide();
                    $("#image"+pictureShow).show();
                    $("#pictureSelect").val("").val(pictureSelect+1);
                }else{
                    $("#upper").show();
                    $("#next").hide();
                    $("[name='imageUrls']").hide();
                    $("#image"+pictureShow).show();
                    $("#pictureSelect").val("").val(pictureSelect+1);
                }
            }

        });
        $("[name='imageUrls']").hide();
        $("#image1").show();
        $("#switch1").addClass("cur");
        if(1==parseInt('${pictureCount}')){
            $("#next").hide();
        }
    });
</script>