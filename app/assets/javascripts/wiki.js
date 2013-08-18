// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

function update_todo(params){
	$.post("/wiki/update_todo", params);
}

var wiki_js = function(){
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

	$('#info_content_type').change(function(){
		type = $('#info_content_type option:selected').text();
		if( type == "task"){
			$('#div_form_task').show();
		}else{
			$('#div_form_task').hide();
		}
	});
}

$(document).ready(wiki_js);
$(window).bind('page:change', wiki_js);