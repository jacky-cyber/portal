var isDebug = true;
function alertDebug(msg) {
    if(isDebug){
		alert(msg);
	}
}
var browser = {
    versions: function() {
        var u = navigator.userAgent,
        app = navigator.appVersion;
        return {
            trident: u.indexOf('Trident') > -1,
            // IE内核
            presto: u.indexOf('Presto') > -1,
            // opera内核
            webKit: u.indexOf('AppleWebKit') > -1,
            // 苹果、谷歌内核
            gecko: u.indexOf('Gecko') > -1 && u.indexOf('KHTML') == -1,
            // 火狐内核
            mobile: !!u.match(/AppleWebKit.*Mobile.*/) || !!u.match(/AppleWebKit/),
            // 是否为移动终端
            ios: !!u.match(/(i[^;]+\;(U;)? CPU.+Mac OS X)/),
            // ios终端
            android: u.indexOf('Android') > -1 || u.indexOf('Linux') > -1,
            // android终端或者uc浏览器
            iPhone: u.indexOf('iPhone') > -1 || u.indexOf('Mac') > -1,
            // 是否为iPhone或者QQHD浏览器
            iPad: u.indexOf('iPad') > -1,
            // 是否iPad
            webApp: u.indexOf('Safari') == -1 // 是否web应该程序，没有头部与底部
        }
    } (),
    language: (navigator.browserLanguage || navigator.language).toLowerCase()
}
var _alert;
/**
 * json对象转换为字符串
 * @param o
 * @returns {String}
 */
function JsonToStr(o) {
    var arr = [];
    var fmt = function(s) {
        if (typeof s == 'object' && s != null) return JsonToStr(s);
        return /^(string|number)$/.test(typeof s) ? '"' + s + '"': s;
    }
    for (var i in o) arr.push('"' + i + '":' + fmt(o[i]));
    return "{" + arr.join(',') + "}";
}
var eventName = "";
var eventCode = "0";
var session = {};
var _locked = false;
function lock() {
    if (_locked) {
        return true;
    }
    _locked = true;
    return false;
}
function unlock() {
    _locked = false;
}
function getWebkitEventCode() {
    return eventCode;
}
function getWebkitEvent() {
    return eventName;
}
function getWebkitValues() {
    return "";
}
function setWebkitValues(a) {}
function clearEvent() {
    eventCode = "0";
    eventName = "";
}
function setWebkitSession(a) {
    session = a;
    clearEvent();
}
var _session_timeout = false;
function showTimeOut() {
    if (!_session_timeout) {
        _session_timeout = true;
        setWebitEvent("clearEvent()", "11");
    }
}
var _mevents = new Array();
function getWebkitEventCode() {
    return _mevents.length > 0 ? _mevents.shift() : "0";
}
function getWebkitEvent() {
    return "";
}


//判断手机类型
function getPhoneType(){
	var phoneType = ""; //1 iphone/ipad; 2 android; 3 win
	
	if (browser.versions.ios || browser.versions.iPhone || browser.versions.iPad) {
    	phoneType = "1";
    } else if (browser.versions.android) {
    	phoneType = "2";
    } else {
    	phoneType = "2";
    }
	
	return phoneType;
}

//打开屏蔽层
function openWaitPanel() {
	
	var cfg = "{'msg':'加载中...','callback':''}";
	var phoneType = "";
	phoneType = getPhoneType();
	
    if (phoneType == "1") {
    	_itask = cfg;
        setWebitEvent('showWaitPanel()', '04');
    } else if (phoneType == "2") {
    	var callbackinfo = eval("(" + cfg + ")");
        window.MsgJs.showWaitPanel('');
        if('' != callbackinfo.callback){
            eval(callbackinfo.callback);
        }
    } else { // other client
    }
}

//关闭屏蔽层
function clearWaitPanel() {
	var phoneType = "";
	phoneType = getPhoneType();
	
	if (phoneType == "1") {
		setWebitEvent('closeWaitPanel()', '04');
    } else if (phoneType == "2") {
    	window.MsgJs.closeWaitPanel();
    } else { // other client
    }
    
}

//弹出消息框,一个ok按钮
function alertInfo(msg,fun) {
	
	var phoneType = "";
	phoneType = getPhoneType();
	
	if (phoneType == "1") {
		if (!fun) {
			fun = "closeWaitPanel()";
		}
		clearEvent();
		var cfg = {
			title : "提示",  // 标题
			msg : msg,
			ok_btn : "false", // 不显示ok按钮
			ok_text : "",
			ok_func : "",
			cancle_text : "确定", // 显示取现按钮 
			cancle_func : fun  // 点击确定后,客户端回调的方法
		};
		_alert = cfg;
	    setWebitEvent("getAlertInfo()", "05");
    } else if (phoneType == "2") {
    	if (!fun) {
			fun = "closeWaitPanel()";
		}
    	var cfg = {title:'提示', msg:msg, ok_btn:'false', cancle_text:'确定', cancle_func:fun};
    	window.MsgJs.setAlertInfo(JsonToStr (cfg));
    } else { // other client
    }
}

function getAlertInfo(){
	return JsonToStr(_alert);
}

//弹出提示信息，两个按钮，左边的
function confirmInfo(cfg) {
	var phoneType = "";
	phoneType = getPhoneType();
	
	if (phoneType == "1") {
		_alert = cfg;
	    setWebitEvent("getAlertInfo()", "05");
    } else if (phoneType == "2") {
    	window.MsgJs.setAlertInfo(JsonToStr (cfg));
    } else { // other client
    }
}

var cmbcParams = "";
function setFuncParams(){
    return JsonToStr(cmbcParams);
}

