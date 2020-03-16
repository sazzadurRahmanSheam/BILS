// All the user related js functions will be here
$(document).ready(function () {

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
        //html+="<script>function printDiv(){alert('windo');window.print();alert('after');}</script>";

        myWindow = window.open("", "myWindow", "width=200, height=100");
        myWindow.document.write(html);
    }


    $('#search').on('click', function () {
        //alert('sdf')
        event.preventDefault();

        $.ajaxSetup({
            headers:{
                'X-CSRF-TOKEN':$('meta[name="csrf-token"]').attr('content')
            }
        });
        var formData = new FormData($('#survey_search')[0]);
        $.ajax({
            url: url+"/survey/report/survey-summary",
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


    })


});




