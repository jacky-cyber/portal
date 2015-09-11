// JavaScript Document
(function($){
	$.fn.ePoP = function(options){
		var dom  = doms();
		options = $.extend({
			width:	400,
			top:	'auto',
			title:	'修改邮寄地址',
			content:	'<p align="center">请注入内容，谢谢！</p>',
			className:	'pop_ActiveLayer'
			
		},options);
		
		var _self = this;
		var _Overlay = $('<div class="pop_ActiveOverlay"></div>')
					   .css({width:dom.width+'px',height:dom.height+'px',opacity:'0.5'})
					   .html('<iframe src="about:blank" frameborder="0"></iframe>')
					   .appendTo($(document.body));
					   //.animate({opacity:0.5},{duration:200,complete:function(){}});
					   
		var _PoPbody = 	'<table width="100%" border="0" cellspacing="0" cellpadding="0">';
			_PoPbody += '<tr> <td class="tl png"></td><td class="tm png"><span class="pop_title">'+options.title+'</span></td><td class="tr png"></td></tr>';
			_PoPbody += '<tr><td class="ml png"></td><td class="content" style="width:'+(options.width-20)+'px; height:20px;"></td><td class="mr png"></td></tr>';
			_PoPbody += '<tr><td class="bl png"></td><td class="bm png"></td><td class="br png"></td></tr>';
			_PoPbody += '</table>';

		
		var _PoPCloseBtn = $('<a title="关闭" class="pop_Close" href="#"></a>')
		
		
		var _PoPLayer = $('<div class="'+options.className+'"></div>')
						.append(_PoPCloseBtn)  //添加关闭按钮
						.append(_PoPbody)		//添加窗体
						.appendTo($(document.body));	//

		
		
		if($(this).selector == 'none'){
			$(_PoPLayer).find('.content').html(options.content);
			
		}else{
			$(this).appendTo($(_PoPLayer).find('.content')).show();	
		}
		
		//定位
		
		var _PoPleft = parseInt(dom.width/2) - parseInt(options.width/2);
		var _PoPtop  = dom.top + (dom.viewHeight/2 - ($(_PoPLayer).outerHeight()/2) - 50);

		if (options.top != 'auto'){
			_PoPtop =  dom.top + options.top;
		}
		
		
		_PoPLayer.css({width:options.width+'px',top:_PoPtop+'px',left:_PoPleft+'px'});
		
		//
		var MSPoP = {
			close:function(){
				_self.appendTo($(document.body)).hide();
				$(_PoPLayer).remove();
				$(_Overlay).remove();
			}
		}
		
		_PoPCloseBtn.click(function(){	
			MSPoP.close();
			
			return false;  /*在ie下删除自身出现内存出错的问题,故返回 false*/
		});
		
		return MSPoP;
		
	}
})(jQuery);