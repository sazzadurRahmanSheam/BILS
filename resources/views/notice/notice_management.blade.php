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
                        <a id="notice_list" data-toggle="tab" href="#notice_list_div">
                           <b> Notice List</b>
                        </a>
                    </li>
                    @if($actions['add_permisiion']==1)
	                    <li class="">
	                        <a data-toggle="tab" href="#entry_form_div" id="notice_entry">
	                           <b> Add notice</b>
	                        </a>
	                    </li>
	                @endif
                </ul>
                <div class="tab-content">
                    <!-- PANEL FOR OVERVIEW-->
                    <div id="notice_list_div" class="tab-pane in active">
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
									<table class="table table-bordered table-hover notice_table" id="notice_table" style="width:100% !important"> 
										<thead>
											<tr>
												<th>Notice ID</th>
												<th>Title</th>
												<th>Details </th>
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
							<form id="notice_form" name="notice_form" enctype="multipart/form-data" class="form form-horizontal form-label-left">
								@csrf
								<div class="row">
								<div class="col-md-12">
									<input type="hidden" name="notice_edit_id" id="notice_edit_id">
									<div class="form-group">
										<label class="control-label col-md-2 col-sm-2 col-xs-6">Notice Title<span class="required">*</span></label>
										<div class="col-md-4 col-sm-4 col-xs-6">
											<input type="text" id="title" name="title" class="form-control col-lg-12"/>
										</div>
										<label class="control-label col-md-2 col-sm-2 col-xs-6" >App User Group</label>
										<div class="col-md-4 col-sm-4 col-xs-6">
											<select style="width: 100% !important" class="mdb-select" multiple name="app_user_group[]" id="app_user_group">
												<option value="" disabled>Select User Group</option>
											</select>
										</div>
									</div>
									<div class="form-group">
										<label class="control-label col-md-2 col-sm-2 col-xs-6" >App User Name</label>
										<div class="col-md-4 col-sm-4 col-xs-6">
											<input type="text" id="app_user_name" name="app_user_name" class="form-control col-lg-12"/>
										</div>
									</div>
									
									<div class="form-group">
										<label class="control-label col-md-2 col-sm-2 col-xs-6">Notice Date<span class="required">*</span></label>
										<div class="col-md-4 col-sm-4 col-xs-6">
											<input type="date" id="notice_date" name="notice_date"  class="form-control col-lg-12"/>
										</div>
										<label class="control-label col-md-2 col-sm-2 col-xs-6" >Expire Date<span class="required">*</span></label>
										<div class="col-md-4 col-sm-4 col-xs-4">
											<input type="date" id="expire_date" name="expire_date" class="form-control col-lg-12"/>
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
										<label class="control-label col-md-2 col-sm-2 col-xs-6">Notice Details</label>
										<div class="col-md-10 col-sm-10 col-xs-12">
											<textarea id="details" name="details" class="form-control col-lg-12"></textarea> 
										</div>
									</div>
									
									
									<div class="ln_solid"></div>
								</div>
								
								</div>
								<div class="form-group">
								<label class="control-label col-md-2 col-sm-2 col-xs-6"></label>
								<div class="col-md-3 col-sm-3 col-xs-12"> 
									<button type="submit" id="save_notice" class="btn btn-success">Save</button>                    
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
	<script src="{{ asset('assets/js/bils/notice/notice.js')}}"></script>
	<script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js"></script>
{{-- <script src=" {{ asset('ckeditor/ckeditor.js') }} "></script>
	<script>
    	CKEDITOR.replace( 'details' );
	</script> --}}

@endsection


