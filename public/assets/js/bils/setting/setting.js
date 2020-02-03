// All the Setting related js functions will be here
$(document).ready(function () {	
	
	// for get site url
	var url = $('.site_url').val();

	// Update General Setting
	$('#save_general_setting').click(function(event){		
		event.preventDefault();
		$.ajaxSetup({
			headers:{
				'X-CSRF-TOKEN':$('meta[name="csrf-token"]').attr('content')
			}
		});
		
		var formData = new FormData($('#general_setting')[0]);
		if($.trim($('#company_name').val()) == ""){
			success_or_error_msg('#form_submit_error','danger',"Please Insert Company Name","#company_name");			
		}
		else if($.trim($('#short_name').val()) == ""){
			success_or_error_msg('#form_submit_error','danger',"Please Insert Short Name","#short_name");			
		}
		else if($.trim($('#site_name').val()) == ""){
			success_or_error_msg('#form_submit_error','danger',"Please Insert Site Name","#site_name");			
		}
		else if($.trim($('#admin_email').val()) == ""){
			success_or_error_msg('#form_submit_error','danger',"Insert Admin Email","#admin_email");			
		}
		else if($.trim($('#admin_mobile').val()) == ""){
			success_or_error_msg('#form_submit_error','danger',"Insert Admin Mobile","#admin_mobile");			
		}
		else{
			$.ajax({
				url: url+"/general/setting-update",
				type:'POST',
				data:formData,
				async:false,
				cache:false,
				contentType:false,processData:false,
				success: function(data){
		 			/*var response = JSON.parse(data);
				
					if(response['result'] == '0'){
						var errors	= response['errors'];					
						resultHtml = '<ul>';
							$.each(errors,function (k,v) {
							resultHtml += '<li>'+ v + '</li>';
						});
						resultHtml += '</ul>';
						success_or_error_msg('#master_message_div',"danger",resultHtml);
						//load_data("");
						clear_form();
					}
					else{				
						success_or_error_msg('#master_message_div',"success","Save Successfully");
						$("#admin_user_list_button").trigger('click');
						admin_datatable.ajax.reload();
						clear_form();

					}
					$(window).scrollTop();*/
				 }	
			});
		}	
	})
	
		
		
	
		
		

	
		

			
	//Delete Admin-user	
	/**delete_admin_user = function delete_admin_user(id){
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
					url: url+'/admin/delete/'+delete_id,
					cache: false,
					success: function(response){
						var response = JSON.parse(response);
						swal(response['deleteMessage'], {
						icon: "success",
						});
						admin_datatable.ajax.reload();
					}
				});
			} 
			else {
				swal("Your Data is safe..!", {
				icon: "warning",
				});
			}
		});
	}*/
	
	
});


  

	 