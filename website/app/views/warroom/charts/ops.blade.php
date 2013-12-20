@extends('warroom.partials._chart')

{{-- Chart Data --}}
@section('chart_datasource')

            op_data = [];

            var ajaxUrl = '{{ URL::to('/') }}/api/operationsbymap';
            $.getJSON(ajaxUrl, function(data) {
                op_data = data;
                makeOpChart();
            });



@overwrite

{{-- Chart Data --}}
@section('chart_data')
data: op_data
@overwrite

{{-- Chart Function --}}
@section('chart_function')
function makeOpChart() {
@overwrite

{{-- Chart Colours --}}
@section('chart_colours')
colors: ['#33c6e7', '#910000', '#8bbc21', '#c8c8c8', '#2f7ed8', '#86aedb', '#86aedb', '#b25a5a', '#b0d363'],
@overwrite

{{-- Chart Id --}}
@section('chart_id')
renderTo: 'chart_op',
@overwrite

{{-- Chart Title --}}
@section('chart_title')
text: 'Operation AO',
@overwrite

{{-- Chart Tooltip --}}
@section('chart_tooltip')
return '<b>' + this.point.name + ' Operations: '+ this.y + '</b> ';
@overwrite

{{-- Chart Element --}}
@section('chart_element')
<div id="chart_op"></div>
@overwrite