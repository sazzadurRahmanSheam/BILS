// All the user related js functions will be here
$(document).ready(function () {	

	
	
	// for get site url
	var url = $('.site_url').val();

	//Teacher Entry And update
	$('#save_teacher').click(function(event){		
		event.preventDefault();
		$.ajaxSetup({
			headers:{
				'X-CSRF-TOKEN':$('meta[name="csrf-token"]').attr('content')
			}
		});
		
		var formData = new FormData($('#teacher_form')[0]);
		if($.trim($('#name').val()) == ""){
			success_or_error_msg('#form_submit_error','danger',"Please Insert Teacher Name","#name");			
		}
		else if($.trim($('#email').val()) == ""){
			success_or_error_msg('#form_submit_error','danger',"Please Insert Email","#email");			
		}
		else if($.trim($('#nid').val()) == ""){
			success_or_error_msg('#form_submit_error','danger',"Please Insert NID NO","#nid");			
		}
		else if($.trim($('#contact_no').val()) == ""){
			success_or_error_msg('#form_submit_error','danger',"Please Insert Contact NO","#contact_no");			
		}
		
		else{
			$.ajax({
				url: url+"/course/teacher/teacher-entry",
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
						//$("#message_form .tableflat").iCheck('check');
						teacher_table.ajax.reload();
						clear_form();
						$("#teacher_add_button").html('Teacher Entry');
						$(".save").html('Save');
						$("#teacher_list_button").trigger('click');
						$("#teacher_img").attr("src", "");
					}
					$(window).scrollTop();
				 }	
			});
		}
	});
	
	
	//autosuggest
	$.ajaxSetup({
		headers:{
			'X-CSRF-TOKEN':$('meta[name="csrf-token"]').attr('content')
		}
	});
	$("#name").autocomplete({

		search: function() {
		},
		source: function(request, response) {
			$.ajax({
				url: url+'/course/teacher/admin-user-name',
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
			var email = ui.item.email;
			var nid = ui.item.nid_no;
			var contact_no = ui.item.contact_no;
			var address = ui.item.address;

			$(this).next().val(id);

			$("#teacher_id").val(id);
			$("#email").val(email);
			$("#nid").val(nid);
			$("#contact_no").val(contact_no);
			$("#address").val(address);
			

		}
	});


	//Teacher Data Table
	var teacher_table = $('#teacher_table').DataTable({
		destroy: true,
		"processing": true,
		"serverSide": false,
		"ajax": url+"/course/teacher/teacher-list",
		"aoColumns": [
			{ mData: 'id'},
			{ mData: 'name' },
			{ mData: 'email'},
			{ mData: 'contact_no'},
			{ mData: 'status', className: "text-center"},
			{ mData: 'actions' , className: "text-center"},
		],
	});

	//Publication Edit
	teacher_edit = function teacher_edit(id){
		var edit_id = id;
		$.ajax({
			url: url+'/course/teacher/teacher-edit/'+edit_id,
			success: function(response){
				var res = JSON.parse(response);
				var data = res['data'];
				var admin_id = res['admin_id'];
				$("#teacher_add_button").trigger('click');
				$("#teacher_add_button").html('Teacher Update');
				$(".save").html('Update');
				
				$("#teacher_edit_id").val(data['id']);
				$("#admin_id").val(admin_id['id']);
				$("#name").val(data['name']);
				$("#email").val(data['email']);
				$("#contact_no").val(data['contact_no']);
				$("#nid").val(data['nid']);
				$("#address").val(data['address']);
				$("#remarks").val(data['remarks']);
				$("#teacher_img").attr("src", profile_image_url+"/"+data["user_profile_image"]);
				(data['status']=='0')?$("#is_active").iCheck('uncheck'):$("#is_active").iCheck('check');
			}
		});
	}

	//Teacher Delete (Just Change Status to Deleted)
    teacher_delete = function teacher_delete(id){
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
                    url: url+'/course/teacher/teacher-delete/'+delete_id,
                    cache: false,
                    success: function(response){
                        var response = JSON.parse(response);
                        swal(response['deleteMessage'], {
                            icon: "success",
                        });
                        teacher_table.ajax.reload();
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

    //Teacher View
	 teacher_view = function teacher_view(id){	
		var user_id = id;
		$.ajax({
			url: url+'/course/teacher/teacher-view/'+user_id,
			success: function(response){
				var data = JSON.parse(response);
				$("#profile_modal").modal();
				$("#name_div").html('<h2>'+data['name']+'</h2>');
				$("#contact_div").html(data['contact_no']);
				$("#email_div").html(data['email']);
				$("#nid_div").html(data['nid']);
				$("#address_div").html(data['address']);
				
				if (data['remarks']!=null && data['remarks']!="") {
					$("#remarks_div").html('<h2>Profile Details</h2>');
					$("#remarks_details").html(data['remarks']);
				}
				else{
					$("#remarks_div").html('');
					$("#remarks_details").html("");
				}

				if(data['status']==0){
					$("#status_div").html('<span class="badge badge-warning">In-active</span>');
				}
				else if(data['status']==1){
					$("#status_div").html('<span class="badge badge-success">Active</span>');
				}
				else{
					$("#status_div").html('<span class="badge badge-danger">Deleted</span>');
				}

				if (data["user_profile_image"]!=null && data["user_profile_image"]!="") {
					$(".profile_image").html('<img src="'+profile_image_url+'/'+data["user_profile_image"]+'" alt="User Image" class="img img-responsive">');
				}
				else{
					$(".profile_image").html('<img src="'+profile_image_url+'/no-user-image.png" alt="User Image" class="img img-responsive">');
				}
			}
		});
	}





	



	

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


  

