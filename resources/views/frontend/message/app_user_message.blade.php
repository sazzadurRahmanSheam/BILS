<!DOCTYPE html>
<html>
<head>
	<title>Bils || app-user message</title>
	<link rel="stylesheet" href="{{ asset('assets/plugins/bootstrap/css/bootstrap.min.css') }}"> 
	
  
</head>
<body>
	<div class="container">
		<div class="jumbotron">
			<div class="text-center">
				<h2>{{ $data[0]->name }}</h2><hr style="border:1px solid black;">
			</div>
			<form action="{{ url('app-user-message-save') }}" method="post" enctype="multipart/form-data" class="form form-horizontal form-label-left">
		@csrf
		<div class="form-group">
			<label class="control-label col-md-2 col-sm-2 col-xs-6">message text:</label>
			<div class="col-md-10 col-sm-10 col-xs-6">
				<input type="text" name="app_user_message" class="form-control col-lg-12"/>
			</div>						
		</div>
		<div class="form-group">
			<label class="control-label col-md-2 col-sm-2 col-xs-6">Attachment:</label>
			<div class="col-md-10 col-sm-10 col-xs-6">
				<input class="form-control" type="file" name="app_user_attachment[]" multiple>
			</div>						
		</div>
		<input type="hidden" name="app_user_id" value="{{ $data[0]->id }}">
		
		
		<div class="form-group text-center">
			<button class="btn btn-success" type="submit">Sent</button>
		</div>
	</form>
		</div>
	</div>
</body>
</html>