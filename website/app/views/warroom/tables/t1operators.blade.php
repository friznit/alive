<script>
    $(document).ready(function(){
        $('#t1_operators').dataTable({
            "bJQueryUI": true,
            "sAjaxSource": 'http://msostore.iriscouch.com/events/_design/kill/_view/player_kills_count?group_level=1&callback=?',
            "sAjaxDataProp": "rows",
            "bPaginate": true,
			"bFilter": true,
            "bInfo": false,
            "aaSorting": [[1, "desc" ]],
            "fnDrawCallback": function ( oSettings ) {
                $("#t1operators_container").mCustomScrollbar("update");
            },
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
            "aoColumnDefs": [
                { "mDataProp": "key",  "aTargets": [ 0 ]},
                { "mDataProp": "value", "aTargets": [ 1 ]}
            ]
        } );
    });

</script>
<div id="t1operators_container">
<table cellpadding="0" cellspacing="0" border="0" class="dataTable table" id="t1_operators">
    <thead>
    <tr>
        <th width="80%">Player</th>
        <th>EKIA</th>
    </tr>
    </thead>
    <tbody>
    </tbody>
</table>
</div>