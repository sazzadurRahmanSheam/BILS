// All the user related js functions will be here
$(document).ready(function () {

    // for get site url
    var url = $('.site_url').val();

    function loadSurvey(id){
        var edit_id = id;
        $.ajax({
            url: url + '/survey/survey-edit/' + id,
            success: function (response) {
            }
        });

    }

    //Save survey body
    add_answer_choice = function add_answer_choice(){
        //alert('sfs')
        event.preventDefault();

        var sl= parseInt($(".answer_list").length)+1;

        html='<label class="control-label col-md-2 col-sm-2 answer_list" >'+sl+'</label>\n' +
            '  <div class="form-group col-md-10">\n' +
            '       <input type="text" id="" name="answer[]"  class="form-control col-md-10" placeholder="Set Answerrs" />\n' +
            '  </div>'
        $('#option_input').append(html)
    }

    $('#option_type').on('change',function () {
        let option_type = $('#option_type').val()
        if(option_type==4 || option_type==3){
            $('#option_input').css('display','block')
        }
        else {
            $('#option_input').css('display','none')
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
        if($('#survey_id').val()!=0){
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
                        $("survey_id").val(response['survey_id'])
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

                    if(!response['id']){
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
                        var type = ''
                        if(response['question_type']==1){type = 'Text Input'}
                        else if(response['question_type']==2){type = 'Number Input'}
                        else if(response['question_type']==3){type = 'Single Choice'}
                        else if(response['question_type']==4){type = 'Multiple Choice'}
                        alert(response['question_details'])

                        var html = '<tr><td>'+response['question_details']+'</td><td>'+type+'</td><td><button class="btn btn-xs btn-primary" onclick="editQuestion('+response['id']+')"><i class="clip-pencil-3"></i></button><button class="btn btn-xs btn-danger" onclick="deleteQuestion('+response['id']+')"><i class="clip-remove"></i></button></td></tr>'
                        $('#question_table tbody').append(html)
                        success_or_error_msg('#master_message_div',"success","Question Added Successfully");
                        $("#message_form .tableflat").iCheck('check');

                        $('#survey_question')[0].reset()
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




