<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Validator;
use Session;
use DB;
use \App\System;
use \App\Setting;
use App\User;
use Auth;



class ProfileController extends Controller
{
	public function __construct(Request $request)
    {
        $this->page_title = $request->route()->getName();
        $description = \Request::route()->getAction();
        $this->page_desc = isset($description['desc']) ? $description['desc'] : $this->page_title;
    }

    public function index(){
    	$data['page_title'] = $this->page_title;
		return view('profile.index',$data);
    }

    public function profile_info(){
    	$id = Auth::user()->id;
    	$profile_info = User::get()->where('id',$id);
    	return  json_encode($profile_info);
    }

    public function update_profile(Request $request){
		$rule = [
            'name' => 'Required|max:220',
            'nid_no' => 'Required|max:20',
            'contact_no' => 'Required|max:13',
            'email' => 'Required|email',
            'emp_image_upload' => 'mimes:jpeg,jpg,png,svg'
        ];

        $validation = Validator::make($request->all(), $rule);
        if ($validation->fails()) {
			$return['result'] = "0";
			$return['errors'] = $validation->errors();
			return json_encode($return);
        }
		else{
			
			if ($request->edit_profile_id != ''){
				#EmailCheck
	            $email_verification = User::where([['email',$request->email],['id', '!=', $request->edit_profile_id]])->first();
           		if(isset($email_verification->id)){
					$return['result'] = "0";
					$return['errors'][] = $request->email." is already exists";
					return json_encode($return);
				}
			}		
			try{
				DB::beginTransaction();
				
				$column_value = [
					'name'=>$request->name,
					'nid_no'=>$request->nid_no,
					'contact_no'=>$request->contact_no,
					'email'=>$request->email,
					'address'=>$request->address,
					'remarks'=>$request->remarks
					//'user_profile_image'=>$image_name,	
				];
				
				$data = User::find($request->edit_profile_id);
				$data->update($column_value);
				DB::commit();
				$return['result'] = "1";
				return json_encode($return);
			}
			catch (\Exception $e){
				DB::rollback();
				$return['result'] = "0";
				$return['errors'][] ="Faild to save";
				return json_encode($return);
			}
		}			
	}

	public function update_password(Request $request){
		$rule = [
            'current_password' => 'Required|max:255',
        ];
        $validation = Validator::make($request->all(), $rule);
        if ($validation->fails()) {
			$return['result'] = "0";
			$return['errors'] = $validation->errors();
			return json_encode($return);
        }
        else{		
			try{
				DB::beginTransaction();
				
				$id = $request->change_pass_id;
				$current_password = md5($request->current_password);

				$column_value = [
					'password'=>$current_password,		
				];
				
				$data = User::find($id);
				if ($current_password == $data['password']) {
					$data->update($column_value);
					DB::commit();
					$return['result'] = "1";
					return json_encode($return);
				}else{
					$return['result'] = "0";
					$return['errors'][] ="Wrong Password..!";
					return json_encode($return);
				}
			}
			catch (\Exception $e){
				DB::rollback();
				$return['result'] = "0";
				$return['errors'][] ="Faild to save";
				return json_encode($return);
			}
		}


	}




}
