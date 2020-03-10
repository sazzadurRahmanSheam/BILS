@extends('layout.master')
@section('style')
	<link rel="stylesheet" type="text/css" href="{{ asset('assets/css/bils/profile.css') }}">
@endsection
@section('content')

	<!--MESSAGE-->
	<div class="row ">
		<div class="col-md-10 col-md-offset-1" id="master_message_div"></div>
	</div>
	<div class="col-md-6 col-sm-6 col-xs-12">
		<div id="form_submit_error" class="text-center" style="display:none"></div>
	</div>
	<!--END MESSAGE-->

    <!--PAGE CONTENT -->
    <div class="row ">
        <div class="col-sm-12">
            <div class="tabbable">
                <ul class="nav nav-tabs tab-padding tab-space-3 tab-blue" id="myTab4">
                    <li class="active">
                        <a id="my_profile_tab" data-toggle="tab" href="#my_profile_info_div">
                           <b> My Profile</b>
                        </a>
                    </li>
                    <li class="hidden" id="edit_profile_menu_tab">
                        <a data-toggle="tab" href="#edit_profile" id="edit_profile_tab">
                           <b> Edit Profile</b>
                        </a>
                    </li>
                    <li class="hidden" id="change_pass_menu_tab">
                        <a data-toggle="tab" href="#change_pass" id="change_pass_tab">
                           <b> Change Password</b>
                        </a>
                    </li>
                </ul>
                <div class="tab-content">
                    <!-- PANEL FOR OVERVIEW-->
                    <div id="my_profile_info_div" class="tab-pane in active">
						<div class="row no-margin-row">
							<div class="container portfolio">
								<div class="bio-info">
									<div class="row">
										<div class="col-md-6">
											<div class="row">
												<div class="col-md-12">
													<div class="bio-image">
														<img class="img-thumbnail" src="{{ asset('assets/images/user/admin') }}/{{ Auth::user()->user_profile_image }}" alt="image" />
													</div>			
												</div>
											</div>	
										</div>
										<div class="col-md-6">
											<div class="bio-content">
												<div id="profile_info"></div>
											</div>
										</div>
									</div>	
								</div>
							</div>
                        </div>
                    </div>
                    <!--END PANEL FOR OVERVIEW -->
                   
                    <!-- PANEL FOR CHANGE PASSWORD -->
                    <div id="edit_profile" class="tab-pane in">
                        <div class="row no-margin-row">
							<form id="my_profile_form" name="my_profile_form" enctype="multipart/form-data" class="form form-horizontal form-label-left">
								@csrf
								<div class="row">
								<div class="col-md-9">
									<input type="hidden" name="edit_profile_id" id="edit_profile_id">
									<div class="form-group">
										<label class="control-label col-md-2 col-sm-2 col-xs-6">Full Name<span class="required">*</span></label>
										<div class="col-md-4 col-sm-4 col-xs-6">
											<input type="text" id="name" name="name" class="form-control col-lg-12"/>
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
										<label class="control-label col-md-2 col-sm-2 col-xs-6">Remarks</label>
										<div class="col-md-10 col-sm-10 col-xs-12">
											<textarea rows="2" cols="100" id="remarks" name="remarks" class="form-control col-lg-12"></textarea> 
										</div>
									</div>
									<div class="ln_solid"></div>
								</div>
								<div class="col-md-3">
									<img src="src" width="70%" height="70%" class="img-thumbnail" id="emp_img">
									<input type="file" name="emp_image_upload" id="emp_image_upload"> 
								</div>
								</div>
								<div class="form-group">
									<input type="hidden" name="id" id="id">
								<label class="control-label col-md-2 col-sm-2 col-xs-6"></label>
								<div class="col-md-4 col-sm-4 col-xs-12">
									
									
									<button type="submit" id="update_profile_info" class="btn btn-success">Update</button>                    
									<button type="button" id="clear_button" class="btn btn-warning">Clear</button>                        
									<button type="button" id="cancle_admin_update" class="btn btn-danger hidden">Cancle</button>              
								</div>
								 
							</div>
							</form>		
                        </div>
                    </div>
                    <!-- END PANEL FOR CHANGE PASSWORD -->

                    <div id="change_pass" class="tab-pane in">
                        <div class="row no-margin-row">
							<form id="change_password_form" name="change_password_form" enctype="multipart/form-data" class="form form-horizontal form-label-left">
								@csrf
								<div class="row">
									<div class="col-md-9">
										<input type="hidden" name="change_pass_id" id="change_pass_id">
										<div class="form-group">
											<label class="control-label col-md-2 col-sm-2 col-xs-6">Current Password<span class="required">*</span></label>
											<div class="col-md-4 col-sm-4 col-xs-6">
												<input type="password" id="current_password" name="current_password" class="form-control col-lg-12"/>
											</div>
											
										</div>
										  
										<div class="form-group">
											<label class="control-label col-md-2 col-sm-2 col-xs-6">New Password<span class="required">*</span></label>
											<div class="col-md-4 col-sm-4 col-xs-6">
												<input type="password" id="new_password" name="new_password" class="form-control col-lg-12"/>
											</div>
										</div>
										<div class="form-group"> 
											<label class="control-label col-md-2 col-sm-2 col-xs-6">Confirm Password<span class="required">*</span></label>
											<div class="col-md-4 col-sm-4 col-xs-6">
												<input type="password" id="confirm_password" name="confirm_password" class="form-control col-lg-12"/>
											</div>
										</div>
									</div>
								
								</div>
								<div class="form-group">
									
								<label class="control-label col-md-2 col-sm-2 col-xs-6"></label>
								<div class="col-md-4 col-sm-4 col-xs-12">
									<button type="submit" id="update_password" class="btn btn-success">Update Password</button>                   
									<button type="button" id="cancle_admin_update" class="btn btn-danger hidden">Cancle</button>              
								</div>
								 
							</div>
							</form>		
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

	<script src="{{ asset('assets/js/bils/profile/profile.js')}}"></script>

@endsection


