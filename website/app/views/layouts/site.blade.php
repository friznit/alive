<!DOCTYPE html>
<html>
<head>
    <title>ALiVE</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="{{ URL::to('/') }}/css/bootstrap.min.css" rel="stylesheet">
    <link href="{{ URL::to('/') }}/css/bootstrap-theme.min.css" rel="stylesheet">
    <link href="{{ URL::to('/') }}/css/style.css" rel="stylesheet">
    <link href="//netdna.bootstrapcdn.com/font-awesome/4.0.2/css/font-awesome.min.css" rel="stylesheet">
    <link href='http://fonts.googleapis.com/css?family=Roboto+Condensed:400,700|Roboto:400,900,500italic,500,300' rel='stylesheet' type='text/css'>
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
    <script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
    <![endif]-->
</head>
<body data-spy="scroll" data-target="#topnav" data-offset="100">

<!-- Fixed navbar -->
<div id="topnav" class="navbar navbar-inverse navbar-fixed-top" role="navigation">
    <div class="container">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="#"><img src="{{ URL::to('/') }}/img/logo.png"/></a>
        </div>
        <div class="navbar-collapse collapse">
            <ul class="nav navbar-nav">
                <li><a href="#Welcome">Welcome</a></li>
                <li><a href="#Gameplay">Gameplay</a></li>
                <li><a href="#Media">Media</a></li>
                <li><a href="#Download">Download</a></li>
                <li><a href="#ALiVEWarRoom">ALiVE War Room</a></li>
                <li><a href="#FAQ">FAQ's</a></li>
                <li><a href="#INFO">More Info</a></li>
                <!--<li{{ (Request::is('style') ? ' class="active"' : '') }}><a href="{{{ URL::to('style') }}}/">Style</a></li>-->
                <!--
                <li{{ (Request::is('/') ? ' class="active"' : '') }}><a href="{{{ URL::to('') }}}/">Home</a></li>
                -->
            </ul>
            <ul class="nav navbar-nav pull-right">
                <li id="login"><img src="{{ URL::to('/') }}/img/alive_warroom_login.png" class="img-responsive navbar-warroom" /></li>
            </ul>
        </div>
    </div>
</div>

@yield('content')

<script src="https://code.jquery.com/jquery.js"></script>
<script src="{{ URL::to('/') }}/js/bootstrap.min.js"></script>
<script src="{{ URL::to('/') }}/js/alive_home.js"></script>
</body>
</html>
