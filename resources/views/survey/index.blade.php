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
                           <b> Surveys List</b>
                        </a>
                    </li>
                    @if($actions['add_permisiion']==1)
	                    <li class="">
	                        <a data-toggle="tab" href="#entry_form_div" id="Survey_add_button">
	                           <b> Add Surveys</b>
	                        </a>
	                    </li>
	                @endif
                    <li style="display: block;" id="survey_view_li">
                        <a data-toggle="tab" href="#survey_view" id="survey_view_button">
                            <b>Courses View</b>
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
									<div class="text-center">
										<h2 class="text-info">Survey Grid Summary</h2>
									</div>
									<table class="table table-bordered table-hover admin_user_table" id="survey_data_table" style="width:100% !important">
										<thead>
											<tr>
												<th>Survey Name</th>
												<th  style="max-width: 120px">Start Date</th>
												<th style="max-width: 120px" >End Date</th>
												<th style="max-width: 120px" >Status</th>
												<th style="max-width: 130px" >Actions</th>
											</tr>
										</thead>
										<tbody>
										</tbody>
									</table>
								</div>
							</div>
							<!-- END Categoreis -->
                        </div>
                    </div>
                    <!--END PANEL FOR OVERVIEW -->

                    <!-- PANEL FOR SURVEY ENTRY UPDATE -->
                    <div id="entry_form_div" class="tab-pane in">
                        <div class="row no-margin-row">
                            <input type="hidden" id="survey_id">
                            <div style="border: solid 1px; padding: 20px; margin-bottom: 20px">
							    <form id="survey_body" name="survey_body" enctype="multipart/form-data" class="form form-horizontal form-label-left" >
								@csrf
								<div class="row">
								    <div class="col-md-12">

									<div class="form-group">
										<label class="control-label col-md-2 col-sm-2 col-xs-6">Survey Name<span class="required">*</span></label>
										<div class="col-md-4 col-sm-4 col-xs-6">
											<input type="text" id="survey_name" name="survey_name" class="form-control col-lg-12"/>
										</div>
										<label class="control-label col-md-2 col-sm-2 col-xs-6" >Survey Type<span class="required">*</span></label>
										<div class="col-md-4 col-sm-4 col-xs-6">
											<select name="survey_type" id="survey_type" class="form-control col-lg-12">
												<option value="" disabled selected>Select Survey Type</option>
											</select>
										</div>
									</div>

									<div class="form-group">
										<label class="control-label col-md-2 col-sm-2 col-xs-6">Start Date<span class="required">*</span></label>
										<div class="col-md-4 col-sm-4 col-xs-6">
											<input type="date" id="survey_start_date" name="survey_start_date"  class="form-control col-lg-12"/>
										</div>
										<label class="control-label col-md-2 col-sm-2 col-xs-6" >End Date<span class="required">*</span></label>
										<div class="col-md-4 col-sm-4 col-xs-4">
											<input type="date" id="survey_end_date" name="survey_end_date" class="form-control col-lg-12"/>
										</div>
									</div>


									<div class="form-group">
										<label class="control-label col-md-2 col-sm-2 col-xs-6">Survey People</label>
										<div class="col-md-4 col-sm-4 col-xs-6">
											<select name="user_group" id="user_group" class="form-control col-lg-12">
												<option value="" disabled selected>Select Survey People</option>
											</select>
										</div>
									</div>
									<div class="form-group">
										<label class="control-label col-md-2 col-sm-2 col-xs-6" >Is Active</label>
										<div class="col-md-4 col-sm-4 col-xs-6">
											<input type="checkbox" id="is_active" name="is_active" checked="checked" class="form-control col-lg-12"/>
										</div>
									</div>
									<br/>
									<div class="form-group">
										<label class="control-label col-md-2 col-sm-2 col-xs-6">Survey Description</label>
										<div class="col-md-10 col-sm-10 col-xs-12">
											<textarea rows="4" cols="100" id="remarks" name="remarks" class="form-control col-lg-12"></textarea>
										</div>
									</div>
                                </div>

                                </div>
                                <div class="form-group" id="survey_body_button">
                                    <label class="control-label col-md-2 col-sm-2 col-xs-6"></label>
                                    <div class="col-md-3 col-sm-3 col-xs-12">
                                        <button type="submit" id="save_survey_body" class="btn btn-success save">Save</button>
                                        <button type="button" id="clear_button" class="btn btn-warning">Clear</button>
                                    </div>
                                    <div class="col-md-7 col-sm-7 col-xs-12">
                                        <div id="form_submit_error" class="text-center" style="display:none"></div>
                                    </div>
                                </div>
                            </form>
                            </div>
                            <div class="survey_question_display"  style="border: solid 1px; padding: 20px; margin-bottom: 20px">

                                <table class="table table-bordered table-hover course_table" id="question_table" style="width:100% !important">
                                    <thead>
                                    <tr style="background-color: #114177; color: white">
                                        <th width="60%">Question Title</th>
                                        <th>Answer Type </th>
                                        <th width="10%">Actions</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    </tbody>
                                </table>
                            </div>

                            <div class="survey_question_display" style="border: solid 1px; padding: 20px; margin-bottom: 20px">

                                <form id="survey_question" name="survey_question" enctype="multipart/form-data" class="form form-horizontal form-label-left">
                                @csrf
                                <div class="row">
                                    <div class="col-md-12">
									<div class="form-group">
                                        <div style="background-color: #114177; color: white; height: 35px; padding: 10px;">
                                            <label>Survey Questions</label>
                                        </div>
										<div class="col-md-12 col-sm-12 col-xs-12">

											<div class="col-md-12 col-lg-12 col-sm-12 col-xs-12">


												<div class="panel panel-default">
                                                    <div class="form-group panel-body" >
                                                        <label class="control-label col-md-2 col-sm-2 col-xs-6">Question Title<span class="required">*</span></label>
                                                        <div class="col-md-4 col-sm-4 col-xs-6">
                                                            <textarea id="question" name="question" class="form-control col-lg-12"></textarea>
                                                            <input type="hidden" name="question_id" id="question_id">
                                                        </div>
                                                        <label class="control-label col-md-2 col-sm-2 col-xs-6" >Answer Type<span class="required">*</span></label>
                                                        <div class="col-md-4 col-sm-4 col-xs-6">
                                                            <select name="option_type" id="option_type" class="form-control col-md-6">
                                                                <option value="" disabled selected>Select Question Type</option>
                                                                <option value="1">Text Input</option>
                                                                <option value="2">Number Input</option>
                                                                <option value="3">Single Choice</option>
                                                                <option value="4">Multiple Choice</option>
                                                            </select>
                                                        </div>

                                                        <div class="col-md-12 panel-body answer_option_input" id="option_input" style="display: none">
                                                        </div>
                                                        <button class="btn btn-dark-grey option_input"  onclick="add_answer_choice()">Add Answer Field</button>

                                                    </div>
                                                </div>
											</div>
										</div>
									</div>
									<div class="ln_solid"></div>
								</div>

								</div>
								<div class="form-group">
								<label class="control-label col-md-2 col-sm-2 col-xs-6"></label>
								<div class="col-md-3 col-sm-3 col-xs-12">
                                    <button id="save_question" class="btn btn-success save">Save</button>
									<button type="button" id="save_question_clear" class="btn btn-warning">Clear</button>
								</div>
								 <div class="col-md-7 col-sm-7 col-xs-12">
									<div id="form_submit_error" class="text-center" style="display:none"></div>
								 </div>
							</div>
							</form>

                            </div>
                        </div>
                    </div>
                    <!-- END PANEL FOR SURVEY CREATE/UPDATE -->
                    <div id="survey_view" class="tab-pane in" style="width: 595px; border: solid 1px">
                        <div class="row no-margin-row">
                            <div class="col-md-12">
                                <div class="col-md-12">
                                    <div class="col-md-12" style="text-align: center">
                                        <span id="survey_title"></span>
                                        <p id="survey_description"></p>
                                    </div>
                                </div>
                                <div class="col-md-12" style="margin-left: 5px;">
                                    <div id="left_sub" class="col-md-6"></div>
                                    <div id="right_sub" class="col-md-6" style="text-align: right"></div>
                                </div>
                                <div class="col-md-12" id="survey_body_view">
                                    <div class="col-md-12" style="margin-bottom: 10px">
                                        <h6>1. What is your Name</h6>
                                        <br><hr style="margin-bottom: 0px; border: .5px dashed ">
                                    </div>
                                    <div class="col-md-12" style="margin-bottom: 10px">
                                        <h6>2. How Old are you?</h6>
                                        <input class="form-control col-lg-12" type="number">
                                    </div>
                                    <div class="col-md-12" style="margin-bottom: 10px">
                                        <h6>3. What is you gender?</h6>
                                        <input type="radio" name="gender" style="margin-left: 10px; margin-right: 5px">Male
                                        <input type="radio" name="gender" style="margin-left: 10px; margin-right: 5px">Female
                                        <input type="radio" name="gender" style="margin-left: 10px; margin-right: 5px">Common
                                    </div>
                                    <div class="col-md-12" style="margin-bottom: 10px">
                                        <h6>4. What is you Profession?</h6>
                                        <input type="radio" name="gender" style="margin-left: 10px; margin-right: 5px">Student
                                        <input type="radio" name="gender" style="margin-left: 10px; margin-right: 5px">Govt. Servant
                                        <input type="radio" name="gender" style="margin-left: 10px; margin-right: 5px">Teacher
                                        <input type="radio" name="gender" style="margin-left: 10px; margin-right: 5px">Lawyer
                                        <input type="radio" name="gender" style="margin-left: 10px; margin-right: 5px">Doctor
                                        <input type="radio" name="gender" style="margin-left: 10px; margin-right: 5px">Unemployed
                                    </div>
                                    <div class="col-md-12" style="margin-bottom: 10px">
                                        <h6>5. What is you Profession?</h6>
                                        <p style="margin: 10px">(A): Student</p>
                                        <p style="margin: 10px">(B): Student</p>
                                        <p style="margin: 10px">(C): Student</p>
                                        <p style="margin: 10px">(D): Student</p>
                                        <p style="margin: 10px">(E): Student</p>
                                        <p style="margin: 10px">(F): Student</p>
                                    </div>
                                    <div class="col-md-12" style="margin-bottom: 10px">
                                        <h6>6. What is you Profession?</h6>
                                        <span style="margin: 10px">(A): Student</span>
                                        <span style="margin: 10px">(B): Student</span>
                                        <span style="margin: 10px">(C): Student</span>
                                        <span style="margin: 10px">(D): Student</span>
                                        <span style="margin: 10px">(E): Student</span>
                                        <span style="margin: 10px">(F): Student</span>
                                    </div>
                                    <div class="col-md-12" style="margin-bottom: 10px">
                                        <h6>6. What is you Profession?</h6>
                                        <div class="col-md-6" style="padding: 10px">(A): Student</div>
                                        <div class="col-md-6" style="padding: 10px">(A): Student</div>
                                        <div class="col-md-6" style="padding: 10px">(A): Student</div>
                                        <div class="col-md-6" style="padding: 10px">(A): Student</div>
                                        <div class="col-md-6" style="padding: 10px">(A): Student</div>
                                        <div class="col-md-6" style="padding: 10px">(A): Student</div>
                                    </div>

                                </div>
                            </div>

                            <div class="col-md-12"><br>
                                <span id="p_mess"></span>
                                <div id="participant_table">

                                </div>
                            </div>

                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>
    </div>
    <!--END PAGE CONTENT-->

@endsection


@section('JScript')

    <script src="{{ asset('assets/js/bils/survey/survey.js')}}"></script>

@endsection


