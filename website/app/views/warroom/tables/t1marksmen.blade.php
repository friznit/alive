<script>
    $(document).ready(function(){
        $('#t1_marksmen').dataTable({
            "bJQueryUI": true,
            "sAjaxSource": 'http://msostore.iriscouch.com/events/_design/kill/_view/kills_by_distance?group_level=2&callback=?',
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
                { "mDataProp": "key.1", "aTargets": [ 0 ]  },
                { "mDataProp": "key.0", "aTargets": [ 1 ]  },
                { "mDataProp": "value", "aTargets": [ 2 ]  }
            ]
        } );
    });

</script>

<table cellpadding="0" cellspacing="0" border="0" class="dataTable table" id="t1_marksmen">
    <thead>
    <tr>
        <th>Player</th>
        <th>Weapon</th>
        <th>Dist</th>
    </tr>
    </thead>
    <tbody>
    </tbody>
</table>