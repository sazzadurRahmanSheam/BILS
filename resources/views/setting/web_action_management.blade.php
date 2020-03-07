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
            
        	<div class="col-md-6 col-sm-12">
        		<h4 class="text-info">Web Action Management</h4><hr>
        		<div id="entry_form_div" class="tab-pane in">
        			@if($actions['add_permisiion']==1)
                        <div class="row no-margin-row">
							<form id="web_action_form" name="web_action_form" enctype="multipart/form-data" class="form form-horizontal form-label-left">
								@csrf
								<div class="row">
									<div class="col-md-12">
										<input type="hidden" name="edit_id" id="edit_id">
										<div class="form-group"> 
											<label class="control-label col-md-3 col-sm-3 col-xs-6" >Module Name<span class="required">*</span></label>
											<div class="col-md-9 col-sm-9  col-xs-6">
												<select class="form-control col-lg-12" id="module_name_for_web_action" name="module_name_for_web_action">
													<option value="" disabled selected>Select Module Name</option>
												</select>
											</div>
										</div>
										<div class="form-group"> 
											<label class="control-label col-md-3 col-sm-3 col-xs-6" >Action Name<span class="required">*</span></label>
											<div class="col-md-9 col-sm-9  col-xs-6">
												<input type="text" id="activity_name" name="activity_name" class="form-control col-lg-12" />
											</div>
										</div>
										<div class="form-group">
											<label class="control-label col-md-2 col-sm-2 col-xs-6" >Is Active</label>
											<div class="col-md-4 col-sm-4 col-xs-6">
												<input type="checkbox" id="is_active" name="is_active" checked="checked" class="form-control col-lg-12"/>
											</div>
										</div>
										<div class="ln_solid"></div>
									</div>
								</div>
								<div class="form-group">
								<label class="control-label col-md-2 col-sm-2 col-xs-6"></label>
								<div class="col-md-4 col-sm-4 col-xs-12">
									<button type="submit" id="save_web_action" class="btn btn-success">Save</button>                    
									<button type="button" id="clear_button" class="btn btn-warning">Clear</button>                         
								</div>
								 <div class="col-md-6 col-sm-6 col-xs-12">
									<div id="form_submit_error" class="text-center" style="display:none"></div>
								 </div>
							</div>
							</form>		
                        </div>
                    @endif
                    </div>
        	</div>


			<div class="col-md-6 col-sm-12">
				<div id="user_list_div" class="tab-pane in active">
					<div class="row no-margin-row">
		                <!-- List of Categories -->
						<div class="panel panel-default">
							<div class="panel-heading">
								<i class="fa fa-external-link-square"></i>

								<div class="panel-tools">
									<a class="btn btn-xs btn-link panel-collapse collapses" href="#"></a>
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
								<table class="table table-bordered table-hover menus_table" id="web_actions_table" style="width:100% !important"> 
									<thead>
										<tr>
											
											<th> ID</th>
											<th> Activity Name</th>
											<th>Module Name</th>
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
			</div>


        </div>
    </div>
    <!--END PAGE CONTENT-->
@endsection


@section('JScript')
	<script type="text/javascript" src="{{ asset('assets/js/bils/setting/setting.js')}}"></script>
@endsection


