<!DOCTYPE html>
<!--[if IE 8]><html class="ie8 no-js" lang="en"><![endif]-->
<!--[if IE 9]><html class="ie9 no-js" lang="en"><![endif]-->
<!--[if !IE]><!-->
<html lang="en" class="no-js">
<!--<![endif]-->
<!-- start: HEAD -->
<head>
    <title>{{isset($page_title) ? $page_title : ''}} | {{$site_settings['short_name']}} </title>
    <!-- start: META -->
    <meta charset="utf-8" />
    <!--[if IE]><meta http-equiv='X-UA-Compatible' content="IE=edge,IE=9,IE=8,chrome=1" /><![endif]-->
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="csrf-token" content="{{ csrf_token() }}">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta content="" name="description" />
    <meta content="" name="author" />
    <!-- end: META -->
    <!-- start: MAIN CSS -->
    <link rel="stylesheet" href="{{ asset('assets/plugins/bootstrap/css/bootstrap.min.css') }}">
    <link rel="stylesheet" href="{{ asset('assets/plugins/font-awesome/css/font-awesome.min.css') }}">
    <link rel="stylesheet" href="{{ asset('assets/fonts/style.css') }}">
    <link rel="stylesheet" href="{{ asset('assets/css/main.css') }}">
    <link rel="stylesheet" href="{{ asset('assets/css/rating.css') }}">
    <link rel="stylesheet" href="{{ asset('assets/css/main-responsive.css') }}">
    <link rel="stylesheet" href="{{ asset('assets/plugins/iCheck/skins/all.css') }}">
    <link rel="stylesheet" href="{{ asset('assets/plugins/bootstrap-colorpalette/css/bootstrap-colorpalette.css') }}">
    <link rel="stylesheet" href="{{ asset('assets/plugins/perfect-scrollbar/src/perfect-scrollbar.css') }}">
    <link rel="stylesheet" href="{{ asset('assets/css/theme_navy.css') }}" type="text/css" id="skin_color">
    <link rel="stylesheet" href="{{ asset('assets/css/print.css') }}" type="text/css" media="print"/>
    <!--[if IE 7]>
    <link rel="stylesheet" href="{{ asset('assets/plugins/font-awesome/css/font-awesome-ie7.min.css') }}">
    <![endif]-->
    <!-- end: MAIN CSS -->
    <link href="{{ asset('assets/plugins/bootstrap-modal/css/bootstrap-modal-bs3patch.css') }}" rel="stylesheet" type="text/css"/>
    <link href="{{ asset('assets/plugins/bootstrap-modal/css/bootstrap-modal.css') }}" rel="stylesheet" type="text/css"/>
    <link rel="stylesheet" href="{{ asset('assets/plugins/summernote/build/summernote.css') }}">
    <!--SweetalertCSS-->
    <link rel="stylesheet" href="{{asset('assets/plugins/sweetalert/sweetalert2.min.css')}}" type="text/css" />
    <!-- Form elements-->

    <link rel="stylesheet" href="{{asset('assets/plugins/DataTables/media/css/DT_bootstrap.css')}}" />


    <link rel="stylesheet" href="{{ asset('assets/plugins/select2/select2.css') }}">
    <link rel="stylesheet" href="{{ asset('assets/plugins/datepicker/css/datepicker.css') }}">
    <link rel="stylesheet" href="{{ asset('assets/plugins/bootstrap-timepicker/css/bootstrap-timepicker.min.css') }}">
    <link rel="stylesheet" href="{{ asset('assets/plugins/bootstrap-daterangepicker/daterangepicker-bs3.css') }}">
    <link rel="stylesheet" href="{{ asset('assets/plugins/bootstrap-colorpicker/css/bootstrap-colorpicker.css') }}">
    <link rel="stylesheet" href="{{ asset('assets/plugins/jQuery-Tags-Input/jquery.tagsinput.css') }}">
    <link rel="stylesheet" href="{{ asset('assets/plugins/bootstrap-fileupload/bootstrap-fileupload.min.css') }}">
    <link rel="stylesheet" href="{{ asset('assets/plugins/summernote/build/summernote.css') }}">
    <link rel="stylesheet" type="text/css" href="{{ asset('assets/css/jquery.jgrowl.min.css') }}" />
    <link rel="stylesheet" type="text/css" href="{{ asset('assets/css/jquery-ui.css') }}" />
    <link rel="stylesheet" type="text/css" href="{{ asset('assets/css/datatables.min.css') }}"/>
    
    <link rel="stylesheet" type="text/css" href="{{ asset('assets/css/image-uploader.min.css') }}"/>
    <link rel="stylesheet" type="text/css" href="{{ asset('assets/css/jquery-editable.css') }}"/>
    <link rel="stylesheet" href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.12/summernote.css" rel="stylesheet">
    {{-- Auto Load css --}}
    <link rel="stylesheet" href="{{ asset('assets/css/jquery-ui.css') }}" rel="stylesheet">
    <style type="text/css" media="screen">
        .jumbotron p {
            /*margin-bottom: 15px;*/
            font-size: 20px !important;
            /*font-weight: 200;*/
        }
    </style>
    <link rel="shortcut icon" href="favicon.ico" />
    @yield('style')
