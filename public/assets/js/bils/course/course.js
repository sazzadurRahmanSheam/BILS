// All the user related js functions will be here

$(document).ready(function () {



    // for get site url
    var url = $('.site_url').val();
    var global_id ;

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

    //Course Entry And update
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

    //Course Data Table
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
                $("#c_title").html("<h2>"+data['course_title']+"</h2>");
                var status_btn = "";
                status_btn +=(data['pub_status']=='0')?"<button class='btn  btn-danger'>Not-published</button>":"<button class='btn  btn-success'>Published</button>";
                if (data['course_status']=='1') {
                    status_btn +=" <button class='btn  btn-warning'>Initiated</button>"
                }else if (data['course_status']=='2') {
                    status_btn +=" <button class='btn  btn-success'>Approved</button>"
                }else if (data['course_status']=='3') {
                    status_btn +=" <button class='btn  btn-danger'>Rejected</button>"
                }else if (data['course_status']=='4') {
                    status_btn +=" <button class='btn  btn-info'>Started</button>"
                }else if (data['course_status']=='5') {
                    status_btn +=" <button class='btn  btn-success'>Completed</button>"
                }
                $("#status_btn").html(status_btn);

                var left_sub = "";
                if(data['duration']!=null){left_sub += "<br><b>Duration: </b>"+data['duration']+" Hours";}
                if(data['appx_start_time']!=null){left_sub += "<br><b>Approximate Start Time: </b>"+data['appx_start_time'];}
                if(data['act_start_time']!=null){left_sub += "<br><b>Actual Start Time: </b>"+data['act_start_time'];}
                if(data['course_type']!=null){left_sub += "<br><b>Course Type: </b>"+data['course_type'];}
                left_sub += "<br><b>Created By: </b>"+data['created_by'];
                if(data['payment_fee']!=null){left_sub += "<br><b>Payment Fee: </b>"+data['payment_fee'];}
                if(data['discount_message']!=null){left_sub += "<br><b>Discount Message: </b>"+data['discount_message'];}
                $("#left_sub").html(left_sub);


                var right_sub = "";

                if(data['appx_end_time']!=null){right_sub +="<br/><b>Approximate End Time: </b>"+data['appx_end_time'];}
                if(data['act_end_time']!=null){right_sub +="<br/><b>Actual End Time: </b>"+data['act_end_time'];}
                if(data['course_teacher']!=null){right_sub +="<br/><b>Course Teacher: </b>"+data['course_teacher'];}
                right_sub +="<br/><b>Updated By: </b>"+data['updated_by'];
                if(data['payment_method']!=null){right_sub +="<br/><b>Payment Method: </b>"+data['payment_method'];}
                right_sub +="<br/><b>Course Responsible Person: </b>"+data['course_responsible_person'];

                $("#right_sub").html(right_sub);

                var description = "";
                description +="<hr>"+data['details']+"<hr>";
                $("#description").html(description);
                global_id = id;
                perticipant_manage();

            }
        });
    }



    //Getting perticipant list
    perticipant_manage = function perticipant_manage(){
        $.ajax({
            url: url+"/course/course-participant-list/"+global_id,
            success: function(res){
                var perticipants = JSON.parse(res);
                var perticipantsList = perticipants['perticipantsList'];
                var registeredList = perticipants['registeredList'];
                var selectedList = perticipants['selectedList'];

                var perticipantTotal = perticipants['perticipantTotal'];
                var registerTotal = perticipants['registerTotal'];
                var selectedTotal = perticipants['selectedTotal'];

                
	
                if(!jQuery.isEmptyObject(perticipants)){
                    var html='';
                    html +='<br><div class="tabbable">';
                    html +='<ul class="nav nav-tabs tab-padding tab-space-3 tab-blue" id="myTab4">';
                    html +='<li class="active"><a id="interested_list_button" data-toggle="tab" href="#interested_div"><b>Interested List <span class="badge badge-pill badge-warning">'+perticipantTotal+'</span></b></a></li>';
                    if(registerTotal>0){html +='<li><a id="registered_list_button" data-toggle="tab" href="#registered_div"><b>Registered List <span class="badge badge-pill badge-warning">'+registerTotal+'</span></b></a></li>';}
                    if(selectedTotal>0){html +='<li><a id="selected_list_button" data-toggle="tab" href="#selected_div"><b>Selected List <span class="badge badge-pill badge-warning">'+selectedTotal+'</span></b></a></li>';}
                    html +='</ul>';
                    html +='<div class="tab-content">';

                    //Interested Table Start
                    html +='<div id="interested_div" class="tab-pane in active">';
                    html += '<table class="table table-bordered"><thead><tr class="headings"><th style="width:10%">SL NO</th><th style="width:40%">Name</th><th style="width:30%">Email</th><th  style="width:20%">Phone</th></tr></thead>';
                    var interest_sl = 1;
                    $.each(perticipantsList, function(i,row){
                        html += '<tr>';
                        html += '<td>'+interest_sl+'</td>';
                        html += '<td>'+row["name"]+'</td>';
                        html += '<td>'+row["email"]+'</td>';
                        html += '<td>'+row["mobile"]+'</td>';

                        html += '</tr>';
                        interest_sl++;
                    });
                    html +='</table>';
                    html +='</div>';
                    //Interested Table End

                    //Registered Table Start
                    html +='<div id="registered_div" class="tab-pane">';
                    html += '<form id="select_form" name="courses_form" enctype="multipart/form-data" class="form form-horizontal form-label-left"><table class="table table-bordered"><thead><tr class="headings"><th style="width:10%">SL NO</th><th style="width:35%">Name</th><th style="width:20%">Email</th><th style="width:20%">Phone</th><th style="width:15%">Selection</th></tr></thead>';
                    var register_sl = 1;
                    $.each(registeredList, function(i,register_row){
                        html += '<tr>';
                        html += '<td>'+register_sl+'</td>';
                        html += '<td>'+register_row["name"]+'</td>';
                        html += '<td>'+register_row["email"]+'</td>';
                        html += '<td>'+register_row["mobile"]+'</td>';
                        html += '<td>';
                       
                        if(select_perticipant_permisiion==1){
                            html +=(register_row["is_selected"]=="1")?'<input class="form-control" checked value="'+register_row["cp_id"]+'"  type="checkbox" name="selected_person[]">':'<input class="form-control" value="'+register_row["cp_id"]+'"  type="checkbox" name="selected_person[]">';
                        }
                        html += '</td></tr>';
                        register_sl++;
                    });
                    html +='<tr><td class="text-center" colspan="4"></td>';
                    html +='<td>'
                    if(select_perticipant_permisiion==1){
                        html +='<button onclick="saveSelect()" class="btn btn-sam btn-success">Submit Selection</button></td></tr>'
                    }
                    html +='</td></tr>'
                    html +='</form></table>';
                    html +='</div>';
                    //Registered Table End

                    //Selected Table Start
                    html +='<div id="selected_div" class="tab-pane">';
                    html += '<form id="select_remove_form" name="select_remove_form" enctype="multipart/form-data" class="form form-horizontal form-label-left"><table class="table table-bordered"><thead><tr class="headings"><th style="width:10%">SL NO</th><th style="width:35%">Name</th><th style="width:20%">Email</th><th style="width:20%">Phone</th><th style="width:15%">Selection</th></tr></thead>';
                    var selected_sl = 1;
                    $.each(selectedList, function(i,selected_row){
                        html += '<tr>';
                        html += '<td>'+selected_sl+'</td>';
                        html += '<td>'+selected_row["name"]+'</td>';
                        html += '<td>'+selected_row["email"]+'</td>';
                        html += '<td>'+selected_row["mobile"]+'</td>';
                        html += '<td class="rem_input" >';
                        if(select_perticipant_permisiion==1){
                            html += '<input class="form-control" value="'+selected_row["cp_id"]+'" type="checkbox" name="remove_person[]">';
                        }
                        html +='</td>;'
                        html += '</tr>';
                        selected_sl++;
                    });
                    html +='<tr><td class="text-center" colspan="4"></td>';
                    html +='<td>';
                    if(select_perticipant_permisiion==1){
                        html +='<button onclick="save_remove_person()" class="btn btn-sm btn-danger" >Remove</button>';
                    }
                    html +='</td>';
                    html +='</form></table>';
                    html +='</div>';
                    //Selected Table End


                    html +='</div>';

                    html +='</div>';
                }

                $('#participant_table').html(html);
                $('.form').iCheck({
                    checkboxClass: 'icheckbox_flat-green',
                    radioClass: 'iradio_flat-green'
                });
            }
        });
    }



    //Course Delete
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
                
                $("#discount_message").val(data['discount_message']);
                (data['pub_status']=='0')?$("#pub_status").iCheck('uncheck'):$("#pub_status").iCheck('check');
                $("#edit_course_status").css('display','block');
                $("#course_status").val(data['course_status']).change();
                $("#course_teacher").val(data['course_teacher']).change();

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

    // Get Teacher
    $.ajax({
        url: url+'/course/get-teacher',
        success: function(response){
            var data = JSON.parse(response);
            var option = "";
            $.each(data,function (k,row) {
                option += '<option>'+row['name']+'</option>';
            });
            $("#course_teacher").append(option);
        }
    });




    saveSelect = function saveSelect(){
        event.preventDefault();
        $.ajaxSetup({
            headers:{
                'X-CSRF-TOKEN':$('meta[name="csrf-token"]').attr('content')
            }
        });

        var formData = new FormData($('#select_form')[0]);

        $.ajax({
            url: url+"/course/save-select-person",
            type:'POST',
            data:formData,
            async:false,
            cache:false,
            contentType:false,processData:false,
            success: function(data){
                perticipant_manage();
                $("#p_mess").html(data);
            }
        });

    }




    save_remove_person = function save_remove_person(){
        event.preventDefault();
        $.ajaxSetup({
            headers:{
                'X-CSRF-TOKEN':$('meta[name="csrf-token"]').attr('content')
            }
        });

        var formData = new FormData($('#select_remove_form')[0]);

        $.ajax({
            url: url+"/course/save-remove-person",
            type:'POST',
            data:formData,
            async:false,
            cache:false,
            contentType:false,processData:false,
            success: function(data){

                perticipant_manage();
                //$("#selected_list_button").trigger('click');
                $("#p_mess").html(data);
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



