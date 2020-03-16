// All the user related js functions will be here
$(document).ready(function () {

    // for get site url
    var url = $('.site_url').val();

    $('.option_input').css('display','none')
    $('.answer_option_input').css('display','none')
    $('.survey_question_display').css('display','none')


    var survey_data_table = $('#survey_data_table').DataTable({
        destroy: true,
        "processing": true,
        "serverSide": false,
        "ajax": url+"/survey/survey-list",
        "aoColumns": [
            { mData: 'survey_name' },
            { mData: 'start_date', className: "text-center"},
            { mData: 'end_date', className: "text-center"},
            { mData: 'status', className: "text-center"},
            { mData: 'actions' , className: "text-center"},
        ],
    });

    deleteAnswer = function deleteAnswer(id){
        event.preventDefault();

        if(id==0){
            alert(id)
            $(this).parents().remove()
            return false;
        }

        //alert(id)
        //return false;
        $.ajax({
            url: url + '/survey/answer-option-delete/' + id,
            success: function (data) {
                //respons = JSON.parse(data);
                //console.log(data)
                editQuestion($('#question_id').val())
            }
        })
    }

    editQuestion= function editQuestion(id){
        event.preventDefault();
        //alert('id')

        $.ajax({
            url: url + '/survey/question-edit/' + id,
            success: function (data) {
                let response = JSON.parse(data);
                console.log(response)
                $('#question').val(response['question']['question_details'])
                $('#question_id').val(response['question']['id'])
                $('#option_type').val(response['question']['question_type'])
                $('#serial').val(response['question']['serial'])
                $('#display_option').val(response['question']['display_option'])
                var html = '';
                var sl=1;
                if(response['question']['question_type']==3 || response['question']['question_type']==4){
                    $('.option_input').css('display','block')
                }
                else{
                    $('.option_input').css('display','none')
                }
                $.each(response['question_answer'], function (key, value) {
                    html+='<label class="control-label col-md-2 col-sm-2 answer_list" >'+sl+'</label>\n' +
                        '  <div class="form-group col-md-10">\n' +
                        '       <div class="col-md-11">' +
                        '         <input type="text" name="answer[]"  class="form-control col-md-8" placeholder="Set Answerrs" value="'+value['answer_option']+'" />' +
                        '         <input type="hidden" name="answer_id[]" value="'+value['id']+'">' +
                        '       </div>' +
                        '       <div class="col-md-1"><button class="btn btn-xs btn-danger" onclick="deleteAnswer('+value['id']+')"><i class="clip-remove"></i></button></div>\n' +
                        '  </div>'
                    sl++;

                })
                $('#option_input').html(html)
                $('.answer_option_input').css('display','block')


            }
        })

    }

    deleteQuestion= function deleteQuestion(id){
        event.preventDefault();

        $.ajax({
            url: url + '/survey/question-delete/' + id,
            success: function (data) {
                //alert(data)
                edit_survey($('#survey_id').val())
                //let response = JSON.parse(data);
            }
        })
    }


    edit_survey= function edit_survey(id){
        //alert('load')
        $('.survey_question_display').css('display','block')
        $('#survey_id').val(id)
        $.ajax({
            url: url + '/survey/survey-edit/' + id,
            success: function (data) {
                var response = JSON.parse(data);

                $("#Survey_add_button").trigger('click');
                $("#Survey_add_button").html('Survey Update');
                $(".save").html('Update');

                $('#survey_name').val(response['survey']['survey_name'])
                $('#survey_type').val(response['survey']['survey_category'])
                $('#survey_start_date').val(response['survey']['start_date'])
                $('#survey_end_date').val(response['survey']['end_date'])
                //$('#user_group').val(response['survey']['survey_name'])
                $('#is_active').val(response['survey']['status'])
                $('#remarks').val(response['survey']['details'])

                let html = '';
                $.each(response['question'], function (key, value) {
                    var type='';
                    if(value['question_type']==1){type = 'Text Input'}
                    else if(value['question_type']==2){type = 'Number Input'}
                    else if(value['question_type']==3){type = 'Single Choice'}
                    else if(value['question_type']==4){type = 'Multiple Choice'}

                    //console.log(value)
                    html += '<tr><td>'+value['question_details']+'</td><td>'+type+'</td><td>'+value['serial']+'</td><td><button class="btn btn-xs btn-primary" onclick="editQuestion('+value['id']+')" style="margin-right: 5px"><i class="clip-pencil-3"></i></button><button class="btn btn-xs btn-danger" onclick="deleteQuestion('+value['id']+')"><i class="clip-remove"></i></button></td></tr>'
                })

                $('#question_table tbody').html(html)

            }
        });

    }


    delete_survey = function delete_survey(id){
        $.ajax({
            url: url + '/survey/survey-delete/' + id,
            success: function (data) {
                survey_data_table.ajax.reload()
            }
        })
    }


    survey_participant_answer = function survey_participant_answer(survey_id,id){
        //alert(survey_id)
        //alert(id)
        $.ajax({
            url: url + '/survey/survey-participant_result_view/'+survey_id+'/'+ id,
            success: function (response) {
                var data = JSON.parse(response);
                console.log(data)

                var description = "</br>";
                $.each(data['question'], function (key, value) {
                    //console.log(value)

                    description+='<div class="col-md-12" style="margin-bottom: 10px">\n'

                    description+=' <h6>'+value['serial']+'. '+value['question_details']+'</h6>\n'


                    if(value['question_type']==1 || value['question_type']==2){
                        description+= '<p>:'+data['answer'][value['id']]['answer']+'</p>'
                    }
                    else {
                        //alert('ok')
                        var sl = 'A'
                        if(value['display_option']==1){
                            $.each(value['answer'],function (key2, answer) {
                                //var answerChoose=''
                                var styleChoose = 'style="margin: 10px"'

                                if(data['answer']['answer_choice'].includes(answer['id'])){
                                    //alert('ok')
                                    styleChoose='style="margin: 10px; color:green"';
                                }

                                description+='<span '+styleChoose+'>('+sl+'): '+answer['answer_option']+'</span>\n';
                                sl = String.fromCharCode(sl.charCodeAt() + 1) // Returns B
                            })
                        }
                        else if(value['display_option']==2){
                            $.each(value['answer'],function (key2, answer) {

                                var styleChoose = 'style="margin: 10px"'

                                if(data['answer']['answer_choice'].includes(answer['id'])){
                                    //alert('ok')
                                    styleChoose='style="margin: 10px; color:green"';
                                }
                                description+='<p '+styleChoose+'">('+sl+'): '+answer['answer_option']+'</p>\n';
                                sl = String.fromCharCode(sl.charCodeAt() + 1) // Returns B
                            })
                        }
                        else if(value['display_option']==3){

                            $.each(value['answer'],function (key2, answer) {
                                //alert(data['answer']['answer_choice'])
                                var styleChoose = 'style="margin: 10px"'

                                if(data['answer']['answer_choice'].includes(answer['id'])){
                                    //alert('ok')
                                    styleChoose='style="margin: 10px; color:green"';
                                }


                                description+='<div class="col-md-5" '+styleChoose+'">('+sl+'): '+answer['answer_option']+'</div>\n';
                                sl = String.fromCharCode(sl.charCodeAt() + 1) // Returns B
                            })
                        }
                    }
                    description+='</div>'
                })

                //console.log(description)

                $("#survey_participant_body_view").html(description);

            }
        })
    }


    survey_participant = function survey_participant(id){


        //$('#survey_id_for_serial').val(id)
        $.ajax({
            url: url+'/survey/survey-participant_view/'+id,
            success: function(response){
                var datas = JSON.parse(response);
                //console.log(data)

               // $("#survey_view_li").css('display','block');
                $("#survey_participants_button").trigger('click');
                console.log(datas)

                $("#survey_name_participant_view").html(datas['survey']['survey_name']);
                $('#survey_details_participant_view').html(datas['survey']['details'])

                var left_sub = "";
                left_sub += "<br><b>Start Date: </b>"+datas['survey']['start_date'];
                left_sub += "<br><b>End Date: </b>"+datas['survey']['end_date'];
                left_sub += "<br><b>Survey Category: </b>"+datas['survey']['survey_category'];

                $("#left_sub_participant_view").html(left_sub);


                var right_sub = "";

                right_sub += "<br><b>Created By: </b>"+datas['survey']['created_by'];
                right_sub += "<br><b>Last Updated By: </b>"+datas['survey']['updated_by'];

                $("#right_sub_participant_view").html(right_sub);



                var html='';
                $.each(datas.surveyParticipant, function (key, data) {
                    html+='<tr><td>'+data['name']+'</td><td>'+datas.surveyQuestion+'</td><td>'+data['question_answered']+'</td><td>'+data['created_at']+'</td><td><button ' +
                        ' onclick="survey_participant_answer('+id+','+data['user_id']+')" class="btn btn-xs btn-primary" ><i class=clip-zoom-in></i></button></td></tr>'
                })

                $('#survey_participant_view tbody').html(html)

            }
        });
    }

    //edit_survey('1')

    //Save survey body
    add_answer_choice = function add_answer_choice(){
        //alert('sfs')
        event.preventDefault();

        var sl= parseInt($(".answer_list").length)+1;

        html='<label class="control-label col-md-2 col-sm-2 answer_list" >'+sl+'</label>\n' +
            '  <div class="form-group col-md-10 answer_block">\n' +
            '       <div class="col-md-11">' +
            '         <input type="text" name="answer[]"  class="form-control col-md-8" placeholder="Set Answerrs" value="" />' +
            '         <input type="hidden" name="answer_id[]" value="">' +
            '       </div>' +
            '       <div class="col-md-1"><button class="btn btn-xs btn-danger" onclick="deleteAnswer(0)"><i class="clip-remove"></i></button></div>\n' +
            '  </div>'
        $('#option_input').append(html)
    }

    $('#option_type').on('change',function () {
        let option_type = $('#option_type').val()
        if(option_type==4 || option_type==3){
            $('.option_input').css('display','block')
            $('.answer_option_input').css('display','block')
            if($('#option_input').html()==''){
                add_answer_choice()
                add_answer_choice()
            }

        }
        else {
            //$('.option_input').css('display','none')
            $('.answer_option_input').css('display','block')
            $('.option_input').css('display','none')
            $('.answer_option_input').css('display','none')
        }

    })

    $('#save_survey_body ').click(function(event){
        event.preventDefault();
        $.ajaxSetup({
            headers:{
                'X-CSRF-TOKEN':$('meta[name="csrf-token"]').attr('content')
            }
        });

        var formData = new FormData($('#survey_body')[0]);
        if($('#survey_id').val()){
            formData.append('survey_id',$('#survey_id').val())
        }
        if($.trim($('#survey_name').val()) == ""){
            success_or_error_msg('#form_submit_error','danger',"Please Insert Survey Title","#survey_name");
        }
        else{
            $.ajax({
                url: url+"/survey/survey-body-entry",
                type:'POST',
                data:formData,
                async:false,
                cache:false,
                contentType:false,processData:false,
                success: function(data){
                    var response = JSON.parse(data);

                    if(!response['survey_id']){
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
                        success_or_error_msg('#master_message_div',"success","Save Successfully");
                        $("#message_form .tableflat").iCheck('check');
                        $("#survey_id").val(response['survey_id'])
                        $('.survey_question_display').css('display','block')

                    }
                    $(window).scrollTop();
                }
            });
        }
    });

    $('#save_question').click(function (event) {
        event.preventDefault();
        $.ajaxSetup({
            headers:{
                'X-CSRF-TOKEN':$('meta[name="csrf-token"]').attr('content')
            }
        });

        var formData = new FormData($('#survey_question')[0]);
        formData.append('survey_id',$('#survey_id').val())
        if($.trim($('#question').val()) == ""){
            success_or_error_msg('#form_submit_error','danger',"Please Insert Question Title","#survey_name");
        }
        else{
            $.ajax({
                url: url+"/survey/survey-question-entry",
                type:'POST',
                data:formData,
                async:false,
                cache:false,
                contentType:false,processData:false,
                success: function(data){
                    var response = JSON.parse(data);

                    console.log(response)

                    if(!response['id'] && response!=1){
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

                        success_or_error_msg('#master_message_div',"success","Question Added Successfully");
                        $("#message_form .tableflat").iCheck('check');

                        edit_survey($('#survey_id').val())


                        $('#survey_question')[0].reset()

                        $('#question_id').val('')
                        $('.answer_option_input').html('')
                        $('.answer_option_input').css('display','none')
                        $('.option_input').css('display','none')

                    }
                    $(window).scrollTop();
                }
            });
        }
    })


    //Survey View
    survey_view = function survey_view(id, serial){
        var id = id;
        $('#survey_id_for_serial').val(id)
        $.ajax({
            url: url+'/survey/survey-view/'+id,
            success: function(response){
                var data = JSON.parse(response);
                $("#survey_view_li").css('display','block');
                $("#survey_view_button").trigger('click');
                //console.log(data)

                $("#survey_title").html("<h2>"+data['survey']['survey_name']+"</h2>");
                $('#survey_description').html(data['survey']['details'])

                var left_sub = "";
                left_sub += "<br><b>Start Date: </b>"+data['survey']['start_date'];
                left_sub += "<br><b>End Date: </b>"+data['survey']['end_date'];
                left_sub += "<br><b>Survey Category: </b>"+data['survey']['survey_category'];

                $("#left_sub").html(left_sub);


                var right_sub = "";

                right_sub += "<br><b>Created By: </b>"+data['survey']['created_by'];
                right_sub += "<br><b>Last Updated By: </b>"+data['survey']['updated_by'];

                $("#right_sub").html(right_sub);



                var description = "</br>";
                $.each(data['question'], function (key, value) {
                    //console.log(value)

                    description+='<div class="col-md-12" style="margin-bottom: 10px">\n'

                    if(serial ==1){
                        $('.serial').css('display','block')
                        description+='<h6><input style="width: 40px; margin-right: 10px" type="number" name="serial[]" id="'+value['id']+'" value="'+value['serial']+'"><input type="hidden" name="id[]" value="'+value['id']+'">'+value['question_details']+'</h6>\n'
                    }
                    else {
                        $('.serial').css('display','none')
                        description+=' <h6>'+value['serial']+'. '+value['question_details']+'</h6>\n'
                    }

                    if(value['question_type']==1 || value['question_type']==2){
                        description+= '<br><hr style="margin-bottom: 0px; border: .5px dashed ">'
                    }
                    else {
                        var sl = 'A'
                        if(value['display_option']==1){
                            $.each(value['answer'],function (key2, answer) {
                                description+='<span style="margin: 10px">('+sl+'): '+answer['answer_option']+'</span>\n';
                                sl = String.fromCharCode(sl.charCodeAt() + 1) // Returns B
                            })
                        }
                        else if(value['display_option']==2){
                            $.each(value['answer'],function (key2, answer) {
                                description+='<p style="margin: 10px">('+sl+'): '+answer['answer_option']+'</p>\n';
                                sl = String.fromCharCode(sl.charCodeAt() + 1) // Returns B
                            })
                        }
                        else if(value['display_option']==3){
                            $.each(value['answer'],function (key2, answer) {
                                description+='<div class="col-md-5" style="margin: 10px">('+sl+'): '+answer['answer_option']+'</div>\n';
                                sl = String.fromCharCode(sl.charCodeAt() + 1) // Returns B
                            })
                        }
                    }
                    description+='</div>'
                })

                $("#survey_body_view").html(description);
                //perticipant_manage();

            }
        });

        $('#updateSerial').click(function (event) {
            event.preventDefault();
            var values = [];
            var tem =0;
            $.each($('#serial_update').serializeArray(), function(i, field) {
                //alert(field.name)
                if(field.name.includes("serial[")){
                    values[tem] = field.value;
                    tem++;
                }
            });
            var duplcate_check = {};
            values.forEach(function(i) { duplcate_check[i] = (duplcate_check[i]||0) + 1;});
            var processNext = 1;
            $.each(duplcate_check, function (key,value) {
                //alert(value)
                if(value>1){
                    alert('You used '+key+' more than once')
                    processNext = 0;
                    return false;
                }
                if(key<1){
                    alert('Serial can not be 0 or negative value')
                    processNext = 0;
                    return false;
                }
            })

            if(processNext==1){
                var formData = new FormData($('#serial_update')[0]);
                $.ajaxSetup({
                    headers:{
                        'X-CSRF-TOKEN':$('meta[name="csrf-token"]').attr('content')
                    }
                });
                $.ajax({
                    url: url + "/survey/survey-question-serialize",
                    type: 'POST',
                    data: formData,
                    async: false,
                    cache: false,
                    contentType: false, processData: false,
                    success: function (data) {
                        if(data==1){
                            success_or_error_msg('#master_message_div',"danger",'Serial has been successfully updated');
                        }
                    }
                })
            }


        })

    }



    // Get survey Category
    $.ajax({
        url: url+'/survey/get-survey-type',
        success: function(response){
            var data = JSON.parse(response);
            var option = "";
            $.each(data,function (k,row) {
                option += '<option value="'+row['id']+'">'+row['category_name']+'</option>';
            });
            $("#survey_type").append(option);
        }
    });

    // Get Survey  User Group
    $.ajax({
        url: url+'/survey/get-user-group',
        success: function(response){
            var data = JSON.parse(response);
            var option = "";
            $.each(data,function (k,row) {
                option += '<option value="'+row['id']+'">'+row['group_name']+'</option>';
            });
            $("#user_group").append(option);
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




