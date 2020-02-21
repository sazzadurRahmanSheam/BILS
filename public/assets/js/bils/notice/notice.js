// All the user related js functions will be here
$(document).ready(function () {	
	
	// for get site url
	var url = $('.site_url').val();

	
	//Load App User Group
	$.ajax({
		url: url+'/notice/load-app-user-groups',
		success: function(response){
			var data = JSON.parse(response);
			var option = "";
			if(!jQuery.isEmptyObject(data)){
				$.each(data, function(i,data){
					option +="<option>"+data['group_name']+"</option>";
				});
			}
			$("#app_user_group").append(option);
		}
	});

	//Notice Entry And update
	$('#save_notice').click(function(event){		
		event.preventDefault();
		$.ajaxSetup({
			headers:{
				'X-CSRF-TOKEN':$('meta[name="csrf-token"]').attr('content')
			}
		});
		
		var formData = new FormData($('#notice_form')[0]);
		if($.trim($('#title').val()) == ""){
			success_or_error_msg('#form_submit_error','danger',"Please Insert Notice Title","#title");			
		}
		else if($.trim($('#notice_date').val()) == ""){
			success_or_error_msg('#form_submit_error','danger',"Please Insert Notice Date","#notice_date");			
		}
		else if($.trim($('#expire_date').val()) == ""){
			success_or_error_msg('#form_submit_error','danger',"Please Insert Notice Expire Date","#expire_date");			
		}
		else{
			$.ajax({
				url: url+"/notice/notice-entry",
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
						
						notice_table.ajax.reload();
						clear_form();
						$("#notice_entry").html('Add Notice');
						$(".save").html('Save');
						$("#notice_list").trigger('click');
						$("#save_notice").html('Save');
					}
					$(window).scrollTop();
				 }	
			});
		}	
	});

	//Notice Data Table
	var notice_table = $('#notice_table').DataTable({
		destroy: true,
		"processing": true,
		"serverSide": false,
		"ajax": url+"/notice/notice-list",
		"aoColumns": [
			{ mData: 'id'},
			{ mData: 'title' },
			{ mData: 'details'},
			{ mData: 'status', className: "text-center"},
			{ mData: 'actions' , className: "text-center"},
		],
	});

	//Notice View
	notice_view = function notice_view(id){
		var notice_id = id;
		$.ajax({
			url: url+'/notice/notice-view/'+notice_id,
			success: function(response){
				var data = JSON.parse(response);
				$("#admin_user_view").modal();
				$("#modal_title").html("Notice View");
				var notice_info = "";
				notice_info += "<h3>"+data['title']+"</h3><hr>";
				notice_info += "<p>"+data['details']+"</p>";
				$("#modal_body").html(notice_info);
				$("#save_notice").html('Update');
			}
		});
	}

	//Notice delete
	delete_notice = function delete_notice(id){
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
					url: url+'/notice/notice-delete/'+delete_id,
					cache: false,
					success: function(response){
						var response = JSON.parse(response);
						swal(response['deleteMessage'], {
						icon: "success",
						});
						notice_table.ajax.reload();
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

	//Notice Edit
	edit_notice = function edit_notice(id){
		var edit_id = id;
		$.ajax({
			url: url+'/notice/notice-edit/'+edit_id,
			success: function(response){
				var data = JSON.parse(response);
				$("#notice_entry").trigger('click');
				$("#notice_entry").html('Notice Update');
				$("#save_notice").html('Update');
				$("#notice_edit_id").val(data['id']);
				$("#title").val(data['title']);
				$("#details").val(data['details']);
				$("#notice_date").val(data['notice_date']);
				$("#expire_date").val(data['expire_date']);
				(data['status']=='1')?$("#is_active").iCheck('check'):$("#is_active").iCheck('uncheck');
			}
		});
	}

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
		// minLength: 1,
		select: function(event, ui) { 
			// var id = ui.item.id;
			// $(this).next().val(id);
		}
	});











	$('.mdb-select').select2({
		placeholder: "Select Groups Here",
		allowClear: true
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


  
