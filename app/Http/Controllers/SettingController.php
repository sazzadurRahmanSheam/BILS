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
use App\WebAction;
use App\UserGroup;
use App\UserGroupPermission;
use App\PublicationCategory;
use App\CourseCategory;
use App\NoticeCategory;
use App\SurveyCategory;

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
		$data['sub_module']= "General Setting";
		$data['setting'] = Setting::first();
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

				$data = Setting::find($request->id);
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

	

	public function moduleManagement(){
		$data['page_title'] = $this->page_title;
		$data['module_name']= "Cpanel";
		$data['sub_module']= "Manage Module";
		$data['menu'] = Menu::all();
		return view('setting.manage_module',$data);
	}

	public function ajaxMenuList(){
		$mesuList = Menu::Select('module_name', 'id',  'menu_title',  'parent_id', 'menu_url','menu_icon_class','status')->where('status','1')->orderBy('created_at','desc')->get();		
		
		$return_arr = array();
		foreach($mesuList as $menu){			
			$menu['status']=($menu->status == 1)?"<button class='btn btn-xs btn-success' disabled>Active</button>":"<button class='btn btn-xs btn-success' disabled>In-active</button>";
			$menu['actions']="<button onclick='moduleEdit(".$menu->id.")' id=edit_" . $menu->id . "  class='btn btn-xs btn-green module-edit' ><i class='clip-pencil-3'></i></button>"
							." <button onclick='moduleDelete(".$menu->id.")' id='delete_" . $menu->id . "' class='btn btn-xs btn-danger' ><i class='clip-remove'></i></button>";
			$return_arr[] = $menu;
		}
		return json_encode(array('data'=>$return_arr));
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
		$data['sub_module']= "Web Actions";
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
					$data = WebAction::find($request->edit_id);
					$data->update($column_value);

				}
				else{
					$response = WebAction::create($column_value);
					//get action id
					$action_id = $response->id;
					//get group id
					$group_id = UserGroup::Select('id')->get();
					// insert a row in user_group_permissions for each group of the action id
					foreach ($group_id as $group_id) {
						$user_group_permissions = new UserGroupPermission();
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
		$webActionList = WebAction::Select('web_actions.id as id','web_actions.activity_name as activity_name','web_actions.status as status','menus.module_name as module_name')
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

	//Web Action Edit
	public function web_action_edit($id){
		$data = WebAction::Select('id','activity_name','module_id')->where('id',$id)->first();
		return json_encode($data);
	}
	//Web Action Management End


	/*----- Publication Management Start -----*/

	public function publication_category_management(){
		$data['page_title'] = $this->page_title;
		$data['module_name']= "Settings";
		$data['sub_module']= "Publication Category";
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
				if ($request->publication_category_edit_id == '') {
					$response = PublicationCategory::create($column_value);
					$return['success'] = "insert";
				}
				else{
					$data = PublicationCategory::find($request->publication_category_edit_id);
					$data->update($column_value);
					$return['success'] = "update";
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
	#Pubilacation Categories List
	public function publication_categories_get(){
		$publication_categories_list = PublicationCategory::Select('id', 'category_name', 'details', 'status')->get();		
		$return_arr = array();
		foreach($publication_categories_list as $row){			
			$row['status']=($row->status == 1)?"<button class='btn btn-xs btn-success' disabled>Active</button>":"<button class='btn btn-xs btn-danger' disabled>In-active</button>";
			$row['actions']="<button onclick='publication_category_edit(".$row->id.")' id=edit_" . $row->id . "  class='btn btn-xs btn-green module-edit' ><i class='clip-pencil-3'></i></button>"
							." <button onclick='publication_category_delete(".$row->id.")' id='delete_" . $row->id . "' class='btn btn-xs btn-danger' ><i class='clip-remove'></i></button>";
			$return_arr[] = $row;
		}
		return json_encode(array('data'=>$return_arr));
	}

	public function publication_category_edit($id){
		$data = PublicationCategory::Select('id','category_name','details','status')->where('id',$id)->first();
		return json_encode($data);
	}

	public function publication_category_delete($id){
		PublicationCategory::find($id)->delete();
		return json_encode(array(
			"deleteMessage"=>"Deleted Successful"
		));
	}

	/*----- Publication Management End -----*/

	
	/*----- Course Management Start -----*/

	#Getting Course Category Management Page
	public function courses_category_management(){
		$data['page_title'] = $this->page_title;
		$data['module_name']= "Settings";
		$data['sub_module']= "Course Category";
		$data['setting'] = Setting::first();
		return view('courses.course_category',$data);
	}

	#Course Category Entry & Update
	public function course_category_entry_update(Request $request){
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
				if ($request->course_category_edit_id == '') {
					$response = CourseCategory::create($column_value);
					$return['success'] = "insert";
				}
				else{
					$data = CourseCategory::find($request->course_category_edit_id);
					$data->update($column_value);
					$return['success'] = "update";
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

	#Course Categories List
	public function course_categories_get(){
		$course_categories_list = CourseCategory::Select('id', 'category_name', 'details', 'status')->get();		
		$return_arr = array();
		foreach($course_categories_list as $row){			
			$row['status']=($row->status == 1)?"<button class='btn btn-xs btn-success' disabled>Active</button>":"<button class='btn btn-xs btn-danger' disabled>In-active</button>";
			$row['actions']="<button onclick='course_category_edit(".$row->id.")' id=edit_" . $row->id . "  class='btn btn-xs btn-green edit' ><i class='clip-pencil-3'></i></button>"
							." <button onclick='course_category_delete(".$row->id.")' id='delete_" . $row->id . "' class='btn btn-xs btn-danger' ><i class='clip-remove'></i></button>";
			$return_arr[] = $row;
		}
		return json_encode(array('data'=>$return_arr));
	}

	#Course Categories Edit
	public function course_category_edit($id){
		$data = CoursCategory::Select('id','category_name','details','status')->where('id',$id)->first();
		return json_encode($data);
	}

	#Course Category Delete
	public function course_category_delete($id){
		CoursCategory::find($id)->delete();
		return json_encode(array(
			"deleteMessage"=>"Deleted Successful"
		));
	}


	/*----- Course Management End -----*/


	/*----- Notice Management Start -----*/

	#Getting Notice Category Management Page
	public function notice_category_management(){
		$data['page_title'] = $this->page_title;
		$data['module_name']= "Settings";
		$data['sub_module']= "Notice Category";
		$data['setting'] = Setting::first();
		return view('notice.notice_category',$data);
	}

	#Notice Category Entry & Update
	public function notice_category_entry_update(Request $request){
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
				if ($request->notice_category_edit_id == '') {
					$response = NoticeCategory::create($column_value);
					$return['success'] = "insert";
				}
				else{
					$data = NoticeCategory::find($request->notice_category_edit_id);
					$data->update($column_value);
					$return['success'] = "update";
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

	#Notice Categories List
	public function notice_categories_get(){
		$notice_categories_list = NoticeCategory::Select('id', 'category_name', 'details', 'status')->get();		
		$return_arr = array();
		foreach($notice_categories_list as $row){			
			$row['status']=($row->status == 1)?"<button class='btn btn-xs btn-success' disabled>Active</button>":"<button class='btn btn-xs btn-danger' disabled>In-active</button>";
			$row['actions']="<button onclick='notice_category_edit(".$row->id.")' id=edit_" . $row->id . "  class='btn btn-xs btn-green edit' ><i class='clip-pencil-3'></i></button>"
							." <button onclick='notice_category_delete(".$row->id.")' id='delete_" . $row->id . "' class='btn btn-xs btn-danger' ><i class='clip-remove'></i></button>";
			$return_arr[] = $row;
		}
		return json_encode(array('data'=>$return_arr));
	}

	#Notice Categories Edit
	public function notice_category_edit($id){
		$data = NoticeCategory::Select('id','category_name','details','status')->where('id',$id)->first();
		return json_encode($data);
	}

	#Notice Category Delete
	public function notice_category_delete($id){
		NoticeCategory::find($id)->delete();
		return json_encode(array(
			"deleteMessage"=>"Deleted Successful"
		));
	}

	/*----- Notice Management End -----*/



	/*----- Survey Category Management Start -----*/
	#Getting Survey Category Management Page
	public function survey_category_management(){
		$data['page_title'] = $this->page_title;
		$data['module_name']= "Settings";
		$data['sub_module']= "Survey Category";
		$data['setting'] = Setting::first();
		return view('survey.survey_category',$data);
	}

	#Survey Category Entry & Update
	public function survey_category_entry_update(Request $request){
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
				if ($request->survey_category_edit_id == '') {
					$response = SurveyCategory::create($column_value);
					$return['success'] = "insert";
				}
				else{
					$data = SurveyCategory::find($request->survey_category_edit_id);
					$data->update($column_value);
					$return['success'] = "update";
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

	#Survey Categories List
	public function survey_categories_get(){
		$survey_categories_list = SurveyCategory::Select('id', 'category_name', 'details', 'status')->get();		
		$return_arr = array();
		foreach($survey_categories_list as $row){			
			$row['status']=($row->status == 1)?"<button class='btn btn-xs btn-success' disabled>Active</button>":"<button class='btn btn-xs btn-danger' disabled>In-active</button>";
			$row['actions']="<button onclick='survey_category_edit(".$row->id.")' id=edit_" . $row->id . "  class='btn btn-xs btn-green edit' ><i class='clip-pencil-3'></i></button>"
							." <button onclick='survey_category_delete(".$row->id.")' id='delete_" . $row->id . "' class='btn btn-xs btn-danger' ><i class='clip-remove'></i></button>";
			$return_arr[] = $row;
		}
		return json_encode(array('data'=>$return_arr));
	}

	#Survey Categories Edit
	public function survey_category_edit($id){
		$data = SurveyCategory::Select('id','category_name','details','status')->where('id',$id)->first();
		return json_encode($data);
	}

	#Survey Category Delete
	public function survey_category_delete($id){
		SurveyCategory::find($id)->delete();
		return json_encode(array(
			"deleteMessage"=>"Deleted Successful"
		));
	}

	/*----- Survey Category Management End -----*/



}

