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
                    <li class="">
                        <a data-toggle="tab" href="#entry_form_div" id="Survey_add_button">
                           <b> Add Surveys</b>
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
									<!--<table class="table table-bordered table-hover admin_user_table" id="admin_user_table" style="width:100% !important"> 
										<thead>
											<tr>
												<th>Photo</th>
												<th>User ID</th>
												<th>Name</th>
												<th>Email </th>
												<th class="hidden-xs">Status</th>
												<th>Actions</th>
											</tr>
										</thead>
										<tbody>
										</tbody>
									</table> -->
								</div>
							</div>
							<!-- END Categoreis -->
                        </div>
                    </div>
                    <!--END PANEL FOR OVERVIEW -->
                   
                    <!-- PANEL FOR CHANGE PASSWORD -->
                    <div id="entry_form_div" class="tab-pane in">
                        <div class="row no-margin-row">
                            
							
							<form id="survey_form" name="survey_form" enctype="multipart/form-data" class="form form-horizontal form-label-left">
								@csrf
								<div class="row">
								<div class="col-md-12">
									<div class="form-group">
										<label class="control-label col-md-2 col-sm-2 col-xs-6">Survey Name<span class="required">*</span></label>
										<div class="col-md-4 col-sm-4 col-xs-6">
											<input type="text" id="" name="" class="form-control col-lg-12"/>
										</div>
										<label class="control-label col-md-2 col-sm-2 col-xs-6" >Survey Type<span class="required">*</span></label>
										<div class="col-md-4 col-sm-4 col-xs-6">
											<select name="" id="" class="form-control col-lg-12">
												<option value="" disabled selected>Select Survey Type</option>
												<option value="">Type 1</option>
												<option value="">Type 2</option>
												<option value="">Type 3</option>
												<option value="">Type 4</option>
											</select>
										</div>
									</div>
									
									<div class="form-group">
										<label class="control-label col-md-2 col-sm-2 col-xs-6">Start Date<span class="required">*</span></label>
										<div class="col-md-4 col-sm-4 col-xs-6">
											<input type="date" id="" name=""  class="form-control col-lg-12"/>
										</div>
										<label class="control-label col-md-2 col-sm-2 col-xs-6" >End Date<span class="required">*</span></label>
										<div class="col-md-4 col-sm-4 col-xs-4">
											<input type="date" id="" name="" class="form-control col-lg-12"/>
										</div>						
									</div>  
									
										
									<div class="form-group">
										<label class="control-label col-md-2 col-sm-2 col-xs-6">Survey People</label>
										<div class="col-md-4 col-sm-4 col-xs-6">
											<select name="" id="" class="form-control col-lg-12">
												<option value="" disabled selected>Select Survey People</option>
												<option value="">All</option>
												<option value="">Group</option>
												<option value="">--</option>
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
									
									<div class="form-group">
										<label class="control-label col-md-2 col-sm-2 col-xs-6" >Survey Questions</label>
										<div class="col-md-10 col-sm-10 col-xs-12">
											<div class="col-md-6 col-lg-6 col-sm-12 col-xs-12">
												<div class="panel panel-default">
													<div class="panel-body">
														<div class="form-group col-md-12">
																<input type="" id="" name=""  class="form-control col-md-10" placeholder="Question 1" />
														</div>
														<div class="col-md-12">
															<label class="control-label col-md-2 col-sm-2" >1.</label>
																<div class="form-group col-md-10">
																	<input type="" id="" name=""  class="form-control col-md-10" placeholder="Set Answerrs" />
																</div>
															<label class="control-label col-md-2 col-sm-2" >2.</label>
																<div class="form-group col-md-10">
																	<input type="" id="" name=""  class="form-control col-md-10" placeholder="Set Answerrs" />
																</div>
															<label class="control-label col-md-2 col-sm-2" >3.</label>
																<div class="form-group col-md-10">
																	<input type="" id="" name=""  class="form-control col-md-10" placeholder="Set Answerrs" />
																</div>
															<label class="control-label col-md-2 col-sm-2" >4.</label>
																<div class="form-group col-md-10">

																	<input type="" id="" name=""  class="form-control col-md-10" placeholder="Set Answerrs" />
																</div>
															
															
														</div>
													</div>
												</div>
											</div>
											<div class="col-md-6 col-lg-6 col-sm-12 col-xs-12">
												<div class="panel panel-default">
													<div class="panel-body">
														<div class="form-group col-md-12">
																<input type="" id="" name=""  class="form-control col-md-10" placeholder="Question 2" />
														</div>
														<div class="col-md-12">
															<label class="control-label col-md-2 col-sm-2" >1.</label>
																<div class="form-group col-md-10">
																	<input type="" id="" name=""  class="form-control col-md-10" placeholder="Set Answerrs" />
																</div>
															<label class="control-label col-md-2 col-sm-2" >2.</label>
																<div class="form-group col-md-10">
																	<input type="" id="" name=""  class="form-control col-md-10" placeholder="Set Answerrs" />
																</div>
															<label class="control-label col-md-2 col-sm-2" >3.</label>
																<div class="form-group col-md-10">
																	<input type="" id="" name=""  class="form-control col-md-10" placeholder="Set Answerrs" />
																</div>
															<label class="control-label col-md-2 col-sm-2" >4.</label>
																<div class="form-group col-md-10">

																	<input type="" id="" name=""  class="form-control col-md-10" placeholder="Set Answerrs" />
																</div>
															
															
														</div>
													</div>
												</div>
											</div>
											<div class="col-md-6 col-lg-6 col-sm-12 col-xs-12">
												<div class="panel panel-default">
													<div class="panel-body">
														<div class="form-group col-md-12">
																<input type="" id="" name=""  class="form-control col-md-10" placeholder="Question 3" />
														</div>
														<div class="col-md-12">
															<label class="control-label col-md-2 col-sm-2" >1.</label>
																<div class="form-group col-md-10">
																	<input type="" id="" name=""  class="form-control col-md-10" placeholder="Set Answerrs" />
																</div>
															<label class="control-label col-md-2 col-sm-2" >2.</label>
																<div class="form-group col-md-10">
																	<input type="" id="" name=""  class="form-control col-md-10" placeholder="Set Answerrs" />
																</div>
															<label class="control-label col-md-2 col-sm-2" >3.</label>
																<div class="form-group col-md-10">
																	<input type="" id="" name=""  class="form-control col-md-10" placeholder="Set Answerrs" />
																</div>
															<label class="control-label col-md-2 col-sm-2" >4.</label>
																<div class="form-group col-md-10">

																	<input type="" id="" name=""  class="form-control col-md-10" placeholder="Set Answerrs" />
																</div>
															
															
														</div>
													</div>
												</div>
											</div>
											<div class="col-md-6 col-lg-6 col-sm-12 col-xs-12">
												<div class="panel panel-default">
													<div class="panel-body">
														<div class="form-group col-md-12">
																<input type="" id="" name=""  class="form-control col-md-10" placeholder="Question 4" />
														</div>
														<div class="col-md-12">
															<label class="control-label col-md-2 col-sm-2" >1.</label>
																<div class="form-group col-md-10">
																	<input type="" id="" name=""  class="form-control col-md-10" placeholder="Set Answerrs" />
																</div>
															<label class="control-label col-md-2 col-sm-2" >2.</label>
																<div class="form-group col-md-10">
																	<input type="" id="" name=""  class="form-control col-md-10" placeholder="Set Answerrs" />
																</div>
															<label class="control-label col-md-2 col-sm-2" >3.</label>
																<div class="form-group col-md-10">
																	<input type="" id="" name=""  class="form-control col-md-10" placeholder="Set Answerrs" />
																</div>
															<label class="control-label col-md-2 col-sm-2" >4.</label>
																<div class="form-group col-md-10">

																	<input type="" id="" name=""  class="form-control col-md-10" placeholder="Set Answerrs" />
																</div>
															
															
														</div>
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
									<button type="submit" id="save_admin_info" class="btn btn-success">Save</button>                    
									<button type="button" id="clear_button" class="btn btn-warning">Clear</button>                         
								</div>
								 <div class="col-md-7 col-sm-7 col-xs-12">
									<div id="form_submit_error" class="text-center" style="display:none"></div>
								 </div>
							</div>
							</form>		
                        </div>
                    </div>
                    <!-- END PANEL FOR CHANGE PASSWORD -->
                </div>
            </div>
        </div>
    </div>
    </div>
    <!--END PAGE CONTENT-->

@endsection


@section('JScript')



@endsection


