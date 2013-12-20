<!DOCTYPE html>
<html>
<head>
    <title>ALiVE</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="//netdna.bootstrapcdn.com/bootstrap/3.0.2/css/bootstrap.min.css" rel="stylesheet" >
    <link href="//netdna.bootstrapcdn.com/bootstrap/3.0.2/css/bootstrap-theme.min.css" rel="stylesheet" >
    <link href="{{ URL::to('/') }}/css/dataTables.bootstrap.css" rel="stylesheet">
    <link href="{{ URL::to('/') }}/css/jquery.mCustomScrollbar.css" rel="stylesheet">
    <link href="{{ URL::to('/') }}/css/style.css" rel="stylesheet">
    <link href="//netdna.bootstrapcdn.com/font-awesome/4.0.2/css/font-awesome.min.css" rel="stylesheet">
    <link href='http://fonts.googleapis.com/css?family=Roboto+Condensed:400,700|Roboto:400,900,500italic,500,300' rel='stylesheet' type='text/css'>
     <link rel="stylesheet" href="http://cdn.leafletjs.com/leaflet-0.6/leaflet.css" />
    <script src="https://code.jquery.com/jquery.js"></script>
    <script src="//netdna.bootstrapcdn.com/bootstrap/3.0.2/js/bootstrap.min.js"></script>
    <script src="http://code.highcharts.com/stock/highstock.js"></script>
    <script src="http://code.highcharts.com/highcharts-more.src.js"></script>
    <script src="http://ajax.aspnetcdn.com/ajax/jquery.dataTables/1.9.4/jquery.dataTables.min.js"></script>
    <script src="{{ URL::to('/') }}/js/highcharts_defaults.js"></script>
    <script src="{{ URL::to('/') }}/js/war_room.js"></script>
    <script src="{{ URL::to('/') }}/js/dataTables.bootstrap.js"></script>
    <script src="{{ URL::to('/') }}/js/jquery.mCustomScrollbar.concat.min.js"></script>
	<script src="http://www.openlayers.org/api/2.7/OpenLayers.js" type="text/javascript"></script>
     <script src="http://cdn.leafletjs.com/leaflet-0.6/leaflet.js"></script>
    <script src="{{ URL::to('/') }}/js/greenthumb/easing/EasePack.min.js"></script>
    <script src="{{ URL::to('/') }}/js/greenthumb/TweenLite.min.js"></script>
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
    <script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
    <![endif]-->
</head>
<body id="body" data-spy="scroll" data-target="#topnav" data-offset="100">

@include('warroom/partials/_nav')

@yield('content')

@include('warroom/partials/_footer')


</body>
</html>
