<?php

#Login

Route::get('/login',array('as'=>'Sign in', 'uses' =>'SystemAuthController@authLogin'));
Route::get('/',array('as'=>'Sign in', 'uses' =>'SystemAuthController@authLogin'));
Route::get('/auth',array('as'=>'Sign in', 'uses' =>'SystemAuthController@authLogin'));
Route::get('auth/login',array('as'=>'Sign in', 'uses' =>'SystemAuthController@authLogin'));
Route::post('auth/post/login',array('as'=>'Sign in', 'uses' =>'SystemAuthController@authPostLogin'));



#ForgetPassword
Route::get('auth/forget/password',array('as'=>'Forgot Password' , 'uses' =>'SystemAuthController@forgetPasswordAuthPage'));
Route::post('auth/forget/password',array('as'=>'Forgot Password' , 'uses' =>'SystemAuthController@authForgotPasswordConfirm'));
Route::get('auth/forget/password/{user_id}/verify',array('as'=>'Forgot Password Verify' , 'uses' =>'SystemAuthController@authSystemForgotPasswordVerification'));
Route::post('auth/forget/password/{user_id}/verify',array('as'=>'New Password Submit' , 'uses' =>'SystemAuthController@authSystemNewPasswordPost'));


Route::get('survey/management', function (){echo "Stop Here";}/*array('as'=>'Surveys Management' , 'uses' =>'SurveysController@index')*/);