</head>
<!-- end: HEAD -->
<!-- start: BODY -->
<body>


<!-- start: HEADER -->
@include('layout.header')
<!-- end: HEADER -->
<!-- start: MAIN CONTAINER -->
<div class="main-container">
    <div class="navbar-content">
        <!-- start: SIDEBAR -->
        @include('layout.sidebar')
		
        <!-- end: SIDEBAR -->
    </div>
    <!-- start: PAGE -->
    <div class="main-content">
        <!-- end: SPANEL CONFIGURATION MODAL FORM -->
        <div class="container">
            <!-- start: PAGE HEADER -->
            @include('layout.breadcrumb')
            <!-- end: PAGE HEADER -->
            <!-- start: PAGE CONTENT -->
            @yield('content')
            <!-- end: PAGE CONTENT-->
        </div>
    </div>
    <!-- end: PAGE -->
</div>
<!-- end: MAIN CONTAINER -->
<!-- start: FOOTER -->
<div class="footer clearfix">
    <div class="footer-inner">
        &copy; Copyright {{date('Y')}} .All Rights Reserved.Powered by <a href="https://technolife.ee/" target="_blank">TechnoLife.</a>
    </div>
    <div class="footer-items">
        <span class="go-top"><i class="clip-chevron-up"></i></span>
    </div>
</div>


<!-- Modal -->
<div class="modal fade" id="admin_user_view" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-content">
        <div class="modal-body">
            <div id="order-div">
                <div class="title text-center">
                    <h4 class="text-info" id="modal_title"></h4><hr>
                </div>
                <div class="done_registration ">                                
                    <div class="doc_content">
                        <div class="col-md-12">
                            <div class="" style="text-align:left;">
                                <div class="byline">
                                    <span id="modal_body"></span>
                                </div>
                            </div>
                        </div>
                    </div>                                  
                </div>                          
            </div>
            
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
        </div>
    </div>
     
   
</div>
{{-- End Modal --}}




<div aria-hidden="true" aria-labelledby="myModalLabel" class="modal fade" id="modalIMG" role="dialog" tabindex="-1">
    <div class="modal-dialog" role="document" style="width:100% !important;">
        <div class="modal-content">
            
                <img id="load_zoom_img" src="" alt="" style="height: 410px;width: 100%;">
            
            <div class="modal-footer">
            <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
        </div>
        </div>
    </div>
</div>





