/*Jie*/
// JavaScript Document
$(function(){
			
	//显示隐藏换肤
	var theme_flag = 0;
	$("#open_themeList").bind({
		click: function(){
			$("#themeList").css("display", "block").animate({"top":"10px", "opacity":"1"}, 500);
			setTimeout(function(){
				if(theme_flag == 0){
					$("#themeList").animate({"top":"-50px", "opacity":"0"}, 500, function(){
						$(this).css("display", "none");
					});
				}
			}, 600);
		},
		mouseover: function(){
			theme_flag = 1;
		},
		mouseleave: function(){
			theme_flag = 0;	
		}
	});
	$("#themeList").bind({
		mouseover: function(){
			theme_flag = 1;
		},
		mouseleave: function(){
			$(this).animate({"top":"-50px", "opacity":"0"}, 500, function(){
				$(this).css("display", "none");
				theme_flag = 0;
			});
		}
	});
	
	//头部一级菜单和左侧菜单的关联
	$(".quick_link li a").click(function(){
		
		$(this).parent().siblings(".active").removeClass("active");
		$(this).parent().addClass("active");	
		
		var nav_id = $("#nav_" + $(this).attr("id").substring(5));
		
		$("#new_menu > ul").animate({"margin-left" : "-250px"}, 200, function(){
			
			//$("#new_menu > ul").hide();
			$("#new_menu > ul > li").css("margin-left", "-250px");
			
			nav_id.show().css("margin-left", "7px");
			nav_id.children("li").each(function(index, element) {
				$(this).animate({"margin-left" : "0"}, (index*30));
			});
			
		});
	});
	
	//二级菜单展开隐藏
	$("#new_menu > ul > li > a").click(function(){
		var obj_cur = $("#new_menu");
		
		obj_cur.find("li.active").removeClass("active");
		$(this).parent().addClass("active");	
		
		
		obj_cur.find("li:has(ul)").each(function(index, element) {
			$(this).find("ul").slideUp(200);
		});
		$(this).parent().find("ul").slideDown(300);
	});
	
	$(".gridHeader table th").live({
		click: function(){
			$(this).closest(".gridHeader").next(".gridScroller").find(".gridTbody")
		}	
	});
	
	
	//解决dwz框架js打开dialog，z-index在底部的问题
	
	
});

