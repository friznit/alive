<script>

	
    $(document).ready(function(){
        $('#recent_ops').dataTable({
            "bJQueryUI": true,
            "sAjaxSource": 'http://msostore.iriscouch.com/events/_design/events/_view/recent_operations?descending=true&limit=50&callback=?',
            "sAjaxDataProp": "rows",
            "bPaginate": false,
			"sScrollY": "610",
			"bScrollCollapse": true,
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
                {
                    "aTargets": [ 0 ],
                    "mDataProp": "key",
                    "mRender": function ( data, type, row ) {
                        return parseArmaDate(data);
                    }
                },{
                    "aTargets": [ 1 ],
                    "mDataProp": "value",
                    "mRender": function ( data, type, row) {
                        return data[1];
                    }
                },{
                    "aTargets": [ 2 ],
                    "mDataProp": "value",
                    "mRender": function ( data, type, row) {
                        return data[2];
                    }
                }
            ]
        } );
    });

</script>

<table cellpadding="0" cellspacing="0" border="0" class="dataTable table table-condensed" id="recent_ops">
    <thead>
    <tr>
        <th>Date</th>
        <th>Map</th>
        <th>Operation</th>
    </tr>
    </thead>
    <tbody>
    </tbody>
</table>