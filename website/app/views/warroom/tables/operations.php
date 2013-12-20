<script>

    $(document).ready(function(){
        $('#operations').dataTable({
            "bJQueryUI": true,
            "sAjaxSource": 'http://msostore.iriscouch.com/events/_design/operationsTable/_view/operationKillsByClass?group_level=3&callback=?',
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
                { "mDataProp": "key.2",  "aTargets": [ 0 ]},
                { "mDataProp": "value.InfKills", "aTargets": [ 1 ]},
                { "mDataProp": "value.VehKills", "aTargets": [ 2 ]},
                { "mDataProp": "value.AirKills", "aTargets": [ 3 ]},
                { "mDataProp": "value.ShipKills", "aTargets": [ 4 ]},
                { "mDataProp": "value.OtherKills", "aTargets": [ 5 ]}
            ]
        } );
    });

</script>

<table cellpadding="0" cellspacing="0" border="0" class="dataTable table" id="operations">
    <thead>
    <tr>
        <th>Operation</th>
        <th>Inf</th>
        <th>Veh</th>
        <th>Air</th>
        <th>Ship</th>
        <th>Other</th>
    </tr>
    </thead>
    <tbody>
    </tbody>
</table>