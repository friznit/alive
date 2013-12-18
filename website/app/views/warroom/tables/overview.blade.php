<script>

    $(document).ready(function() {

        $.getJSON('http://msostore.iriscouch.com/events/_design/events/_view/Totals?callback=?', function(totals)
        {
            var kills = totals.rows[0].value.Kills;
            counter($('#ekia').append(),kills);

            var losses = totals.rows[0].value.Deaths;
            counter($('#losses').append(),losses);

            var ops = totals.rows[0].value.Operations;
            counter($('#operation_count').append(),ops);

            var hours = Math.round((totals.rows[0].value.CombatHours / 60)*10)/10;
            counter($('#combat_hours').append(),hours);

            var fired = totals.rows[0].value.ShotsFired;
            counter($('#ammo').append(),fired);
        })

        $.getJSON('http://msostore.iriscouch.com/events/_design/events/_view/players_list?group_level=2&callback=?', function(activeunits)
        {
            var active = activeunits.rows.length;
            counter($('#active_units').append(),active);
        })
    })
</script>

<div id="overview_container">

    <table cellpadding="0" cellspacing="0" border="0" class="table" id="overview">
        <tbody>
        <tr>
            <td width="40%">Enemy killed in action</td>
            <td width="60%"><span id="ekia">0</span></td>
        </tr>
        <tr>
            <td>Losses</td>
            <td><span id="losses">0</span></td>
        </tr>
        <tr>
            <td>Operations</td>
            <td><span id="operation_count">0</span></td>
        </tr>
        <tr>
            <td>Combat hours</td>
            <td><span id="combat_hours">0</span></td>
        </tr>
        <tr>
            <td>Ammunition</td>
            <td><span id="ammo">0</span></td>
        </tr>
        <tr>
            <td>Active units</td>
            <td><span id="active_units">0</span></td>
        </tr>
        </tbody>
        <tbody>
        </tbody>
    </table>

</div>