//设置标题栏内容和左右按钮的事件
function setTitleBar(jsonParam){
	cmbcParams = jsonParam;
	setWebitEvent("setFuncParams()", "updateTitleInfo");
}

//从商城回到手机银行客户端画面
function goBack(){

	setWebitEvent("closeWaitPanel()", "goBack");
}

//隐藏民生的title
function hideTitleBar(){

	setWebitEvent("", "hideTitleBar");
}

//商户联合登录，并跳转商户url
function loginForComm(beforeUrl,toUrl){
	var p = {
			'beforeUrl':beforeUrl,
			'toUrl':toUrl
		};
	cmbcParams = p;
	setWebitEvent("setFuncParams()", "loginForComm");
}

//跳转商户url
function gotoShopUrl(toUrl){
	var p = {
			'toUrl':toUrl
		};
	cmbcParams = p;
	setWebitEvent("setFuncParams()", "gotoShopUrl");
}

//提交支付订单
function submitOrderForCash(orderInfo){
	alertDebug("submitOrderForCash:"+orderInfo);
	setWebitEvent(orderInfo, "submitOrderForCash");
}

//提交订单,用于后面进行逻辑处理
function submitOrderForComm(orderInfo, eventNo){
	var p = {
		'orderInfo':orderInfo,
		'eventNo':eventNo
	};
	cmbcParams = p;
	setWebitEvent("setFuncParams()", "submitOrderForComm");
}
/*	获取客户端的信息 	 
	return	{"CMBCDeviceSysVersion":"7.1.2",	//系统版本号
				"CMBCDeviceModel":"iPhone",		//设备类型
				"CMBCAppType":"1",				//当前应用类型 1为个人版本  2为小薇版本 3企业 4信用卡专版
				"CMBCReleaseVersion":"2.5"}     //当前版本号
*/
function getClientInformation(methodNameOrParam){
	if(methodNameOrParam == undefined || methodNameOrParam == null || methodNameOrParam == ""){
		methodNameOrParam = "temp";
	}
	alertDebug(methodNameOrParam);
	var clientMsg = setWebitEvent(methodNameOrParam, "clientInformation");
	alertDebug("获取客户端的信息:"+clientMsg);
	if(clientMsg != undefined && clientMsg != null){
		alertDebug("获取客户端的信息:"+clientMsg);
		eval(methodNameOrParam+"('"+clientMsg+"')");
		return clientMsg; // android 返回，ios不返回，如果不用code码，也可以返回
	}
}

function getLatLongitude(callBackMethod){
	return setWebitEvent(callBackMethod, "getLatLongitude");
}
// -------------------------Android iPhone 公共（合并）的方法----------------------
function setWebitEvent(methodNameOrParam, evtCode) {// code:ios监听的code,b:ios 回调的方法名
	var phoneType = "";
	phoneType = getPhoneType();
	alertDebug("setWebitEvent.phoneType:"+phoneType+",code:"+evtCode+",methodNameOrParam:"+methodNameOrParam);
    if (methodNameOrParam == "") {
        return;
    }
    if (phoneType == "1") { // ios 客户端
        _mevents.push(JsonToStr({
            code: evtCode,
            name: methodNameOrParam
        }));
    } else if (phoneType == "2") {  // Android客户端
        return setAndroidWebitEvent(methodNameOrParam, evtCode);
    } else { // other client
    }
}

function setAndroidWebitEvent(methodNameOrParam, evtCode) {
	alertDebug("setAndroidWebitEvent.methodNameOrParam:" + methodNameOrParam + ",evtCode:" + evtCode);
    switch (evtCode) {
    case "submitOrderForCash":
        { // 1用商户证书加密后的订单信息
            // var param = eval(methodNameOrParam);
            window.SysClientJs.submitOrderForCash(methodNameOrParam);
            break;
        }
    case "submitOrderForComm":
        { // 2积分提交订单接口
            var param = eval(methodNameOrParam);
            window.SysClientJs.submitOrderForComm(param);
            break;
        }
    case "goBack": // code 13,A2
        { // 3从商城回到手机银行客户端画面
            window.SysClientJs.goBack();
            break;
        }
    case 'loginForComm':
        { // 4(toUrl，params) 登录后要跳转的url,登录所需要传的参数列表
            var titlejson = eval(methodNameOrParam);
            window.SysClientJs.loginForComm(titlejson);
            break;
        }
    case 'gotoShopUrl':
        { // 5 需要跳转的商户url,所需的参数列表
            var alertjson = eval(methodNameOrParam);
            window.SysClientJs.gotoShopUrl(alertjson);
            break;
        }
    case 'sessionTimeOut':
        { // 6 Session超时 退出登录(已有的code码)
            window.MsgJs.sessionTimeOut(methodNameOrParam);
            break;
        }
    case 'updateTitleInfo':
        { // 7 设置标题栏及标题的左按钮和右按钮(已有的code码)
            var titlejson = eval(methodNameOrParam);
            window.SysClientJs.updataTitleInfo(titlejson);
            break;
        }
    case "hideTitleBar": //
	    { // 隐藏民生title
	        window.SysClientJs.hideTitleBar();
	        break;
	    }
	case "getLatLongitude": 
		{ // 服务器获取客户端的经纬度,客户端回调methodNameOrParam:setLatLongitudeCallBack(String latitude,String longitude)｛// 经度 ，纬度 
	        window.SysClientJs.getLatLongitude(methodNameOrParam);
	        break;
	    }
    case "clientInformation": 
		{ // 通用商户接入,添加客户端信息获取
	        return window.SysClientJs.clientInformation();
			// eval(methodNameOrParam+"("+clientInformation+")");
	    }
    }
}