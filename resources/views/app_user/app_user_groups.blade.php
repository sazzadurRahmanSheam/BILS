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
    	<ul class="nav nav-tabs tab-padding tab-space-3 tab-blue" id="myTab4">
            <li class="active">
                <a id="user_group_management_tab" data-toggle="tab" href="#user_group_management">
                   <b>App User Group Management</b>
                </a>
            </li>
        </ul>
        <div class="tab-content">
        	<div id="user_group_management" class="tab-pane in active">
        		<div class="col-sm-12">
            <div class="col-md-6 col-sm-6 col-xs-12">
            	<div class="panel panel-default">
            		<div class="panel-heading">
	            		<p class="text-info">App User Group Management</p>
	            	</div>
            	<div class="panel-body">
	            	
	            	<div class="row no-margin-row">
						<form id="save_group_form" name="admin_user_form" enctype="multipart/form-data" class="form form-horizontal form-label-left">
							@csrf
							<div class="row">
								<div class="col-md-12">
									<input type="hidden" name="edit_id" id="edit_id">
									<div class="form-group">
										<label class="control-label col-md-3 col-sm-3 col-xs-6">Group Name<span class="required">*</span></label>
										<div class="col-md-9 col-sm-9 col-xs-6">
											<input type="text" id="group_name" name="group_name" class="form-control col-lg-12"/>
										</div>
									</div>
									<input type="hidden" name="type" id="type" value="2">
									<div class="form-group">
										<label class="control-label col-md-2 col-sm-2 col-xs-6" >Is Active</label>
										<div class="col-md-4 col-sm-4 col-xs-6">
											<input type="checkbox" name="is_active" id="is_active" value="1" checked>
										</div>
									</div>
									<div class="ln_solid"></div>
								</div>
							</div>
							<div class="form-group">
							<label class="control-label col-md-2 col-sm-2 col-xs-6"></label>
							<div class="col-md-6 col-sm-6 col-xs-12">
								@if($actions['add_permisiion']>0)
									<button type="submit" id="save_app_user_group" class="btn btn-success save">Save</button>                    
									<button type="button" id="clear_button" class="btn btn-warning">Clear</button>
								@endif                       
								<button type="button" id="cancle_admin_user_group_button" class="btn btn-danger hidden">Cancle</button>                         
							</div>
							 <div class="col-md-7 col-sm-7 col-xs-12">
								<div id="form_submit_error" class="text-center" style="display:none"></div>
							 </div>
							</div>
						</form>		
	                </div>
            	</div>
            </div>
            </div>


			<div class="col-md-6 col-sm-6 col-xs-12">
				<div class="row no-margin-row">
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
							<table class="table table-bordered table-hover" id="app_user_group" style="width:100% !important"> 
								<thead>
									<tr>
										<th>ID</th>
										<th>Group Name</th>
										<th>Type</th>
										<th class="hidden-xs">Status</th>
										<th>Actions</th>
									</tr>
								</thead>
								<tbody>
								</tbody>
							</table>
						</div>
					</div>
			    </div>
			</div>
        </div>
        	</div>
        </div>
    </div>

@endsection


@section('JScript')

	<script src="{{ asset('assets/js/bils/admin/user.js')}}"></script>
	<script src="{{ asset('assets/js/bils/app user/app_user.js')}}"></script>

@endsection


