// All the user related js functions will be here
$(document).ready(function () {
    $.ajaxSetup({
        headers:{
            'X-CSRF-TOKEN':$('meta[name="csrf-token"]').attr('content')
        }
    });
    // for get site url
    var url = $('.site_url').val();

    // printDiv =  function printDiv() {
    //     alert('sdf')
    //     var printContents = $('#order_summary_view').html();
    //     var printWindow = window.open('', '', 'height=400,width=800');
    //     printWindow.document.write('<html><head><title>DIV Contents</title>');
    //     printWindow.document.write('</head><body style="padding:10px">');
    //     printWindow.document.write(printContents);
    //     printWindow.document.write('</body></html>');
    //     printWindow.document.close();
    //     printWindow.print();
    // }

    /*$('#printDiv').on('click', function () {
            alert('ok')
        })*/


    function openWin( html) {
        html+="<script>function printDiv(){alert('windo');window.print();alert('after');}</script>";
        myWindow = window.open("", "myWindow", "height=800,width=600");
        myWindow.document.write(html);
    }


    $('#app_user_search').on('click', function (){
        event.preventDefault();

        var id = $('#app_user_group_id_id').val();
        var search_criteria = $('#search_criteria').val();
        //alert(search_criteria)
        $.ajaxSetup({
            headers:{
                'X-CSRF-TOKEN':$('meta[name="csrf-token"]').attr('content')
            }
        });
        
        var formData = new FormData($('#app_user_report_form')[0]);

        // if (id!="" && search_criteria==""  ) {
            $.ajax({
                url: url+'/report/app-user-report',
                type:'POST',
                data:formData,
                async:false,
                cache:false,
                contentType:false,
                processData:false,
                success: function(response){
                    var app_user = JSON.parse(response);
                    var status = "";
                    
                    var html_head = '<div class="col-md-12" style="margin-top: 20px">\n' +
                        '           <div class="col-md-12" style="text-align: center">\n' +
                        '           <img src="'+url+'/assets/images/logo.jpg" style=" height: 100px; width: auto; margin-top: 30px">\n'+
                        '           <h3> App User Report</h3>\n' +                    
                        '           </div>\n' +
                        '           </div>'

                    


                    var description = "</br>";
                    
                       

                    description +='<table style="width:100%; border: 1px solid grey ;border-collapse: collapse">';
                    description +='<thead>';
                    description +='<tr style="padding: 5px">';
                    description +='<th style="padding: 5px; border: 1px solid grey; text-align: left">Name</th>';
                    description +='<th style="padding: 5px; border: 1px solid grey; text-align: left">Email</th>';
                    description +='<th style="padding: 5px; border: 1px solid grey; text-align: left">Phone</th>';
                    description +='<th style="padding: 5px; border: 1px solid grey; text-align: left">Address</th>';
                    // description +='<th style="padding: 5px; border: 1px solid grey; text-align: left">Groups</th>';
                    description +='<th style="padding: 5px; border: 1px solid grey; text-align: left">Status</th>';
                    description +='</tr>';
                    description +='</thead>';
                    description +='<tbody>';
                    $.each(app_user, function (key, app_user) {
                        if (app_user['status']==0) {
                            status = "In-active";
                        }
                        else if (app_user['status']==1) {
                            status = "Active";
                        }
                        else{
                            status = "Deleted";
                        }
                        description +='<tr>';
                        description +='<td style="border: 1px solid grey; padding: 5px">'+app_user['name']+'</td>';
                        description +='<td style="border: 1px solid grey; padding: 5px">'+app_user['email']+'</td>';
                        description +='<td style="border: 1px solid grey; padding: 5px">'+app_user['contact_no']+'</td>';
                        description +='<td style="border: 1px solid grey; padding: 5px">'+app_user['address']+'</td>';
                        // description +='<td style="border: 1px solid grey; padding: 5px">'+group_name[0]['group_name']+'</td>';
                        description +='<td style="border: 1px solid grey; padding: 5px">'+status+'</td>';
                        description +='</tr>';
                    });
                    description +='</tbody></table>';
                   
                     var html_body = '<div style="width: 98%" id="survey_body_view">'+description+'</div>'

                    var html= '<div style="width: 610px;  padding-left: 20px">'+html_head+'<br>'+html_body+'</div>\n'


                    openWin(html)
                }
            });
        // }
        // else if(id!="" && search_criteria!="" ){
        //     alert("Group & ....")
        // }
        // else if(id=="" && search_criteria!=""){
        //     alert("Only .....")
        // }
        // else{
        //     alert("Enter Something")
        // }

        



    });



    $("#app_user_group_name_search").autocomplete({

        search: function() {
        },
        source: function(request, response) {
            $.ajax({
                url: url+'/report/app-user-auto-suggest',
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
        minLength: 1,
        select: function(event, ui) {
            var id = ui.item.id;
            $(this).next().val(id);
        }
    });

});




