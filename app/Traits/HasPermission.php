<?php

namespace App\Traits;

use App\User;
use App\UserGroupMember;
use App\UserGroupPermission;

use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\Collection;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsToMany;
use Illuminate\Support\Str;

trait HasPermission
{
    public function PermissionHasOrNot($admin_emp_id,$action_id){
		//echo UserGroupMember::selectRaw("group_concat('".'"'."', group_id,'".'"'."') as groupss")->where('emp_id',$admin_emp_id)->groupBy('emp_id')->toSql();
		$user_groups_arr = UserGroupMember::selectRaw("group_concat('".'"'."', group_id,'".'"'."') as groupss")->where('emp_id',$admin_emp_id)->groupBy('emp_id')->get();
		$user_groups = $user_groups_arr[0]['groupss'];

		//this is not working  whereIn dynamic multipe value
		//$user_groups = explode(',',$user_groups_arr[0]['groups']);
		//$permission = User_group_permission::select('status')->whereIn('group_id',[$user_groups])->where('action_id',$action_id)->get();
		//\DB::enableQueryLog();
		$permission = \DB::select(\DB::raw("SELECT count(status) as has_permission FROM user_group_permissions WHERE group_id IN($user_groups) AND action_id=$action_id AND STATUS=1"));
		//dd(\DB::getQueryLog()); 
		//dd($permission);
		foreach($permission as $p){
			return $p->has_permission;
		}
	}

}
