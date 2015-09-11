function hint(id){
	if(!id) return;
	var obj = document.getElementById(id);
	if(obj){
		obj.title = obj.getAttribute('title');
		if(!obj.title) return;
		obj.onblur = function(){
			obj.style.color = "#999999";
			if(!obj.value || obj.value == obj.title){
				 obj.value = obj.title
			}
		}
		obj.onfocus = function(){
			obj.style.color = "#333333";
			if(obj.value == obj.title){
				 obj.value = '';
			}
		}
		obj.onblur();
	}
}