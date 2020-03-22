<?php

#Login
Route::get('/login',array('as'=>'Sign in', 'uses' =>'SystemAuthController@authLogin'));
Route::get('/',array('as'=>'Sign in', 'uses' =>'SystemAuthController@authLogin'));
Route::get('/auth',array('as'=>'Sign in', 'uses' =>'SystemAuthController@authLogin'));
Route::get('auth/login',array('as'=>'Sign in', 'uses' =>'SystemAuthController@authLogin'));
Route::post('auth/post/login',array('as'=>'Sign in', 'uses' =>'SystemAuthController@authPostLogin'));

##App User Message 
Route::get('/message/app-user/{id}',array('as'=>'App User Message', 'uses' =>'AppUserController@appUserMessage'));
Route::post('app-user-message-save',array('as'=>'App User Message Save', 'uses' =>'AppUserController@appUserMessageSave'));


#ForgetPassword
Route::get('auth/forget/password',array('as'=>'Forgot Password' , 'uses' =>'SystemAuthController@forgetPasswordAuthPage'));
Route::post('auth/forget/password',array('as'=>'Forgot Password' , 'uses' =>'SystemAuthController@authForgotPasswordConfirm'));
Route::get('auth/forget/password/{user_id}/verify',array('as'=>'Forgot Password Verify' , 'uses' =>'SystemAuthController@authSystemForgotPasswordVerification'));
Route::post('auth/forget/password/{user_id}/verify',array('as'=>'New Password Submit' , 'uses' =>'SystemAuthController@authSystemNewPasswordPost'));


