// All the user related js functions will be here
$(document).ready(function () {	
	
	// for get site url
	var url = $('.site_url').val();

	//Load Publication Type(Category)
	$.ajax({
		url: url+'/publication/load-publication-type',
		success: function(response){
			var data = JSON.parse(response);
			if(!jQuery.isEmptyObject(data)){
				var html = '';
				$.each(data, function(i,data){
					html += '<option>'+data["category_name"]+'</option>';
				});
			}
			$('#publication_type').append(html);	
		}
	});
	
	//Load App User Group
	$.ajax({
		url: url+'/notice/load-app-user-groups',
		success: function(response){
			var data = JSON.parse(response);
			if(!jQuery.isEmptyObject(data)){
				var html = '<table class="table table-bordered"><thead><tr class="headings"><th class="column-title text-center" class="col-md-8 col-sm-8 col-xs-8" >App User Groups</th><th class="col-md-2 col-sm-2 col-xs-12"> <input type="checkbox" id="check-all" class="tableflat">Select All</th></tr></thead>';
					html += '<tr><td colspan="2">';
					$.each(data, function(i,data){
						html += '<div class="col-md-3" style="margin-top:5px;"><input type="checkbox" name="app_user_group[]"  class="tableflat check_permission"  value="'+data["id"]+'"/> '+data["group_name"]+'</div>';
					});
					html += '</td></tr>';
				html +='</table>';	
			}
			$('#app_user_group').html(html);
			
			$('#publication_form').iCheck({
					checkboxClass: 'icheckbox_flat-green',
					radioClass: 'iradio_flat-green'
			});									
			
			$('#publication_form input#check-all').on('ifChecked', function () {
				
				$("#publication_form .tableflat").iCheck('check');
			});
			$('#publication_form input#check-all').on('ifUnchecked', function () {
				
				$("#publication_form .tableflat").iCheck('uncheck');
			});
			
		}
	});

	//Notice Entry And update
	$('#save_publication ').click(function(event){		
		event.preventDefault();
		$.ajaxSetup({
			headers:{
				'X-CSRF-TOKEN':$('meta[name="csrf-token"]').attr('content')
			}
		});
		
		var formData = new FormData($('#publication_form')[0]);
		if($.trim($('#publication_title').val()) == ""){
			success_or_error_msg('#form_submit_error','danger',"Please Insert Publication Title","#publication_title");			
		}
		else if($.trim($('#details').val()) == ""){
			success_or_error_msg('#form_submit_error','danger',"Please Insert Publication Details","#details");			
		}
		else{
			$.ajax({
				url: url+"/publication/publication-entry",
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
						
						publication_table.ajax.reload();
						clear_form();
						$("#publication_entry").html('Add Publication');
						$(".save").html('Save');
						$("#publication_list").trigger('click');
						
					}
					$(window).scrollTop();
				 }	
			});
		}	
	});

	//Publication Data Table
	var publication_table = $('#publication_table').DataTable({
		destroy: true,
		"processing": true,
		"serverSide": false,
		"ajax": url+"/publication/publication-list",
		"aoColumns": [
			{ mData: 'id'},
			{ mData: 'publication_title' },
			// { mData: 'details'},
			{ mData: 'publication_type'},
			{ mData: 'authors'},
			{ mData: 'status', className: "text-center"},
			{ mData: 'actions' , className: "text-center"},
		],
	});

	//Publication View
	publication_view = function publication_view(id){
		var publication_id = id;
		$.ajax({
			url: url+'/publication/publication-view/'+publication_id,
			success: function(response){
				var data = JSON.parse(response);
				$("#admin_user_view").modal();
				$("#modal_title").html("Publication View");
				var publication_info = "";
				publication_info += "<h3>"+data['publication_title']+"</h3>";
				publication_info += "<h5><span class='badge badge-info'>Type: "+data['publication_type']+"</span> <span class='badge badge-warning'> Author: "+data['authors']+"</span></h5><hr>";
				publication_info += "<p>"+data['details']+"</p>";
				$("#modal_body").html(publication_info);
			}
		});
	}

	//Publication delete
	delete_publication = function delete_publication(id){
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
					url: url+'/publication/publication-delete/'+delete_id,
					cache: false,
					success: function(response){
						var response = JSON.parse(response);
						swal(response['deleteMessage'], {
						icon: "success",
						});
						publication_table.ajax.reload();
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
	edit_publication = function edit_publication(id){
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


  

