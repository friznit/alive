<!DOCTYPE html>
<html lang="en-US">
	<head>
		<meta charset="utf-8">
	</head>
	<body>
		<h2>Your ALiVE War Room signup is almost complete</h2>

		<p><b>Account:</b> {{{ $email }}}</p>
		<p>To activate your account, <a href="{{  URL::to('user/activate', array('id' => $userId, urlencode($activationCode))) }}">click here.</a></p>
		<p>Or point your browser to this address: <br /> {{  URL::to('user/activate', array('id' => $userId, urlencode($activationCode))) }}</p>
		<p>Thank you, <br />
			~The ALiVE dev team</p>
	</body>
</html>