Route::group(['middleware' => ['auth']], function () {
    #logout
	
	//echo "hold on";die;
	Route::get('/',array('as'=>'Dashboard' , 'uses' =>'AdminController@index'));
    Route::get('auth/logout/{email}',array('as'=>'Logout' , 'uses' =>'SystemAuthController@authLogout'));	
	Route::get('/dashboard',array('as'=>'Dashboard' , 'uses' =>'AdminController@index'));
	Route::get('/admin/admin-user-management',array('as'=>'Admin Users' , 'uses' =>'AdminController@adminUserManagement'));
	Route::get('/admin/ajax/admin-list',array('as'=>'Admin User List' , 'uses' =>'AdminController@ajaxAdminList'));
	Route::post('/admin/admin-user-entry',array('as'=>'Admin User Entry' , 'uses' =>'AdminController@ajaxAdminEntry'));

	Route::get('/admin/delete/{id}',array('as'=>'Admin Delete' , 'uses' =>'AdminController@adminDestroy'));
	Route::get('/admin/admin-view/{id}',array('as'=>'Admin View' , 'uses' =>'AdminController@adminUserView'));
	Route::get('/admin/edit/{id}',array('as'=>'Admin Edit' , 'uses' =>'AdminController@adminUserEdit'));
	Route::get('/general/setting',array('as'=>'General Setting' , 'uses' =>'SettingController@generalSetting'));
	Route::post('/general/setting-update',array('as'=>'General Setting Update' , 'uses' =>'SettingController@generalSettingUpdate'));
	
	Route::get('/module/manage-module',array('as'=>'Manage Module' , 'uses' =>'SettingController@moduleManagement'));
	Route::get('/module/menu-list',array('as'=>'Menu List' , 'uses' =>'SettingController@ajaxMenuList'));	
	Route::get('/module/get-parent-menu',array('as'=>'Parent Menu List' , 'uses' =>'SettingController@getParentMenu'));	
	Route::get('/module/get-module-id/{module_name}',array('as'=>'Menu ID' , 'uses' =>'SettingController@getMenuID'));	
	Route::post('/module/module-entry/',array('as'=>'Module Entry' , 'uses' =>'SettingController@moduleEntry'));
	Route::get('/module/edit/{id}',array('as'=>'Module Edit' , 'uses' =>'SettingController@moduleEdit'));
	Route::get('/module/delete/{id}',array('as'=>'Module Edit' , 'uses' =>'SettingController@moduleDelete'));

	/*--------------Web Action start-------------*/
	Route::get('/web/action-management',array('as'=>'Web Action Management' , 'uses' =>'SettingController@webActionManagement'));
	Route::get('/web-action/get-module-name',array('as'=>'Web Action Management' , 'uses' =>'SettingController@getModuleName'));
	Route::post('/web-action/web-action-entry',array('as'=>'Web Action Entry' , 'uses' =>'SettingController@webActionEntry'));
	Route::get('/web-action/action-lists',array('as'=>'Web Action List' , 'uses' =>'SettingController@webActionList'));
	Route::get('/web-action/edit/{id}',array('as'=>'Web Action Edit' , 'uses' =>'SettingController@web_action_edit'));
	/*--------------Web Action End-------------*/
	
	/*--------------Admin User Groups start-------------*/
	Route::get('admin/admin-group-management',array('as'=>'Admin User Groups Management' , 'uses' =>'AdminController@admin_user_groups'));
	##Updating
	Route::post('/admin/admin-group-entry',array('as'=>'Admin Groups Entry' , 'uses' =>'AdminController@admin_groups_entry_or_update'));
	Route::get('/admin/admin-group-list',array('as'=>'Admin Groups List' , 'uses' =>'AdminController@admin_groups_list'));
	Route::get('/admin/admin-group-edit/{id}',array('as'=>'Admin Groups Edit' , 'uses' =>'AdminController@admin_group_edit'));
	Route::get('/admin/admin-group-delete/{id}',array('as'=>'Admin Groups Delete' , 'uses' =>'AdminController@admin_group_delete'));
	/*--------------Groups End-------------*/

	/*--------------App User Start-------------*/
	Route::get('app-user/app-user-management',array('as'=>'App User Management' , 'uses' =>'AppUserController@index'));
	Route::post('/app-user/app-user-entry',array('as'=>'App User Entry' , 'uses' =>'AppUserController@app_user_entry_update'));
	Route::get('/app-user/app-user-list',array('as'=>'App User Entry' , 'uses' =>'AppUserController@app_user_list'));
	Route::get('/app-user/app-user-delete/{id}',array('as'=>'App User Delete' , 'uses' =>'AppUserController@app_user_delete'));
	Route::get('/app-user/app-user-editedit/{id}',array('as'=>'App User Edit' , 'uses' =>'AppUserController@app_user_edit'));
	Route::get('/app-user/app-user-view/{id}',array('as'=>'App User View' , 'uses' =>'AppUserController@app_user_view'));
	Route::get('app-user/app-user-group-management',array('as'=>'App User Group Management' , 'uses' =>'AppUserController@app_user_management'));
	/*--------------App User End-------------*/

	/*--------------User Group Start-------------*/
	Route::get('/admin/load-user-groups',array('as'=>'Load User Groups' , 'uses' =>'AdminController@load_user_groups'));
	Route::get('/app-user/app-user-group-list',array('as'=>'Load User Groups' , 'uses' =>'AppUserController@load_app_user_groups'));
	/*--------------User Group End-------------*/

	/*-------------- Actions For Permission Start-------------*/
	Route::get('/admin/load-actions-for-group-permission/{id}',array('as'=>'Load Actions' , 'uses' =>'AdminController@load_actions_for_group_permission'));
	Route::post('/admin/permission-action-entry-update',array('as'=>'Permission Entry' , 'uses' =>'AdminController@permission_action_entry_update'));
	/*-------------- Actions For Permission End-------------*/

	/*-------------- Messages Start-------------*/
	Route::get('messages/all-messages-management',array('as'=>'All Messages Management' , 'uses' =>'MessageController@all_messages'));
	/*-------------- Messages End-------------*/


	/*-------------- Surveys Start-------------*/
	Route::get('survey/management',array('as'=>'Surveys Management' , 'uses' =>'SurveysController@index'));
	/*-------------- Surveys End-------------*/


	/*-------------- Courses Start-------------*/
	Route::get('cources/open-course',array('as'=>'Open Course' , 'uses' =>'CoursesController@index'));
	/*-------------- Courses End-------------*/


	
});
