<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Http\Requests;
use App\User;
use App\System;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Session;

class SystemAuthController extends Controller
{
    /**
     * Class constructor.
     * get current route name for page title.
     *
     */
    public function __construct(Request $request){
        $this->page_title = $request->route()->getName();
        $description = \Request::route()->getAction();
        $this->page_desc = isset($description['desc']) ? $description['desc'] : $this->page_title;
    }

    /**
     * Show admin login page for admin
     * checked Auth user, if failed get user data according to email.
     * checked user type, if "admin" redirect to dashboard
     * or redirect to login.
     *
     * @return HTML view Response.
     */
    public function authLogin()
    {
        if (\Auth::check()) {
            \App\User::LogInStatusUpdate("login");
           // return redirect('dashboard');

        } else {
            $data['page_title'] = $this->page_title;
            $session_email=\Session::get('email');
            if (!empty($session_email)) {
                $user_info=\DB::table('users')
                    ->where('email', $session_email)
                    ->select('email','name','user_profile_image')
                    ->first();
                $data['user_info']=$user_info;
            }
			//dd($data);
            return view('auth.login',$data);
        }
    }

    /**
     * Check Admin Authentication
     * checked validation, if failed redirect with error message
     * checked auth $credentials, if failed redirect with error message
     * checked user type, if "admin" change login status.
     *
     * @param  Request $request
     * @return Response.
     */
    public function authPostLogin(Request $request)
    {
        $validator = \Validator::make($request->all(), [
            'email' => 'required|email',
            'password' => 'required',
        ]);
		
        if ($validator->fails()) {
            return redirect()->back()->withErrors($validator)->withInput();
        }
        $remember_me = $request->has('remember_me') ? true : false;
        $credentials = [
            'email' => $request->input('email'),
            'password'=>$request->input('password'),
            'status'=> "1"
        ];

        if (\Auth::attempt($credentials,$remember_me)) {
            \Session::put('email', \Auth::user()->email);
            \Session::put('last_login', Auth::user()->last_login);

            if (\Session::has('pre_login_url') ) {
                $url = \Session::get('pre_login_url');
                \Session::forget('pre_login_url');
                return redirect($url);
            }else {	
                \App\User::LogInStatusUpdate(1);
                return redirect('dashboard');
            }

        } else {
            return redirect('auth/login')
                ->with('errormessage',"Incorrect combinations.Please try again.");
        }
    }

    /**
     * Admin logout
     * check auth login, if failed redirect with error message
     * get user data according to email
     * checked name slug, if found change login status and logout user.
     *
     * @param string $name_slug
     * @return Response.
     */
    public function authLogout($email)
    {
		
        if (\Auth::check()) {
            $user_info = \App\User::where('email',\Auth::user()->email)->first();
           // print_r($user_info); die();
            if (!empty($user_info) && ($email==$user_info->email)) {
				\App\User::LogInStatusUpdate(0);
                \Auth::logout();
                \Session::flush();
                return \Redirect::to('auth/login');
            } else {
                return \Redirect::to('auth/login');
            }
        } else {
            return \Redirect::to('auth/login')->with('errormessage',"Error logout");
        }
    }

    /**
     * User Registration
     * checked validation, if failed redirect with message
     * data store into users table.
     *
     * @param Request $request
     * @return Response
     */
    public function authRegistration(Request $request)
    {
        $now = date('Y-m-d H:i:s');
        $v = \Validator::make($request->all(), [
            'name' => 'required',
            'email' => 'required|email|unique:users',
            'password' => 'required',
            'repeat_password' => 'required|in_array:password',
        ]);
        if ($v->fails()) {
            return redirect()->back()->withErrors($v)->withInput();
        }
        $slug=explode(' ', strtolower($request->input('name')));
        $name_slug=implode('.', $slug);
        $registration=array(
            'name' => ucwords($request->input('name')),
            'name_slug' => $name_slug,
            'user_type' => 'normal_user',
            'user_role' => 'normal_user',
            'user_profile_image' => '',
            'login_status' => 0,
            'status' => 'active',
            'email' => $request->input('email'),
            'password' => bcrypt($request->input('password')),
            'created_at' => $now,
            'updated_at' => $now,
        );
        try {
            $registration = \DB::table('users')->insert($registration);
            if ($registration) {
                return redirect('auth/login')->with('message',"You have successfully registered");
            }
        } catch(\Exception $e) {
            $message = "Message : ".$e->getMessage().", File : ".$e->getFile().", Line : ".$e->getLine();
            return redirect('auth/login')->with('errormessage',"Duplicate email or something is wrong on user registration ! Please try again..");
        }
    }

