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
                        <a id="app_user_list_button" data-toggle="tab" href="#user_list_div">
                           <b> App User List</b>
                        </a>
                    </li>
                    <li class="">
                        <a data-toggle="tab" href="#entry_form_div" id="app_user_button">
                           <b> Add App User</b>
                        </a>
                    </li>
                </ul>
                <div class="tab-content">
                    <!-- PANEL FOR OVERVIEW-->
                    <div id="user_list_div" class="tab-pane in active">
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
									<table class="table table-bordered table-hover admin_user_table" id="app_user_table" style="width:100% !important"> 
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
                            
							
							<form id="app_user_form" name="app_user_form" enctype="multipart/form-data" class="form form-horizontal form-label-left">
								@csrf
								<div class="row">
								<div class="col-md-9">
									<input type="hidden" name="app_user_edit_id" id="app_user_edit_id">
									<div class="form-group">
										<label class="control-label col-md-2 col-sm-2 col-xs-6">Full Name<span class="required">*</span></label>
										<div class="col-md-4 col-sm-4 col-xs-6">
											<input type="text" id="app_user_name" name="app_user_name" required class="form-control col-lg-12"/>
										</div>
										<label class="control-label col-md-2 col-sm-2 col-xs-6" >NID No<span class="required">*</span></label>
										<div class="col-md-4 col-sm-4 col-xs-6">
											<input type="text" id="nid_no" name="nid_no" class="form-control col-lg-12" />
										</div>
									</div>
									  
									<div class="form-group">
										<label class="control-label col-md-2 col-sm-2 col-xs-6">Contact No<span class="required">*</span></label>
										<div class="col-md-4 col-sm-4 col-xs-6">
											<input type="text" id="contact_no" name="contact_no" required class="form-control col-lg-12"/>
										</div>
										<label class="control-label col-md-2 col-sm-2 col-xs-6">Email<span class="required">*</span></label>
										<div class="col-md-4 col-sm-4 col-xs-6">
											<input type="email" id="email" name="email" required class="form-control col-lg-12"/>
										</div>
									</div>
									<div class="form-group"> 
										<label class="control-label col-md-2 col-sm-2 col-xs-6" >Address</label>
										<div class="col-md-10 col-sm-10  col-xs-6">
											<input type="text" id="address" name="address" class="form-control col-lg-12" />
										</div>
									</div>	
									<div class="form-group">
										<label class="control-label col-md-2 col-sm-2 col-xs-6">Password</label>
										<div class="col-md-4 col-sm-4 col-xs-6">
											<input type="password" id="password" name="password"  class="form-control col-lg-12"/>
										</div>
									</div>
									<div class="form-group">
										<label class="control-label col-md-2 col-sm-2 col-xs-6" >Is Active</label>
										<div class="col-md-4 col-sm-4 col-xs-6">
											<input type="checkbox" id="is_active" name="is_active" checked="checked" class="form-control col-lg-12" value="1" />
										</div>
									</div>
									<br/>
									<div class="form-group">
										<label class="control-label col-md-2 col-sm-2 col-xs-6">Remarks</label>
										<div class="col-md-10 col-sm-10 col-xs-12">
											<textarea rows="2" cols="100" id="remarks" name="remarks" class="form-control col-lg-12"></textarea> 
										</div>
									</div>
									<div class="form-group">
										<label class="control-label col-md-2 col-sm-2 col-xs-6" >User Group</label>
										<div id="group_select" class="col-md-10 col-sm-10 col-xs-12"></div>
									</div>
									<div class="ln_solid"></div>
								</div>
								<div class="col-md-3">
									<img src="src" width="70%" height="70%" class="img-thumbnail" id="emp_img">
									<input type="file" name="emp_image_upload" id="emp_image_upload"> 
								</div>
								</div>
								<div class="form-group">
								<label class="control-label col-md-2 col-sm-2 col-xs-6"></label>
								<div class="col-md-3 col-sm-3 col-xs-12">
									<button type="submit" id="save_app_user_info" class="btn btn-success">Save</button>                    
									<button type="button" id="clear_button" class="btn btn-warning">Clear</button>
									<button type="button" id="cancle_app_user_update" class="btn btn-danger hide">Cancle</button>                    
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

<script src="{{ asset('assets/js/bils/app user/app_user.js')}}"></script>
<script>
// save the state of the page in local storage
</script>



@endsection


