@extends('layout.master')
@section('content')
	<!--MESSAGE-->
	<div class="row ">
		<div class="col-md-10 col-md-offset-1" id="master_message_div">
		</div>
	</div>
	<!--END MESSAGE-->

    <!--PAGE CONTENT -->
    <div class="row ">
        <div class="col-sm-12">
            <div class="tabbable">
                <ul class="nav nav-tabs tab-padding tab-space-3 tab-blue" id="myTab4">
                    <li class="active">
                        <a id="survey_list_button" data-toggle="tab" href="#survey_list_div">
                           <b> Surveys Summary</b>
                        </a>
                    </li>
                </ul>
                <div class="tab-content">
                    <!-- PANEL FOR OVERVIEW-->
                    <div id="survey_list_div" class="tab-pane in active">
						<div class="row no-margin-row">
                           <!-- List of Categories -->
							<div class="panel panel-default">
								<div class="panel-heading">
									<i class="fa fa-external-link-square"></i>

									<div class="panel-tools">
										<a class="btn btn-xs btn-link panel-collapse collapses" href="#">
										</a>
										<a class="btn btn-xs btn-link panel-config" href="#panel-config" data-toggle="modal">
											<i class="fa fa-wrench"></i>
										</a>
										<a class="btn btn-xs btn-link panel-refresh" href="#">
											<i class="fa fa-refresh"></i>
										</a>
										<a class="btn btn-xs btn-link panel-expand" href="#">
											<i class="fa fa-resize-full"></i>
										</a>
										<a class="btn btn-xs btn-link panel-close" href="#">
											<i class="fa fa-times"></i>
										</a>
									</div>
								</div>
								<div class="panel-body">
                                    <div class="col-md-12">
                                        <form id="survey_search" name="survey_search" enctype="multipart/form-data" class="form form-horizontal form-label-left" >
                                            <div class="col-md-5">
                                                <label class="control-label col-md-4 col-sm-4 col-xs-12">Start Date<span class="required">*</span></label>
                                                <div class="col-md-8 col-sm-8 col-xs-8">
                                                    <input type="date" id="date_from" name="date_from"  class="form-control col-lg-12"/>
                                                </div>
                                            </div>
                                            <div class="col-md-5">
                                                <label class="control-label col-md-4 col-sm-4 col-xs-12">End Date<span class="required">*</span></label>
                                                <div class="col-md-8 col-sm-8 col-xs-8">
                                                    <input type="date" id="date_to" name="date_to"  class="form-control col-lg-12"/>
                                                </div>
                                            </div>
                                            <div class="col-md-2">
                                            <button type="button" class=" btn btn-primary " style="alignment: center" id="search">Search</button>
                                        </div>
                                        </form>
                                    </div>

								</div>
							</div>
							<!-- END Categoreis -->
                        </div>
                    </div>
                    <!--END PANEL FOR OVERVIEW -->

                </div>

                <div>
                    <div style="alignment: center; text-align: center">
                        <img src="http://bils.test/assets/images/logo.jpg" style=" height: 100px; width: auto;">
                        <h2 style="text-align: center; color: #5897fb; size: 24px;">Survey Grid Summary</h2>
                    </div>
                    <div style="padding: 5px">
                        <table style="width:100%; border: 1px solid grey; border-collapse: collapse">
                            <thead>
                            <tr style="padding: 5px; border: 1px solid gray; text-align: center ">
                                <th style="padding: 5px; border: 1px solid grey">Survey Name</th>
                                <th style="max-width: 120px; padding: 5px; border: 1px solid grey; text-align: center">Start Date</th>
                                <th style="max-width: 120px; padding: 5px; border: 1px solid grey; text-align: center" >End Date</th>
                                <th style="max-width: 120px; padding: 5px; border: 1px solid grey; text-align: center" >Status</th>
                                <th style="max-width: 40px; padding: 5px; border: 1px solid grey; text-align: center" >Question</th>
                                <th style="max-width: 40px; padding: 5px; border: 1px solid grey; text-align: center" >Participants</th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                                <td style="border: 1px solid grey; padding: 5px">Survey Name</td>
                                <td style="border: 1px solid grey; padding: 5px; text-align: center">Start Date</td>
                                <td style="border: 1px solid grey; padding: 5px; text-align: center">End Date</td>
                                <td style="border: 1px solid grey; padding: 5px; text-align: center"> Status</td>
                                <td style="border: 1px solid grey; padding: 5px; text-align: center">5</td>
                                <td style="border: 1px solid grey; padding: 5px; text-align: center"> 234</td>
                            </tr>
                            <tr>
                                <td style="border: 1px solid grey; padding: 5px">Survey Name</td>
                                <td style="border: 1px solid grey; padding: 5px; text-align: center">Start Date</td>
                                <td style="border: 1px solid grey; padding: 5px; text-align: center">End Date</td>
                                <td style="border: 1px solid grey; padding: 5px; text-align: center"> Status</td>
                                <td style="border: 1px solid grey; padding: 5px; text-align: center">5</td>
                                <td style="border: 1px solid grey; padding: 5px; text-align: center"> 234</td>
                            </tr>

                            </tbody>
                        </table>


                    </div>

                    <div style="alignment: left; bottom: 0; position: fixed">
                        <label>Printed By: kajol</label><br>
                        <label>Print Date: kajol</label>

                    </div>
                </div>
            </div>
        </div>
    </div>
    </div>
    <!--END PAGE CONTENT-->

@endsection


@section('JScript')

    <script src="{{ asset('assets/js/bils/reports/survey_summary.js')}}"></script>

@endsection


