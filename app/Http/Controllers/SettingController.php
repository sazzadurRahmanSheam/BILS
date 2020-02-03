<?php

namespace App\Http\Controllers;
//later i will use use App\Traits\HasRoleAndPermission;
use Illuminate\Http\Request;
use Validator;
use Session;
use DB;
use \App\System;
use \App\Setting;

class SettingController extends Controller
{
    public function __construct(Request $request)
    {
        $this->page_title = $request->route()->getName();
        $description = \Request::route()->getAction();
        $this->page_desc = isset($description['desc']) ? $description['desc'] : $this->page_title;
    }

	//General Setting
	public function generalSetting(){
		$data['page_title'] = $this->page_title;
		$data['module_name']= "Cpanel";
		$data['setting'] = Setting::first();
		//return response()->json($data['setting']);
		return view('setting.general_setting',$data);
	}

	//Update General  Setting
	public function generalSettingUpdate(Request $request){

		$rule = [
            'company_name' => 'Required|max:100',
            'short_name' => 'Required|max:10',
            'site_name' => 'Required',
            'admin_email' => 'Required|email',
            'admin_mobile' => 'Required',
            'emp_image_upload' => 'mimes:jpeg,jpg,png,svg'
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
				$column_value = [
					'company_name'=>$request->company_name,
					'short_name'=>$request->short_name,
					'site_name'=>$request->site_name,
					'admin_email'=>$request->admin_email,
					'admin_mobile'=>$request->admin_mobile,
					'site_url'=>$request->site_url,
					'admin_url'=>$request->admin_url,
					'address'=>$request->address,
					//'user_profile_image'=>$image_name,	
				];

				
				
				//dd($column_value);

				//$response = Setting::create($column_value);

				$data = Setting::first();
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


}

