@extends('auth.layout.login-master')
@section('login-content')
    <div class="box-login btn-squared">
        <h3>Set New Password </h3>
        <p>
            Please set your new password.
        </p>
        <form class="form-login" action="{{ url('auth/forget/password/'.$user_info->id.'/verify') }}" method="post">
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
                <input type="hidden" name="user_id" value="{{isset($user_info->id)?$user_info->id:''}}">
                <input type="hidden" name="token" value="{{isset($user_info->id)?$user_info->id:''}}">
                <input type="hidden" name="_token" value="{{ csrf_token() }}" />

                <div class="form-group form-actions">
						<span class="input-icon">
							<input type="password" class="form-control lock" name="password" placeholder="New Password">
                            <i class="fa fa-lock"></i>
                        </span>

                </div>

                <div class="form-group form-actions">
						<span class="input-icon">
							<input type="password" class="form-control lock" name="confirm_password" placeholder="Confirm New Password">
                            <i class="fa fa-lock"></i>
                        </span>

                </div>
                <div class="form-actions">
                    <button type="submit" class="btn btn-success pull-right btn-squared">
                        Confirm <i class="fa fa-arrow-circle-right"></i>
                    </button>
                </div>
            </fieldset>
        </form>
    </div>
@endsection