@extends('warroom.partials._chart')

{{-- Chart Data --}}
@section('chart_datasource')

            baseUrl = 'http://msostore.iriscouch.com/events/_design/kill/_view/';
            casualties_data = [];

            var ajaxUrl = baseUrl + 'side_killed_count?group_level=1&callback=?';
            $.getJSON(ajaxUrl, function(data) {
                for (var i=0; i<data.rows.length; i++) {
                    if(data.rows[i].value > 1) {
                    casualties_data.push([data.rows[i].key, data.rows[i].value]);
                    }
                }
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