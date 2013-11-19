<!doctype html>
<html lang="en">
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<title>Error 500 - Internal Server Error</title>
	<meta name="viewport" content="width=device-width">
    <link href='http://fonts.googleapis.com/css?family=Roboto+Condensed:400,700|Roboto:400,900,500italic,500,300' rel='stylesheet' type='text/css'>
	<style type="text/css">
        body {
            padding-top: 54px;
            padding-bottom: 30px;
            background: #232323;
            color: #fff;
            font-family: 'Roboto', sans-serif;
        }

        .wrapper{
            margin-left: auto;
            margin-right: auto;
            width:50%;
        }

        a, a:visited
        {
            color:#2972A3;
        }
	</style>
</head>
<body>
	<div class="wrapper">
		<div role="main" class="main">
			<?php $messages = array('Ouch.', 'Oh no!', 'Whoops!'); ?>

			<h1><?php echo $messages[mt_rand(0, 2)]; ?></h1>

			<h2>Server Error: 500 (Internal Server Error)</h2>

			<h3>What does this mean?</h3>

			<p>
				Something went wrong on our servers while we were processing your request.
				We're really sorry about this, and will work hard to get this resolved as
				soon as possible.
			</p>

			<p>
				Perhaps you would like to go to our <a href="{{{ URL::to('/') }}}">home page</a>?
			</p>
		</div>
	</div>
</body>
</html>
