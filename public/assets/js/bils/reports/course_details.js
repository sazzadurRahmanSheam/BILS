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
        //alert('sdf')
        event.preventDefault();

        var id= $('#course_id').val();
        $.ajax({
            url: url+'/course/course-view/'+id,
            success: function(response){
                var data = JSON.parse(response);
                console.log(data);

                var html_head = '<div class="col-md-12" style="margin-top: 20px">\n' +
                    '           <div class="col-md-12" style="text-align: center">\n' +
                    '           <img src="'+url+'/assets/images/logo.jpg" style=" height: 100px; width: auto; margin-top: 30px">\n'+
                    '           <h3>'+data["course_title"]+'</h3>\n' +
                    '           <p>'+data['details']+'</p>\n' +
                    '           </div>\n' +
                    '           </div>'

                var left_sub = "";
                left_sub += "<br><b>Approximate Start Time: </b>"+data['appx_start_time'];
                left_sub += "<br><b>Approximate End Time: </b>"+data['appx_end_time'];
               

                var right_sub = "";

                right_sub += "<br><b>Created By: </b>"+data['created_by'];
                right_sub += "<br><b>Last Updated By: </b>"+['updated_by'];

                var html_details = '<div style="margin-left: 5px; width: 98%">\n' +
                    '         <table style="border: 0px; width: 100%;"><tr style="width: 100%"><td style="width: 50%">'+left_sub+'</td><td style="text-align: right;width: 50%">'+right_sub+'</td></tr></table>'
                    '              </div>'


                var description = "</br>";
                //Getting perticipant list
 

                

                 html += '  </tbody>\n' +
                    '        </table>\n' +
                    '        </div></div>'

                var html_body = '<div style="width: 98%" id="survey_body_view">'+description+'</div>'

                var html= '<div style="width: 610px; border: solid 1px; padding-left: 20px">'+html_head+'<br>'+html_details+'<br>'+html_body+'</div>\n'


                openWin(html)
            }
        })



    });




    




    $("#course_name_code").autocomplete({

        search: function() {
        },
        source: function(request, response) {
            $.ajax({
                url: url+'/report/course/course-name',
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




