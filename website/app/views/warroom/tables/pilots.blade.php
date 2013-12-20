<script>
    $(document).ready(function(){
        $('#pilots').dataTable({
            "bJQueryUI": true,
            "sAjaxSource": 'http://msostore.iriscouch.com/events/_design/kill/_view/player_in_vehicle_kills_count?group_level=2&callback=?',
            "sAjaxDataProp": "rows",
            "bPaginate": true,
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
            "aaSorting": [[2, "desc" ]],
            "aoColumnDefs": [
                { "mDataProp": "key.0", "aTargets": [ 0 ] },
                { "mDataProp": "key.1", "aTargets": [ 1 ] },
                { "mDataProp": "value", "aTargets": [ 2 ] }
            ]
        } );
    });

</script>

<table cellpadding="0" cellspacing="0" border="0" class="dataTable table" id="pilots">
    <thead>
    <tr>
        <th>Player</th>
        <th>Vehicle</th>
        <th>EKIA</th>
    </tr>
    </thead>
    <tbody>
    </tbody>
</table>