<script>

    $(document).ready(function() {

        $.getJSON('http://msostore.iriscouch.com/events/_design/events/_view/Totals?callback=?', function(totals)
        {
            $('#overview').append('EKIA: ' + totals.rows[0].value.Kills + '<br>')
            $('#overview').append('Losses: ' + totals.rows[0].value.Deaths+ '<br>')
            $('#overview').append('Operations: ' + totals.rows[0].value.Operations + '<br>')
            $('#overview').append('Combat Hours: ' + Math.round((totals.rows[0].value.CombatHours / 60)*10)/10 + '<br>')
            $('#overview').append('Ammunition: ' + totals.rows[0].value.ShotsFired + '<br>')
        })

        $.getJSON('http://msostore.iriscouch.com/events/_design/events/_view/players_list?group_level=2&callback=?', function(activeunits)
        {
            $('#overview').append('Active Units: ' + activeunits.rows.length + '<br>')
        })
    })
</script>

<div id="overview">

</div>