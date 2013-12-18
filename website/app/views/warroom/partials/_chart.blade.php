<script type="text/javascript">
    $(function () {

        var chart;
        (function() {

            @section('chart_datasource')
            @show

            @section('chart_function')
            @show

                chart = new Highcharts.Chart({
                    @section('chart_colours')
                    @show
                    chart: {
                        @section('chart_id')
                        @show
                        plotBorderWidth: 0,
                        backgroundColor: 'transparent',
                        plotBackgroundColor: null,
                        plotShadow: false,
                        height: 140,
                        margin: 0,
                        spacing: 0,
                        marginRight: 90,
                        marginLeft: -20,
                        marginBottom: -50
                    },
                    legend: {
                        symbolPadding: 2,
                        symbolWidth: 5,
                        backgroundColor: null,
                        borderColor: null,
                        layout: 'vertical',
                        align: 'right',
                        verticalAlign: 'center',
                        rtl: true
                    },
                    title: {
                        @section('chart_title')
                        @show
                        align: 'left',
                        x: 5,
                        y: 20
                    },
                    subtitle: {
                        text: '',
                        style: {
                            display: 'none'
                        }
                    },
                    tooltip: {
                        formatter: function() {
                            @section('chart_tooltip')
                            @show
                        }
                    },
                    plotOptions: {
                        pie: {
                            dataLabels: {
                                enabled: false
                            },
                            showInLegend: true,
                            borderWidth: 0,
                            startAngle: -90,
                            endAngle: 90,
                            center: ['50%', '75%']
                        }
                    },
                    credits: {
                        enabled: false
                    },
                    series: [{
                        type: 'pie',
                        name: 'Total Losses',
                        innerSize: '50%',
                        @section('chart_data')
                        @show
                    }]
                });
            }
        })();
    });

</script>


@section('chart_element')
@show
