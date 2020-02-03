@extends('auth.layout.login-master')
@section('login-content')

    <!-- start: FORGOT BOX -->
    <div class="box-forgot" style="display: block;">
        <h3>Forget Password?</h3>
        <p>
            Enter your e-mail address below to reset your password.
        </p>
        <form class="form-forgot" action="{{url('auth/forget/password')}}" method="post">
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

            <fieldset>
                <div class="form-group">
                    <span class="input-icon">
                        <input type="email" class="form-control" name="email" placeholder="Email">
								<i class="fa fa-envelope"></i> </span>
                </div>
                <div class="form-actions">
                    <a href="{{url('/')}}" class="btn btn-light-grey go-back">
                        <i class="fa fa-circle-arrow-left"></i> Back
                    </a>
                    <button type="submit" class="btn btn-bricky pull-right">
                        Submit <i class="fa fa-arrow-circle-right"></i>
                    </button>
                </div>
            </fieldset>
        </form>
    </div>
    <!-- end: FORGOT BOX -->
@endsection