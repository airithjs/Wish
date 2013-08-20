// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

function update_todo(params){
	$.post("/wiki/update_todo", params);
}

function check_content_type(){
	type = $('#info_content_type option:selected').text();
	if( type == "task"){
		$('#div_form_task').show();
	}else{
		$('#div_form_task').hide();
	}
}

var wiki_js = function(){
	check_content_type();

	$('.unload').each(function(){
      content_id = $(this).attr("content_id");
      $(this).load("/wiki/fragment", {content_id: content_id});
      $(this).removeClass('unload');
  });

	$('.button_update_todo').click(function(){
		content_id = $(this).attr("content");
		idx = $(this).attr("idx");
		title = $(this).attr("text");
		dialog = $(this)
		$('#dialog_todo_update').text(idx + ". " + title);

		$('#dialog_todo_update').dialog({
			title:"Update To Do",
			width: "500px",
			buttons: [
				{
					text:"Complete", 
					click: function(){
						update_todo({content_id:content_id, idx:idx, state:"complete"});
						$(this).dialog("close");
					}
				},
				{
					text:"Fail", 
					click: function(){
						update_todo({content_id:content_id, idx:idx, state:"fail"});
						$(this).dialog("close");
					}
				},
				{
					text:"Cancle",
					click: function(){
						update_todo({content_id:content_id, idx:idx, state:"cancel"});
						$(this).dialog("close");
					}
				}
			]
		});
	});

	$('#info_content_type').change(check_content_type);

	$('.button_file_upload').click(function(){
		$('#dialog_file_upload').dialog({
			title: "file upload",
			buttons: [
				{text:"cancel", click: function(){$(this).dialog("close")}},
				{text:"upload", click: function(){
					$(this).dialog("close");
					$('#file_upload').submit();
				}}
			]
		});
	});

	$('#button_find_image').click(function(){
		$('#div_select_image').load("/wiki/images");
		$('#div_select_image').dialog({
			title : "find image",
			width: 800, height: 600,
			buttons: [
				{text:"select", click: function(){$(this).dialog("close")}}
			]
		});
	});
}

$(document).ready(wiki_js);
$(window).bind('page:change', wiki_js);