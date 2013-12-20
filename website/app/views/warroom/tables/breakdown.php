<script>

    $(document).ready(function(){
        $('#breakdown').dataTable({
            "bJQueryUI": true,
            "sAjaxSource": 'http://msostore.iriscouch.com/events/_design/operationsTable/_view/operationTotals?group_level=3&callback=?',
            "sAjaxDataProp": "rows",
            "bPaginate": true,
            "bLengthChange": true,
            "bFilter": true,
            "bAutoWidth": true,
            "aaSorting": [[ 4, "desc" ]],
            "bProcessing" : true,
            "fnDrawCallback": function ( oSettings ) {
                /* Need to redo the counters if filtered or sorted */
                /*
                if ( oSettings.bSorted || oSettings.bFiltered )
                {
                    for ( var i=0, iLen=oSettings.aiDisplay.length ; i<iLen ; i++ )
                    {
                        $('td:eq(0)', oSettings.aoData[ oSettings.aiDisplay[i] ].nTr ).html( i+1 );
                    }
                }
                */
            },
            "aoColumns": [
                { "mData": "key.2" },
                { "mData": "key.0" },
                { "mData": "value.Operations" },
                { "mData": "value.CombatHours" },
                { "mData": "value.Kills" },
                { "mData": "value.Injured" },
                { "mData": "value.Deaths" },
                { "mData": "value.ShotsFired" },
                { "mData": "value.CombatDives" },
                { "mData": "value.ParaJumps" },
                { "mData": "value.Heals" },
                { "mData": "value.VehicleTime" },
                { "mData": "value.VehicleKills" },
                { "mData": "value.PilotTime" }
            ]
        } );
    });

</script>

<table cellpadding="0" cellspacing="0" border="0" class="dataTable table" id="breakdown">
    <thead>
    <tr>
        <th>Operation</th>
        <th>AO</th>
        <th>Sessions</th>
        <th>Minutes Played</th>
        <th>Kills</th>
        <th>Injuries</th>
        <th>Deaths</th>
        <th>Ammo</th>
        <th>Combat Dives</th>
        <th>Para. Jumps</th>
        <th>Medical Support</th>
        <th>Vehicle Time</th>
        <th>Gunnery Kills</th>
        <th>Flight Time</th>
    </tr>
    </thead>
    <tbody>
    </tbody>
</table>