<?php

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

#Login

Route::get('/login',array('as'=>'Sign in', 'uses' =>'SystemAuthController@authLogin'));
Route::get('/',array('as'=>'Sign in', 'uses' =>'SystemAuthController@authLogin'));
Route::get('/auth',array('as'=>'Sign in', 'uses' =>'SystemAuthController@authLogin'));
Route::get('auth/login',array('as'=>'Sign in', 'uses' =>'SystemAuthController@authLogin'));
Route::post('auth/post/login',array('as'=>'Sign in' , 'uses' =>'SystemAuthController@authPostLogin'));



#ForgetPassword
Route::get('auth/forget/password',array('as'=>'Forgot Password' , 'uses' =>'SystemAuthController@forgetPasswordAuthPage'));
Route::post('auth/forget/password',array('as'=>'Forgot Password' , 'uses' =>'SystemAuthController@authForgotPasswordConfirm'));
Route::get('auth/forget/password/{user_id}/verify',array('as'=>'Forgot Password Verify' , 'uses' =>'SystemAuthController@authSystemForgotPasswordVerification'));
Route::post('auth/forget/password/{user_id}/verify',array('as'=>'New Password Submit' , 'uses' =>'SystemAuthController@authSystemNewPasswordPost'));



Route::group(['middleware' => ['auth']], function () {
    #logout
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
	Route::get('/module/webaction-management',array('as'=>'Web Action' , 'uses' =>'MenuController@webActionManagement'));

	Route::get('/module/menu-list',array('as'=>'Menu List' , 'uses' =>'MenuController@ajaxMenuList'));
	
	
});



/*

Route::get('/', function () {
    return view('welcome');
});

Auth::routes();

Route::get('/home', 'HomeController@index')->name('home');
*/
