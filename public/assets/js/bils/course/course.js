// All the user related js functions will be here
$(document).ready(function () {	
	
	// for get site url
	var url = $('.site_url').val();

	
	//Load App User Group Using Notice Controller
	/*$.ajax({
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
	});*/

	//Message Entry And update
	$('#save_course ').click(function(event){		
		event.preventDefault();
		$.ajaxSetup({
			headers:{
				'X-CSRF-TOKEN':$('meta[name="csrf-token"]').attr('content')
			}
		});
		
		var formData = new FormData($('#courses_form')[0]);
		if($.trim($('#course_title').val()) == ""){
			success_or_error_msg('#form_submit_error','danger',"Please Insert Course Title","#course_title");			
		}
		
		
		else{
			$.ajax({
				url: url+"/course/course-entry",
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
						$("#message_form .tableflat").iCheck('check');
						course_table.ajax.reload();
						clear_form();
						$("#courses_add_button").html('Open Course');
						$(".save").html('Save');
						$("#courses_list_button").trigger('click');
						
					}
					$(window).scrollTop();
				 }	
			});
		}
	});

	//Publication Data Table
	var course_table = $('#course_table').DataTable({
		destroy: true,
		"processing": true,
		"serverSide": false,
		"ajax": url+"/course/course-list",
		"aoColumns": [
			{ mData: 'id'},
			{ mData: 'course_title' },
			{ mData: 'duration'},
			{ mData: 'pub_status', className: "text-center"},
			{ mData: 'course_status', className: "text-center"},
			{ mData: 'actions' , className: "text-center"},
		],
	});

	//Course View
	course_view = function course_view(id){
		var id = id;
		$.ajax({
			url: url+'/course/course-view/'+id,
			success: function(response){
				var data = JSON.parse(response);
				$("#course_view_li").css('display','block');
				$("#course_view_button").trigger('click');
				$("#c_title").html("<h2>Title: "+data['course_title']+"</h2>");
				var left_sub = "";
				left_sub += "<p><b>Duration: </b>"+data['duration']+" Hours</p>";
				left_sub += "<b>Approximate Start Time: </b>"+data['appx_start_time'];
				left_sub += "<br><b>Actual Start Time: </b>"+data['act_start_time'];
				left_sub += "<br><b>Course Type: </b>"+data['course_type'];
				left_sub += "<br><b>Created By: </b>"+data['created_by'];
				$("#left_sub").html(left_sub);


				var right_sub = "";
				right_sub +=(data['pub_status']=='0')?"<button class='btn btn-xs btn-danger'>Not-published</button>":"<button class='btn btn-xs btn-success'>Published</button>";
				if (data['course_status']=='1') {
					right_sub +=" <button class='btn btn-xs btn-warning'>Initiated</button>"
				}else if (data['course_status']=='2') {
					right_sub +=" <button class='btn btn-xs btn-success'>Approved</button>"
				}else if (data['course_status']=='3') {
					right_sub +=" <button class='btn btn-xs btn-danger'>Rejected</button>"
				}else if (data['course_status']=='4') {
					right_sub +=" <button class='btn btn-xs btn-info'>Started</button>"
				}else if (data['course_status']=='5') {
					right_sub +=" <button class='btn btn-xs btn-success'>Completed</button>"
				}
				right_sub +="<br/><b>Approximate End Time: </b>"+data['appx_end_time'];
				right_sub +="<br/><b>Actual End Time: </b>"+data['act_end_time'];
				right_sub +="<br/><b>Course Teacher: </b>"+data['course_teacher'];
				right_sub +="<br/><b>Updated By: </b>"+data['updated_by'];

				$("#right_sub").html(right_sub);
				
				// course_info += "<p>"+data['details']+"</p>";
				
				
				
			
				
				
				
				// course_info += "<h4>Course Responsible Person: "+data['course_responsible_person']+"</h4>";
				
				// course_info += "<h4>Payment Fee: "+data['payment_fee']+"</h4>";
				// course_info += "<h4>Payment Method: "+data['payment_method']+"</h4>";
				// course_info += "<h4>Discount Message: "+data['discount_message']+"</h4>";
				
				// $("#modal_body").html(course_info);
			}
		});
	}

	//Message Delete
	delete_course = function delete_course(id){
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
					url: url+'/course/course-delete/'+delete_id,
					cache: false,
					success: function(response){
						var response = JSON.parse(response);
						swal(response['deleteMessage'], {
						icon: "success",
						});
						course_table.ajax.reload();
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
	edit_course = function edit_course(id){
		var edit_id = id;
		$.ajax({
			url: url+'/course/course-edit/'+edit_id,
			success: function(response){
				var data = JSON.parse(response);
				$("#courses_add_button").trigger('click');
				$("#courses_add_button").html('Course Update');
				$(".save").html('Update');
				
				$("#course_edit_id").val(data['id']);
				$("#course_title").val(data['course_title']);
				$("#details").val(data['details']);
				$("#duration").val(data['duration']);
				$("#course_type").val(data['course_type']).change();
				$("#appx_start_time").val(data['appx_start_time']);
				$("#appx_end_time").val(data['appx_end_time']);
				$("#act_start_time").val(data['act_start_time']);
				$("#act_end_time").val(data['act_end_time']);
				$("#payment_fee").val(data['payment_fee']);
				$("#payment_method").val(data['payment_method']);
				$("#course_teacher").val(data['course_teacher']);
				$("#discount_message").val(data['discount_message']);
				(data['pub_status']=='0')?$("#pub_status").iCheck('uncheck'):$("#pub_status").iCheck('check');
				$("#edit_course_status").css('display','block');
				$("#course_status").val(data['course_status']).change();

			}
		});
	}

	// Get Course Category
	$.ajax({
			url: url+'/course/get-course-categories',
			success: function(response){
				var data = JSON.parse(response);
				var option = "";
				$.each(data,function (k,row) {
					option += '<option value="'+row['id']+'">'+row['category_name']+'</option>';
				});
				$("#course_type").append(option);
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


  

