// All the user related js functions will be here
$(document).ready(function () {	
	
	// for get site url
	var url = $('.site_url').val();

	/*App User Data Tables*/
	
	var app_user_datatable = $('#app_user_table').DataTable({
		destroy: true,
		"processing": true,
		"serverSide": false,
		"ajax": url+"/app-user/app-user-list",
		"aoColumns": [
			{ mData: 'user_profile_image', className: "text-center"}, 
			{ mData: 'id'},
			{ mData: 'name' },
			{ mData: 'email'},
			{ mData: 'status', className: "text-center"},
			{ mData: 'actions' , className: "text-center"},
		],
	});
	
	

	// icheck for the inputs
	$('.form').iCheck({
		checkboxClass: 'icheckbox_flat-green',
		radioClass: 'iradio_flat-green'
	});	
	$('.flat_radio').iCheck({
		radioClass: 'iradio_flat-green'
	});

		
		
	/*-------- App Users Entry And Update Start --------*/
	$('#save_app_user_info').click(function(event){		
		event.preventDefault();
		$.ajaxSetup({
			headers:{
				'X-CSRF-TOKEN':$('meta[name="csrf-token"]').attr('content')
			}
		});

		var formData = new FormData($('#app_user_form')[0]);

		if($.trim($('#app_user_name').val()) == ""){
			success_or_error_msg('#form_submit_error','danger',"Please Insert Name","#app_user_name");			
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
				url: url+"/app-user/app-user-entry",
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
						//load_data("");
						clear_form();
					}
					else{				
						success_or_error_msg('#master_message_div',"success","Save Successfully");
						$("#app_user_list_button").trigger('click');
						app_user_datatable.ajax.reload();
						clear_form();
						$("#app_user_button").html('Add App User');
						$("#save_app_user_info").html('Save');
						$("#cancle_app_user_update").addClass('hide');
					}
					$(window).scrollTop();
				 }	
			});
		}	
	});

	/*-------- App Users Entry And Update End --------*/
	

	//Clear form
	$("#clear_button").on('click',function(){
		clear_form();
	});	





	
	
		
		
	/*-------- App Users Delete Start --------*/
	delete_app_user = function delete_app_user(id){
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
					url: url+'/app-user/app-user-delete/'+delete_id,
					cache: false,
					success: function(response){
						var response = JSON.parse(response);
						swal(response['deleteMessage'], {
						icon: "success",
						});
						app_user_datatable.ajax.reload();
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
	/*-------- App Users Delete End --------*/

		
	
	/*-------- App Users Edit Start --------*/
	
	app_user_edit = function app_user_edit(id){
		var edit_id = id;
		$.ajax({
			url: url+'/app-user/app-user-editedit/'+edit_id,
			cache: false,
			success: function(response){
				var response = JSON.parse(response);
				var app_user_info = response.app_user;
				var user_group_member_details = response.user_group_member_details;
				$("#app_user_button").trigger('click');
				$("#app_user_button").html('Update App User');
				$("#save_app_user_info").html('Update');
				$("#cancle_app_user_update").removeClass('hide');

				$("#app_user_edit_id").val(app_user_info['id']);
				$("#app_user_name").val(app_user_info['name']);
				$("#nid_no").val(app_user_info['nid_no']);
				$("#contact_no").val(app_user_info['contact_no']);
				$("#email").val(app_user_info['email']);
				$("#address").val(app_user_info['address']);
				$("#remarks").val(app_user_info['remarks']);
				(app_user_info['status']=='0')?$("#is_active").iCheck('uncheck'):$("#is_active").iCheck('check');
				// console.log(user_group_member_details);

				/*get group for edit*/
				if(!jQuery.isEmptyObject(user_group_member_details)){
				var html = '<table class="table table-bordered"><thead><tr class="headings"><th class="column-title text-center" class="col-md-8 col-sm-8 col-xs-8" >User Groups</th><th class="col-md-2 col-sm-2 col-xs-12"><input type="checkbox" id="check-all" class="tableflat">Select All</th></tr></thead>';
					html += '<tr><td colspan="2">';
					$.each(user_group_member_details, function(i,row){
						if (row['status']=='0') {
							html += '<div class="col-md-3" style="margin-top:5px;"><input type="checkbox" name="group[]"  class="tableflat"  value="'+row["id"]+'"/> '+row["group_name"]+'</div>';
						}
						else{
							html += '<div class="col-md-3" style="margin-top:5px;"><input checked type="checkbox" name="group[]"  class="tableflat"  value="'+row["id"]+'"/> '+row["group_name"]+'</div>';
						}
					});
					html += '</td></tr>';
				html +='</table>';	
			}
			$('#select_app_user_group').html(html);
			$('#app_user_form').iCheck({
					checkboxClass: 'icheckbox_flat-green',
					radioClass: 'iradio_flat-green'
			});									
			
			$('#app_user_form input#check-all').on('ifChecked', function () {
				
				$("#app_user_form .tableflat").iCheck('check');
			});
			$('#app_user_form input#check-all').on('ifUnchecked', function () {
				
				$("#app_user_form .tableflat").iCheck('uncheck');
			});

			}
		});
	}
	/*-------- App Users Edit End --------*/


	/*-------- Cancle App Users Update Start --------*/
	$("#cancle_app_user_update").click(function(){
		clear_form();
		$("#app_user_list_button").trigger('click');
		$("#app_user_button").html('Add App User');
		$("#save_app_user_info").html('Save');
		$("#cancle_app_user_update").addClass('hide');

	});
	/*-------- Cancle App Users Update End --------*/

	
	//Admin User View
	 app_user_view = function app_user_view(id){	
		var user_id = id;
		$.ajax({
			url: url+'/app-user/app-user-view/'+user_id,
			success: function(response){
				var data = JSON.parse(response);
				$("#admin_user_view").modal();
				$("#modal_title").html("App User Info");
				var status,user_type;
				(data['status']=='0')?status='In-active':status='Active';
				(data['user_type']=='2')?user_type='App User':user_type='Admin';
				var app_user_info = "";
				app_user_info+="<h3>ID: <small>"+data['id']+"</small></h3>";
				app_user_info+="<h3>Name: <small>"+data['name']+"</small></h3>";
				app_user_info+="<h3>NID NO: <small>"+data['nid_no']+"</small></h3>";
				app_user_info+="<h3>Contact NO: <small>"+data['contact_no']+"</small></h3>";
				app_user_info+="<h3>Email: <small>"+data['email']+"</small></h3>";
				app_user_info+="<h3>Address: <small>"+data['address']+"</small></h3>";
				app_user_info+="<h3>Remarks: <small>"+data['remarks']+"</small></h3>";
				app_user_info+="<h3>Status: <small>"+status+"</small></h3>";
				app_user_info+="<h3>User Type: <small>"+user_type+"</small></h3>";
				$("#modal_body").html(app_user_info);
			}
		});
	}
		


	


	//App User Group Entry And update With Admin controller
	$('#save_app_user_group').click(function(event){		
		event.preventDefault();
		$.ajaxSetup({
			headers:{
				'X-CSRF-TOKEN':$('meta[name="csrf-token"]').attr('content')
			}
		});
		
		var formData = new FormData($('#save_group_form')[0]);
		if($.trim($('#group_name').val()) == ""){
			success_or_error_msg('#form_submit_error','danger',"Please Insert Group Name","#group_name");			
		}
		else{
			$.ajax({
				url: url+"/admin/admin-group-entry",
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
						
						app_user_group.ajax.reload();
						clear_form();
						$("#cancle_admin_user_group_button").addClass('hidden');
						$(".save").html('Save');

					}
					$(window).scrollTop();
				 }	
			});
		}	
	})


	//App User Group list for group details
	var app_user_group = $('#app_user_group').DataTable({
		destroy: true,
		"processing": true,
		"serverSide": false,
		"ajax": url+"/app-user/app-user-group-list",
		"aoColumns": [ 
			{ mData: 'id'},
			{ mData: 'group_name' },
			{ mData: 'type'},
			{ mData: 'status', className: "text-center"},
			{ mData: 'actions' , className: "text-center"},
		],
	});

	
	/*------ Get Group Name For App User Entry Start ------*/
	$.ajax({
		url: url+"/app-user/load-app-user-groups",
		dataType: 'json',
		success: function(response) {
		var data = response.data;	
			if(!jQuery.isEmptyObject(data)){
				var html = '<table class="table table-bordered"><thead><tr class="headings"><th class="column-title text-center" class="col-md-8 col-sm-8 col-xs-8" >User Groups</th><th class="col-md-2 col-sm-2 col-xs-12"> <input checked type="checkbox" id="check-all" class="tableflat">Select All</th></tr></thead>';
					html += '<tr><td colspan="2">';
					$.each(data, function(i,data){
						html += '<div class="col-md-3" style="margin-top:5px;"><input checked type="checkbox" name="group[]"  class="tableflat check_permission"  value="'+data["id"]+'"/> '+data["group_name"]+'</div>';
					});
					html += '</td></tr>';
				html +='</table>';	
			}
			$('#select_app_user_group').html(html);
			$('#app_user_form').iCheck({
					checkboxClass: 'icheckbox_flat-green',
					radioClass: 'iradio_flat-green'
			});									
			
			$('#app_user_form input#check-all').on('ifChecked', function () {
				
				$("#app_user_form .tableflat").iCheck('check');
			});
			$('#app_user_form input#check-all').on('ifUnchecked', function () {
				
				$("#app_user_form .tableflat").iCheck('uncheck');
			});
		}
	});
	/*------ Get Group Name For App User Entry End ------*/
	






	
	
});


  

	 