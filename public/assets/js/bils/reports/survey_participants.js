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
        myWindow = window.open("", "myWindow", "width=600, height=1000");
        myWindow.document.write(html);
    }


    $('#search').on('click', function () {
        //alert('sdf')
        event.preventDefault();

        id= $('#survey_id').val()


        $.ajax({
            url: url+'/survey/survey-participant_view/'+id,
            success: function(response){
                var datas = JSON.parse(response);
                //console.log(data)

                // $("#survey_view_li").css('display','block');
                $("#survey_participants_button").trigger('click');
                console.log(datas)


                var html_head = '<div class="col-md-12" style="margin-top: 20px">\n' +
                    '           <div class="col-md-12" style="text-align: center">\n' +
                    '           <img src="'+url+'/assets/images/logo.jpg" style=" height: 100px; width: auto; margin-top: 30px">\n'+
                    '           <h3>'+datas['survey']['survey_name']+'</h3>\n' +
                    '           <p>'+datas['survey']['details']+'</p>\n' +
                    '           </div>\n' +
                    '           </div>'

                var left_sub = "";
                left_sub += "<br><b>Start Date: </b>"+datas['survey']['start_date'];
                left_sub += "<br><b>End Date: </b>"+datas['survey']['end_date'];
                left_sub += "<br><b>Survey Category: </b>"+datas['survey']['survey_category'];

                var right_sub = "";

                right_sub += "<br><b>Created By: </b>"+datas['survey']['created_by'];
                right_sub += "<br><b>Last Updated By: </b>"+datas['survey']['updated_by'];

                var html_details = '<div style="margin-left: 5px; width: 98%">\n' +
                    '         <table style="border: 0px; width: 100%;"><tr style="width: 100%"><td style="width: 50%">'+left_sub+'</td><td style="text-align: right;width: 50%">'+right_sub+'</td></tr></table>'
                '              </div>'


                var description = "</br>";


                var html='';
                $.each(datas.surveyParticipant, function (key, data) {
                    html+='<tr ><td style="border: 1px solid grey; padding: 5px">'+data['name']+'</td>' +
                        '<td style="border: 1px solid grey; padding: 5px; text-align: center">'+datas.surveyQuestion+'</td>' +
                        '<td style="border: 1px solid grey; padding: 5px; text-align: center">'+data['question_answered']+'</td>' +
                        '<td style="border: 1px solid grey; padding: 5px; text-align: center">'+data['created_at']+'</td></tr>'
                })

                description +='<table style="width:100%; border: 1px solid grey ;border-collapse: collapse">\n' +
                    '         <thead>\n' +
                    '         <tr style="padding: 5px">\n' +
                    '         <th style="padding: 5px; border: 1px solid grey; text-align: left">Participant Name</th>\n' +
                    '          <th style="max-width: 80px; padding: 5px; border: 1px solid grey; text-align: center">Question Total</th>\n' +
                    '          <th style="max-width: 80px; padding: 5px; border: 1px solid grey; text-align: center" >Question Answered</th>\n' +
                    '          <th style="max-width: 120px; padding: 5px; border: 1px solid grey; text-align: center" >Date</th>\n' +
                    '          </tr>\n' +
                    '         </thead>\n' +
                    '         <tbody>\n' +html+
                    '        </tbody>\n' +
                    '        </table>'

                var html_body = '<div style="width: 98%" id="survey_body_view">'+description+'</div>'

                var html2= '<div style="width: 610px; min-height: 800px;  padding-left: 20px">'+html_head+'<br>'+html_details+'<br>'+html_body+'</div>\n'

                openWin(html2)
                // $('#survey_participant_view tbody').html(html)

            }
        });



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




