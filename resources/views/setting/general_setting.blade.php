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
                        <a data-toggle="tab" href="#entry_form_div" id="">
                           <b>Geneal Setting</b>
                        </a>
                    </li>
                </ul>
                <div class="tab-content">
                    <!-- PANEL FOR CHANGE PASSWORD -->
                    <div id="entry_form_div" class="tab-pane in active">
                        <div class="row no-margin-row">
							<form id="general_setting" name="admin_user_form" enctype="multipart/form-data" class="form form-horizontal form-label-left">
								@csrf
								<div class="row">
									<div class="col-md-9">
										<div class="form-group">
											<label for="company_name" class="control-label col-md-2 col-sm-2 col-xs-6">Company Name<span class="required">*</span></label>
											<div class="col-md-4 col-sm-4 col-xs-6">
												<input type="text" id="company_name" name="company_name" required class="form-control col-lg-12" value="{{ $setting['company_name'] }}" />
											</div>
											<label for="short_name" class="control-label col-md-2 col-sm-2 col-xs-6" >Short Name<span class="required">*</span></label>
											<div class="col-md-4 col-sm-4 col-xs-6">
												<input type="text" id="short_name" name="short_name" class="form-control col-lg-12" value="{{ $setting['short_name'] }}" />
											</div>
										</div>
										<div class="form-group">
											<label for="site_name" class="control-label col-md-2 col-sm-2 col-xs-6">Site Name<span class="required">*</span></label>
											<div class="col-md-4 col-sm-4 col-xs-6">
												<input type="text" id="site_name" name="site_name"  class="form-control col-lg-12" value="{{ $setting['site_name'] }}" />
											</div>
											<label for="admin_email" class="control-label col-md-2 col-sm-2 col-xs-6" >Admin Email<span class="required">*</span></label>
											<div class="ccol-md-4 col-sm-4 col-xs-6">
												<input type="email" id="admin_email" name="admin_email"  class="form-control col-lg-12"value="{{ $setting['admin_email'] }}" />
											</div>						
										</div>  
										<div class="form-group">
											<label for="admin_mobile" class="control-label col-md-2 col-sm-2 col-xs-6">Admin Mobile<span class="required">*</span></label>
											<div class="col-md-4 col-sm-4 col-xs-6">
												<input type="text" id="admin_mobile" name="admin_mobile" required class="form-control col-lg-12" value="{{ $setting['admin_mobile'] }}"/>
											</div>
											<label for="site_url" class="control-label col-md-2 col-sm-2 col-xs-6">Site URL</label>
											<div class="col-md-4 col-sm-4 col-xs-6">
												<input type="text" id="site_url" name="site_url"  class="form-control col-lg-12" value="{{ $setting['site_url'] }}" />
											</div>
										</div>
										<div class="form-group">
											<label for="admin_url" class="control-label col-md-2 col-sm-2 col-xs-6">Admin URL</label>
											<div class="col-md-10 col-sm-10  col-xs-6">
												<input type="text" id="admin_url" name="admin_url"  class="form-control col-lg-12" value="{{ $setting['admin_url'] }}" />
											</div>
										</div>
										<div class="form-group"> 
											<label for="address" class="control-label col-md-2 col-sm-2 col-xs-6" >Address</label>
											<div class="col-md-10 col-sm-10  col-xs-6">
												<input type="text" id="address" name="address" class="form-control col-lg-12" value="{{ $setting['address'] }}" />
											</div>
										</div>
										<br/>
										<div class="ln_solid"></div>
									</div>
									<div class="col-md-3">
										<img src="src"
										 width="70%" height="70%" class="img-thumbnail" id="emp_img">
										<input type="file" name="logo" id="logo"> 
									</div>
								</div>
								<div class="form-group">
									<label class="control-label col-md-2 col-sm-2 col-xs-6"></label>
									<div class="col-md-3 col-sm-3 col-xs-12">
										<button type="submit" id="save_general_setting" class="btn btn-success">Save</button>
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
    <!--END PAGE CONTENT-->
@endsection


@section('JScript')
	<script type="text/javascript" src="{{ asset('assets/js/bils/setting/setting.js')}}"></script>
@endsection


