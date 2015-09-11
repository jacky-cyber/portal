$(function(){
	//获取当前输入对象
	var $write = $('.write:first'),
		shift = false,
		capslock = false;
	
	$(".write").focus(function(){
		$write = $(this);	
	});
	
	
	var input_length = 1;
	//按键点击写入
	$('#keyboard li').click(function(){
		var $this = $(this),
			character = $this.html(); 
		
		// Shift 键
		if ($this.hasClass('left-shift') || $this.hasClass('right-shift')) {
			$('.letter').toggleClass('uppercase');
			$('.symbol span').toggle();
			
			shift = (shift === true) ? false : true;
			capslock = false;
			return false;
		}
		
		// Caps lock 键
		if ($this.hasClass('capslock')) {
			$('.letter').toggleClass('uppercase');
			capslock = true;
			return false;
		}
		
		// Delete 键
		if ($this.hasClass('delete')) {
			var html = $write.val();
			
			$write.val(html.substr(0, html.length - 1)).focus();
			return false;
		}
		
		// Tab 键
		if ($this.hasClass('tab')) {
			$("body input:text, body input:password").eq(input_length).focus();
			
			input_length ++;
			
			if(input_length == $("body input:text, body input:password").length) input_length = 0;
			
			return false;
		}
		
		// 输入字符
		if ($this.hasClass('symbol')) character = $('span:visible', $this).html();
		if ($this.hasClass('space')) character = ' ';
		if ($this.hasClass('return')) character = "\n";
		
		// 判断是否大写
		if ($this.hasClass('uppercase')) character = character.toUpperCase();
		
		// 点击一次后移除 shift
		if (shift === true) {
			$('.symbol span').toggle();
			if (capslock === false) $('.letter').toggleClass('uppercase');
			
			shift = false;
		}
		
		// 输入内容
		$write.val($write.val() + character).focus();
	});
});