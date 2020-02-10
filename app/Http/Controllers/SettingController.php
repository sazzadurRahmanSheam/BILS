<?php

namespace App\Http\Controllers;
//later i will use use App\Traits\HasRoleAndPermission;
use Illuminate\Http\Request;
use Validator;
use Session;
use DB;
use \App\System;
use \App\Setting;
use App\Menu;
use App\Web_action;
use App\User_group;
use App\User_group_permission;
use App\Publication_category;

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
				//$data = new Setting;
				$data = Setting::find($request->id);
				$data->update($column_value);
				// dd($data);
				
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

	

	public function moduleManagement(){
		$data['page_title'] = $this->page_title;
		$data['module_name']= "Cpanel";
		$data['menu'] = Menu::all();
		return view('setting.manage_module',$data);
	}

	public function ajaxMenuList(){
		$mesuList = Menu::Select('module_name', 'id',  'menu_title',  'parent_id', 'menu_url','menu_icon_class','status')->where('status','1')->orderBy('created_at','desc')->get();		
		//dd($adminmenu);
		$return_arr = array();
		foreach($mesuList as $menu){			
			$menu['status']=($menu->status == 1)?"<button class='btn btn-xs btn-success' disabled>Active</button>":"<button class='btn btn-xs btn-success' disabled>In-active</button>";
			$menu['actions']="<button onclick='moduleEdit(".$menu->id.")' id=edit_" . $menu->id . "  class='btn btn-xs btn-green module-edit' ><i class='clip-pencil-3'></i></button>"
							." <button onclick='moduleDelete(".$menu->id.")' id='delete_" . $menu->id . "' class='btn btn-xs btn-danger' ><i class='clip-remove'></i></button>";
			$return_arr[] = $menu;
		}
		return json_encode(array('data'=>$return_arr));
       // return view('admin.manage', $data);
	}

	//getting parent menu
	public function getParentMenu(){
		$parent_menu = Menu::Select('module_name')->where('parent_id','0')->orderBy('id', 'desc')->get();
		return json_encode(array('data'=>$parent_menu));
	}

	public function getMenuID($module_name){
		$menu_id = Menu::Select('id')->where('module_name',$module_name)->first();
		if ($menu_id==null) {
			$parent_id = 0;
		}
		else{
			$parent_id = $menu_id['id'];
		}
		return $parent_id;
	}


	//Module Entry
	public function moduleEntry(Request $request){
		$rule = [
            'module_name' => 'Required|max:50',
            'menu_title' => 'Required|max:50',
        ];

        $validation = Validator::make($request->all(), $rule);
        if ($validation->fails()) {
			$return['result'] = "0";
			$return['errors'] = $validation->errors();
			return json_encode($return);
        }
		else{
			try{
				if ($request->menu_url=="") {
					$menu_url = "";
				}else{
					$menu_url = $request->menu_url;
				}
				DB::beginTransaction();
				$column_value = [
					'module_name'=>$request->module_name,
					'menu_title'=>$request->menu_title,
					'parent_id'=>$request->parent_id,
					'menu_url'=>$menu_url,
					'menu_icon_class'=>$request->menu_icon_class,
				];

				if($request->edit_id !=""){
					$data = Menu::find($request->edit_id);
					$data->update($column_value);
				}

				else{
					$response = Menu::create($column_value);
				}
				
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


	//get data for update
	public function moduleEdit($id){
		 $data = Menu::Select('id','module_name','menu_title','menu_url','menu_icon_class','parent_id')->where('id',$id)->first();
		return json_encode($data);
	}


	//Module delete
	public function moduleDelete($id){
		$parent_menu = Menu::Select('module_name','parent_id')->where('id',$id)->first();
		if ($parent_menu['parent_id']=='0') {
			return json_encode(array(
				"parentmessage"=>"You Cant Not Delete ".$parent_menu['module_name'].". It Has Sub-menu",
			));
		}else{
			Menu::Select('id')->where('id',$id)->delete();
			return json_encode(array(
				"deleteMessage"=>"Delete Successful",
			));

		}
	}





	//Web Aciton Management Start Here

	//Get web action page
	public function webActionManagement(){
		$data['page_title'] = $this->page_title;
		$data['module_name']= "Cpanel";
		$data['setting'] = Setting::first();
		return view('setting.web_action_management',$data);
	}

	//get module name and id
	public function getModuleName(){
		$data = Menu::Select('id','module_name')->where('parent_id','0')->get();
		return json_encode(array('data'=>$data));
	}

	//Web Action Entry And Update
	public function webActionEntry(Request $request){
		$rule = [
            'module_name_for_web_action' => 'Required',
            'activity_name' => 'Required|max:50',
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
					'activity_name'=>$request->activity_name,
					'module_id'=>$request->module_name_for_web_action,
				];

				if($request->edit_id !=""){
					$data = Web_action::find($request->edit_id);
					$data->update($column_value);

				}
				else{
					$response = Web_action::create($column_value);
					//get action id
					$action_id = $response->id;
					//get group id
					$group_id = User_group::Select('id')->get();
					// insert a row in user_group_permissions for each group of the action id
					foreach ($group_id as $group_id) {
						$user_group_permissions = new User_group_permission();
						$user_group_permissions->group_id=$group_id['id'];
						$user_group_permissions->action_id=$action_id;
						$user_group_permissions->status='0';
						$user_group_permissions->save();
					}
				}
				
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

	//Web Action List
	public function webActionList(){
		$webActionList = Web_action::Select('web_actions.id as id','web_actions.activity_name as activity_name','web_actions.status as status','menus.module_name as module_name')
			->leftJoin('menus', 'web_actions.module_id', '=', 'menus.id')
			->where('web_actions.status','1')
			->get();

		$return_arr = array();
		foreach($webActionList as $webActionList){			
			$webActionList['status']=($webActionList->status == 1)?"<button class='btn btn-xs btn-success' disabled>Active</button>":"<button class='btn btn-xs btn-success' disabled>In-active</button>";
			$webActionList['actions']="<button onclick='web_action_edit(".$webActionList->id.")' id=edit_" . $webActionList->id . "  class='btn btn-xs btn-green module-edit' ><i class='clip-pencil-3'></i></button>";
			$return_arr[] = $webActionList;
		}
		return json_encode(array('data'=>$return_arr));
       
	}

	/*." <button onclick='web_action_delete(".$webActionList->id.")' id='delete_" . $webActionList->id . "' class='btn btn-xs btn-danger' ><i class='clip-remove'></i></button>"*/

	//Web Action Edit
	public function web_action_edit($id){
		$data = Web_action::Select('id','activity_name','module_id')->where('id',$id)->first();
		return json_encode($data);
	}
	//Web Action Management End


	/*----- Publication Management Start -----*/

	public function publication_category_management(){
		$data['page_title'] = $this->page_title;
		$data['module_name']= "Settings";
		$data['setting'] = Setting::first();
		return view('publication.publication_category',$data);
	}

	#publication Category Entry & Update
	public function publication_category_entry_update(Request $request){
		$rule = [
            'category_name' => 'Required|max:100',
        ];

        $validation = Validator::make($request->all(), $rule);
        if ($validation->fails()) {
			$return['result'] = "0";
			$return['errors'] = $validation->errors();
			return json_encode($return);
        }
		else{
			try{
				$status = ($request->is_active=="")?'0':$request->is_active;
				DB::beginTransaction();       
				$column_value = [
					'category_name'=>$request->category_name,
					'details'=>$request->details,	
					'status'=>$status,	
				];

				$response = Publication_category::create($column_value);
				
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

	/*----- Publication Management End -----*/



}

