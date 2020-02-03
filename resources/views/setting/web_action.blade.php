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
        		<div id="entry_form_div" class="tab-pane in">
                        <div class="row no-margin-row">
                            
							
							<form id="admin_user_form" name="admin_user_form" enctype="multipart/form-data" class="form form-horizontal form-label-left">
								@csrf
								<div class="row">
								<div class="col-md-12">
									  
									
									<div class="form-group"> 
										<label class="control-label col-md-2 col-sm-2 col-xs-6" >Menu Name</label>
										<div class="col-md-10 col-sm-10  col-xs-6">
											<input type="text" id="" name="" class="form-control col-lg-12" list="existed_menu" />
											<datalist id="existed_menu">
												<option value="Internet Explorer">
												<option value="Firefox">
												<option value="Chrome">
												<option value="Opera">
												<option value="Safari">
											</datalist>
										</div>
									</div>
									<div class="form-group"> 
										<label class="control-label col-md-2 col-sm-2 col-xs-6" >Menu Title</label>
										<div class="col-md-10 col-sm-10  col-xs-6">
											<input type="text" id="" name="" class="form-control col-lg-12" />
										</div>
									</div>
									<div class="form-group"> 
										<label class="control-label col-md-2 col-sm-2 col-xs-6" >Menu URL</label>
										<div class="col-md-10 col-sm-10  col-xs-6">
											<input type="text" id="" name="" class="form-control col-lg-12" />
										</div>
									</div>
									<div class="form-group"> 
										<label class="control-label col-md-2 col-sm-2 col-xs-6" >Icon Class</label>
										<div class="col-md-10 col-sm-10  col-xs-6">
											<input type="text" id="" name="" class="form-control col-lg-12" />
										</div>
									</div>
									
								
									
									
									<div class="ln_solid"></div>
								</div>
								
								</div>
								<div class="form-group">
								<label class="control-label col-md-2 col-sm-2 col-xs-6"></label>
								<div class="col-md-3 col-sm-3 col-xs-12">
									<input type="hidden" id="emp_id" name="emp_id" />
									<input type="hidden" name="id" id="id">  
									<button type="submit" id="save_admin_info" class="btn btn-success">Save</button>                    
									<button type="button" id="clear_button" class="btn btn-primary">Clear</button>                         
								</div>
								 <div class="col-md-7 col-sm-7 col-xs-12">
									<div id="form_submit_error" class="text-center" style="display:none"></div>
								 </div>
							</div>
							</form>		
                        </div>
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
								<table class="table table-bordered table-hover menus_table" id="menus_table" style="width:100% !important"> 
									<thead>
										<tr>
											
											<th> ID</th>
											<th>Module Name</th>
											<th>Menu Title </th>
											<th>Parent ID </th>
											<th>Menu URL </th>
											<th>Menu Icon Class </th>
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


