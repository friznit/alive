<script type="text/javascript">
    $(function() {

        var seriesOptions = [],
            yAxisOptions = [],
            seriesCounter = 0,
            names = ['Operations', 'Players', 'Kills', 'Deaths'],
            colors = Highcharts.getOptions().colors;

        $.each(names, function(i, name) {

            var ajaxUrl = '{{ URL::to('/') }}/api/'+ name.toLowerCase() +'byday';
            $.getJSON(ajaxUrl, function(data) {

                var seriesData = data;

                seriesOptions[i] = {
                    name: name,
                    data: seriesData
                };

                // As we're loading the data asynchronously, we don't know what order it will arrive. So
                // we keep a counter and create the chart when all the data is loaded.
                seriesCounter++;

                if (seriesCounter == names.length) {
                    createTempoChart();
                }
            });
        });

        // create the chart when all data is loaded
        function createTempoChart() {

            $('#tempo_chart').highcharts('StockChart', {
                chart: {
                    renderTo: 'tempo_chart',
                    backgroundColor: null,
                    plotBackgroundColor: null,
                    plotBorderWidth: null,
                    plotShadow: false
                },
                exporting: {
                    enabled: false
                },
                legend: {
                    enabled: true,
                    itemStyle: {
                        color: 'silver'
                    }
                },
                rangeSelector: {
                    selected: 4,
                    inputEnabled: false,
                    buttonTheme: { // styles for the buttons
                        fill: 'none',
                        stroke: 'none',
                        'stroke-width': 0,
                        r: 3,
                        style: {
                            color: 'silver',
                            fontWeight: 'bold'
                        },
                        states: {
                            hover: {
                                fill: '#CC9',
                                style: {
                                    color: '#EEE'
                                }
                            },
                            select: {
                                fill: '#AA6',
                                style: {
                                    color: 'white'
                                }
                            }
                        }
                    },
                    labelStyle: {
                        color: 'silver',
                        fontWeight: 'bold'
                    }
                },
                xAxis: {
                    title: {
                        text: 'Date',
                        style: {
                            color: 'silver'
                        }
                    }
                },
                yAxis: {
                    type: 'logarithmic',
                    title: {
                        text: 'Count',
                        style: {
                            color: 'silver'
                        }
                    },
                    plotLines: [{
                        value: 0,
                        width: 2,
                        color: 'silver'
                    }]
                },

                plotOptions: {
                    series: {
                    }
                },

                tooltip: {
                    pointFormat: '<span style="color:{series.color}">{series.name}</span>: <b>{point.y}<br/>'
                },

                series: seriesOptions
            });
        }

    });

</script>

<div id="tempo_chart"></div>