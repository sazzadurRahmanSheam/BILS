// All the Setting related js functions will be here
$(document).ready(function () {	
	
	// for get site url
	var url = $('.site_url').val();

	// icheck for the inputs
	$('.form').iCheck({
		checkboxClass: 'icheckbox_flat-green',
		radioClass: 'iradio_flat-green'
	});	
	
	$('.flat_radio').iCheck({
		//checkboxClass: 'icheckbox_flat-green'
		radioClass: 'iradio_flat-green'
	});
		

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




	//for show menus list
	var menu_datatable = $('#menus_table').DataTable({
		destroy: true,
		"processing": true,
		"serverSide": false,
		"ajax": url+"/module/menu-list",
		"aoColumns": [ 
			{ mData: 'id'},
			{ mData: 'module_name' },
			{ mData: 'menu_title'},
			{ mData: 'status', className: "text-center"},
			{ mData: 'actions' , className: "text-center"},
		],
	});




	//Getting Parrent Menu
	$.ajax({
		url : url+"/module/get-parent-menu",
		cache: false,
        dataType: 'json',
        success: function(response){
            //console.log(response);
            var data = response.data;
            var option = '';
            $.each(data,function(index,row){
	        	option +="<option>";
	        	option += row.module_name;
	        	option += "</option>";
            })

            $("#existed_menu").html(option);
            //console.log(data[0]['module_name']);
        }
	});


	//seeting input field for parrent_id
	$("input[name=module_name]").focusout(function(){
    	var module_name = $(this).val();
    	$.ajax({
    		url : url+"/module/get-module-id/"+module_name,
    		success: function(response){
    			var parent_id = response;
    			//$("#web_action_form").append('<input type="hidden" name="parent_id" id="parent_id" value="'+parent_id+'">');
    			$("#parent_id").val(parent_id);
    		}
    	});
	});


	//Entry And Update Function For Module
	$("#save_module").on('click',function(){

		event.preventDefault();
		$.ajaxSetup({
			headers:{
				'X-CSRF-TOKEN':$('meta[name="csrf-token"]').attr('content')
			}
		});
		
		
		var formData = new FormData($('#web_action_form')[0]);

		if($.trim($('#module_name').val()) == ""){
			success_or_error_msg('#form_submit_error','danger',"Please Insert Module Name","#module_name");			
		}
		else if($.trim($('#menu_title').val()) == ""){
			success_or_error_msg('#form_submit_error','danger',"Please Insert Menu Title","#menu_title");			
		}
		else{
			
			$.ajax({
				url: url+"/module/module-entry",
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
						success_or_error_msg('#master_message_div',"success","Save Successfully");
						
						menu_datatable.ajax.reload();
						clear_form();
						$("#clear_button").show();
						$("#save_module").html('Save');

					}
					$(window).scrollTop();
				 }	
			});
		}

		//console.log(formData);
	});


	//Clear form
	$("#clear_button").on('click',function(){
		clear_form();
		$("#parent_id").remove();
	});


	//Edit function for Module
	moduleEdit = function moduleEdit(id){
		var edit_id = id;
		$.ajax({
			url: url+'/module/edit/'+edit_id,
			cache: false,
			success: function(response){
				var data = JSON.parse(response);
				$("#save_module").html('Update');
				$("#clear_button").hide();
				$("#module_name").val(data['module_name']);
				$("#edit_id").val(data['id']);
				$("#parent_id").val(data['parent_id']);
				$("#menu_title").val(data['menu_title']);
				$("#menu_url").val(data['menu_url']);
				$("#menu_icon_class").val(data['menu_icon_class']);
			}
		});
	}

	
	//Delete Module	
	moduleDelete = function moduleDelete(id){
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
					url: url+'/module/delete/'+delete_id,
					cache: false,
					success: function(response){
						var response = JSON.parse(response);
						if (response['parentmessage']) {
							swal(response['parentmessage'], {
								icon: "warning",
							});
						}
						else{
							swal(response['deleteMessage'], {
								icon: "success",
							});
							menu_datatable.ajax.reload();
						}
						
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


	//Getting Module Name
	$.ajax({
		url : url+"/web-action/get-module-name",
		cache: false,
        dataType: 'json',
        success: function(response){
            //console.log(response);
            var data = response.data;
            var option = '';
            $.each(data,function(index,row){
	        	option +="<option value='"+row.id+"'>";
	        	option += row.module_name;
	        	option += "</option>";
            })
            $("#module_name_for_web_action").append(option);
        }
	});


	//Entry and Update Web Action
	$('#save_web_action').click(function(event){		
		event.preventDefault();
		$.ajaxSetup({
			headers:{
				'X-CSRF-TOKEN':$('meta[name="csrf-token"]').attr('content')
			}
		});
		
		var formData = new FormData($('#web_action_form')[0]);
		if($.trim($('#module_name_for_web_action').val()) == ""){
			success_or_error_msg('#form_submit_error','danger',"Please Select Module Name","#module_name_for_web_action");			
		}
		else if($.trim($('#activity_name').val()) == ""){
			success_or_error_msg('#form_submit_error','danger',"Please Insert Action Name","#activity_name");			
		}
		else{
			$.ajax({
				url: url+"/web-action/web-action-entry",
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
						success_or_error_msg('#master_message_div',"success","Successful");
						clear_form();
						web_actions_table.ajax.reload();
						$("#clear_button").show();
						$("#save_web_action").html("Save");
					}
					$(window).scrollTop();
				 }	
			});
		}
	});

	//Web Action Show
	var web_actions_table = $('#web_actions_table').DataTable({
		destroy: true,
		"processing": true,
		"serverSide": false,
		"ajax": url+"/web-action/action-lists",
		"aoColumns": [ 
			{ mData: 'id'},
			{ mData: 'activity_name' },
			{ mData: 'module_name' },
			{ mData: 'status', className: "text-center"},
			{ mData: 'actions' , className: "text-center"},
		],
	});


	//Web Actions Edit
	web_action_edit = function web_action_edit(id){
		var edit_id = id;
		$.ajax({
			url: url+'/web-action/edit/'+edit_id,
			cache: false,
			success: function(response){
				var data = JSON.parse(response);
				$("#save_web_action").html('Update');
				$("#clear_button").hide();
				$("#activity_name").val(data['activity_name']);
				$("#edit_id").val(data['id']);
				$("#module_name_for_web_action").val(data['module_id']).change();
			}
		});
	}


	/*----- Publication Start -----*/

	//Publication Category Entry And Update
	$("#save_publication_category").on('click',function(){

		event.preventDefault();
		$.ajaxSetup({
			headers:{
				'X-CSRF-TOKEN':$('meta[name="csrf-token"]').attr('content')
			}
		});
		
		
		var formData = new FormData($('#save_publication_category_form')[0]);

		if($.trim($('#category_name').val()) == ""){
			success_or_error_msg('#form_submit_error','danger',"Please Insert Category Name","#category_name");			
		}
		else{
			
			$.ajax({
				url: url+"/settings/publication/publication-category-entry",
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
						if (response['success']=='insert') {
							success_or_error_msg('#master_message_div',"success","Publication Category Inserted Successful");
						}else{
							success_or_error_msg('#master_message_div',"success","Updated Successful");
						}
						publication_category.ajax.reload();
						clear_form();
						$("#save_publication_category").html('Save');
						$("#cancle_publication_category").addClass('hidden');
					}
					$(window).scrollTop();
				 }	
			});
		}
	});

	//Publication Categories data table
	var publication_category = $('#publication_category').DataTable({
		destroy: true,
		"processing": true,
		"serverSide": false,
		"ajax": url+"/setting/publication/publication-categories-list",
		"aoColumns": [ 
			{ mData: 'id'},
			{ mData: 'category_name' },
			{ mData: 'details'},
			{ mData: 'status', className: "text-center"},
			{ mData: 'actions' , className: "text-center"},
		],
	});
	//Edit
	publication_category_edit = function publication_category_edit(id){
		var edit_id = id;
		$.ajax({
			url: url+'/setting/publication/publication-categories-edit/'+edit_id,
			cache: false,
			success: function(response){
				var data = JSON.parse(response);
				$("#save_publication_category").html('Update');
				$("#cancle_publication_category").removeClass('hidden');
				$("#category_name").val(data['category_name']);
				$("#publication_category_edit_id").val(data['id']);
				$("#details").val(data['details']);
				(data['status']=="1")?$("#is_active").iCheck('check'):$("#is_active").iCheck('uncheck');
			}
		});
	}

	//Cancle Publication Categoru update
	$("#cancle_publication_category").click(function(){
		clear_form();
		$("#cancle_publication_category").addClass('hidden');
		$("#save_publication_category").html('Save');
	});

	//Delete
	publication_category_delete = function publication_category_delete(id){
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
					url: url+'/setting/publication/publication-category-delete/'+delete_id,
					cache: false,
					success: function(response){
						var response = JSON.parse(response);
						if (response['parentmessage']) {
							swal(response['parentmessage'], {
								icon: "warning",
							});
						}
						else{
							swal(response['deleteMessage'], {
								icon: "success",
							});
							publication_category.ajax.reload();
						}
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



	/*----- Publication End -----*/



	/*----- Course Start -----*/

	//Course Category Entry And Update
	$("#save_course_category").on('click',function(){

		event.preventDefault();
		$.ajaxSetup({
			headers:{
				'X-CSRF-TOKEN':$('meta[name="csrf-token"]').attr('content')
			}
		});
		
		
		var formData = new FormData($('#save_course_category_form')[0]);

		if($.trim($('#category_name').val()) == ""){
			success_or_error_msg('#form_submit_error','danger',"Please Insert Category Name","#category_name");			
		}
		else{
			
			$.ajax({
				url: url+"/settings/courses/course-category-entry",
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
						if (response['success']=='insert') {
							success_or_error_msg('#master_message_div',"success","Course Category Inserted Successful");
						}else{
							success_or_error_msg('#master_message_div',"success","Updated Successful");
						}
						course_category.ajax.reload();
						success_function();
						
					}
					$(window).scrollTop();
				 }	
			});
		}
	});

	//Course Categories data table
	var course_category = $('#course_category').DataTable({
		destroy: true,
		"processing": true,
		"serverSide": false,
		"ajax": url+"/settings/courses/course-categories-list",
		"aoColumns": [ 
			{ mData: 'id'},
			{ mData: 'category_name' },
			{ mData: 'details'},
			{ mData: 'status', className: "text-center"},
			{ mData: 'actions' , className: "text-center"},
		],
	});

	//Edit
	course_category_edit = function course_category_edit(id){
		var edit_id = id;
		$.ajax({
			url: url+'/settings/courses/course-categories-edit/'+edit_id,
			cache: false,
			success: function(response){
				var data = JSON.parse(response);
				$("#save_course_category").html('Update');
				cancle_btn_show();
				cancle_function();
				$("#category_name").val(data['category_name']);
				$("#course_category_edit_id").val(data['id']);
				$("#details").val(data['details']);
				(data['status']=="1")?$("#is_active").iCheck('check'):$("#is_active").iCheck('uncheck');
			}
		});
	}

	//Delete Course Category
	course_category_delete = function course_category_delete(id){
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
					url: url+'/setting/course/course-category-delete/'+delete_id,
					cache: false,
					success: function(response){
						var response = JSON.parse(response);
						if (response['parentmessage']) {
							swal(response['parentmessage'], {
								icon: "warning",
							});
						}
						else{
							swal(response['deleteMessage'], {
								icon: "success",
							});
							course_category.ajax.reload();
						}
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

	/*----- Course End -----*/

	/*----- Notice Start -----*/

	//notice Category Entry And Update
	$("#save_notice_category").on('click',function(){

		event.preventDefault();
		$.ajaxSetup({
			headers:{
				'X-CSRF-TOKEN':$('meta[name="csrf-token"]').attr('content')
			}
		});
		
		
		var formData = new FormData($('#save_notice_category_form')[0]);

		if($.trim($('#category_name').val()) == ""){
			success_or_error_msg('#form_submit_error','danger',"Please Insert Category Name","#category_name");			
		}
		else{
			
			$.ajax({
				url: url+"/settings/notice/notice-category-entry",
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
						if (response['success']=='insert') {
							success_or_error_msg('#master_message_div',"success","Notice Category Inserted Successful");
						}else{
							success_or_error_msg('#master_message_div',"success","Updated Successful");
						}
						notice_category.ajax.reload();
						success_function();
						
					}
					$(window).scrollTop();
				 }	
			});
		}
	});

	//Notice Categories data table
	var notice_category = $('#notice_category').DataTable({
		destroy: true,
		"processing": true,
		"serverSide": false,
		"ajax": url+"/settings/notice/notice-categories-list",
		"aoColumns": [ 
			{ mData: 'id'},
			{ mData: 'category_name' },
			{ mData: 'details'},
			{ mData: 'status', className: "text-center"},
			{ mData: 'actions' , className: "text-center"},
		],
	});

	//Edit Notice Category
	notice_category_edit = function notice_category_edit(id){
		var edit_id = id;
		$.ajax({
			url: url+'/settings/notice/notice-categories-edit/'+edit_id,
			cache: false,
			success: function(response){
				var data = JSON.parse(response);
				$("#save_notice_category").html('Update');
				cancle_btn_show();
				cancle_function();
				$("#category_name").val(data['category_name']);
				$("#notice_category_edit_id").val(data['id']);
				$("#details").val(data['details']);
				(data['status']=="1")?$("#is_active").iCheck('check'):$("#is_active").iCheck('uncheck');
			}
		});
	}

	//Delete Notice Category
	notice_category_delete = function notice_category_delete(id){
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
					url: url+'/setting/notice/notice-category-delete/'+delete_id,
					cache: false,
					success: function(response){
						var response = JSON.parse(response);
						if (response['parentmessage']) {
							swal(response['parentmessage'], {
								icon: "warning",
							});
						}
						else{
							swal(response['deleteMessage'], {
								icon: "success",
							});
							notice_category.ajax.reload();
						}
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

	/*----- Notice End -----*/


	/*----- Survey Start -----*/

	//Survey Category Entry And Update
	$("#save_survey_category").on('click',function(){

		event.preventDefault();
		$.ajaxSetup({
			headers:{
				'X-CSRF-TOKEN':$('meta[name="csrf-token"]').attr('content')
			}
		});
		
		
		var formData = new FormData($('#save_survey_category_form')[0]);

		if($.trim($('#category_name').val()) == ""){
			success_or_error_msg('#form_submit_error','danger',"Please Insert Category Name","#category_name");			
		}
		else{
			
			$.ajax({
				url: url+"/settings/survey/survey-category-entry",
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
						if (response['success']=='insert') {
							success_or_error_msg('#master_message_div',"success","Survey Category Inserted Successful");
						}else{
							success_or_error_msg('#master_message_div',"success","Updated Successful");
						}
						survey_category.ajax.reload();
						success_function();
						
					}
					$(window).scrollTop();
				 }	
			});
		}
	});

	//Survey Categories data table
	var survey_category = $('#survey_category').DataTable({
		destroy: true,
		"processing": true,
		"serverSide": false,
		"ajax": url+"/settings/survey/survey-categories-list",
		"aoColumns": [ 
			{ mData: 'id'},
			{ mData: 'category_name' },
			{ mData: 'details'},
			{ mData: 'status', className: "text-center"},
			{ mData: 'actions' , className: "text-center"},
		],
	});

	//Edit Survey Category
	survey_category_edit = function survey_category_edit(id){
		var edit_id = id;
		$.ajax({
			url: url+'/settings/survey/survey-categories-edit/'+edit_id,
			cache: false,
			success: function(response){
				var data = JSON.parse(response);
				$("#save_survey_category").html('Update');
				cancle_btn_show();
				cancle_function();
				$("#category_name").val(data['category_name']);
				$("#survey_category_edit_id").val(data['id']);
				$("#details").val(data['details']);
				(data['status']=="1")?$("#is_active").iCheck('check'):$("#is_active").iCheck('uncheck');
			}
		});
	}

	//Delete Notice Category
	survey_category_delete = function survey_category_delete(id){
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
					url: url+'/settings/survey/survey-categories-delete/'+delete_id,
					cache: false,
					success: function(response){
						var response = JSON.parse(response);
						if (response['parentmessage']) {
							swal(response['parentmessage'], {
								icon: "warning",
							});
						}
						else{
							swal(response['deleteMessage'], {
								icon: "success",
							});
							survey_category.ajax.reload();
						}
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


	/*----- Survey End -----*/









	
	/*----- Comon Function Start -----*/
	cancle_btn_show = function cancle_btn_show(){
		$("#cancle_btn").removeClass('hidden');
	}
	cancle_function = function cancle_function(){
		$("#cancle_btn").click(function() {
			$("#cancle_btn").addClass('hidden');
			clear_form();
			success_function();
		});
	}
	success_function = function success_function(){
		$("#cancle_btn").addClass('hidden');
		$(".save").html("Save");
		clear_form();
	}
	/*----- Comon Function End -----*/

	
});

	 