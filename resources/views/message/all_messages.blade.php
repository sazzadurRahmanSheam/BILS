@extends('layout.master')

@section('style')
	<link rel="stylesheet" type="text/css" href="{{ asset('assets/css/bils/messages.css') }}">

@endsection

@section('content')
	
	


	<div class="col-md-12" style="padding: 0;">
		<div id="frame">

	
	<div class="content">
		<div class="contact-profile">
			<img src="http://emilcarlsson.se/assets/harveyspecter.png" alt="" />
			<p id="app_user_name"></p>
			<div class="social-media">
				<div id="load_more_message">
					
				</div>
			</div>
		</div>
		<div class="messages">
			<ul style="padding-left: 0;">
				<div class="message_body">
					
				</div>
				{{-- <li class="sent">
					<img src="http://emilcarlsson.se/assets/mikeross.png" alt="" />
					<p>How the hell am I supposed to get a jury to believe you when I am not even sure that I do?!</p>
				</li>
				
				<li class="replies">
					<img src="http://emilcarlsson.se/assets/harveyspecter.png" alt="" />
					<p>When you're backed against the wall, break the god damn thing down.</p>
				</li> --}}
				
			</ul>
		</div>
		<div class="message-input">

			<div class="wrap">
				<form id="sent_message_to_user" name="sent_message_to_user" enctype="multipart/form-data" class="form form-horizontal form-label-left">
					@csrf
					<input type="hidden" name="app_user_id" id="app_user_id">
					<input type="text" name="admin_message" id="admin_message" placeholder="Write your message..." />
					<label for="attachment" class="custom-file-upload">
    					<i class="fa fa-paperclip attachment" aria-hidden="true"></i>
					</label>
					<input multiple id="attachment" name="attachment[]" type="file"/>

					<button type="submit" class="submit" id="message_sent_to_user"><i class="fa fa-paper-plane" aria-hidden="true"></i></button>
				</form>
			</div>
		</div>
	</div>


	{{-- <label for="file-upload" class="custom-file-upload">
    Custom Upload
</label>
<input id="file-upload" type="file"/> --}}
		

		{{-- <input type="file" id="file" />
		<label for="file" class="btn-3"><span>select</span></label> --}}

	

   
 
    {{-- <div class="input-group">
      <input type="text" class="form-control" aria-label="...">
      <div class="input-group-btn">
        <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Action <span class="caret"></span></button>
        <ul class="dropdown-menu dropdown-menu-right">
          <li><a href="#">Action</a></li>
          <li><a href="#">Another action</a></li>
          <li><a href="#">Something else here</a></li>
          <li role="separator" class="divider"></li>
          <li><a href="#">Separated link</a></li>
        </ul>
      </div>
    </div> --}}
  




	<div id="sidepanel">

		<div id="profile">
			<div class="wrap">
				<img id="profile-img" src="http://emilcarlsson.se/assets/mikeross.png" class="online" alt="" />
				<p>{{ Auth::user()->name }}</p>
			</div>
		</div>

		
		<div id="search">
			<label for=""><i class="fa fa-search" aria-hidden="true"></i></label>
			<input type="text" id="search_app_user" name="search_app_user" placeholder="Search App Users...." />
		</div>
		<div id="contacts">
			<ul style="list-style-type: none; padding: 0;">
				<div id="app_user_show">
					
				</div>
				{{-- <li class="contact active">
					<div class="wrap">
						<span class="contact-status busy"></span>
						<img src="http://emilcarlsson.se/assets/harveyspecter.png" alt="" />
						<div class="meta">
							<p class="name">Harvey Specter</p>
							<p class="preview">Wrong. You take the gun, or you pull out a bigger one. Or, you call their bluff. Or, you do any one of a hundred and forty six other things.</p>
						</div>
					</div>
				</li> --}}
				
			</ul>
		</div>
		{{-- <div id="bottom-bar">
			<button id="addcontact"><i class="fa fa-user-plus fa-fw" aria-hidden="true"></i> <span>Add contact</span></button>
			<button id="settings"><i class="fa fa-cog fa-fw" aria-hidden="true"></i> <span>Settings</span></button>
		</div> --}}
	</div>



</div>
	</div>



@endsection


@section('JScript')

	<script src="{{ asset('assets/js/bils/message/message.js')}}"></script>

@endsection


