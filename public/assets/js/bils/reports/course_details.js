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
        myWindow = window.open("", "myWindow", "width=600, height=1000");
        myWindow.document.write(html);
    }

    



    $('#course_detailssearch').on('click', function () {
        
        event.preventDefault();
        var id = $("#course_title_code").val();
        //alert(id)
        if(id=="" || id==null){
            alert("Select Course");
        }
        else{
            $.ajax({
                url: url+'/report/course/course-details',
                type:'POST',
                data:{id:id},
                async:false,
                cache:false,
                success: function(response){
                    var data = JSON.parse(response);
                    var course_details = data['course_details'];
                    var interested_list = data['interested_list'];
                    var registeredList = data['registeredList'];
                    var selectedList = data['selectedList'];

                    var html_head = '<div class="col-md-12" style="margin-top: 20px">\n' +
                        '           <div class="col-md-12" style="text-align: center">\n' +
                        '           <img src="'+url+'/assets/images/logo.jpg" style=" height: 100px; width: auto; margin-top: 30px">\n'+
                        '           <h2>'+course_details["course_title"]+'</h2>\n' +
                        '           </div>\n' +
                        '           </div>'


                    var left_sub = "";
                    left_sub += "<br><b>Course Code: </b>"+course_details['course_code'];
                    if (course_details['appx_start_time']!="" && course_details['appx_start_time']!=null) {
                        left_sub += "<br><b>Approximate Start Time: </b>"+course_details['appx_start_time'];
                    }
                    if (course_details['appx_end_time'] != "" && course_details['appx_end_time']!=null) {
                       left_sub += "<br><b>Approximate End Time: </b>"+course_details['appx_end_time']; 
                    }
                    if (course_details['course_teacher']!="" && course_details['course_teacher']!=null) {
                        left_sub += "<br><b>Teacher: </b>"+course_details['course_teacher'];  
                    }
                    
                   

                    var right_sub = "";
                    if (course_details['act_start_time']!="" && course_details['act_start_time']!=null) {
                        right_sub += "<br><b>Actual Start Time: </b>"+course_details['act_start_time'];
                    }
                    if (course_details['act_end_time']!="" && course_details['act_end_time']!=null) {
                        right_sub += "<br><b>Actual End Time: </b>"+course_details['act_end_time'];
                    }
                    right_sub += "<br><b>Created By: </b>"+course_details['created_by'];
                    right_sub += "<br><b>Updated By: </b>"+course_details['updated_by'];

                    var html_details = '<div style="margin-left: 5px; width: 98%">\n' +
                        '                   <table style="border: 0px; width: 100%;"><tr style="width: 100%"><td style="width: 50%">'+left_sub+'</td><td style="text-align: right;width: 50%">'+right_sub+'</td></tr></table>'
                        '              </div>'


                    var description = "</br>";
                    description = '<p style="text-align: justify; text-justify: inter-word;">'+course_details['details']+'</p>';;
                    
                    //perticipant list
                    if (interested_list!="") {
                        description +='<br><div class="interested_list"><div style="text-align:center"><h3>Interested List</h3></div>';
                        description +='<table style="width:100%; border: 1px solid grey ;border-collapse: collapse">';
                        description +='<thead>';
                        description +='<tr style="padding: 5px">';
                        description +='<th style="padding: 5px; border: 1px solid grey; text-align: left">Name</th>';
                        description +='<th style="padding: 5px; border: 1px solid grey; text-align: left">Email</th>';
                        description +='<th style="padding: 5px; border: 1px solid grey; text-align: left">Phone</th>';
                        description +='</tr>';
                        description +='</thead>';
                        description +='<tbody>';
                        $.each(interested_list, function (key, value) {
                            description +='<tr>';
                            description +='<td style="border: 1px solid grey; padding: 5px">'+value['name']+'</td>';
                            description +='<td style="border: 1px solid grey; padding: 5px">'+value['email']+'</td>';
                            description +='<td style="border: 1px solid grey; padding: 5px">'+value['mobile']+'</td>';
                            description +='</tr>';
                        });
                        description +='</tbody></table></div>';
                    }

                    //Register List
                    if (registeredList!="") {
                        description +='<br><div class="registered_list"><div style="text-align:center"><h3>Registered List</h3></div>';
                        description +='<table style="width:100%; border: 1px solid grey ;border-collapse: collapse">';
                        description +='<thead>';
                        description +='<tr style="padding: 5px">';
                        description +='<th style="padding: 5px; border: 1px solid grey; text-align: left">Name</th>';
                        description +='<th style="padding: 5px; border: 1px solid grey; text-align: left">Email</th>';
                        description +='<th style="padding: 5px; border: 1px solid grey; text-align: left">Phone</th>';
                        description +='</tr>';
                        description +='</thead>';
                        description +='<tbody>';
                        $.each(registeredList, function (key, value) {
                            description +='<tr>';
                            description +='<td style="border: 1px solid grey; padding: 5px">'+value['name']+'</td>';
                            description +='<td style="border: 1px solid grey; padding: 5px">'+value['email']+'</td>';
                            description +='<td style="border: 1px solid grey; padding: 5px">'+value['mobile']+'</td>';
                            description +='</tr>';
                        });
                        description +='</tbody></table></div>';
                    }

                    //Selected List
                    if (selectedList!="") {
                        description +='<br><div class="registered_list"><div style="text-align:center"><h3>Selected List</h3></div>';
                        description +='<table style="width:100%; border: 1px solid grey ;border-collapse: collapse">';
                        description +='<thead>';
                        description +='<tr style="padding: 5px">';
                        description +='<th style="padding: 5px; border: 1px solid grey; text-align: left">Name</th>';
                        description +='<th style="padding: 5px; border: 1px solid grey; text-align: left">Email</th>';
                        description +='<th style="padding: 5px; border: 1px solid grey; text-align: left">Phone</th>';
                        description +='</tr>';
                        description +='</thead>';
                        description +='<tbody>';
                        $.each(selectedList, function (key, value) {
                            description +='<tr>';
                            description +='<td style="border: 1px solid grey; padding: 5px">'+value['name']+'</td>';
                            description +='<td style="border: 1px solid grey; padding: 5px">'+value['email']+'</td>';
                            description +='<td style="border: 1px solid grey; padding: 5px">'+value['mobile']+'</td>';
                            description +='</tr>';
                        });
                        description +='</tbody></table></div>';
                    }

                    description+='</div>';
                    

                    

                    var html_body = '<div style="width: 98%" id="survey_body_view">'+description+'</div>'

                    var html= '<div style="width: 610px; padding-left: 20px">'+html_head+'<br>'+html_details+'<br>'+html_body+'</div>\n'


                    openWin(html)
                }
            })
        }



    });


    // Load Course Title And Course Code
    $.ajax({
        url: url+'/report/course/get-course-title',
        success: function(response){
            var data = JSON.parse(response);
            var option = "";
            $.each(data, function (key, value) {
                option+='<option value="'+value["id"]+'">'+value["course_code"]+'->'+value["course_title"]+'</option>';
            });
            $("#course_title_code").append(option);
        }
    });




    




    // $("#course_name_code").autocomplete({

    //     search: function() {
    //     },
    //     source: function(request, response) {
    //         $.ajax({
    //             url: url+'/report/course/course-name',
    //             dataType: "json",
    //             type: "post",
    //             async:false,
    //             data: {
    //                 term: request.term
    //             },
    //             success: function(data) {
    //                 response(data);
    //             }
    //         });
    //     },
    //     minLength: 2,
    //     select: function(event, ui) {
    //         var id = ui.item.id;
    //         $(this).next().val(id);

    //     }
    // });

});




