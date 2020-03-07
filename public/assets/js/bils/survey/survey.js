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
                var html = '';
                var sl=1;
                if(response['question']['question_type']==3 || response['question']['question_type']==4){
                    $('.option_input').css('display','block')
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
                    html += '<tr><td>'+value['question_details']+'</td><td>'+type+'</td><td><button class="btn btn-xs btn-primary" onclick="editQuestion('+value['id']+')" style="margin-right: 5px"><i class="clip-pencil-3"></i></button><button class="btn btn-xs btn-danger" onclick="deleteQuestion('+value['id']+')"><i class="clip-remove"></i></button></td></tr>'
                })

                $('#question_table tbody').html(html)

            }
        });

    }

    survey_view = function survey_view(id){

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
            add_answer_choice()
            add_answer_choice()
        }
        else {
            //$('.option_input').css('display','none')
            $('.answer_option_input').css('display','block')
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

    $('#save_question').click(function (even) {
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