<!-- Profile Modal -->
<div class="modal fade" id="profile_modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-content">
        <div class="modal-body">
            <div id="">
                <div class="title text-center">
                    <h4 class="text-info">Profile View</h4>
                </div>
                <div class="done_registration ">                                
                    <div class="doc_content">
                        <div class="col-md-12">
                            <div class="" style="text-align:left">
                                <div class="byline">
                                    <span id="profile_modal_body"></span>
                                     <div class="">    
                                        <div class="jumbotron" style="margin-bottom: 0px!important">
                                          <div class="row">
                                              <div class="col-md-3 col-xs-12 col-sm-6 col-lg-3">
                                                <div class="thumbnail text-center photo_view_postion_b" >
                                                  <div class="profile_image">
                                                      
                                                  </div>
                                                </div>
                                              </div>
                                              <div class="col-md-9 col-xs-12 col-sm-6 col-lg-9">
                                                  <div class="" style="border-bottom:1px solid black">
                                                    <span id="name_div"></span>
                                                    <p><div id="status_div"></div></p>
                                                    <div id="group_div"></div></p>
                                                  </div>
                                                    <hr>
                                                  <div class="col-md-6">  
                                                  
                                                    <p title="Phone"><span class="glyphicon glyphicon-earphone one" style="width:50px;"></span><span id="contact_div"></span></p>
                                                    <p title="Email"><span class="glyphicon glyphicon-envelope one" style="width:50px;"></span><span id="email_div"></span></p>
                                                    
                                                  </div>
                                                  <div class="col-md-6">
                                                      <p title="NID NO"><span class="glyphicon glyphicon-credit-card one" style="width:50px;"></span><span id="nid_div"></span></p>
                                                    <p title="Address"><span class="glyphicon glyphicon-map-marker one" style="width:50px;"></span><span id="address_div"></span></p>
                                                  </div>



                                                  
                                              </div>
                                            </div>
                    <div class="row">
                      <div class="row">
                        <div class="col-md-12">
                        <div class="form-group" style="border-bottom:1px solid black">
                            <div id="remarks_div"></div>
                        </div>
                        </div>
                      </div>
                    </div>
                    <div class="row"> 
                     <div class="col-md-12">
                        <div id="remarks_details">
                            
                        </div>
                     </div>
                     
                    
                    </div>
                    
                    {{-- <div class="row">
                      <div class="form-group row">
                        <div class="col-md-12">
                            <div class="form-group" style="border-bottom:1px solid black">
                                <h2>CAR INFO</h2>
                            </div>
                            <div class="col-md-6">
                                <div class="col-sm-4 col-xs-6 tital " >Brand:</div><div class="col-sm-8 col-xs-6 contant_i">Prasad</div>
                                <div class="clearfix"></div><div class="bot-border"></div>
                                <div class="col-sm-4 col-xs-6 tital " >Year:</div><div class="col-sm-8 col-xs-6 contant_i">Prasad</div>
                                <div class="clearfix"></div><div class="bot-border"></div>
                             </div>    
                           <div class="col-md-6">
                                <div class="col-sm-4 col-xs-6 tital " >Model:</div><div class="col-sm-8 col-xs-6 contant_i">Prasad</div>
                                <div class="clearfix"></div><div class="bot-border"></div>
                                <div class="col-sm-4 col-xs-6 tital " >Color:</div><div class="col-sm-8 col-xs-6 contant_i">Prasad</div>
                                <div class="clearfix"></div><div class="bot-border"></div>
                             </div>    
                            
                        </div>
                      </div>
                    </div> --}}
                    
                    
                    
                    
                    
                    
                </div>
            </div>





                                </div>
                            </div>
                        </div>
                    </div>                                  
                </div>                          
            </div>
            
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
        </div>
    </div>
     
   
</div>
{{-- End Profile Modal --}}



