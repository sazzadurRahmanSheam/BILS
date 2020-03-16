// All the user related js functions will be here
$(document).ready(function () {
    $.ajaxSetup({
        headers:{
            'X-CSRF-TOKEN':$('meta[name="csrf-token"]').attr('content')
        }
    });
    // for get site url
    var url = $('.site_url').val();

    printDiv =  function printDiv() {
        alert('sdf')
        var printContents = $('#order_summary_view').html();
        var printWindow = window.open('', '', 'height=400,width=800');
        printWindow.document.write('<html><head><title>DIV Contents</title>');
        printWindow.document.write('</head><body style="padding:10px">');
        printWindow.document.write(printContents);
        printWindow.document.write('</body></html>');
        printWindow.document.close();
        printWindow.print();
    }

    /*$('#printDiv').on('click', function () {
            alert('ok')
        })*/


    function openWin( html) {
        html+="<script>function printDiv(){alert('windo');window.print();alert('after');}</script>";
        myWindow = window.open("", "myWindow", "width=200, height=100");
        myWindow.document.write(html);
    }


    $('#search').on('click', function () {
        //alert('sdf')
        event.preventDefault();

        id= $('#survey_id').val()
        $.ajax({
            url: url+'/survey/survey-view/'+id,
            success: function(response){
                var data = JSON.parse(response);
                console.log(data)

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
                    description+=' <h5>'+value['serial']+'. '+value['question_details']+'</h5>\n'

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

                var html_body = '<div style="width: 98%" id="survey_body_view">'+description+'</div>'

                var html= '<div style="width: 610px; border: solid 1px; padding-left: 20px">'+html_head+'<br>'+html_details+'<br>'+html_body+'</div>\n'


                openWin(html)
            }
        })
        /*
        var formData = new FormData($('#survey_details')[0]);
        $.ajax({
            url: url+"/survey/survey-delete/"+,
            type:'POST',
            data:formData,
            async:false,
            cache:false,
            contentType:false,processData:false,
            success: function(data){
                var response = JSON.parse(data);

                var html = '<button style="text-align: right; background-color: #FFCC00 ; font-size: 20px; top: 0; float: right" id="printDiv" onclick="printDiv()">Print</button>\n' +
                    '<div id="order_summary_view">\n' +
                    '        <div style="alignment: center; text-align: center">\n' +
                    '            <img src="http://bils.test/assets/images/logo.jpg" style=" height: 100px; width: auto;">' +
                    '             <h2 style="text-align: center; color: #5897fb; size: 24px;">Survey Grid Summary</h2>\n' +
                    '        </div>\n' +
                    '        <div style="padding: 5px">\n' +
                    '           <table style="width:100%; border: 1px solid grey ;border-collapse: collapse">\n' +
                    '              <thead>\n' +
                    '                <tr style="padding: 5px">\n' +
                    '                 <th style="padding: 5px; border: 1px solid grey; text-align: left">Survey Name</th>\n' +
                    '                 <th style="max-width: 120px; padding: 5px; border: 1px solid grey; text-align: center">Start Date</th>\n' +
                    '                 <th style="max-width: 120px; padding: 5px; border: 1px solid grey; text-align: center" >End Date</th>\n' +
                    '                 <th style="max-width: 120px; padding: 5px; border: 1px solid grey; text-align: center" >Status</th>\n' +
                    '                 <th style="max-width: 40px; padding: 5px; border: 1px solid grey; text-align: center" >Question</th>\n' +
                    '                 <th style="max-width: 40px; padding: 5px; border: 1px solid grey; text-align: center" >Participants</th>\n' +
                    '                </tr>\n' +
                    '              </thead>\n' +
                    '              <tbody>'



                $.each(response, function (key, value) {
                    if(key!='user'){
                        if(value['status']==1){
                            status = 'Active'
                        }
                        else {
                            status = 'Inactive'
                        }

                        //console.log(value)
                        html+='<tr>\n' +
                            '     <td style="border: 1px solid grey; padding: 5px">'+value['survey_name']+'</td>\n' +
                            '     <td style="border: 1px solid grey; padding: 5px; text-align: center">'+value['start_date']+'</td>\n' +
                            '     <td style="border: 1px solid grey; padding: 5px; text-align: center">'+value['end_date']+'</td>\n' +
                            '     <td style="border: 1px solid grey; padding: 5px; text-align: center"> '+status+'</td>\n' +
                            '     <td style="border: 1px solid grey; padding: 5px; text-align: center">'+value['question']+'</td>\n' +
                            '     <td style="border: 1px solid grey; padding: 5px; text-align: center"> '+value['participant']+'</td>\n' +
                            '   </tr>'
                    }

                })

                html += '  </tbody>\n' +
                    '        </table>\n' +
                    '        </div></div>'


                html+='<div style="alignment: left; bottom: 0; position: fixed">\n' +
                    '      <label>Printed By: '+response['user']+'</label><br>\n' +
                    '      <label>Print Date: '+Date()+'</label>\n' +
                    '   </div>'
                openWin(html)
                //printDiv('order_summary_view')



            }
        });

        */


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

});




