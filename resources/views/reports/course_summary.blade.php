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
                        <a id="" data-toggle="tab" href="#course_sumarry_div">
                            <b> Course Summary</b>
                        </a>
                    </li>
                </ul>
                <div class="tab-content">
                    <!-- PANEL FOR OVERVIEW-->
                    <div id="course_sumarry_div" class="tab-pane in active">
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
                                        <form id="course_search" name="survey_search" enctype="multipart/form-data" class="form form-horizontal form-label-left" >
                                            <div class="col-md-5">
                                                <label class="control-label col-md-4 col-sm-4 col-xs-12">Start Date<span class="required">*</span></label>
                                                <div class="col-md-8 col-sm-8 col-xs-8">
                                                    <input  type="date" id="date_from" name="date_from"  class="form-control col-lg-12"/>
                                                </div>
                                            </div>
                                            <div class="col-md-5">
                                                <label class="control-label col-md-4 col-sm-4 col-xs-12">End Date<span class="required">*</span></label>
                                                <div class="col-md-8 col-sm-8 col-xs-8">
                                                    <input  type="date" id="date_to" name="date_to"  class="form-control col-lg-12"/>
                                                </div>
                                            </div>
                                            <div class="col-md-2">
                                                <button type="button" class="btn btn-primary" id="search_course_summary">Search</button>
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

    <script src="{{ asset('assets/js/bils/reports/course_summary.js')}}"></script>

@endsection

