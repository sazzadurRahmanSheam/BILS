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
                        <a id="courses_list_button" data-toggle="tab" href="#courses_list_div">
                           <b> Courses List</b>
                        </a>
                    </li>
                    @if($actions['add_permisiion']==1)
	                    <li class="">
	                        <a data-toggle="tab" href="#entry_form_div" id="courses_add_button">
	                           <b> Open Courses</b>
	                        </a>
	                    </li>
	                @endif
	                <li style="display: none;" id="course_view_li">
                        <a data-toggle="tab" href="#course_view" id="course_view_button">
                           <b>Courses View</b>
                        </a>
	                </li>
                </ul>
                <div class="tab-content">
                    <!-- PANEL FOR OVERVIEW-->
                    <div id="courses_list_div" class="tab-pane in active">
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
									<table class="table table-bordered table-hover course_table" id="course_table" style="width:100% !important"> 
										<thead>
											<tr>
												<th>ID</th>
												<th>Course Title</th>
												<th>Duration </th>
												<th class="hidden-xs">Publish Status</th>
												<th class="hidden-xs">Course Status</th>
												<th>Actions</th>
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
                   
                    <!-- PANEL FOR CHANGE PASSWORD -->
                    <div id="entry_form_div" class="tab-pane in">
                        <div class="row no-margin-row">
                            
							
							<form id="courses_form" name="courses_form" enctype="multipart/form-data" class="form form-horizontal form-label-left">
								@csrf
								<div class="row">
									<input type="hidden" name="course_edit_id" id="course_edit_id">
								<div class="col-md-12">
									<div class="form-group">
										<label class="control-label col-md-2 col-sm-2 col-xs-6">Course Title<span class="required">*</span></label>
										<div class="col-md-10 col-sm-10 col-xs-10">
											<input type="text" id="course_title" name="course_title" class="form-control col-lg-12"/>
										</div>
									</div>
									{{-- <div class="form-group">
										<label class="control-label col-md-2 col-sm-2 col-xs-6">Course Code<span class="required">*</span></label>
										<div class="col-md-10 col-sm-10 col-xs-10">
											<input type="text" id="course_code" name="course_code" class="form-control col-lg-12"/>
										</div>
									</div> --}}
									<div class="form-group">
										<label class="control-label col-md-2 col-sm-2 col-xs-6">Course Description</label>
										<div class="col-md-10 col-sm-10 col-xs-12">
											<textarea rows="4" cols="100" id="details" name="details" class="form-control col-lg-12"></textarea> 
										</div>
									</div>

									<div class="form-group">
										<label class="control-label col-md-2 col-sm-2 col-xs-6">Duration (H)</label>
										<div class="col-md-4 col-sm-4 col-xs-6">
											<input type="text" id="duration" name="duration"  class="form-control col-lg-12"/>
										</div>
										<label class="control-label col-md-2 col-sm-2 col-xs-6">Course Category</label>
										<div class="col-md-4 col-sm-4 col-xs-6">
											<select name="course_type" id="course_type" class="form-control col-lg-12" >
												<option selected="" disabled="" value="">Select Course Category</option>
											</select>
										</div>			
									</div>


									 <div class="form-group">
										<label class="control-label col-md-2 col-sm-2 col-xs-6">Appx. Start Date</label>
										<div class="col-md-4 col-sm-4 col-xs-6">
											<input type="date" id="appx_start_time" name="appx_start_time"  class="form-control col-lg-12"/>
										</div>
										<label class="control-label col-md-2 col-sm-2 col-xs-6" >Appx. End Date</label>
										<div class="col-md-4 col-sm-4 col-xs-4">
											<input type="date" id="appx_end_time" name="appx_end_time" class="form-control col-lg-12"/>
										</div>						
									</div>

									<div class="form-group">
										<label class="control-label col-md-2 col-sm-2 col-xs-6">Act. Start Date</label>
										<div class="col-md-4 col-sm-4 col-xs-6">
											<input type="date" id="act_start_time" name="act_start_time"  class="form-control col-lg-12"/>
										</div>
										<label class="control-label col-md-2 col-sm-2 col-xs-6" >Act. End Date</label>
										<div class="col-md-4 col-sm-4 col-xs-4">
											<input type="date" id="act_end_time" name="act_end_time" class="form-control col-lg-12"/>
										</div>						
									</div>

									<div class="form-group">
										<label class="control-label col-md-2 col-sm-2 col-xs-6">Payment Fee</label>
										<div class="col-md-4 col-sm-4 col-xs-6">
											<input type="text" id="payment_fee" name="payment_fee"  class="form-control col-lg-12"/>
										</div>
										<label class="control-label col-md-2 col-sm-2 col-xs-6" >Payment Method</label>
										<div class="col-md-4 col-sm-4 col-xs-4">
											<input type="text" id="payment_method" name="payment_method" class="form-control col-lg-12"/>
										</div>						
									</div>

									<div class="form-group">
										<label class="control-label col-md-2 col-sm-2 col-xs-6">Course Teacher</label>
										<div class="col-md-4 col-sm-4 col-xs-6">
											<select name="course_teacher" id="course_teacher" class="form-control col-lg-12">
												<option  selected="" disabled="" value="">Select Teacher</option>
											</select>
											
										</div>
										<label class="control-label col-md-2 col-sm-2 col-xs-6" >Discount Message</label>
										<div class="col-md-4 col-sm-4 col-xs-4">
											<input type="text" id="discount_message" name="discount_message" class="form-control col-lg-12"/>
										</div>						
									</div>

									@if($actions['publish_course_permisiion']==1)
										<div style="display:none;" id="edit_course_status" class="form-group">
											<label class="control-label col-md-2 col-sm-2 col-xs-6">Course Status</label>
											<div class="col-md-4 col-sm-4 col-xs-6">
												<select name="course_status" id="course_status"  class="form-control col-lg-12">
													<option disabled="" selected="" value="">Change Course Status</option>
													<option value="1">Initiate</option>
													<option value="2">Approved</option>
													<option value="3">Rejected</option>
													<option value="4">Started</option>
													<option value="5">Completed</option>
												</select>
											</div>					
										</div>

										<div class="form-group">
											<label class="control-label col-md-2 col-sm-2 col-xs-6" >Is Published</label>
											<div class="col-md-4 col-sm-4 col-xs-6">
												<input type="checkbox" id="pub_status" name="pub_status" class="form-control col-lg-12"/>
											</div>
										</div>
									@endif
									<br/>
								
									
								</div>
								
								</div>
								<div class="form-group">
								<label class="control-label col-md-2 col-sm-2 col-xs-6"></label>
								<div class="col-md-3 col-sm-3 col-xs-12"> 
									<button type="submit" id="save_course" class="btn btn-success save">Save</button>                    
									<button type="button" id="clear_button" class="btn btn-warning">Clear</button>                         
									<button type="button" id="course_cancel_btn" class="btn btn-danger hidden">Cancel</button>                         
								</div>
								 <div class="col-md-7 col-sm-7 col-xs-12">
									<div id="form_submit_error" class="text-center" style="display:none"></div>
								 </div>
							</div>
							</form>		
                        </div>
                    </div>
                    <!-- END PANEL FOR CHANGE PASSWORD -->

                    <div id="course_view" class="tab-pane in">
                        <div class="row no-margin-row">
							<div class="col-md-12">
								<div class="col-md-12">
									<div class="col-md-9" style="padding-left:0px">
										<span id="c_title"></span>
									</div>
									<div class="col-md-3" style="text-align: right;padding-right:0px;">
										<span id="status_btn"></span>
									</div>
								</div>
								<div class="col-md-12" style="padding-left: 0px;">
									<div id="left_sub" class="col-md-6"></div>
									<div id="right_sub" class="col-md-6"></div>
								</div>
								<div class="col-md-12" id="description">
									
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
	<script>
		var select_perticipant_permisiion = "<?php echo $actions['select_perticipant_permisiion']; ?>";
	</script>
	<script src="{{ asset('assets/js/bils/course/course.js')}}"></script>
@endsection