// All the user related js functions will be here

// for get site url
var url = $('.site_url').val();

//function for data table
function adminDataTable(){
	$('#admin_user_table').DataTable({
		destroy: true,
		"processing": true,
		"serverSide": false,
		"ajax": url+"/admin/ajax/admin-list",
		"aoColumns": [
			{ mData: 'user_profile_image', className: "text-center"}, 
			{ mData: 'id'},
			{ mData: 'name' },
			{ mData: 'email'},
			{ mData: 'status', className: "text-center"},
			{ mData: 'actions' , className: "text-center"},
		],
		/*'rowCallback': function (nRow, aData, iDisplayIndex) {
			nRow.id = aData[0];
			nRow.className = "danger";
			return nRow;
		},*/
	});
}

$(function () {
	
	// load admin type user datatable @ajax
	adminDataTable();
	
	
	// icheck for the inputs
	$('.form').iCheck({
		checkboxClass: 'icheckbox_flat-green',
		radioClass: 'iradio_flat-green'
	});	
	
	$('.flat_radio').iCheck({
		//checkboxClass: 'icheckbox_flat-green'
		radioClass: 'iradio_flat-green'
	});
		
		
	// save and update for public post/notice
	$('#save_admin_info').click(function(event){		
		event.preventDefault();
		$.ajaxSetup({
			headers:{
				'X-CSRF-TOKEN':$('meta[name="csrf-token"]').attr('content')
			}
		});
		
		
		var formData = new FormData($('#admin_user_form')[0]);
		formData.append("q","insert_or_update");
		if($.trim($('#emp_name').val()) == ""){
			success_or_error_msg('#form_submit_error','danger',"Please Insert Name","#emp_name");			
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
		//	$('#save_emp_info').attr('disabled','disabled');
			
			//alert(url);return;
			
			$.ajax({
				url: url+"/admin/admin-user-entry",
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
						success_or_error_msg('#master_message_div',"success","Save Successfully");
						$("#admin_user_list_button").trigger('click');
						adminDataTable();
						clear_form();

					}
					$(window).scrollTop();
				 }	
			});
		}	
	})
	
	//Clear form
	$("#clear_button").on('click',function(){
		clear_form();
	});

		
			
		
});


//Admin User View
function admin_user_view(id){
	
	var user_id = id;
	$.ajax({
		url: url+'/admin/admin-view/'+user_id,
		success: function(response){
			var data = JSON.parse(response);
			$("#admin_user_view").modal();
			var user_type,login_status,status;
			(data['user_type']=="1")? user_type = "Admin" : "App User";
			(data['login_status']=="1")? login_status = "Logged In" : "Not Logged In";
			(data['status']=="1")? status = "Active" : "In-active";
			var admin_info = "";
			admin_info+="<h4>"+data['id']+"</h4>";
			admin_info+="<h4>"+data['name']+"</h4>";
			admin_info+="<h4>"+data['nid_no']+"</h4>";
			admin_info+="<h4>"+data['contact_no']+"</h4>";
			admin_info+="<h4>"+data['email']+"</h4>";
			admin_info+="<h4>"+data['address']+"</h4>";
			admin_info+="<h4>"+user_type+"</h4>";
			admin_info+="<h4>"+login_status+"</h4>";
			admin_info+="<h4>"+status+"</h4>";
			
			$("#modal_body").html(admin_info);
			console.log(data);
		}
	});
}



        	
//Delete Admin-user	
function delete_admin_user(id){
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
					adminDataTable();
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


//Admin User Edit
 function admin_user_edit(id){
	var edit_id = id;
	$.ajax({
		url: url+'/admin/edit/'+edit_id,
				cache: false,
				success: function(response){
					var data = JSON.parse(response);
					$("#admin_user_add_button").trigger('click');
					$("#admin_user_add_button").html('Update Admin User');
					$("#save_admin_info").html('Update');
					$("#emp_name").val(data['name']);
					$("#nid_no").val(data['nid_no']);
					$("#id").val(data['id']);
					// $("#designation_name").val(data['']);
					// $("#department_name").val(data['']);
					$("#contact_no").val(data['contact_no']);
					$("#email").val(data['email']);
					$("#address").val(data['address']);
					//$("#password").hide();
					$("#remarks").val(data['remarks']);
					// $("#").val(data['']);
					// $("#").val(data['']);
					// $("#").val(data['']);
				}
	});
}
	 