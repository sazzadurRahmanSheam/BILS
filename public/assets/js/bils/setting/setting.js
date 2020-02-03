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
		 			var response = JSON.parse(data);
				
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
						success_or_error_msg('#master_message_div',"success","Updated Successful");
						$("#admin_user_list_button").trigger('click');
						location.reload(true);
						//clear_form();

					}
					$(window).scrollTop();
				 }	
			});
		}	
	});





	/*var menu_datatable = $('#menus_table').DataTable({
		destroy: true,
		"processing": true,
		"serverSide": false,
		"ajax": url+"/module/menu-list",
		"aoColumns": [ 
			{ mData: 'id'},
			{ mData: 'module_name' },
			{ mData: 'menu_title'},
			{ mData: 'parent_id'},
			{ mData: 'menu_url'},
			{ mData: 'menu_icon_class'},
			{ mData: 'status', className: "text-center"},
			{ mData: 'actions' , className: "text-center"},
		],
	});*/




	
	
});


  

	 