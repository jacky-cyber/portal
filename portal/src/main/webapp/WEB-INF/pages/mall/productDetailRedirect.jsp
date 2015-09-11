<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@page import="com.ifunpay.portal.ProjectXml" %>
<%--<%@page import="com.mopon.dhb.core.entity.base.*"%>--%>

<%@include file="/WEB-INF/common/include.jsp" %>
<%@include file="/WEB-INF/common/jscss.jsp" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html>
<head>
    <title>金融云平台</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=0"
          name="viewport">
    <meta content="yes" name="apple-mobile-web-app-capable">
    <meta content="black" name="apple-mobile-web-app-status-bar-style">
    <meta content="telephone=no" name="format-detection">
    <meta http-equiv="Access-Control-Allow-Origin" content="*">
</head>


<script type="text/javascript">

    var flg = true;
    var str = "";


    function newtab(n) {
        var tabnav = "newtab" + n;
        var tabid = "newtabid" + n;
        cleardisplay();

        document.getElementById(tabid).style.display = "block";
        f_addClass(document.getElementById(tabnav), 'new_nav_sel_li');
    }
    function cleardisplay() {
        for (i = 1; i < 4; i++) {
            var cleartabid = "newtabid" + i;
            document.getElementById(cleartabid).style.display = "none";
            f_removeClass(document.getElementById("newtab" + i), 'new_nav_sel_li');
        }
    }
    function f_addClass(obj, className) {
        if (obj) {
            obj.className += ' ' + className;
        }
    }
    function f_removeClass(obj, className) {
        var reg = new RegExp('^' + className + '\\s|\\s' + className + '$|' + className + '\\s');
        if (obj) {
            obj.className = obj.className.replace(reg, '');
        }
    }


    function bindClickSubmit() {
        if (flg == true) {
            $("form[name=orderform]").submit();
            return true;
        }
        return false;
    }

    $(document).on("pageinit", "#pageone", function () {

        $("img[name='imageUrls']").on("swiperight", function () {

            if (2 == $("#pictureSelect").val()) {
                $("#image1").show();
                $("#image2").hide();
                $("#image3").hide();
                $("#pictureSelect").val("").val(1);
                $("#upper").hide();
                $("#next").show();
            } else if (3 == $("#pictureSelect").val()) {
                $("#image1").hide();
                $("#image2").show();
                $("#image3").hide();
                $("#pictureSelect").val("").val(2);
                $("#upper").show();
                $("#next").show();
            }

        });
    })
    $(document).on("pageinit", "#pageone", function () {
        $("img[name='imageUrls']").on("swipeleft", function () {

            if (1 == $("#pictureSelect").val()) {
                $("#image1").hide();
                $("#image2").show();
                $("#image3").hide();
                $("#pictureSelect").val("").val(2);
                $("#upper").show();
                $("#next").show();
            } else if (2 == $("#pictureSelect").val()) {
                $("#image1").hide();
                $("#image2").hide();
                $("#image3").show();
                $("#pictureSelect").val("").val(3);
                $("#upper").show();
                $("#next").hide();
            }
        });
    })
    $(document).ready(function () {
        $("#upper").click(function () {
            if (2 == $("#pictureSelect").val()) {
                $("#image1").show();
                $("#image2").hide();
                $("#image3").hide();
                $("#pictureSelect").val("").val(1);
                $("#upper").hide();
                $("#next").show();
            } else if (3 == $("#pictureSelect").val()) {
                $("#image1").hide();
                $("#image2").show();
                $("#image3").hide();
                $("#pictureSelect").val("").val(2);
                $("#upper").show();
                $("#next").show();
            }
        });

        $("#next").click(function () {
            if (1 == $("#pictureSelect").val()) {
                $("#image1").hide();
                $("#image2").show();
                $("#image3").hide();
                $("#pictureSelect").val("").val(2);
                $("#upper").show();
                $("#next").show();
            } else if (2 == $("#pictureSelect").val()) {
                $("#image1").hide();
                $("#image2").hide();
                $("#image3").show();
                $("#pictureSelect").val("").val(3);
                $("#upper").show();
                $("#next").hide();
            }
        });
    });

