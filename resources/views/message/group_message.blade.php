@extends('layout.master')

@section('style')
	<link rel="stylesheet" type="text/css" href="{{ asset('assets/css/bils/messages.css') }}">


	<style>

		h4 { font-family: 'Open Sans'; margin: 0;}

		.modal,body.modal-open {
		    padding-right: 0!important
		}

		body.modal-open {
		    overflow: auto
		}

		body.scrollable {
		    overflow-y: auto
		}

		.modal-footer {
			display: flex;
			justify-content: flex-start;
			.btn {
				position: absolute;
				right: 10px;
			}
		}

		.modal {
			/*height:500px;*/
			left: 35%;
			bottom: auto;
			right: auto;
			padding: 0;
			width: 62%;
			margin-left: -250px;
			background-color: #ffffff;
			border: 1px solid #999999;
			border: 1px solid rgba(0, 0, 0, 0.2);
			border-radius: 6px;
			-webkit-box-shadow: 0 3px 9px rgba(0, 0, 0, 0.5);
			box-shadow: 0 3px 9px rgba(0, 0, 0, 0.5);
			background-clip: padding-box;
		}

	</style>


@endsection

@section('content')

	<div class="col-md-12" style="padding: 0;">
		<div id="frame">
			<div class="content">
				<div class="contact-profile">
					<img id="app_user_image" src="" alt="" />
					<p id="app_user_name"></p> {{-- onclick="showProfile()" style="cursor:pointer; text-decoration: none;" --}}
					<div class="social-media">
						<div id="load_more_message">

						</div>
					</div>
				</div>
				<div class="messages">
					<ul style="padding-left: 0;">
						<div class="message_body">

						</div>
						

					</ul>
				</div>
				<div class="message-input">
					<div class="wrap">
						<form id="sent_message_to_group" name="sent_message_to_group" enctype="multipart/form-data" class="form form-horizontal form-label-left">
							@csrf
							<div style="width: 90%; float: left;">
								<input type="hidden" name="group_id" id="group_id">
								<div >
									<input style="width: 100%" type="text" name="admin_message" id="admin_message" placeholder="Write your message..." />
								</div>
							</div>
							<div style="width: 10%; float: left;">
								<label for="group_msg_attachment" class="custom-file-upload">
									<i class="fa fa-paperclip attachment" aria-hidden="true"></i>
								</label>
								<input multiple id="group_msg_attachment" name="group_msg_attachment[]" type="file"/>
								<button type="submit" class="submit" id="message_sent_to_group"><i class="fa fa-paper-plane" aria-hidden="true"></i></button>
							</div>
						</form>
					</div>
				</div>
			</div>



			<div id="sidepanel">
				<div id="profile">
					<div class="wrap">
						<img id="profile-img" src="{{ asset('assets/images/user/admin') }}/{{ Auth::user()->user_profile_image }}" class="online" alt="" />
						<p>{{ Auth::user()->name }}</p>
					</div>
				</div>

				<div id="search">
					<label for=""><i class="fa fa-search" aria-hidden="true"></i></label>
					<input type="text" id="search_app_user_group" name="search_app_user_group" placeholder="Search Group...." />
				</div>
				<div id="contacts">
					<ul style="list-style-type: none; padding: 0;">
						<div id="app_user_group_show">

						</div>
						

					</ul>
				</div>
				<div id="bottom-bar">
				
				</div>
			</div>
		</div>
	</div>



@endsection


@section('JScript')
	<script>
		var msg_image_url = "<?php echo asset('assets/images/message'); ?>";
		var app_user_profile_url = "<?php echo asset('assets/images/user/app_user'); ?>";
		var profile_image_url = "<?php echo asset('assets/images/user/app_user'); ?>";
	</script>
	
	<script src="{{ asset('assets/js/bils/message/message.js')}}"></script>

@endsection


