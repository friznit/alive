@extends('warroom.partials._chart')

{{-- Chart Data --}}
@section('chart_datasource')

            opf_casualties_data = [];

            var ajaxUrl = '{{ URL::to('/') }}/api/lossesopf';
            $.getJSON(ajaxUrl, function(data) {
                opf_casualties_data = data;
                makeOpfLossesChart();
            });

@overwrite

{{-- Chart Data --}}
@section('chart_data')
data: opf_casualties_data
@overwrite

{{-- Chart Function --}}
@section('chart_function')
function makeOpfLossesChart() {
@overwrite

{{-- Chart Colours --}}
@section('chart_colours')
colors: ['#bf8484', '#b25a5a', '#a02a2a', '#681010'],
@overwrite

{{-- Chart Id --}}
@section('chart_id')
renderTo: 'chart_opf_losses',
@overwrite

{{-- Chart Title --}}
@section('chart_title')
text: 'OPFOR Losses',
@overwrite

{{-- Chart Tooltip --}}
@section('chart_tooltip')
return '<b>' + this.point.name + ' Losses: '+ this.y + '</b> ';
@overwrite

{{-- Chart Element --}}
@section('chart_element')
<div id="chart_opf_losses"></div>
@overwrite