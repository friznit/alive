<script>

    $(document).ready(function() {

        var ajaxUrl = '{{ URL::to('/') }}/api/totals';
        $.getJSON(ajaxUrl, function(data) {
            var totals = data;

            var kills = totals.Kills;
            counter($('#ekia').append(),kills);

            var losses = totals.Deaths;
            counter($('#losses').append(),losses);

            var ops = totals.Operations;
            counter($('#operation_count').append(),ops);

            var hours = Math.round((totals.CombatHours / 60)*10)/10;
            counter($('#combat_hours').append(),hours);

            var fired = totals.ShotsFired;
            counter($('#ammo').append(),fired);
        });

        var ajaxUrl = '{{ URL::to('/') }}/api/activeunitcount';
        $.getJSON(ajaxUrl, function(data) {
            var activeunits = data;

            counter($('#active_units').append(),activeunits);
        });
    })
</script>

<div id="overview_container">

    <table cellpadding="0" cellspacing="0" border="0" class="table overview-table">
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