<!doctype html>
<html lang="en">
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<title>Error 403 - Forbidden</title>
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
			<?php $messages = array('We need a map.', 'I think we\'re lost.', 'We took a wrong turn.'); ?>

			<h2>Server Error: 403 (Forbidden)</h2>

			<h3>What does this mean?</h3>

			<p>
				We couldn't find the page you requested on our servers. We're really sorry
				about that. It's our fault, not yours. We'll work hard to get this page
				back online as soon as possible.
			</p>

			<p>
				Perhaps you would like to go to our <a href="{{{ URL::to('/') }}}">home page</a>?
			</p>
		</div>
	</div>
</body>
</html>
