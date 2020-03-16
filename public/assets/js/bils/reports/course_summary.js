$(document).ready(function () {

	// for get site url
	var url = $('.site_url').val();

	// printDiv =  function printDiv() {
		
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
		//html+="<script>function printDiv(){alert('windo');window.print();alert('after');}</script>";

		myWindow = window.open("", "myWindow", "width=650, height=1000");
		myWindow.document.write(html);
	}


	$('#search_course_summary').on('click', function () {
		event.preventDefault();

		$.ajaxSetup({
			headers:{
				'X-CSRF-TOKEN':$('meta[name="csrf-token"]').attr('content')
			}
		});
		var formData = new FormData($('#course_search')[0]);
		$.ajax({
			url: url+"/report/course/get-course-summary",
			type:'POST',
			data:formData,
			async:false,
			cache:false,
			contentType:false,
			processData:false,
			success: function(data){
				var response = JSON.parse(data);

				var html = '<button style="text-align: right; background-color: #FFCC00 ; font-size: 20px; top: 0; float: right" id="printDiv" onclick="printDiv()">Print</button>\n' +
					'<div id="order_summary_view">\n' +
					'        <div style="alignment: center; text-align: center">\n' +
					'            <img src="'+url+'/assets/images/logo.jpg" style=" height: 100px; width: auto;">' +
					'             <h2 style="text-align: center; color: #5897fb; size: 24px;">Course Grid Summary</h2>\n' +
					'        </div>\n' +
					'        <div style="padding: 5px">\n' +
					'           <table style="width:100%; border: 1px solid grey ;border-collapse: collapse">\n' +
					'              <thead>\n' +
					'                <tr style="padding: 5px">\n' +
					'                 <th style="padding: 5px; border: 1px solid grey; text-align: left">Course Name</th>\n' +
					'                 <th style="max-width: 120px; padding: 5px; border: 1px solid grey; text-align: center">Teacher</th>\n' +
					'                 <th style="max-width: 120px; padding: 5px; border: 1px solid grey; text-align: center" >Paypemt Method</th>\n' +
					'                 <th style="max-width: 120px; padding: 5px; border: 1px solid grey; text-align: center" >Payment Fee</th>\n' +
					'                 <th style="max-width: 40px; padding: 5px; border: 1px solid grey; text-align: center" >Starus</th>\n' +
					'                 <th style="max-width: 40px; padding: 5px; border: 1px solid grey; text-align: center" >Interested</th>\n' +
					'                </tr>\n' +
					'              </thead>\n' +
					'              <tbody>'



				$.each(response, function (key, value) {
					if(key!='user'){
						if(value['status']==1){
							status = 'Active'
						}
						else {
							status = 'Removed'
						}

						//console.log(value)
						html+='<tr>\n' +
							'     <td style="border: 1px solid grey; padding: 5px">'+value['course_title']+'</td>\n' +
							'     <td style="border: 1px solid grey; padding: 5px; text-align: center">'+value['start_date']+'</td>\n' +
							'     <td style="border: 1px solid grey; padding: 5px; text-align: center">'+value['course_teacher']+'</td>\n' +
							'     <td style="border: 1px solid grey; padding: 5px; text-align: center"> '+value['payment_fee']+'</td>\n' +
							'     <td style="border: 1px solid grey; padding: 5px; text-align: center">'+status+'</td>\n' +
							'     <td style="border: 1px solid grey; padding: 5px; text-align: center"> '+value['interested']+'</td>\n' +
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




