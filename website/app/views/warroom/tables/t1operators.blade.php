<script>
    $(document).ready(function(){
        $('#t1_operators').dataTable({
            "bJQueryUI": true,
            "sAjaxSource": 'http://msostore.iriscouch.com/events/_design/kill/_view/player_kills_count?group_level=1&limit=14&callback=?',
            "sAjaxDataProp": "rows",
            "bPaginate": true,
            "aaSorting": [[1, "desc" ]],
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
            "aoColumnDefs": [
                { "mDataProp": "key",  "aTargets": [ 0 ]},
                { "mDataProp": "value", "aTargets": [ 1 ]}
            ]
        } );
    });

</script>

<table cellpadding="0" cellspacing="0" border="0" class="dataTable table" id="t1_operators">
    <thead>
    <tr>
        <th>Player</th>
        <th>EKIA</th>
    </tr>
    </thead>
    <tbody>
    </tbody>
</table>