Route::group(['middleware' => ['auth']], function () {
    #logout


	Route::get('/',array('as'=>'Dashboard' , 'uses' =>'AdminController@index'));
    Route::get('auth/logout/{email}',array('as'=>'Logout' , 'uses' =>'SystemAuthController@authLogout'));
	Route::get('/dashboard',array('as'=>'Dashboard' , 'uses' =>'AdminController@index'));
	Route::get('/admin/ajax/admin-list',array('as'=>'Admin User List' , 'uses' =>'AdminController@ajaxAdminList'));
	Route::get('/admin/admin-view/{id}',array('as'=>'Admin View' , 'uses' =>'AdminController@adminUserView'));
	Route::get('/module/menu-list',array('as'=>'Menu List' , 'uses' =>'SettingController@ajaxMenuList'));
	Route::get('/module/get-parent-menu',array('as'=>'Parent Menu List' , 'uses' =>'SettingController@getParentMenu'));
	Route::get('/module/get-module-id/{module_name}',array('as'=>'Menu ID' , 'uses' =>'SettingController@getMenuID'));




	/*--------------Web Action start-------------*/
	Route::get('/web-action/get-module-name',array('as'=>'Web Action Management' , 'uses' =>'SettingController@getModuleName'));
	Route::get('/web-action/action-lists',array('as'=>'Web Action List' , 'uses' =>'SettingController@webActionList'));
	/*--------------Web Action End-------------*/

	/*--------------Admin User Groups start-------------*/
	Route::get('/admin/admin-group-list',array('as'=>'Admin Groups List' , 'uses' =>'AdminController@admin_groups_list'));
	/*--------------Groups End-------------*/

	/*--------------App User Start-------------*/
	Route::get('/app-user/app-user-list',array('as'=>'App User List' , 'uses' =>'AppUserController@app_user_list'));
	Route::get('/app-user/app-user-view/{id}',array('as'=>'App User View' , 'uses' =>'AppUserController@app_user_view'));
	Route::get('/app-user/load-app-user-groups',array('as'=>'App User Group List' , 'uses' =>'AppUserController@app_user_group_list_for_entry'));
	/*--------------App User End-------------*/

	/*-------------- User Group Start-------------*/
	Route::get('/admin/load-user-groups',array('as'=>'Load User Groups', 'uses' =>'AdminController@load_user_groups'));
	#data Table
	Route::get('/app-user/app-user-group-list',array('as'=>'Load User Groups', 'uses' =>'AppUserController@load_app_user_groups'));
	/*-------------- User Group End-------------*/

	/*-------------- Actions For Permission Start-------------*/
	Route::get('/admin/load-actions-for-group-permission/{id}',array('as'=>'Load Actions', 'uses' =>'AdminController@load_actions_for_group_permission'));

	/*-------------- Actions For Permission End-------------*/

    /*-------------- Surveys Start-------------*/
    Route::get('/settings/survey/survey-categories-list',array('as'=>'Get Surveys Category List', 'uses' =>'SettingController@survey_categories_get'));
    /*-------------- Surveys End-------------*/


    /*-------------- Messages Start-------------*/
	Route::get('messages/all-messages-management',array('as'=>'All Messages Management', 'uses' =>'MessageController@all_messages'));
	Route::get('/message/sent-message-list',array('as'=>'Sent Message List', 'uses' =>'MessageController@messageList'));
	Route::get('/message/message-view/{id}',array('as'=>'Sent Message View', 'uses' =>'MessageController@messageView'));

    Route::get('/settings/message/message-categories-list',array('as'=>'Get Message Category List', 'uses' =>'SettingController@message_categories_get'));

    /*-------------- Messages End-------------*/





	/*-------------- Courses Category Start-------------*/
	Route::get('/settings/courses/course-categories-list',array('as'=>'Get Courses Category List', 'uses' =>'SettingController@course_categories_get'));
	/*-------------- Courses Category End-------------*/


	/*-------------- Publication Start-------------*/
	Route::get('/setting/publication/publication-categories-list',array('as'=>'Get Publication Category', 'uses' =>'SettingController@publication_categories_get'));

	Route::get('/publication/publication-list',array('as'=>'Publication List', 'uses' =>'PublicationController@publicationList'));
	Route::get('/publication/load-publication-type',array('as'=>'Load Publication Type', 'uses' =>'PublicationController@publicationTypeList'));


	Route::get('/publication/publication-view/{id}',array('as'=>'Publication View', 'uses' =>'PublicationController@publicationView'));
	/*-------------- Publication End-------------*/



	/*-------------- Notice Start-------------*/
	Route::get('/settings/notice/notice-categories-list',array('as'=>'Get Notice Category List', 'uses' =>'SettingController@notice_categories_get'));
	Route::get('/notice/load-app-user-groups',array('as'=>'Get App User Group List', 'uses' =>'NoticeController@load_app_user_groups'));
	Route::get('/notice/notice-list',array('as'=>'Notice List', 'uses' =>'NoticeController@noticeList'));
	Route::get('/notice/notice-view/{id}',array('as'=>'Notice View', 'uses' =>'NoticeController@noticeView'));
	Route::post('/notice/app-user-name',array('as'=>'App User Name Auto-complete', 'uses' =>'NoticeController@appUserNameAutoComplete'));

	/*-------------- Notice End-------------*/

	/*-------------- Profile Start-------------*/
	Route::get('/profile/my-profile',array('as'=>'My Profile Management', 'uses' =>'ProfileController@index'));
	Route::get('/profile/my-profile-info',array('as'=>'Get My Profile Info', 'uses' =>'ProfileController@profile_info'));
	Route::post('/profile/my-profile-update',array('as'=>'Update My Profile Info', 'uses' =>'ProfileController@update_profile'));
	Route::post('/profile/password-update',array('as'=>'Update My Profile Info', 'uses' =>'ProfileController@update_password'));
	/*-------------- Profile End-------------*/

	##Getting Course Category For Add Courses
	Route::get('/course/get-course-categories',array('as'=>'Get Course Categories', 'uses' =>'CoursesController@getCategories'));

	Route::get('/course/course-list',array('as'=>'Get Course List', 'uses' =>'CoursesController@getCourseList'));


	##Chaki---------start
	##Getting Survey Type For Add Add Survey
    Route::get('/survey/get-survey-type',array('as'=>'Get Survey Types', 'uses' =>'SurveysController@getSurveyTypes'));
    Route::get('/survey/get-user-group',array('as'=>'Get Survey User Group', 'uses' =>'SurveysController@getUserGroup'));

    Route::get('/survey/survey-list',array('as'=>'Get Survey List', 'uses' =>'SurveysController@getSurveyList'));

    Route::get('/survey/survey-view/{id}',array('as'=>'Survey View', 'uses' =>'SurveysController@surveyView'));

    Route::get('/survey/survey-participant_view/{id}',array('as'=>'Survey Participants View', 'uses' =>'SurveysController@surveyParticipantView'));
    Route::get('/survey/survey-participant_result_view/{survey_id}/{id}',array('as'=>'Survey Participants Result View', 'uses' =>'SurveysController@surveyParticipantResultView'));


    //auto suggest
    Route::post('/survey/survey-name',array('as'=>'Survey Name Auto-complete', 'uses' =>'SurveysController@SurveyNameAutoComplete'));
    Route::post('/survey/participant-name',array('as'=>'Participant Name Auto-complete', 'uses' =>'SurveysController@ParticipantNameAutoComplete'));

    ##Chaki---------End


    Route::get('/course/course-list',array('as'=>'Get Course List', 'uses' =>'CoursesController@getCourseList'));



    ##Course View
	Route::get('/course/course-view/{id}',array('as'=>'Course View', 'uses' =>'CoursesController@courseView'));

	Route::get('/course/course-participant-list/{id}',array('as'=>'Perticipants List', 'uses' =>'CoursesController@interestedPerticipantsList'));

	##Save Selected Person
	Route::post('/course/save-select-person',array('as'=>'Save Selected Perticipants', 'uses' =>'CoursesController@saveSelectedPerson'));
	Route::post('/course/save-remove-person',array('as'=>'Save Remove Perticipants', 'uses' =>'CoursesController@saveRemovePerson'));

	Route::post('/course/teacher/admin-user-name',array('as'=>'Admin User Name Auto-complete', 'uses' =>'TeacherController@adminUserNameAutoComplete'));
	Route::get('/course/teacher/teacher-list',array('as'=>'Teacher List', 'uses' =>'TeacherController@teacherList'));
	Route::get('/course/teacher/teacher-view/{id}',array('as'=>'Teacher View', 'uses' =>'TeacherController@teacherView'));
	Route::get('/course/get-teacher',array('as'=>'Teacher View', 'uses' =>'CoursesController@getTeacher'));

	## Load App User For Message
	Route::get('/message/load-app-user',array('as'=>'Load App User', 'uses' =>'MessageController@loadAppUser'));
	##Load Messages for one-to-one Chat
	Route::post('/message/load-message',array('as'=>'Load Message', 'uses' =>'MessageController@loadMessage'));
	##Search App Users
	Route::post('/message/search-app-users',array('as'=>'Search App Users', 'uses' =>'MessageController@searchAppUsers'));

	##Sent message to user
	Route::post('/message/admin-message-sent-to-user',array('as'=>'Admin message Sent', 'uses' =>'MessageController@newMsgSent'));

	Route::get('/report/course/get-course-title',array('as'=>'Get course Title', 'uses' =>'CoursesController@getCourseTitle'));
	Route::post('/report/course/course-details',array('as'=>'Get course Title', 'uses' =>'CoursesController@getCourseDetailsReport'));
	## App user Report
	Route::get('/report/app-user',array('as'=>'App user report', 'uses' =>'AppUserController@appUserReport'));
	Route::post('/report/app-user-auto-suggest',array('as'=>'App user name auto-suggest', 'uses' =>'AppUserController@appUserNameAutoComplete'));
	Route::get('/report/app-user-report/{id}',array('as'=>'Get App user Report', 'uses' =>'AppUserController@getAppUserReport'));





});





