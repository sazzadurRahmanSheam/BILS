@extends('layout.master')
@section('style')
    
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
                        <a id="survey_list_button" data-toggle="tab" href="#survey_list_div">
                            <b> App User Report</b>
                        </a>
                    </li>
                </ul>
                <div class="tab-content">
                    <!-- PANEL FOR OVERVIEW-->
                    <div id="survey_list_div" class="tab-pane in active">
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
                                    <div class="col-md-12">
                                        <form id="app_user_report_form" name="app_user_report_form" enctype="multipart/form-data" class="form form-horizontal form-label-left" >
                                            <div class="col-md-10">
                                                <label class="control-label col-md-3 col-sm-3 col-xs-12">App User Group Name<span class="required">*</span></label>
                                                <div class="col-md-4 col-sm-4 col-xs-4">
                                                    <input type="text" id="app_user_group_name_search" name="app_user_group_name_search"  class="form-control col-lg-12"/>
                                                    <input type="hidden" id="app_user_group_id_id" name="app_user_group_id_id" value="">
                                                </div>

                                                <label class="control-label col-md-1 col-sm-1 col-xs-12">OR</label>
                                                <div class="col-md-4 col-sm-4 col-xs-4">
                                                    <select name="search_criteria" id="search_criteria" class="form-control">
                                                        <option value="">Select Type</option>
                                                        <option value="1">Active</option>
                                                        <option value="0">In-Active</option>
                                                        <option value="3">participated In Course</option>
                                                        <option value="4">participated In Survey</option>
                                                    </select>
                                                </div>

                                            </div>
                                            <div class="col-md-2">
                                                <button type="button" class=" btn btn-primary " id="app_user_search">Search</button>
                                            </div>
                                        </form>
                                    </div>

                                </div>
                            </div>
                            <!-- END Categoreis -->
                        </div>
                    </div>
                    <!--END PANEL FOR OVERVIEW -->

                </div>

            </div>
        </div>
    </div>
    </div>
    <!--END PAGE CONTENT-->

@endsection


@section('JScript')

    <script src="{{ asset('assets/js/bils/reports/app_user.js')}}"></script>
    
@endsection


