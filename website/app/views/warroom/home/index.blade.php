@extends('warroom.layouts.default')

{{-- Content --}}
@section('content')

<div class="globalmap-panel">

    <div class="row" >

    </div>

    <div class="row">
        <div class="col-md-3">
            @include('warroom/tables/overview')
            @include('warroom/tables/recent_ops')
            @include('warroom/tables/live_feed')
        </div>
        <div class="col-md-3">

        </div>
    </div>

    <!--
	
    <div class="row">
        <div class="col-md-2 col-md-offset-2">
            @include('warroom/charts/casualties')
        </div>
        <div class="col-md-2">
            @include('warroom/charts/blu_losses')
        </div>
        <div class="col-md-2">
            @include('warroom/charts/opf_losses')
        </div>
        <div class="col-md-2">
            @include('warroom/charts/ops')
        </div>
    </div>

    -->

</div>

<!--
<div class="dark-panel form-holder" id="Media">
    @include('warroom/charts/tempo')
</div>
-->

<!--
<div class="white-panel">

    <div class="row">
        <div class="col-md-4 col-md-offset-2">
            @include('warroom/tables/t1operators')
        </div>
        <div class="col-md-4">
            @include('warroom/tables/t1marksmen')
        </div>
    </div>

    <div class="row">
        <div class="col-md-4 col-md-offset-2">
            @include('warroom/tables/pilots')
        </div>
         <div class="col-md-4">
            @include('warroom/tables/operations')
        </div>
    </div>

    <div class="row">
        <div class="col-md-8 col-md-offset-2">
            @include('warroom/tables/personnel')
        </div>
    </div>

    <div class="row">
        <div class="col-md-8 col-md-offset-2">
            @include('warroom/tables/breakdown')
        </div>
    </div>

    <div class="row">
        <div class="col-md-4 col-md-offset-2">
            @include('warroom/tables/kpm')
        </div>
        <div class="col-md-4">
            @include('warroom/tables/av_distance')
        </div>
    </div>

    <div class="row">
        <div class="col-md-4 col-md-offset-2">
            @include('warroom/tables/score')
        </div>
        <div class="col-md-4">
            @include('warroom/tables/rating')
        </div>
    </div>

</div>
-->

@stop