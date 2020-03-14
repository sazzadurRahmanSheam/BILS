// All the user related js functions will be here
$(document).ready(function () {	
	
	// for get site url
	var url = $('.site_url').val();
	var number_of_msg = 10;
	
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


	loadAppUser = function loadAppUser(){

		$.ajax({
			url: url+'/message/load-app-user',
			success: function(response){
				var response = JSON.parse(response);
				var app_user = response['app_user_info'];
				//Load App user who are chated 
				if(!jQuery.isEmptyObject(app_user)){
					var html = "";
					//var active_chat_class = "active";
					$.each(app_user, function(i,row){
						html+='<li onclick="loadMessage('+row["app_user_id"]+','+number_of_msg+')" class="contact">';
						html+='<div class="wrap">';
						html+='<span class="contact-status online"></span>';
						html+='<img src="http://emilcarlsson.se/assets/harveyspecter.png" alt="" />';
						html+='<div class="meta">';
						html+='<p class="name">'+row["name"]+'</p>';
						//html+='<p class="preview">Wrong. You take the gun, or you pull out a bigger one. Or, you call their bluff. Or, you do any one of a hundred and forty six other things.</p>';
						html+='</div>';
						html+='</div>';
						html+='</li>';
						//active_chat_class = "";
					});
				}
				$("#app_user_show").html(html);

			}
		});
	}
	loadAppUser();


	loadMessage = function loadMessage(app_user_id, number_of_msg){//
		$("#search_app_user").val("");
		event.preventDefault();
		$.ajaxSetup({
			headers:{
				'X-CSRF-TOKEN':$('meta[name="csrf-token"]').attr('content')
			}
		});
		var app_user_id_load_msg = app_user_id;
		var msg_no = number_of_msg;

		$.ajax({
			url: url+'/message/load-message',
			type:'POST',
				data:{
					app_user_id_load_msg:app_user_id_load_msg,
					msg_no:msg_no
				},
				async:false,
			success: function(response){
				var response = JSON.parse(response);
				
				var message = response['message'];
				var app_user_name = response['app_user_name'];
				
				//Messages
				var message_body = "";
				if(!jQuery.isEmptyObject(message)){

					$.each(message, function(i,message){
						html = "";
						if((message["admin_message"]!=null && message["admin_message"]!="") || ( message["is_attachment"]!=""&& message["is_attachment"]!=null ) ){
							html += '<li class="sent_msg">';
							html += '<img src="http://emilcarlsson.se/assets/harveyspecter.png" alt="" />';
							
							if (message["admin_message"]!=null && message["admin_message"]!="") {html += '<p>'+message["admin_message"]+'</p>';}

							if(message["is_attachment"]==1){
								if(message["attachment_type"]==1){
									//Image
									html += '<img style="height:150px !important; width:180px !important; border-radius:0px !important;" src="'+msg_image_url+'/'+message["admin_atachment"]+'" alt="">';
								}
								else if(message["attachment_type"]==2){
									//Video
									html +='<video style="float:right" width="280" controls><source src="'+msg_image_url+'/'+message["admin_atachment"]+'" type="video/mp4"></video>';
								}
								else if(message["attachment_type"]==3){
									//Audio
									html +='<audio controls><source src="'+msg_image_url+'/'+message["admin_atachment"]+'" type="audio/mpeg"></audio>';
								}
								else{
									//Other Files
									html += '<a href="'+msg_image_url+'/'+message["admin_atachment"]+'" download><p style="word-wrap: break-word;">'+message["admin_atachment"]+'</p></a>';
								}
							}
							
							html += '</li>';
							html += '<span class="time_date_sent"> '+message["msg_date"]+'</span>';
							
							
						}
						else if(message["app_user_message"]!=null && message["app_user_message"]!=""){
							

							html += '<li class="receive_msg">';
							html += '<img src="http://emilcarlsson.se/assets/mikeross.png" alt="" />';
							html += '<p>'+message["app_user_message"]+'</p>';
							html += '<span class="time_date">'+message["msg_date"]+'</span>';
							html += '</li>';
							// 11:01 AM    |    June 9
							
						}
						message_body = html+message_body;
						
					});
					
				}
				loadAppUser();
				$(".message_body").html(message_body);
				$("#app_user_name").html(app_user_name['name']);
				$("#load_more_message").html('<button onclick="limitIncrease('+app_user_name["id"]+');" style="margin-right: 10px;" type="button" class="btn btn-xs btn-warning">Load Old Message</button>');
				$("#app_user_id").val(app_user_name['id']);
				if (number_of_msg==10) {
					$(".messages").animate({ scrollTop: $(document).height() }, "fast");
				}
			}
		});
	}


	searchAppUsers = function searchAppUsers(){
		event.preventDefault();
		$.ajaxSetup({
			headers:{
				'X-CSRF-TOKEN':$('meta[name="csrf-token"]').attr('content')
			}
		});
		var name = $("#search_app_user").val();
		if(name!=""){
			$.ajax({
				url: url+"/message/search-app-users",
				type:'POST',
				data:{name:name},
				async:false,
				success: function(data){
					var app_users = JSON.parse(data);
					
					if(!jQuery.isEmptyObject(app_users)){
						var html = "";
						$.each(app_users, function(i,row){
							html+='<li class="contact">';
							html+='<div class="wrap">';
							//html+='<span class="contact-status busy"></span>';
							html+='<img src="http://emilcarlsson.se/assets/harveyspecter.png" alt="" />';
							html+='<div class="meta">';
							html+='<p onclick="loadMessage('+row["id"]+','+number_of_msg+')" class="name">'+row["name"]+'</p>';
							//html+='<p class="preview">Wrong. You take the gun, or you pull out a bigger one. Or, you call their bluff. Or, you do any one of a hundred and forty six other things.</p>';
							html+='</div>';
							html+='</div>';
							html+='</li>';
							
						});
					}
				$("#app_user_show").html(html);

				}	
			});
		

		}
		else {
			loadAppUser();
		}
	}

	$("#search_app_user").keyup(function(){
		searchAppUsers();
	});


	

	$("#message_sent_to_user").click(function(){
		event.preventDefault();
		$.ajaxSetup({
			headers:{
				'X-CSRF-TOKEN':$('meta[name="csrf-token"]').attr('content')
			}
		});
		newMsgSent();
	});

	newMsgSent = function newMsgSent(){
        	
    	
		var formData = new FormData($('#sent_message_to_user')[0]);
		if(( $.trim($('#admin_message').val()) != "" || $.trim($('#attachment').val()) != "" ) && $.trim($('#app_user_id').val()) != ""){
			
			$.ajax({
				url: url+"/message/admin-message-sent-to-user",
				type:'POST',
				data:formData,
				async:false,
				cache:false,
				contentType:false,
				processData:false,
				success: function(data){
					$("#attachment").val('');
					loadMessage($('#app_user_id').val(),number_of_msg);
					$('#admin_message').val("");
					$(".messages").animate({ scrollTop: $(document).height() }, "fast");
					loadAppUser();
				 }	
			});
		}
	}

	$(window).on('keydown', function(e) {
		if (e.which == 13) {
			newMsgSent();
			return false;
		}
	});

	
        
      
	

		  
		 


			
			  
			  





	

	limitIncrease = function limitIncrease(id){
		number_of_msg = number_of_msg+10;
		loadMessage(id,number_of_msg);
	}

	//autosuggest
	/*$.ajaxSetup({
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
	});*/



	



	

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


  

