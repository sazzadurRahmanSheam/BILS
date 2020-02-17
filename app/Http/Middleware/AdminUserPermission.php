<?php

namespace App\Http\Middleware;
use App\Traits\HasPermission;
use Closure;

class AdminUserPermission
{
	use HasPermission;
    /**
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \Closure  $next
     * @return mixed
     */
    public function handle($request, Closure $next)
    {
		if(\Auth::check())
        {
			$action 	   = $request->route()->getAction();
			$admin_user_id  =  \Auth::user()->id;
			if($this->PermissionHasOrNot($admin_user_id, $action['action_id'])){
				return $next($request);
			}
			else
            {
                \Session::flash('errormessage','You Dont Have Permission');
                \Session::put('pre_login_url',\URL::current());
                return redirect()->back();
            }
        } 
		else{
            if ($request->ajax())
            {
                return response('Unauthorized.', 401);
            }
            else
            {
                \Session::flash('errormessage','Invalid Request');
                \Session::put('pre_login_url',\URL::current());
                return redirect()->guest('/auth/login');
            }
        }
    }
}
