@extends('warroom.layouts.default')

{{-- Content --}}
@section('content')

<div id="map" style="max-width: 100%"></div>

<script type="text/javascript">
	var map;
	var mapBounds = new OpenLayers.Bounds( 0.0, -1410.0, 3300, 0.0); // (  0.0, -2682.0, 4496.0, 0.0 )
	var mapMinZoom = 0;
	var mapMaxZoom = 5; // 6

	// avoid pink tiles
	OpenLayers.IMAGE_RELOAD_ATTEMPTS = 3;
	OpenLayers.Util.onImageLoadErrorColor = "transparent";

	function init(){
		var options = {
			controls: [],
			maxExtent: new OpenLayers.Bounds(  0.0, -1410.0, 3300, 0.0 ), //  (  0.0, -2682.0, 4496.0, 0.0 )
			maxResolution: 16.000000, //32
			numZoomLevels: 6 // 7
			};
		map = new OpenLayers.Map('map', options);
	
		var layer = new OpenLayers.Layer.TMS( "ALiVE Global","{{ URL::to('/') }}/maps/globalmap2/", //globalmap
			{  url: '', serviceVersion: '.', layername: '.', alpha: true,
				type: 'png', getURL: overlay_getTileURL
			});
		map.addLayer(layer);
		map.zoomToExtent( mapBounds );	
	
		//map.addControl(new OpenLayers.Control.PanZoomBar());
		//map.addControl(new OpenLayers.Control.MousePosition());
		map.addControl(new OpenLayers.Control.MouseDefaults());
		map.addControl(new OpenLayers.Control.KeyboardDefaults());
	}
	
	onresize=function(){ resize(); };
			
	$(document).ready(function() {
		init();
	    resize();
		map.setCenter(new OpenLayers.LonLat(1600,700), 4); // 

	});
</script>

<div class="col-md-2" style="position: absolute; z-index:10000; right: 10px; top:50px;">
    @include('warroom/tables/overview')
</div>

<div class="col-md-2" style="position: absolute; z-index:10000; left: 10px; top:50px;">
    @include('warroom/tables/recent_ops')
</div>

<div class="col-md-3" style="position: absolute; z-index:10000; left: 10px; top:300px;">
    @include('warroom/tables/t1operators')
</div>

<div class="col-md-2" style="position: absolute; z-index:10000; right: 10px; top:300px;">
    @include('warroom/tables/live_feed')
</div>

<div class="col-md-12" style="position: absolute; z-index:10000; bottom:100px;">

                <div class="col-md-3">
                    @include('warroom/charts/blu_losses')
                </div>
                <div class="col-md-3">
                    @include('warroom/charts/opf_losses')
                </div>
                <div class="col-md-3">
                    @include('warroom/charts/casualties')
                </div>
                <div class="col-md-3">
                    @include('warroom/charts/ops')
                </div>

 </div>

@stop