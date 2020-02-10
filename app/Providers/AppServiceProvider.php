<?php

namespace App\Providers;
use App\Setting;
use App\Menu;
use Illuminate\Support\ServiceProvider;

class AppServiceProvider extends ServiceProvider
{
    /**
     * Register any application services.
     *
     * @return void
     */
    public function register()
    {
        //
    }

    /**
     * Bootstrap any application services.
     *
     * @return void
     */
    public function boot()
    {
		//get the settings data from DB and deliver to master layout
		view()->composer('layout.master', function($view){
			$site_settings = Setting::first();
			$view->with('site_settings',$site_settings);
		});
		
		view()->composer('layout.sidebar', function($view){
			$menus = Menu::where('parent_id',0)->get();
			$menu_n_submenu_array = array();
			foreach($menus as $parent_menu){
				$submenus = Menu::where('parent_id',$parent_menu['id'])->get();
				if($submenus->count() >0){
					$parent_menu['sub_menus'] = $submenus;
				}
				$menu_n_submenu_array[] = $parent_menu;
			}
			$view->with('menus',$menu_n_submenu_array);
		});
		
    }
}
