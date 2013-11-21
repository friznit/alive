@extends('warroom.partials._chart')

{{-- Chart Data --}}
@section('chart_datasource')

            baseUrl = 'http://msostore.iriscouch.com/events/_design/kill/_view/';
            opf_casualties_data = [];

            var ajaxUrl = baseUrl + 'side_killed_count_by_class?group_level=2&callback=?';
            $.getJSON(ajaxUrl, function(data) {
                for (var i=0; i<data.rows.length; i++) {
                    if(data.rows[i].value > 0) {
                        if((data.rows[i].key[0] == "EAST") && (data.rows[i].key[1] != null) && (data.rows[i].key[1] != "any")) {
                            opf_casualties_data.push([data.rows[i].key[1], data.rows[i].value]);
                        }
                    }
                }
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