function check_content_type(){
	type = $('#info_content_type option:selected').text();
	if( type == "task"){
		$('#div_form_task').show();
		$('#div_form_project').hide();
	}else if( type == "project" ){
		$('#div_form_task').hide();
		$('#div_form_project').show();
	}else{
		$('#div_form_task').hide();
		$('#div_form_project').hide();
	}
}


var editor_js = function(){
	check_content_type();
	$('#info_content_type').change(check_content_type);

	$('#edit_submit').click(function(){
		comment = $('#comment').val();
		if( comment == ""){
			alert("Please input comment");
			event.preventDefault();
		}else{
			alert("save");
		}
	})	
}



$(document).ready(editor_js);
$(window).bind('page:change', editor_js);