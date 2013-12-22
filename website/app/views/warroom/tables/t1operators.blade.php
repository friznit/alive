<script>
    $(document).ready(function(){
        $('#t1_operators').dataTable({
					"bJQueryUI": true,
					"sAjaxSource": 'http://msostore.iriscouch.com/events/_design/kill/_view/player_kills_count?group_level=1&callback=?',
					"sAjaxDataProp": "rows",
					"sScrollY": "500px",
					"bPaginate": false,
					"bInfo": false,
					"bScrollCollapse": true,
					"aaSorting": [[1, "desc" ]],
					"fnInitComplete": function () {
						        $("#t1_operators_wrapper").find('.dataTables_scrollBody').mCustomScrollbar();
					},
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
        <th width="70%">Player</th>
        <th>EKIA</th>
    </tr>
    </thead>
    <tbody>
    </tbody>
</table>
</div>