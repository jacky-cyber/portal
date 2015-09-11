/**
 * myHeader：头部Header自动显示与隐藏
 */
var myHeader = (function() {
	//是否已显菜单；
	var _isShow = false;

	//滚动条位置
	var _scrollPositionTop = 0;

	//touchstar位置
	var _y = 0;

	//移动距离
	var moveDistance = 5;

	//显示header
	function _showHeader() {
		setTimeout(function() {
			$("#myHeader").slideDown("fast", function() {
				_isShow = true;
			});
		}, 200);
	}

	//隐藏header
	function _hideHeader() {
		$("#myHeader").slideUp("fast", function() {
			_isShow = false;
		});
	}
	;

	//touchstart事件，初始化值
	function _start(e) {
		if (e.touches.length == 0) {
			return;
		}
		var t = e.touches[0];
		_y = t.pageY;
	}
	;

	//touchmove事件时；限制为垂直滑动页面时才起作用
	function _move(e) {
		if (e.touches.length == 0) {
			return;
		}
		var t = e.touches[0];

		var moveH = t.pageY - _y;
		var timer = null;

		//向下滑动时  延时获取滚动条位置，提高准备性
		if (moveH >= moveDistance) {
			if (timer) {
				clearTimeout(timer)
			}
			timer = setTimeout(function() {
				_scrollPositionTop = $(document).scrollTop();
				if (_scrollPositionTop <= 10 && !_isShow) {
					_showHeader();
				}
			}, 200);
		}

		//向上滑动时
		if (moveH < 0 && Math.abs(moveH) >= moveDistance) {
			if (timer) {
				clearTimeout(timer)
			}
			_hideHeader();
		}
	}
	;

	return {
		regEvent : function() {
			document.addEventListener("touchstart", _start, false);
			document.addEventListener("touchmove", _move, false);
		}
	}

})();

$(function() {
	//当滚动条发生变化时，监控滚动条的位置变化。只要是滚动条回到了顶部就显示。
	$(window).scroll(function() {
		sTimer = setTimeout(function() {
			_scrollPositionTop = $(document).scrollTop();
			if (_scrollPositionTop <= 10) {
				var header = $("#myHeader");
				if (header.is(":hidden")) {
					header.slideDown("fast");
				}
			}
		}, 300);
	});
	myHeader.regEvent("#myHeader");
});