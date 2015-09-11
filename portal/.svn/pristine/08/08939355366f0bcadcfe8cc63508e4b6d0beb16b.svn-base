// JavaScript Document


/*javascript 常用函数*/
String.prototype.Trim = function(){
	return this.replace(/(^\s*)|(\s*$)/g, "");
}
String.prototype.LTrim = function(){
	return this.replace(/(^\s*)/g, "");
}
String.prototype.RTrim = function(){
	return this.replace(/(\s*$)/g, "");
}

//document的属性方法
function doms(){
		  
	  var _dd = document.documentElement;
	  var _db = document.body;
	  var _dom = _dd || _db;

	  
	  return{
		  width:  Math.max(_dom.clientWidth, _dom.scrollWidth),		// 页面宽度
		  height: Math.max(_dom.clientHeight, _dom.scrollHeight),	// 页面长度
		  left: Math.max(_dd.scrollLeft, _db.scrollLeft),			// 被滚动条卷去的文档宽度
		  top: Math.max(_dd.scrollTop, _db.scrollTop),				// 被滚动条卷去的文档高度
		  viewHeight: _dom.clientHeight,
		  viewWidth: _dom.clientWidth
	  };
};



(function($){
		  
	$(document).ready(function(){
							   
		///顶部菜单					   
		$(".v2_jht_top_wrap").find(".v2_has_drop_menu").hover(function(){
		
			$(this).children('a').css({
				'border':'1px #cccccc solid',
				'background-color':'#fbfbfb',
				'border-bottom':0,
				'margin-top':'-1px',
				'margin-left':'-1px'
			}).end().find("ul").show();
			
		},function(){
			
			$(this).children('a').css({
				'border':0,
				'margin-top':0,
				'background-color':'none',
				'margin-top':'0px',
				'margin-left':'0px'
			}).end().find("ul").hide();
		
		});
	
	
		///回到顶部按钮
		$('<a href="javascript:void(0)" class="v2_jht_gototop"></a>').appendTo('body').goToTop({
			pageWidth:960,//附着容器宽度
			pageWGap:10,//按钮和容器的距离
			pageHGap:400,//按钮和页面底部的距离
			startline:10,//出现按钮时的滚动条滚动的距离
			duration:200,//回到顶部的速度时间ms
			showBtntime:100//显示\隐藏回到顶部按钮的速度时间
		});
	
	
		///邮件订阅
		$("#subscribe_email").focus(function(){
			 var txt_val = this.defaultValue;
			 if($(this).val() == txt_val){
				$(this).val("");
			 }
		}).blur(function(){
			var txt_val = this.defaultValue;
			if($(this).val() == ''){
				$(this).val(txt_val);
			}
		});
		
		
	});

})(jQuery);

  //头部跟随滚动条
(function($){
	
	$(document).ready(function(){
		if( $.browser.msie&&parseFloat($.browser.version)<7 ){
			$("#v2_jht_top_tool").css({position:'absolute'});
			
			$(window).scroll(function(){
				$("#v2_jht_top_tool").css({'top':$(window).scrollTop()+'px'});		  
			});
		}
	});
	
})(jQuery)


