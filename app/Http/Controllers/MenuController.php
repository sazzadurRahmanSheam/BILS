<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Menu;

class MenuController extends Controller
{

	public function __construct(Request $request)
    {
        $this->page_title = $request->route()->getName();
        $description = \Request::route()->getAction();
        $this->page_desc = isset($description['desc']) ? $description['desc'] : $this->page_title;
    }

	

    public function webActionManagement(){
		$data['page_title'] = $this->page_title;
		$data['module_name']= "Menus";
		$data['menu'] = Menu::all();
		return view('setting.web_action',$data);
	}

	public function ajaxMenuList(){
		$mesuList = Menu::Select('module_name', 'id',  'menu_title',  'parent_id', 'menu_url','menu_icon_class','status')->where('status','1')->orderBy('created_at','desc')->get();		
		//dd($adminmenu);
		$return_arr = array();
		foreach($mesuList as $menu){			
			$menu['status']=($menu->status == 1)?"<button class='btn btn-xs btn-success' disabled>Active</button>":"<button class='btn btn-xs btn-success' disabled>In-active</button>";
			$menu['actions']="<button onclick='admin_menu_edit(".$menu->id.")' id=edit_" . $menu->id . "  class='btn btn-xs btn-green admin-menu-edit' ><i class='clip-pencil-3'></i></button>"
							." <button onclick='admin_menu_view(".$menu->id.")' id='view_" . $menu->id . "' class='btn btn-xs btn-primary admin-menu-view' ><i class='clip-zoom-in'></i></button>"
							." <button onclick='delete_admin_menu(".$menu->id.")' id='delete_" . $menu->id . "' class='btn btn-xs btn-danger admin-menu-delete' ><i class='clip-remove'></i></button>";
			$return_arr[] = $menu;
		}
		return json_encode(array('data'=>$return_arr));
       // return view('admin.manage', $data);
	}
}
