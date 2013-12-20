@extends('warroom.partials._chart')

{{-- Chart Data --}}
@section('chart_datasource')

            casualties_data = [];

            var ajaxUrl = '{{ URL::to('/') }}/api/casualties';
            $.getJSON(ajaxUrl, function(data) {
                casualties_data = data;
                makeCasualtiesChart();
            });

@overwrite

{{-- Chart Data --}}
@section('chart_data')
data: casualties_data
@overwrite

{{-- Chart Function --}}
@section('chart_function')
function makeCasualtiesChart() {
@overwrite

{{-- Chart Colours --}}
@section('chart_colours')
colors: ['#33c6e7', '#910000', '#8bbc21', '#c8c8c8', '#2f7ed8'],
@overwrite

{{-- Chart Id --}}
@section('chart_id')
renderTo: 'chart_casualties',
@overwrite

{{-- Chart Title --}}
@section('chart_title')
text: 'Casualties',
@overwrite

{{-- Chart Tooltip --}}
@section('chart_tooltip')
return '<b>' + this.point.name + ' Losses: '+ this.y + '</b> ';
@overwrite

{{-- Chart Element --}}
@section('chart_element')
<div id="chart_casualties"></div>
@overwrite