<!-- end: FOOTER -->
<!-- start: MAIN JAVASCRIPTS -->
<!--[if lt IE 9]>
<script src="{{asset('assets/plugins/respond.min.js') }}"></script>
<script src="{{asset('assets/plugins/excanvas.min.js') }}"></script>
<script type="text/javascript" src="{{ asset('assets/plugins/jQuery-lib/1.10.2/jquery.min.js') }}"></script>
<![endif]-->
<!--[if gte IE 9]><!-->
<script src="{{ asset('assets/plugins/jQuery-lib/2.0.3/jquery.min.js') }}"></script>
<!--<![endif]-->
<script src="{{ asset('assets/plugins/jquery-ui/jquery-ui-1.10.2.custom.min.js') }}"></script>
<script src="{{ asset('assets/plugins/bootstrap/js/bootstrap.min.js') }}"></script>
<script src="{{ asset('js/jquery-ui.js')}}"></script>
<script type="text/javascript" src="{{asset('assets/plugins/DataTables/media/js/jquery.dataTables.min.js')}}"></script>
<script type="text/javascript" src="{{asset('assets/plugins/DataTables/media/js/DT_bootstrap.js')}}"></script>
<script src="{{asset('assets/js/table-data.js')}}"></script>

<script src="{{ asset('assets/plugins/bootstrap-hover-dropdown/bootstrap-hover-dropdown.min.js') }}"></script>
<script src="{{ asset('assets/plugins/blockUI/jquery.blockUI.js') }}"></script>
<script src="{{ asset('assets/plugins/iCheck/jquery.icheck.min.js') }}"></script>
<script src="{{ asset('assets/plugins/perfect-scrollbar/src/jquery.mousewheel.js') }}"></script>
<script src="{{ asset('assets/plugins/perfect-scrollbar/src/perfect-scrollbar.js') }}"></script>
<script src="{{ asset('assets/plugins/less/less-1.5.0.min.js') }}"></script>
<script src="{{ asset('assets/plugins/jquery-cookie/jquery.cookie.js') }}"></script>
<script src="{{ asset('assets/plugins/bootstrap-colorpalette/js/bootstrap-colorpalette.js') }}"></script>
<script src="{{ asset('assets/js/main.js') }}"></script>
<!-- end: MAIN JAVASCRIPTS -->

<script src="{{ asset('assets/plugins/bootstrap-modal/js/bootstrap-modal.js') }}"></script>
<script src="{{ asset('assets/plugins/bootstrap-modal/js/bootstrap-modalmanager.js') }}"></script>
<script src="{{ asset('assets/js/ui-modals.js') }}"></script>

<script src="{{ asset('assets/plugins/jquery-validation/dist/jquery.validate.min.js') }}"></script>
<script src="{{ asset('assets/plugins/summernote/build/summernote.min.js') }}"></script>
<!--sweetlertJs-->
<script src="{{asset('assets/plugins/sweetalert/sweetalert2.min.js')}}"></script>