</script>
<div data-role="page" id="pageone">
    <nav>
        <div class="tab_nav tab_nav_one">
            <c:if test="${flag != '1' }"> <!-- 扫码没有后退 -->
                <a href="javascript:history.back(-1);">
                    <img src="<%=request.getContextPath()%>/client/images/return.png" width="20" height="16"
                         class="fl"/>
                </a>
            </c:if>
            <div class="Hide fl">${product.name}</div>
        </div>
    </nav>
    <article>
        <div class="product_infor">
            <form name="orderform" id="orderform" class="orderform" method="post"
                  action="<%=request.getContextPath()%>/mvc/mallszccb/toOrderConfirmRd.html">
                <input type="hidden" name="apId" id="apId" value="${product.id}"/>
                <input type="hidden" name="flag" id="flag" value="${flag}"/>
                <input type="hidden" name="terminalId" value="${terminalId}"/>
                <input type="hidden" name="needLogin" value="${needLogin}"/>
                <input type="hidden" name="serialNo" value="${serialNo}"/>

                <div class="product_in  top">
                    <input type="hidden" id="imageUrl" value="${product.coverImgUrl}"/>

                    <div class="product_img">
                        <input id="pictureSelect" value="1" style="display: none">
                        <img id="upper" style="width: 30px;height: 30px;margin-bottom: 100px; display: none"
                             src="<%=request.getContextPath()%>/client/images/upper.png"/>
                        <img name="imageUrls" id="image1" src="${baseUrl}${picture1}" width="192px" height="220px"/>
                        <img name="imageUrls" id="image2" style="display: none" src="${baseUrl}${picture2}"
                             width="192px" height="220px"/>
                        <img name="imageUrls" id="image3" style="display: none" src="${baseUrl}${picture3}"
                             width="192px" height="220px"/>
                        <img id="next" style="width: 30px;height: 30px; margin-bottom: 100px; z-index: 1000;"
                             src="<%=request.getContextPath()%>/client/images/next.png"/>

                    </div>


                    <div id="acProName" class="product_tit">${product.name}</div>

                    <div class="price_div1">
                        <div class="price_left">
                            <div>
                                <div><strong id="sellCountter" class="hsz f20">${activityProduct.buyerNumNow}</strong>人已抢购
                                </div>
                                <div>价格：<span class="f20 red">¥<fmt:formatNumber value="${product.price}"
                                                                                 type="currency" pattern="#.##"
                                                                                 minFractionDigits="2"/></span></div>
                            </div>
                        </div>
                        <div class="price_right">
                            <div clsaa="price_qg" style="text-align:center;">
                                <a href="javascript:void(0)" class="buy_btn" onclick="bindClickSubmit();return false;">立即购买</a>
                            </div>
                        </div>
                    </div>

                    <div class="clear"></div>
                </div>
            </form>
        </div>
        <span id="errMessage" style="color: red;">${errorMsg}</span>

        <div class="new_nav clear fl">
            <ul>
                <li class="cur new_nav_sel_li" id='newtab1' onclick='newtab(1)'>商品介绍</li>
                <li class="cur" id='newtab2' onclick='newtab(2)'>本单详情</li>
                <li class="cur" id='newtab3' onclick='newtab(3)' style="border-right: none; box-shadow:none;">商品特色</li>
            </ul>
        </div>

        <div id='newtabid1' class='tabid clear mr_top'>
            <div class="story clear">
                <p>
                    ${activityProduct.product.productOutline}
                </p>
            </div>
        </div>
        <div id='newtabid2' class='tabid clear' style='display: none;'>
            <div class="story clear" style="height: auto;">
                <p>
                    ${activityProduct.product.productOutline}
                </p>
            </div>
        </div>
        <div id='newtabid3' class='tabid clear' style='display: none;'>
            <div class="story clear ">
                <p>
                    ${activityProduct.product.productFeature}
                </p>
            </div>
        </div>
    </article>
</div>
</html>