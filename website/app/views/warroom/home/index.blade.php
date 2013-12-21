@extends('warroom.layouts.default')

{{-- Content --}}
@section('content')
 
<div id="map" style="height: 900px;"></div>

<script type="text/javascript">

        var map = L.map('map', {
			minZoom: 0,
			maxZoom: 5,
			crs: L.CRS.Simple
		}).setView([4096,4096], 2);
		
		var southWest = map.unproject([0,1654], map.getMaxZoom());
		var northEast = map.unproject([8192,6400], map.getMaxZoom());
		map.setMaxBounds(new L.LatLngBounds(southWest, northEast));
		L.tileLayer("{{ URL::to('/') }}/maps/globalmap3/{z}/{x}/{y}.png" , {
            attribution: 'ALiVE',
            tms: true	//means invert.
        }).addTo(map);
		
		map.on('click', function(e) {
			alert(map.project(e.latlng, map.getMaxZoom()));
		});
		
    $(document).ready(function() {
		$(".trigger").click(function(){
			$(".panel").toggle("fast");
			$(this).toggleClass("active");
			return false;
		});
	});
</script>

<div class="col-md-2" style="position: absolute; z-index:10000; right: 10px; top:50px;">
    @include('warroom/tables/overview')
</div>

<div class="col-md-2" style="position: absolute; z-index:10000; left: 10px; top:50px;">
    @include('warroom/tables/recent_ops')
</div>

<div class="col-md-2" style="position: absolute; z-index:10000; left: 10px; top:300px;">
    @include('warroom/tables/t1operators')
</div>

<div class="col-md-2" style="position: absolute; z-index:10000; right: 10px; top:300px;">
    @include('warroom/tables/live_feed')
</div>

<div class="col-md-12">

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