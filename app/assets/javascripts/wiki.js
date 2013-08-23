// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

function update_todo(params){
	$.post("/wiki/update_todo", params);
}



var wiki_js = function(){
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

	
	$('#file_upload').ajaxForm(function(){
		alert("complete");
	});

	$('.button_file_upload').click(function(){
		$('#raw_file_content_id').val( $('#content_id').val());
		$('#dialog_file_upload').dialog({
			title: "file upload",
			buttons: [
				{text:"cancel", click: function(){$(this).dialog("close")}},
				{text:"upload", click: function(){
					$(this).dialog("close");
					$('#file_upload').submit();
					$('#raw_file_comment').val("");
					$('#raw_file_upload').val(null);
					$('#file_upload').ajaxForm(function(){
						alert("complete");
					});
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