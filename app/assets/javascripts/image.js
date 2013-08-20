function copyToClipboard (text) {  
	window.prompt ("Copy to clipboard: Ctrl+C, Enter", text); 
}

var img_js = function(){
	$('.button_img_select').click(function(){
		fileid = $(this).attr("fileid");
		copyToClipboard("[[img|id:" + fileid + "]]");
	});
}

$(document).ready(img_js);
$(window).bind('page:change', img_js);