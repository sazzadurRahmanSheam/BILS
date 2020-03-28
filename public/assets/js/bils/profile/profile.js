// All the user related js functions will be here
$(document).ready(function () {	
	
	// for get site url
	var url = $('.site_url').val();

	/*----- My Profile ------*/

		
		profile_info = function profile_info(){
			$.ajax({
				url: url+'/profile/my-profile-info',
				success: function(response){
					var response = JSON.parse(response);
					var data = response[0];
					var html = "";

					if (data["user_profile_image"]!=null && data["user_profile_image"]!="") {
						$(".user_profile_img").attr("src", profile_image_url+"/"+data["user_profile_image"]);
					}
					else{
						$(".user_profile_img").attr("src", profile_image_url+"/no-user-image.png");
					}
					
					html +="<h1>"+data['name']+"</h1><hr>";
					
					html +="<h4><i class='fa fa-phone'></i>  "+data['contact_no']+"</h4><hr>";
					html +="<h4><i class='fa fa-envelope'></i> "+data['email']+"</h4><hr>";
					html +="<h4><i  class='clip-location'></i> "+data['address']+"</h4><hr>";
					html +="<h4><b>NID NO: </b>"+data['nid_no']+"</h4><hr>";
					
					html +="<h4><b>Profile Details: </b>"+data['remarks']+"</h4><hr>";
					html +="<button class='btn btn-info' onclick='edit_profile()'>Edit Profile</button>";
					html +=" <button class='btn btn-danger' onclick='change_password()'>Change Password</button>";
					$("#profile_info").html(html);
				}
			}); 	
		}
		profile_info();

		edit_profile = function edit_profile(){
			$.ajax({
				url: url+'/profile/my-profile-info',
				success: function(response){
					var response = JSON.parse(response);
					var data = response[0];
					$("#edit_profile_menu_tab").removeClass('hidden');
					$("#edit_profile_tab").trigger('click');
					$("#edit_profile_id").val(data['id']);
					$("#name").val(data['name']);
					$("#nid_no").val(data['nid_no']);
					$("#contact_no").val(data['contact_no']);
					$("#email").val(data['email']);
					$("#address").val(data['address']);
					$("#remarks").val(data['remarks']);
					//$("#emp_image_upload").val(data['user_profile_image']);
					$("#emp_img").attr("src", profile_image_url+"/"+data["user_profile_image"]);
				}
			});			
		}


		$('#update_profile_info').click(function(event){		
		event.preventDefault();
		$.ajaxSetup({
			headers:{
				'X-CSRF-TOKEN':$('meta[name="csrf-token"]').attr('content')
			}
		});

		var formData = new FormData($('#my_profile_form')[0]);

		if($.trim($('#name').val()) == ""){
			success_or_error_msg('#form_submit_error','danger',"Please Insert Name","#name");			
		}
		else if($.trim($('#nid_no').val()) == ""){
			success_or_error_msg('#form_submit_error','danger',"Please Insert NID no","#nid_no");			
		}
		else if($.trim($('#contact_no').val()) == ""){
			success_or_error_msg('#form_submit_error','danger',"Please Insert contact no","#contact_no");			
		}
		else if($.trim($('#email').val()) == ""){
			success_or_error_msg('#form_submit_error','danger',"Select Email","#email");			
		}	
		else{
			
			$.ajax({
				url: url+"/profile/my-profile-update",
				type:'POST',
				data:formData,
				async:false,
				cache:false,
				contentType:false,
				processData:false,
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
						//clear_form();
					}
					else{				
						success_or_error_msg('#master_message_div',"success","Update Successfully");
						clear_form();
						$("#my_profile_tab").trigger('click');
						$("#edit_profile_menu_tab").addClass('hidden');
						profile_info();
					}
					$(window).scrollTop();
				 }	
			});
		}	
	});


	change_password = function change_password(){
		$.ajax({
				url: url+'/profile/my-profile-info',
				success: function(response){
					var response = JSON.parse(response);
					var data = response[0];
					$("#change_pass_menu_tab").removeClass('hidden');
					$("#change_pass_tab").trigger('click');
					$("#change_pass_id").val(data['id']);
				}
			});			
	}


	$('#update_password').click(function(event){		
		event.preventDefault();
		$.ajaxSetup({
			headers:{
				'X-CSRF-TOKEN':$('meta[name="csrf-token"]').attr('content')
			}
		});

		var formData = new FormData($('#change_password_form')[0]);

		if($.trim($('#current_password').val()) == ""){
			success_or_error_msg('#form_submit_error','danger',"Please Insert Current Password","#current_password");			
		}else if($.trim($('#new_password').val()) == ""){
			success_or_error_msg('#form_submit_error','danger',"Please Insert New Password","#new_password");			
		}else if($.trim($('#confirm_password').val()) == ""){
			success_or_error_msg('#form_submit_error','danger',"Please Confirm Password","#confirm_password");			
		}
		else{
			var new_password = $("#new_password").val();
			var confirm_password = $("#confirm_password").val();
			if (new_password==confirm_password) {
				$.ajax({
					url: url+"/profile/password-update",
					type:'POST',
					data:formData,
					async:false,
					cache:false,
					contentType:false,
					processData:false,
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
							success_or_error_msg('#master_message_div',"success","Change Password Successfully");
							clear_form();
							$("#my_profile_tab").trigger('click');
							$("#change_pass_menu_tab").addClass('hidden');
							profile_info();
						}
						$(window).scrollTop();
					}	
				});
			}
			else{
				success_or_error_msg('#master_message_div',"danger","New Password And Confirm Password Does Not Match");
			}
			
		}	
	});



	
	/*----- My Profile ------*/
	



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


  

	 