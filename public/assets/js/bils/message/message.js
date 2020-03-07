// All the user related js functions will be here
$(document).ready(function () {	
	
	// for get site url
	var url = $('.site_url').val();

	
	//Load App User Group Using Notice Controller
	$.ajax({
		url: url+'/notice/load-app-user-groups',
		success: function(response){
			var data = JSON.parse(response);
			if(!jQuery.isEmptyObject(data)){
				var html = '<table class="table table-bordered"><thead><tr class="headings"><th class="column-title text-center" class="col-md-8 col-sm-8 col-xs-8" >App User Groups</th><th class="col-md-2 col-sm-2 col-xs-12"> <input type="checkbox" id="check-all" class="tableflat">Select All</th></tr></thead>';
					html += '<tr><td colspan="2">';
					$.each(data, function(i,data){
						html += '<div class="col-md-3" style="margin-top:5px;"><input type="checkbox"  name="app_user_group[]"  class="tableflat check_permission"  value="'+data["id"]+'"/> '+data["group_name"]+'</div>';
					});
					html += '</td></tr>';
				html +='</table>';	
			}
			$('#app_user_group').html(html);
			
			$('#message_form').iCheck({
					checkboxClass: 'icheckbox_flat-green',
					radioClass: 'iradio_flat-green'
			});									
			
			$('#message_form input#check-all').on('ifChecked', function () {
				
				$("#message_form .tableflat").iCheck('check');
			});
			$('#message_form input#check-all').on('ifUnchecked', function () {
				
				$("#message_form .tableflat").iCheck('uncheck');
			});
			
		}
	});

	//Message Entry And update
	$('#save_message ').click(function(event){		
		event.preventDefault();
		$.ajaxSetup({
			headers:{
				'X-CSRF-TOKEN':$('meta[name="csrf-token"]').attr('content')
			}
		});
		
		var formData = new FormData($('#message_form')[0]);
		if($.trim($('#admin_message').val()) == ""){
			success_or_error_msg('#form_submit_error','danger',"Please Insert Message","#admin_message");			
		}
		// if( $('#app_user_group').checked==true ){
		// 	success_or_error_msg('#form_submit_error','danger',"Please Select App User Name Or app Urser group");			
		// }
		
		else{
			$.ajax({
				url: url+"/message/message-entry",
				type:'POST',
				data:formData,
				async:false,
				cache:false,
				contentType:false,processData:false,
				success: function(data){
					var response = JSON.parse(data);
				
					if(response['result'] == '0'){
						var errors	= response['errors'];					
						resultHtml = '<ul>';
							$.each(errors,function (k,v) {
							resultHtml += '<li>'+ v + '</li>';
						});
						resultHtml += '</ul>';
						success_or_error_msg('#master_message_div',"danger",resultHtml);
						
						clear_form();
					}
					else{				
						success_or_error_msg('#master_message_div',"success","Save Successfully");
						$("#message_form .tableflat").iCheck('uncheck');
						message_table.ajax.reload();
						clear_form();
						// $("#publication_entry").html('Add Publication');
						// $(".save").html('Save');
						// $("#publication_list").trigger('click');
						
					}
					$(window).scrollTop();
				 }	
			});
		}	
	});

	//Publication Data Table
	var message_table = $('#message_table').DataTable({
		destroy: true,
		"processing": true,
		"serverSide": false,
		"ajax": url+"/message/sent-message-list",
		"aoColumns": [
			{ mData: 'id'},
			{ mData: 'message_id' },
			{ mData: 'admin_id'},
			{ mData: 'admin_message'},
			{ mData: 'app_user_id'},
			{ mData: 'is_seen', className: "text-center"},
			{ mData: 'status', className: "text-center"},
			{ mData: 'actions' , className: "text-center"},
		],
	});

	//Message View
	message_view = function message_view(id){
		var id = id;
		$.ajax({
			url: url+'/message/message-view/'+id,
			success: function(response){
				var data = JSON.parse(response);
				$("#admin_user_view").modal();
				$("#modal_title").html("Message View");
				var message_info = "";
			
				$("#modal_body").html(message_info);
			}
		});
	}

	//Message Delete
	delete_message = function delete_message(id){
		var delete_id = id;
		swal({
			title: "Are you sure?",
			text: "You wants to delete item parmanently!",
			icon: "warning",
			buttons: true,
			dangerMode: true,
		}).then((willDelete) => {
			if (willDelete) {
				$.ajax({
					url: url+'/message/message-delete/'+delete_id,
					cache: false,
					success: function(response){
						var response = JSON.parse(response);
						swal(response['deleteMessage'], {
						icon: "success",
						});
						message_table.ajax.reload();
					}
				});
			} 
			else {
				swal("Your Data is safe..!", {
				icon: "warning",
				});
			}
		});
	}

	//Publication Edit
	/*edit_publication = function edit_publication(id){
		var edit_id = id;
		$.ajax({
			url: url+'/publication/publication-edit/'+edit_id,
			success: function(response){
				var data = JSON.parse(response);
				$("#publication_entry").trigger('click');
				$("#publication_entry").html('Publication Update');
				$("#save_publication").html('Update');
				$("#publication_edit_id").val(data['id']);
				$("#publication_title").val(data['publication_title']);
				$("#details").val(data['details']);
				$("#authors").val(data['authors']);
				$("#publication_type").val(data['publication_type']).change();
				(data['status']=='1')?$("#is_active").iCheck('check'):$("#is_active").iCheck('uncheck');
			}
		});
	}*/


	//autosuggest
	$.ajaxSetup({
		headers:{
			'X-CSRF-TOKEN':$('meta[name="csrf-token"]').attr('content')
		}
	});
	$("#app_user_name").autocomplete({

		search: function() {
		},
		source: function(request, response) {
			$.ajax({
				url: url+'/notice/app-user-name',
				dataType: "json",
				type: "post",
				async:false,
				data: {
					term: request.term
				},
				success: function(data) {
					response(data);
				}
			});
		},
		minLength: 2,
		select: function(event, ui) { 
			var id = ui.item.id;
			
			$(this).next().val(id);
			$("#app_user_id").val(id);
			
		}
	});



	



	

	//Clear form
	$("#clear_button").on('click',function(){
		clear_form();
	});

	// icheck for the inputs
	$('.form').iCheck({
		checkboxClass: 'icheckbox_flat-green',
		radioClass: 'iradio_flat-green'
	});	

	$('.flat_radio').iCheck({
		radioClass: 'iradio_flat-green'
	});

		
		
	






	
	
});


  