<script src="{{ asset('assets/plugins/jquery-inputlimiter/jquery.inputlimiter.1.3.1.min.js') }}"></script>
<script src="{{ asset('assets/plugins/autosize/jquery.autosize.min.js') }}"></script>
<script src="{{ asset('assets/plugins/select2/select2.min.js') }}"></script>
<script src="{{ asset('assets/plugins/jquery.maskedinput/src/jquery.maskedinput.js') }}"></script>
<script src="{{ asset('assets/plugins/jquery-maskmoney/jquery.maskMoney.js') }}"></script>
<script src="{{ asset('assets/plugins/bootstrap-datepicker/js/bootstrap-datepicker.js') }}"></script>
<script src="{{ asset('assets/plugins/bootstrap-timepicker/js/bootstrap-timepicker.min.js') }}"></script>
<script src="{{ asset('assets/plugins/bootstrap-daterangepicker/moment.min.js') }}"></script>
<script src="{{ asset('assets/plugins/bootstrap-daterangepicker/daterangepicker.js') }}"></script>
<script src="{{ asset('assets/plugins/bootstrap-colorpicker/js/bootstrap-colorpicker.js') }}"></script>
<script src="{{ asset('assets/plugins/bootstrap-colorpicker/js/commits.js') }}"></script>
<script src="{{ asset('assets/plugins/jQuery-Tags-Input/jquery.tagsinput.js') }}"></script>
<script src="{{ asset('assets/plugins/bootstrap-fileupload/bootstrap-fileupload.min.js') }}"></script>
{{--<script src="{{ asset('assets/plugins/summernote/build/summernote.min.js') }}"></script>--}}
<script src="{{ asset('assets/js/summernote.js') }}"></script>
<script src="{{ asset('assets/plugins/ckeditor/ckeditor.js') }}"></script>
<script src="{{ asset('assets/plugins/ckeditor/adapters/jquery.js') }}"></script>
<script src="{{ asset('assets/js/form-elements.js') }}"></script>
<script src="{{ asset('assets/js/jquery.jgrowl.min.js') }}"></script>
<script src="{{ asset('assets/js/bootbox.min.js') }}"></script>
<script src="{{ asset('assets/js/jquery-sortable-min.js') }}"></script>
<script src="{{ asset('assets/js/underscore.js')}}"></script>

<!--<script src="{{ asset('js/notify.js')}}"></script>-->

<script src="{{ asset('assets/js/datatables.min.js')}}"></script>
<script src="{{ asset('assets/js/dropzone.js')}}"></script>
<script src="{{ asset('assets/js/image-uploader.min.js')}}"></script>
<script src="{{ asset('assets/js/jquery-editable-poshytip.min.js')}}"></script>
<script src="{{ asset('assets/js/jquery.poshytip.min.js')}}"></script>
<script src="{{asset('/assets/js/pusher.min.js')}}"></script>
<script src="{{ asset('assets/js/bils/common.js')}}"></script>
{{--<script src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.12/summernote.js"></script--}}


<script>
    jQuery(document).ready(function() {
        Main.init();
        UIModals.init();
        FormElements.init();
        TableData.init();
    });
    var APP_URL = '{!! url('/') !!}';

    </script>

<input type="hidden" class="site_url" value="{{url('/')}}">
{{-- <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script> --}}
<script src="{{ asset('assets/js/sweetalert.min.js')}}"></script>
<script src="{{ asset('assets/js/jquery-ui.min.js')}}"></script>
@yield('JScript')
<script>
   /* // Enable pusher logging - don't include this in production
    Pusher.logToConsole = true;
    var pusher = new Pusher( '<?php echo config('notification.PUSHER_APP_KEY');?>',{
        cluster: 'ap2',
        forceTLS: true
    });
    var channel = pusher.subscribe('<?php echo config('notification.PUSHER_APP_CHANNEL');?>');
    console.log('<?php echo config('notification.PUSHER_APP_CHANNEL');?>');
    channel.bind('<?php echo isset(\Auth::user()->id) && \Auth::user()->user_type == 'partner' ? 'order-status:' .\Auth::user()->company_id : 'order-status';?>', function(data) {
        // alert(JSON.stringify(data));
        var notificationCount = $('.notificationCounter').attr('notificationCount');
        var notificationCountTotal = parseInt(notificationCount) + 1;
        $('.notificationCounter').attr('notificationCount', notificationCountTotal);
        $('.notificationCounter').html(notificationCountTotal);
        $('.notificationCountertext').html(' You have ' + notificationCountTotal + ' new notifications');
        var html = '';
        html+= '<li>' +
            '<a href="javascript:void(0)">' +
            '<span class="label label-primary" notify_id="'+ data.order_id +'"><i class="fa fa-user"></i></span>' +
            '<span class="message">'+ data.message +'</span>' +
            // '<span class="time"> 1 min</span>' +
            '</a>' +
            '</li>'
        $('.notificationList ul').prepend(html);
    });*/
</script>
</body>
<!-- end: BODY -->
</html>