    /**
     * Send mail to user who forget his account password
     * check user name exist, if not found redirect to same page.
     *
     * @param  $request
     * @return Response.
     */

    public function forgetPasswordAuthPage()
    {
        if (\Auth::check()) {
            return redirect('auth/login')->with('errormessage', 'Whoops, looks like something went wrong!.');
        } else {
            $data['page_title'] = $this->page_title;
            return view('auth.forget-password',$data);
        }
    }
    public function authForgotPasswordConfirm(Request $request)
    {
        $v = \Validator::make($request->all(), [
            'email' => 'required|email',
        ]);
        if ($v->fails()) {
            return redirect()->back()->withErrors($v)->withInput();
        }
        $email = $request->input('email');
        $user_email= \App\User::where('email','=',$email)->first();
        if (!isset($user_email->id)) {
            return redirect('auth/forget/password')->with('errormessage',"Sorry email does not match!");
        }


        #UpdateRememberToken
        $token = \App\System::RandomStringNum(16);
        \App\User::where('id',$user_email->id)->update(['remember_token'=>$token]);

        $reset_url= url('auth/forget/password/'.$user_email->id.'/verify').'?token='.$token;
		echo $reset_url;die;
        //return \Redirect::to($reset_url);

        \App\System::ForgotPasswordEmail($user_email->id, $reset_url);
        return redirect('auth/forget/password')->with('message',"Please check your mail !.");
    }

    /**
     * creating form for new password
     * update password according to user_id.
     *
     * @param int $users_id
     * @return HTML view Response.
     */
    public function authSystemForgotPasswordVerification($user_id)
    {
        $remember_token=isset($_GET['token'])?$_GET['token']:'';
        $user_info= \App\User::where('id','=',$user_id)->first();

        if(!empty($remember_token)&&isset($user_info->id) && !empty($user_info->remember_token) && ($user_info->remember_token==$remember_token)){

            $data['user_info']=$user_info;
            $data['page_title'] = $this->page_title;
            return \View::make('auth.set-new-password',$data);

        }else return redirect('auth/forget/password')->with('errormessage',"Sorry invalid token!");

    }


    /**
     * Set new password according to user
     * check validation, if failed redirect same page with error message
     * change user password and update user table.
     *
     * @param Request $request
     * @return Response.
     */
    public function authSystemNewPasswordPost(Request $request)
    {
        $now = date('Y-m-d H:i:s');
        $validator = \Validator::make($request->all(), [
            'password' => 'required|min:4',
            'confirm_password' => 'required|same:password',
        ]);
        if ($validator->fails()) {
            return redirect()->back()->withErrors($validator)->withInput();
        }

        $user_id =  \Request::input('user_id');

        $update_password=array(
            'password' => bcrypt($request->input('password')),
            'remember_token' => null,
            'updated_at' => $now
        );
        try {
            $update_pass=\App\User::where('id', $user_id)->update($update_password);
            if($update_pass) {
                return redirect('auth/login')->with('message',"Password updated successfully !");
            }
        } catch(\Exception $e) {
            $message = "Message : ".$e->getMessage().", File : ".$e->getFile().", Line : ".$e->getLine();           
            return redirect('auth/login')->with('errormessage',"Password update failed  !");
        }

    }


    public function EmailVerificationPage($user_id)
    {
        $remember_token=isset($_GET['token'])?$_GET['token']:'';
        $user_info= \App\User::where('id','=',$user_id)->first();

        if(!empty($remember_token)&&isset($user_info->id) && !empty($user_info->remember_token) && ($user_info->remember_token==$remember_token)){

            $data['user_info']=$user_info;
            $data['page_title'] = $this->page_title;
            return \View::make('partner.partner-set-new-password',$data);

        }else return redirect('/')->with('errormessage',"Sorry invalid token!");

    }


    public function EmailUpdateNewPassword(Request $request,$user_id)
    {
        $now = date('Y-m-d H:i:s');
        $validator = \Validator::make($request->all(), [
            'password' => 'required|min:4',
            'confirm_password' => 'required|same:password',
        ]);
        if ($validator->fails()) {
            return redirect()->back()->withErrors($validator)->withInput();
        }

        $user_id =  \Request::input('user_id');

        $update_password=array(
            'password' => bcrypt($request->input('password')),
            'remember_token' => null,
            'updated_at' => $now
        );
        try {
            $update_pass=\App\User::where('id', $user_id)->update($update_password);

            if($update_pass) {
                return redirect('auth/login')->with('message',"Password updated successfully !");
            }
        } catch(\Exception $e) {
            $message = "Message : ".$e->getMessage().", File : ".$e->getFile().", Line : ".$e->getLine();
            return redirect('auth/login')->with('errormessage',"Password update failed  !");
        }
    }
}
