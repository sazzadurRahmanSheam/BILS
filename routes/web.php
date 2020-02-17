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



Route::group(['middleware' => ['auth']], function () {
    #logout
    Route::get('auth/logout/{email}',array('as'=>'Logout' , 'uses' =>'SystemAuthController@authLogout'));	
	Route::get('/dashboard',array('as'=>'Dashboard' , 'uses' =>'AdminController@index'));
	Route::get('user/admin/admin-user-management',array('as'=>'Admin Users' , 'uses' =>'AdminController@adminUserManagement'));
	Route::get('/admin/ajax/admin-list',array('as'=>'Admin User List' , 'uses' =>'AdminController@ajaxAdminList'));
	Route::post('/admin/admin-user-entry',array('as'=>'Admin User Entry' , 'uses' =>'AdminController@ajaxAdminEntry'));

	Route::get('/admin/delete/{id}',array('as'=>'Admin Delete' , 'uses' =>'AdminController@adminDestroy'));
	Route::get('/admin/admin-view/{id}',array('as'=>'Admin View' , 'uses' =>'AdminController@adminUserView'));
	Route::get('/admin/edit/{id}',array('as'=>'Admin Edit' , 'uses' =>'AdminController@adminUserEdit'));
	Route::get('cp/general/general-setting',array('as'=>'General Setting' , 'uses' =>'SettingController@generalSetting'));
	Route::post('/general/setting-update',array('as'=>'General Setting Update' , 'uses' =>'SettingController@generalSettingUpdate'));
	
	Route::get('cp/module/manage-module',array('as'=>'Manage Module' , 'uses' =>'SettingController@moduleManagement'));

	Route::get('/module/menu-list',array('as'=>'Menu List' , 'uses' =>'SettingController@ajaxMenuList'));
	
	Route::get('/module/get-parent-menu',array('as'=>'Parent Menu List' , 'uses' =>'SettingController@getParentMenu'));
	
	Route::get('/module/get-module-id/{module_name}',array('as'=>'Menu ID' , 'uses' =>'SettingController@getMenuID'));
	
	Route::post('/module/module-entry/',array('as'=>'Module Entry' , 'uses' =>'SettingController@moduleEntry'));

	Route::get('/module/edit/{id}',array('as'=>'Module Edit' , 'uses' =>'SettingController@moduleEdit'));
	Route::get('/module/delete/{id}',array('as'=>'Module Edit' , 'uses' =>'SettingController@moduleDelete'));

	/*--------------Web Action start-------------*/
	Route::get('cp/web-action/web-action-management',array('as'=>'Web Action Management' , 'uses' =>'SettingController@webActionManagement'));
	Route::get('/web-action/get-module-name',array('as'=>'Web Action Management' , 'uses' =>'SettingController@getModuleName'));
	Route::post('/web-action/web-action-entry',array('as'=>'Web Action Entry' , 'uses' =>'SettingController@webActionEntry'));
	Route::get('/web-action/action-lists',array('as'=>'Web Action List' , 'uses' =>'SettingController@webActionList'));
	Route::get('/web-action/edit/{id}',array('as'=>'Web Action Edit' , 'uses' =>'SettingController@web_action_edit'));
	/*--------------Web Action End-------------*/
	
	/*--------------Admin User Groups start-------------*/
	Route::get('settings/admin/admin-group-management',array('as'=>'Admin User Groups Management' , 'uses' =>'AdminController@admin_user_groups'));
	##Updating
	Route::post('/admin/admin-group-entry',array('as'=>'Admin Groups Entry' , 'uses' =>'AdminController@admin_groups_entry_or_update'));
	Route::get('/admin/admin-group-list',array('as'=>'Admin Groups List' , 'uses' =>'AdminController@admin_groups_list'));
	Route::get('/admin/admin-group-edit/{id}',array('as'=>'Admin Groups Edit' , 'uses' =>'AdminController@admin_group_edit'));
	Route::get('/admin/admin-group-delete/{id}',array('as'=>'Admin Groups Delete' , 'uses' =>'AdminController@admin_group_delete'));
	/*--------------Groups End-------------*/

	/*--------------App User Start-------------*/
	Route::get('user/app-user/app-user-management',array('as'=>'App User Management' , 'uses' =>'AppUserController@index'));
	Route::post('/app-user/app-user-entry',array('as'=>'App User Entry' , 'uses' =>'AppUserController@app_user_entry_update'));
	Route::get('/app-user/app-user-list',array('as'=>'App User Entry' , 'uses' =>'AppUserController@app_user_list'));
	Route::get('/app-user/app-user-delete/{id}',array('as'=>'App User Delete' , 'uses' =>'AppUserController@app_user_delete'));
	Route::get('/app-user/app-user-editedit/{id}',array('as'=>'App User Edit' , 'uses' =>'AppUserController@app_user_edit'));
	Route::get('/app-user/app-user-view/{id}',array('as'=>'App User View' , 'uses' =>'AppUserController@app_user_view'));
	Route::get('settings/app-user/app-user-group-management',array('as'=>'App User Group Management' , 'uses' =>'AppUserController@app_user_management'));
	Route::get('/app-user/load-app-user-groups',array('as'=>'App User Group List' , 'uses' =>'AppUserController@app_user_group_list_for_entry'));
	/*--------------App User End-------------*/

	/*--------------User Group Start-------------*/
	Route::get('/admin/load-user-groups',array('as'=>'Load User Groups', 'uses' =>'AdminController@load_user_groups'));
	#data Table
	Route::get('/app-user/app-user-group-list',array('as'=>'Load User Groups', 'uses' =>'AppUserController@load_app_user_groups'));
	/*--------------User Group End-------------*/

	/*-------------- Actions For Permission Start-------------*/
	Route::get('/admin/load-actions-for-group-permission/{id}',array('as'=>'Load Actions', 'uses' =>'AdminController@load_actions_for_group_permission'));
	Route::post('/admin/permission-action-entry-update',array('as'=>'Permission Entry', 'uses' =>'AdminController@permission_action_entry_update'));
	/*-------------- Actions For Permission End-------------*/




	/*-------------- Messages Start-------------*/
	Route::get('messages/all-messages-management',array('as'=>'All Messages Management', 'uses' =>'MessageController@all_messages'));
	/*-------------- Messages End-------------*/



	/*-------------- Surveys Start-------------*/
	Route::get('survey/management',array('as'=>'Surveys Management', 'uses' =>'SurveysController@index'));
	Route::get('settings/survey/manage-survey-category',array('as'=>'Surveys Category Management', 'uses' =>'SettingController@survey_category_management'));
	Route::post('/settings/survey/survey-category-entry',array('as'=>'Surveys Category Entry', 'uses' =>'SettingController@survey_category_entry_update'));
	Route::get('/settings/survey/survey-categories-list',array('as'=>'Get Surveys Category List', 'uses' =>'SettingController@survey_categories_get'));
	Route::get('/settings/survey/survey-categories-edit/{id}',array('as'=>'Edit Surveys Category', 'uses' =>'SettingController@survey_category_edit'));
	Route::get('/settings/survey/survey-categories-delete/{id}',array('as'=>'Delete Surveys Category', 'uses' =>'SettingController@survey_category_delete'));
	/*-------------- Surveys End-------------*/


	/*-------------- Courses Start-------------*/
	Route::get('courses/open-course',array('as'=>'Open Course', 'uses' =>'CoursesController@index'));
	Route::get('settings/courses/manage-courses-category',array('as'=>'Courses Category Management', 'uses' =>'SettingController@courses_category_management'));
	Route::post('/settings/courses/course-category-entry',array('as'=>'Courses Category Entry', 'uses' =>'SettingController@course_category_entry_update'));
	Route::get('/settings/courses/course-categories-list',array('as'=>'Get Courses Category List', 'uses' =>'SettingController@course_categories_get'));
	Route::get('/settings/courses/course-categories-edit/{id}',array('as'=>'Get Courses Category Edit', 'uses' =>'SettingController@course_category_edit'));
	Route::get('/setting/course/course-category-delete/{id}',array('as'=>'Get Courses Category Delete', 'uses' =>'SettingController@course_category_delete'));
	/*-------------- Courses End-------------*/


	/*-------------- Publication Start-------------*/
	Route::get('settings/publication/publication-category',array('as'=>'Publication Category Management', 'uses' =>'SettingController@publication_category_management'));
	Route::post('/settings/publication/publication-category-entry',array('as'=>'Publication Category Entry', 'uses' =>'SettingController@publication_category_entry_update'));
	Route::get('/setting/publication/publication-categories-list',array('as'=>'Get Publication Category', 'uses' =>'SettingController@publication_categories_get'));
	Route::get('/setting/publication/publication-categories-edit/{id}',array('as'=>'Edit Publication Category', 'uses' =>'SettingController@publication_category_edit'));
	Route::get('/setting/publication/publication-category-delete/{id}',array('as'=>'Delete Publication Category', 'uses' =>'SettingController@publication_category_delete'));
	/*-------------- Publication End-------------*/



	/*-------------- Notice Start-------------*/
	Route::get('settings/notice/manage-notice-category',array('as'=>'Notice Category Management', 'uses' =>'SettingController@notice_category_management'));
	Route::post('/settings/notice/notice-category-entry',array('as'=>'Notice Category Entry', 'uses' =>'SettingController@notice_category_entry_update'));
	Route::get('/settings/notice/notice-categories-list',array('as'=>'Get Notice Category List', 'uses' =>'SettingController@notice_categories_get'));
	Route::get('/settings/notice/notice-categories-edit/{id}',array('as'=>'Edit Notice Category', 'uses' =>'SettingController@notice_category_edit'));
	Route::get('/setting/notice/notice-category-delete/{id}',array('as'=>'Delete Notice Category', 'uses' =>'SettingController@notice_category_delete'));

	/*-------------- Notice End-------------*/



	


	
});
