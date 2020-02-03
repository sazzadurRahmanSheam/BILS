<!DOCTYPE html>
<html lang="en">
<head>
    <title>Cine Cms-Customer Care Login</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" type="text/css" href="{{asset('customerCare/vendor/bootstrap/css/bootstrap.min.css')}}">
    <!--===============================================================================================-->
    <link rel="stylesheet" type="text/css" href="{{asset('customerCare/fonts/font-awesome-4.7.0/css/font-awesome.min.css')}}">
    <!--===============================================================================================-->
    <link rel="stylesheet" type="text/css" href="{{asset('customerCare/vendor/animate/animate.css')}}">
    <!--===============================================================================================-->
    <link rel="stylesheet" type="text/css" href="{{asset('customerCare/vendor/css-hamburgers/hamburgers.min.css')}}">
    <!--===============================================================================================-->
    <link rel="stylesheet" type="text/css" href="{{asset('customerCare/vendor/animsition/css/animsition.min.css')}}">
    <!--===============================================================================================-->
    <link rel="stylesheet" type="text/css" href="{{asset('customerCare/css/util.css')}}">
    <link rel="stylesheet" type="text/css" href="{{asset('customerCare/css/main.css')}}">
    <!--===============================================================================================-->

</head>
<body>

<div class="limiter">
    <div class="container-login100">
        <div class="wrap-login100">
            <form class="login100-form validate-form p-l-55 p-r-55 p-t-178" action="{{ url('/customer-care') }}" method="post">
                <input type="hidden" name="_token" value="{{csrf_token()}}">
                @if($errors->count() > 0 )
                    <div class="alert alert-danger btn-squared">
                        <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
                        <h6>The following errors have occurred:</h6>
                        <ul>
                            @foreach( $errors->all() as $message )
                                <li>{{ $message }}</li>
                            @endforeach
                        </ul>
                    </div>
                @endif
                @if(Session::has('message'))
                    <div class="alert alert-success btn-squared" role="alert">
                        <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
                        {{ Session::get('message') }}
                    </div>
                @endif
                @if(Session::has('errormessage'))
                    <div class="alert alert-danger btn-squared" role="alert">
                        <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
                        {{ Session::get('errormessage') }}
                    </div>
                @endif
                {{--<div class="errorHandler alert alert-danger no-display btn-squared">
                    <i class="fa fa-remove-sign"></i> You have some form errors. Please check below.
                </div>--}}
                <span class="login100-form-title">
						CineSpot-Customer Care Login
					</span>

                <div class="wrap-input100 validate-input m-b-16" data-validate="Please enter User ID">
                    <input class="input100" type="email" name="email" placeholder="User ID">
                    <span class="focus-input100"></span>
                </div>

                <div class="wrap-input100 validate-input" data-validate = "Please enter password">
                    <input class="input100" type="password" name="password" placeholder="Password">
                    <span class="focus-input100"></span>
                </div>
                <div class="text-right p-t-13 p-b-23">

                </div>
                <div class="container-login100-form-btn">
                    <button class="login100-form-btn">
                        Login
                    </button>
                </div>

                <div class="flex-col-c p-t-170 p-b-40">

                </div>
            </form>
        </div>
    </div>
</div>


<!--===============================================================================================-->
<script src="{{asset('customerCare/vendor/jquery/jquery-3.2.1.min.js')}}"></script>
<!--===============================================================================================-->
<script src="{{asset('customerCare/vendor/animsition/js/animsition.min.js')}}"></script>
<!--===============================================================================================-->
<script src="{{asset('customerCare/vendor/bootstrap/js/popper.js')}}"></script>
<script src="{{asset('customerCare/vendor/bootstrap/js/bootstrap.min.js')}}"></script>
<!--===============================================================================================-->
<script src="{{asset('customerCare/vendor/select2/select2.min.js')}}"></script>
<!--===============================================================================================-->
<script src="{{asset('customerCare/vendor/daterangepicker/moment.min.js')}}"></script>
<script src="{{asset('customerCare/js/main.js')}}"></script>

</body>
</html>