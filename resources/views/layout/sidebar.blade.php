<div class="main-navigation navbar-collapse collapse">
    <div class="navigation-toggler">
        <i class="clip-chevron-left"></i>
        <i class="clip-chevron-right"></i>
    </div>
    <!-- end: MAIN MENU TOGGLER BUTTON -->
    <!-- start: MAIN NAVIGATION MENU -->
    <ul class="main-navigation-menu">
		<li class="{{isset($page_title) && ($page_title=='Dashboard') ? 'active' : ''}} ">
			<a href="{{url('dashboard')}}"><i class="clip-home-3"></i>
				<span class="title"> Dashboard </span>
				<span class="selected"></span>
			</a>
		</li>
		@foreach($menus as $menu)		
			<li class="{{isset($module_name) && ($module_name==$menu['module_name']) ? 'active' : ''}} ">
				<a href="{{$menu['menu_url'] === "" ? 'javascript:void(0)' : url($menu['menu_url'])}}"><i class="{{$menu['menu_icon_class']}}"></i>
					<span class="title"> {{$menu['menu_title']}} </span>
					@if(isset($menu['sub_menus']))
						<i class="icon-arrow"></i>
					@endif
					<span class="selected"></span>
				</a>
				@if(isset($menu['sub_menus']))				
					<ul class="sub-menu">
						@foreach($menu['sub_menus'] as $sub_menu)		
						<li>
							<a href="{{url($sub_menu['menu_url'])}}">
								<span class="title">{{$sub_menu['menu_title']}} </span>
							</a>
						</li>
						@endforeach
					</ul>
				@endif				
			</li>
		@endforeach
    </ul>
    <!-- end: MAIN NAVIGATION MENU -->
</div>