Route::group(['middleware' => ['permission']], function () {
	/*----- Course Start -----*/
	Route::get('courses/open-course',array('as'=>'Course Management' , 'action_id'=>'24', 'uses' =>'CoursesController@index'));
	Route::post('/course/course-entry',array('as'=>'Course Entry' , 'action_id'=>'26', 'uses' =>'CoursesController@courseEntryUpdate'));
	Route::get('/course/course-edit/{id}',array('as'=>'Course Edit' , 'action_id'=>'76', 'uses' =>'CoursesController@courseEdit'));
	Route::get('/course/course-delete/{id}',array('as'=>'Course Delete' , 'action_id'=>'77', 'uses' =>'CoursesController@courseDelete'));
	/*----- Course End -----*/

	/*----- Survey Start -----*/
	Route::get('survey/management',array('as'=>'Surveys Management' , 'action_id'=>'27', 'uses' =>'SurveysController@index'));

    ##chaki-------------Start



    Route::post('/survey/survey-body-entry',array('as'=>'Survey Body Entry' , 'action_id'=>'28', 'uses' =>'SurveysController@surveyBodyEntry'));
    Route::post('/survey/survey-question-entry',array('as'=>'Survey Question Entry' , 'action_id'=>'28', 'uses' =>'SurveysController@surveyQuestionEntry'));
    Route::get('/survey/survey-edit/{id}',array('as'=>'Survey Edit' , 'action_id'=>'86', 'uses' =>'SurveysController@surveyEdit'));
    Route::get('/survey/question-edit/{id}',array('as'=>'Question Edit' , 'action_id'=>'86', 'uses' =>'SurveysController@questionEdit'));
    Route::get('/survey/question-delete/{id}',array('as'=>'Question Delete' , 'action_id'=>'86', 'uses' =>'SurveysController@questionDelete'));
    Route::get('/survey/answer-option-delete/{id}',array('as'=>'Answer Option Delete' , 'action_id'=>'86', 'uses' =>'SurveysController@answerDelete'));
    Route::post('/survey/survey-question-serialize',array('as'=>'Survey Question Serialization' , 'action_id'=>'86', 'uses' =>'SurveysController@surveyQuestionSerialize'));
    Route::get('/survey/survey-delete/{id}',array('as'=>'Survey Delete' , 'action_id'=>'87', 'uses' =>'SurveysController@surveyDelete'));

    ##chaki-------------End
    /*--------Report Start--------*/
    Route::get('report/survey-summary',array('as'=>'Survey Summary' , 'action_id'=>'27', 'uses' =>'SurveysController@surveySummery'));
    Route::get('report/survey-details',array('as'=>'Survey Details' , 'action_id'=>'27', 'uses' =>'SurveysController@surveyDetails'));
    Route::get('report/survey-data',array('as'=>'Survey Data' , 'action_id'=>'27', 'uses' =>'SurveysController@surveyData'));
    Route::get('report/survey-participants',array('as'=>'Survey Participant' , 'action_id'=>'27', 'uses' =>'SurveysController@surveyParticipant'));
    Route::get('report/survey-participants-answers',array('as'=>'Survey Participant Answers' , 'action_id'=>'27', 'uses' =>'SurveysController@surveyParticipantAnswer'));


    Route::post('/survey/report/survey-summary',array('as'=>'Survey Summary Report' , 'action_id'=>'27', 'uses' =>'SurveysController@surveySummeryReport'));
    
    ## Siam Start
    Route::get('report/course-summary',array('as'=>'Course Summary Report' , 'action_id'=>'25', 'uses' =>'CoursesController@courseSummery'));
    Route::post('/report/course/get-course-summary',array('as'=>'Get Course Summary Report' , 'action_id'=>'25', 'uses' =>'CoursesController@getCourseSummery'));
    Route::get('/report/course-details',array('as'=>'Get Course Details' , 'action_id'=>'25', 'uses' =>'CoursesController@getCourseDetails'));
    Route::post('/report/course/course-name',array('as'=>'Get Course Name' , 'action_id'=>'25', 'uses' =>'CoursesController@getCourseNameAutoComplete'));
    ## Siam End

    /*--------Report End--------*/


    /*----- Survey End -----*/

	/*----- Admin User Start -----*/
	Route::get('user/admin/admin-user-management',array('as'=>'Admin Users' , 'action_id'=>'1', 'uses' =>'AdminController@adminUserManagement'));
	Route::post('/admin/admin-user-entry',array('as'=>'Admin User Entry', 'action_id'=>'2', 'uses' =>'AdminController@ajaxAdminEntry'));
	Route::get('/admin/delete/{id}',array('as'=>'Admin Delete', 'action_id'=>'6', 'uses' =>'AdminController@adminDestroy'));
	Route::get('/admin/edit/{id}',array('as'=>'Admin Edit', 'action_id'=>'4', 'uses' =>'AdminController@adminUserEdit'));
	/*----- Admin User End -----*/

	/*--------------App User Start-------------*/
	Route::get('user/app-user/app-user-management',array('as'=>'App User Management', 'action_id'=>'7', 'uses' =>'AppUserController@index'));
	Route::post('/app-user/app-user-entry',array('as'=>'App User Entry' ,'action_id'=>'9', 'uses' =>'AppUserController@app_user_entry_update'));
	Route::get('/app-user/app-user-editedit/{id}',array('as'=>'App User Edit', 'action_id'=>'9', 'uses' =>'AppUserController@app_user_edit'));
	Route::get('/app-user/app-user-delete/{id}',array('as'=>'App User Delete', 'action_id'=>'10', 'uses' =>'AppUserController@app_user_delete'));
	/*--------------App User End-------------*/

	/*--------------Web Action start-------------*/
	Route::get('cp/web-action/web-action-management',array('as'=>'Web Action Management', 'action_id'=>'32', 'uses' =>'SettingController@webActionManagement'));
	Route::post('/web-action/web-action-entry',array('as'=>'Web Action Entry', 'action_id'=>'30', 'uses' =>'SettingController@webActionEntry'));
	Route::get('/web-action/edit/{id}',array('as'=>'Web Action Edit', 'action_id'=>'31', 'uses' =>'SettingController@web_action_edit'));
	/*--------------Web Action End-------------*/


	/*--------------General Setting Start-------------*/
	Route::get('cp/general/general-setting',array('as'=>'General Setting Management', 'action_id'=>'33', 'uses' =>'SettingController@generalSetting'));
	Route::post('/general/setting-update',array('as'=>'General Setting Update', 'action_id'=>'33', 'uses' =>'SettingController@generalSettingUpdate'));
	/*--------------General Setting End-------------*/


	/*-------------- Manage Module Start-------------*/
	Route::get('cp/module/manage-module',array('as'=>'Manage Module' , 'action_id'=>'35', 'uses' =>'SettingController@moduleManagement'));
	Route::post('/module/module-entry/',array('as'=>'Module Entry' , 'action_id'=>'36', 'uses' =>'SettingController@moduleEntry'));
	Route::get('/module/edit/{id}',array('as'=>'Module Edit' , 'action_id'=>'37', 'uses' =>'SettingController@moduleEdit'));
	Route::get('/module/delete/{id}',array('as'=>'Module Edit' , 'action_id'=>'38', 'uses' =>'SettingController@moduleDelete'));
	/*-------------- Manage Module End-------------*/


	/*-------------- Admin User Group Start-------------*/
	Route::get('settings/admin/admin-group-management',array('as'=>'Admin User Groups Management', 'action_id'=>'39', 'uses' =>'AdminController@admin_user_groups'));
	Route::post('/admin/admin-group-entry',array('as'=>'Admin Groups Entry', 'action_id'=>'40', 'uses' =>'AdminController@admin_groups_entry_or_update'));
	Route::get('/admin/admin-group-edit/{id}',array('as'=>'Admin Groups Edit', 'action_id'=>'42', 'uses' =>'AdminController@admin_group_edit'));
	Route::get('/admin/admin-group-delete/{id}',array('as'=>'Admin Groups Delete', 'action_id'=>'43', 'uses' =>'AdminController@admin_group_delete'));
	##Permission
	Route::post('/admin/permission-action-entry-update',array('as'=>'Permission Entry', 'action_id'=>'41', 'uses' =>'AdminController@permission_action_entry_update'));
	/*-------------- Admin User Group End-------------*/

	/*-------------- App User Group End-------------*/
	Route::get('settings/app-user/app-user-group-management',array('as'=>'App User Group Management', 'action_id'=>'44', 'uses' =>'AppUserController@app_user_management'));
	/*-------------- App User Group End-------------*/

	/*-------------- Publication Category Start-------------*/
	Route::get('settings/publication/publication-category',array('as'=>'Publication Category Management', 'action_id'=>'48', 'uses' =>'SettingController@publication_category_management'));
	Route::post('/settings/publication/publication-category-entry',array('as'=>'Publication Category Entry', 'action_id'=>'49', 'uses' =>'SettingController@publication_category_entry_update'));
	Route::get('/setting/publication/publication-categories-edit/{id}',array('as'=>'Edit Publication Category', 'action_id'=>'50', 'uses' =>'SettingController@publication_category_edit'));
	Route::get('/setting/publication/publication-category-delete/{id}',array('as'=>'Delete Publication Category', 'action_id'=>'51', 'uses' =>'SettingController@publication_category_delete'));
	/*-------------- Publication Category End-------------*/

	/*-------------- Courses Category Start-------------*/
	Route::get('settings/courses/manage-courses-category',array('as'=>'Courses Category Management', 'action_id'=>'52', 'uses' =>'SettingController@courses_category_management'));
	Route::post('/settings/courses/course-category-entry',array('as'=>'Courses Category Entry', 'action_id'=>'53', 'uses' =>'SettingController@course_category_entry_update'));
Route::get('/settings/courses/course-categories-edit/{id}',array('as'=>'Get Courses Category Edit', 'action_id'=>'54', 'uses' =>'SettingController@course_category_edit'));
	Route::get('/setting/course/course-category-delete/{id}',array('as'=>'Get Courses Category Delete', 'action_id'=>'55', 'uses' =>'SettingController@course_category_delete'));
	/*-------------- Courses Category End-------------*/


	/*-------------- Notice Category Start-------------*/
	Route::get('settings/notice/manage-notice-category',array('as'=>'Notice Category Management', 'action_id'=>'56', 'uses' =>'SettingController@notice_category_management'));
	Route::post('/settings/notice/notice-category-entry',array('as'=>'Notice Category Entry', 'action_id'=>'57', 'uses' =>'SettingController@notice_category_entry_update'));
Route::get('/settings/notice/notice-categories-edit/{id}',array('as'=>'Edit Notice Category', 'action_id'=>'58', 'uses' =>'SettingController@notice_category_edit'));
	Route::get('/setting/notice/notice-category-delete/{id}',array('as'=>'Delete Notice Category', 'action_id'=>'59', 'uses' =>'SettingController@notice_category_delete'));
	/*-------------- Notice Category End-------------*/


	/*-------------- Survey Category Start-------------*/
	Route::get('settings/survey/manage-survey-category',array('as'=>'Surveys Category Management', 'action_id'=>'60', 'uses' =>'SettingController@survey_category_management'));
	Route::post('/settings/survey/survey-category-entry',array('as'=>'Surveys Category Entry', 'action_id'=>'61', 'uses' =>'SettingController@survey_category_entry_update'));
Route::get('/settings/survey/survey-categories-edit/{id}',array('as'=>'Edit Surveys Category', 'action_id'=>'62', 'uses' =>'SettingController@survey_category_edit'));
	Route::get('/settings/survey/survey-categories-delete/{id}',array('as'=>'Delete Surveys Category', 'action_id'=>'63', 'uses' =>'SettingController@survey_category_delete'));
	/*-------------- Survey Category End-------------*/


    /*-------------- Message Category Start-------------*/
    Route::get('settings/message/message-category',array('as'=>'Message Category Management', 'action_id'=>'82', 'uses' =>'SettingController@message_category_management'));
    Route::post('/settings/message/message-category-entry',array('as'=>'Message Category Entry', 'action_id'=>'83', 'uses' =>'SettingController@message_category_entry_update'));
    Route::get('/settings/message/message-category-edit/{id}',array('as'=>'Edit Message Category', 'action_id'=>'84', 'uses' =>'SettingController@message_category_edit'));
    Route::get('/settings/message/message-category-delete/{id}',array('as'=>'Delete Message Category', 'action_id'=>'85', 'uses' =>'SettingController@message_category_delete'));
    /*-------------- Message Category End-------------*/


	/*-------------- Notice Management Start -------------*/
	Route::get('notice/manage-notice',array('as'=>'Notice Management', 'action_id'=>'64', 'uses' =>'NoticeController@noticeManagement'));
	Route::post('/notice/notice-entry',array('as'=>'Notice Entry', 'action_id'=>'65', 'uses' =>'NoticeController@noticeEntry'));
	Route::get('/notice/notice-edit/{id}',array('as'=>'Notice Edit', 'action_id'=>'66', 'uses' =>'NoticeController@noticeEdit'));
	Route::get('/notice/notice-delete/{id}',array('as'=>'Notice Delete', 'action_id'=>'67', 'uses' =>'NoticeController@noticeDelete'));
	/*--------------  Notice Management End  -------------*/


	/*--------------  Publication Management Start  -------------*/
	Route::get('publication/publication-management',array('as'=>'Publication Management', 'action_id'=>'68', 'uses' =>'PublicationController@index'));
	Route::post('/publication/publication-entry',array('as'=>'Publication Entry', 'action_id'=>'69', 'uses' =>'PublicationController@publicationEntry'));
	Route::get('/publication/publication-edit/{id}',array('as'=>'Publication Edit', 'action_id'=>'70', 'uses' =>'PublicationController@publicationEdit'));
	Route::get('/publication/publication-delete/{id}',array('as'=>'Publication Delete', 'action_id'=>'71', 'uses' =>'PublicationController@publicationDelete'));
	/*--------------  Publication Management End  -------------*/


	/*--------------  Sent Message Management Start  -------------*/
	Route::get('messages/sent-message',array('as'=>'Sent Message Management', 'action_id'=>'72', 'uses' =>'MessageController@sentMessageManage'));
	Route::post('/message/message-entry',array('as'=>'Message Entry', 'action_id'=>'73', 'uses' =>'MessageController@messageEntry'));
	Route::get('/message/message-delete/{id}',array('as'=>'Message Delete', 'action_id'=>'75', 'uses' =>'MessageController@messageDelete'));
	/*--------------  Sent Message Management End  -------------*/

	/*--------------  Manage Teacher Start  -------------*/
	Route::get('course/teacher/manage-teacher',array('as'=>'Manage Teacher', 'action_id'=>'88', 'uses' =>'TeacherController@index'));
	Route::post('/course/teacher/teacher-entry',array('as'=>'Teacher Entry', 'action_id'=>'89', 'uses' =>'TeacherController@teacherEntryUpdate'));
	Route::get('/course/teacher/teacher-edit/{id}',array('as'=>'Teacher Update', 'action_id'=>'90', 'uses' =>'TeacherController@teacherEdit'));
	Route::get('/course/teacher/teacher-delete/{id}',array('as'=>'Teacher Delete', 'action_id'=>'91', 'uses' =>'TeacherController@teacherDelete'));
	/*--------------  Manage Teacher End  -------------*/





});

