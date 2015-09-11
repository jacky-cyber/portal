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