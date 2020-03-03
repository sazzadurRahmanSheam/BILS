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
	                           <b> Add Courses</b>
	                        </a>
	                    </li>
	                @endif
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
										<label class="control-label col-md-2 col-sm-2 col-xs-6">Course Type</label>
										<div class="col-md-4 col-sm-4 col-xs-6">
											<select name="course_type" id="course_type" class="form-control col-lg-12" >
												<option selected="" disabled="" value="">Select Course Type</option>
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
										<label class="control-label col-md-2 col-sm-2 col-xs-6" >Is Published</label>
										<div class="col-md-4 col-sm-4 col-xs-6">
											<input type="checkbox" id="pub_status" name="pub_status" checked="checked" class="form-control col-lg-12"/>
										</div>
									</div>
									<br/>
									
									
									
									
								</div>
								
								</div>
								<div class="form-group">
								<label class="control-label col-md-2 col-sm-2 col-xs-6"></label>
								<div class="col-md-3 col-sm-3 col-xs-12"> 
									<button type="submit" id="save_course" class="btn btn-success save">Save</button>                    
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

	<script src="{{ asset('assets/js/bils/course/course.js')}}"></script>

@endsection


