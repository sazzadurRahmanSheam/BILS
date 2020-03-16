@extends('layout.master')
@section('style')
	<link rel="stylesheet" href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/themes/smoothness/jquery-ui.css"><link rel="stylesheet" href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/themes/smoothness/jquery-ui.css">
@endsection
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
                        <a id="teacher_list_button" data-toggle="tab" href="#teacher_list_div">
                           <b> Teacher List</b>
                        </a>
                    </li>
                    @if($actions['add_permisiion']==1)
	                    <li class="">
	                        <a data-toggle="tab" href="#entry_form_div" id="teacher_add_button">
	                           <b> Teacher Entry</b>
	                        </a>
	                    </li>
	                @endif
	                {{-- <li style="display: none;" id="course_view_li">
                        <a data-toggle="tab" href="#course_view" id="course_view_button">
                           <b>Courses View</b>
                        </a>
	                </li> --}}
                </ul>
                <div class="tab-content">
                    <!-- PANEL FOR OVERVIEW-->
                    <div id="teacher_list_div" class="tab-pane in active">
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
									<table class="table table-bordered table-hover teacher_table" id="teacher_table" style="width:100% !important"> 
										<thead>
											<tr>
												<th>ID</th>
												<th>Name</th>
												<th>Email </th>
												<th>Phone</th>
												<th class="hidden-xs">Status</th>
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
                            
							
							<form id="teacher_form" name="courses_form" enctype="multipart/form-data" class="form form-horizontal form-label-left">
								@csrf
								<div class="row">
									<input type="hidden" name="teacher_edit_id" id="teacher_edit_id">
								<div class="col-md-12">
								

									 <div class="form-group">
									 	<input type="hidden" name="teacher_id" id="teacher_id">
									 	<input type="hidden" name="admin_id" id="admin_id">
										<label class="control-label col-md-2 col-sm-2 col-xs-6">Name<span class="required">*</span></label>
										<div class="col-md-4 col-sm-4 col-xs-6">
											<input type="text" id="name" name="name"  class="form-control col-lg-12"/>
										</div>
										<label class="control-label col-md-2 col-sm-2 col-xs-6" >Email<span class="required">*</span></label>
										<div class="col-md-4 col-sm-4 col-xs-4">
											<input type="email" id="email" name="email" class="form-control col-lg-12"/>
										</div>						
									</div>

									<div class="form-group">
										<label class="control-label col-md-2 col-sm-2 col-xs-6">Contact NO<span class="required">*</span></label>
										<div class="col-md-4 col-sm-4 col-xs-6">
											<input type="text" id="contact_no" name="contact_no"  class="form-control col-lg-12"/>
										</div>
										<label class="control-label col-md-2 col-sm-2 col-xs-6" >NID NO<span class="required">*</span></label>
										<div class="col-md-4 col-sm-4 col-xs-4">
											<input type="text" id="nid" name="nid" class="form-control col-lg-12"/>
										</div>						
									</div>

									<div class="form-group"> 
										<label class="control-label col-md-2 col-sm-2 col-xs-6" >Address</label>
										<div class="col-md-10 col-sm-10  col-xs-6">
											<input type="text" id="address" name="address" class="form-control col-lg-12" />
										</div>
									</div>

									
									<div class="form-group">
										<label class="control-label col-md-2 col-sm-2 col-xs-6" >Is Ative</label>
										<div class="col-md-4 col-sm-4 col-xs-6">
											<input checked="" type="checkbox" id="is_active" name="is_active" class="form-control col-lg-12"/>
										</div>
									</div>
									<br/>
								
									
								</div>
								
								</div>
								<div class="form-group">
								<label class="control-label col-md-2 col-sm-2 col-xs-6"></label>
								<div class="col-md-3 col-sm-3 col-xs-12"> 
									<button type="submit" id="save_teacher" class="btn btn-success save">Save</button>                    
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

	<script src="{{ asset('assets/js/bils/teacher/teacher.js')}}"></script>
	<script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js"></script>

@endsection





