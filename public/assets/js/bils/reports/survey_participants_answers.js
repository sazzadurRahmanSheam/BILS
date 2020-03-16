// All the user related js functions will be here
$(document).ready(function () {
    $.ajaxSetup({
        headers:{
            'X-CSRF-TOKEN':$('meta[name="csrf-token"]').attr('content')
        }
    });
    // for get site url
    var url = $('.site_url').val();

    function openWin( html) {
        html+="<script>function printDiv(){alert('windo');window.print();alert('after');}</script>";
        myWindow = window.open("", "myWindow", "width=600, height=100");
        myWindow.document.write(html);
    }



    $('#search').on('click', function () {
        //alert('sdf')
        event.preventDefault();

        id= $('#survey_id').val()
        participant_id = $('#survey_participant_id').val()


        $.ajax({
            url: url + '/survey/survey-participant_result_view/'+id+'/'+ participant_id,
            success: function (response) {
                var data = JSON.parse(response);
                //console.log(data)

                var html_head = '<div class="col-md-12" style="margin-top: 20px">\n' +
                    '           <div class="col-md-12" style="text-align: center">\n' +
                    '           <img src="'+url+'/assets/images/logo.jpg" style=" height: 100px; width: auto; margin-top: 30px">\n'+
                    '           <h3>'+data['survey']['survey_name']+'</h3>\n' +
                    '           <p>'+data['survey']['details']+'</p>\n' +
                    '           </div>\n' +
                    '           </div>'

                var left_sub = "";
                left_sub += "<br><b>Start Date: </b>"+data['survey']['start_date'];
                left_sub += "<br><b>End Date: </b>"+data['survey']['end_date'];
                left_sub += "<br><b>Survey Category: </b>"+data['survey']['survey_category'];

                var right_sub = "";

                right_sub += "<br><b>Created By: </b>"+data['survey']['created_by'];
                right_sub += "<br><b>Last Updated By: </b>"+data['survey']['updated_by'];

                var html_details = '<div style="margin-left: 5px; width: 98%">\n' +
                    '         <table style="border: 0px; width: 100%;"><tr style="width: 100%"><td style="width: 50%">'+left_sub+'</td><td style="text-align: right;width: 50%">'+right_sub+'</td></tr></table>'
                '              </div>'


                var description = "</br>";
                $.each(data['question'], function (key, value) {
                    //console.log(value)

                    description+='<div style="margin-bottom: 10px; width: 100%">\n'

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
                                var styleChoose = 'style="margin: 10px; width: 40%"'

                                if(data['answer']['answer_choice'].includes(answer['id'])){
                                    //alert('ok')
                                    styleChoose='style="margin: 10px; color:green"';
                                }


                                description+='<div '+styleChoose+'">('+sl+'): '+answer['answer_option']+'</div>\n';
                                sl = String.fromCharCode(sl.charCodeAt() + 1) // Returns B
                            })
                        }
                    }
                    description+='</div>'
                })

                //console.log(description)

                var html_body = '<div style="width: 98%" id="survey_body_view">'+description+'</div>'

                var html= '<div style="width: 610px; border: solid 1px; padding-left: 20px">'+html_head+'<br>'+html_details+'<br>'+html_body+'</div>\n'


                openWin(html)
            }
        })


    })





    $('#survey_name_code').on('focusout',function () {
        //alert('sdf')
        if($('#survey_id').val!='' && $('#survey_id').val()!=0){
            //alert('false')
            $('#survey_participant').prop('disabled', false);
        }
        else {
            //alert('true')
            $('#survey_participant').prop('disabled', true);
            $('#survey_participant_id').val(0);
        }

    })

    $("#survey_name_code").autocomplete({

        search: function() {
        },
        source: function(request, response) {
            $.ajax({
                url: url+'/survey/survey-name',
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
            $(this).next().val(id);

        }
    });

    $("#survey_participant").autocomplete({

        search: function() {
        },
        source: function(request, response) {
            $.ajax({
                url: url+'/survey/participant-name',
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
            $(this).next().val(id);

        }
    });


});




