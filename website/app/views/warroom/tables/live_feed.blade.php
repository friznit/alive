<script>

    $(document).ready(function() {

        $.getJSON('http://msostore.iriscouch.com/events/_design/events/_view/all_events?descending=true&limit=12&callback=?', function(data) {

            $.each(data.rows, function (index, row) {

                if (row.value.Event == "Kill")
                {
                    if (row.value.Death == "true")
                    {
                        $('#live_feed')
                            .append(row.value.Map + ' - Grid:' + row.value.KilledPos + ' - ')
                            .append(row.value.gameTime + ' local<br>')
                            .append('<b>' + row.value.Killedfaction + ' ' + row.value.KilledType + '<span style="color: red;"> ' + row.value.PlayerName + '</span> has been KIA')
                            .append('<br>' + parseArmaDate(row.key) + ' - <span style="color: cadetblue;">Operation ' + row.value.Operation +'</span><hr>')

                    } else {
                        if (row.value.KilledClass != "Infantry")
                        {
                            $('#live_feed')
                                .append(row.value.Map + ' - Grid:' + row.value.KilledPos + ' - ')
                                .append(row.value.gameTime + ' local<br>')
                                .append('<b>' + row.value.Killedfaction + ' <span style="color: red;">' + row.value.KilledType + '</span> has been destroyed')
                                .append('<br>' + parseArmaDate(row.key) + ' - <span style="color: cadetblue;">Operation ' + row.value.Operation +'</span><hr>')
                        } else {
                            $('#live_feed')
                                .append(row.value.Map + ' - Grid:' + row.value.KilledPos + ' - ')
                                .append(row.value.gameTime + ' local<br>')
                                .append('<b>' + row.value.Killerfaction + ' ' + row.value.KillerType + ' <span style="color: cadetblue;">(' + row.value.PlayerName)
                                .append('</span><b>) kills ' + row.value.Killedfaction)
                                .append('<b><span style="color: red;"> ' + row.value.KilledType)
                                .append('</span> with an ' + row.value.Weapon)
                                .append(' from ' + row.value.Distance + 'm')
                                .append('<br>' + parseArmaDate(row.key) + ' - <span style="color: cadetblue;">Operation ' + row.value.Operation +'</span><hr>')
                        }
                    }

                }

                if (row.value.Event == "OperationStart")
                {
                    $('#live_feed')
                        .append(row.value.Map + ' - ')
                        .append(row.value.gameTime + ' local<br>')
                        .append('<b> Operation <span style="color: white;">' + row.value.Operation + '</span> has been launched.')
                        .append('<br>' + parseArmaDate(row.key) + ' - <span style="color: cadetblue;">Operation ' + row.value.Operation +'</span><hr>')
                }

                if (row.value.Event == "OperationFinish")
                {
                    $('#live_feed')
                        .append(row.value.Map + ' - ')
                        .append(row.value.gameTime + ' local<br>')
                        .append('<b> Operation <span style="color: white;">' + row.value.Operation + '</span> has ended after ' + row.value.timePlayed + ' minutes.')
                        .append('<br>' + parseArmaDate(row.key) + ' - <span style="color: cadetblue;">Operation ' + row.value.Operation +'</span><hr>')
                }

                if (row.value.Event == "Hit" && !(row.value.PlayerHit))
                {
                    $('#live_feed')
                        .append(row.value.Map + ' - Grid:' + row.value.hitPos + ' - ')
                        .append(row.value.gameTime + ' local<br>')
                        .append('<b>' + row.value.sourcefaction + ' ' + row.value.sourceType + ' <span style="color: cadetblue;">(' + row.value.PlayerName + ')</span> has scored a hit on a ' + row.value.hitfaction + ' ' + row.value.hitType + '.')
                        .append('<br>' + parseArmaDate(row.key) + ' - <span style="color: cadetblue;">Operation ' + row.value.Operation +'</span><hr>')
                }

                if (row.value.Event == "Missile")
                {
                    if (row.value.FiredAt == "true")
                    {
                        $('#live_feed')
                            .append(row.value.Map + ' - Grid:' + row.value.targetPos + ' - ')
                            .append(row.value.gameTime + ' local<br>')
                            .append('<b>' + row.value.targetFaction + ' ' + row.value.targetType + ' <span style="color: orange;">(' + row.value.PlayerName + ')</span> has been engaged by a ' + row.value.sourceFaction + ' ' + row.value.sourceType + '.')
                            .append('<br>' + parseArmaDate(row.key) + ' - <span style="color: cadetblue;">Operation ' + row.value.Operation +'</span><hr>')
                    } else {
                        $('#live_feed')
                            .append(row.value.Map + ' - Grid:' + row.value.sourcePos + ' - ')
                            .append(row.value.gameTime + ' local<br>')
                            .append('<b>' + row.value.sourceFaction + ' ' + row.value.sourceType + ' <span style="color: cadetblue;">(' + row.value.PlayerName)
                            .append(')</span><b> is engaging ' + row.value.targetFaction)
                            .append('<b> ' + row.value.targetType)
                            .append(' with a ' + row.value.Weapon)
                            .append(' from ' + row.value.Distance + 'm using a ' + row.value.projectile)
                            .append('<br>' + parseArmaDate(row.key) + ' - <span style="color: cadetblue;">Operation ' + row.value.Operation +'</span><hr>')
                    }

                }

            });
        });
    });
</script>

<div id="live_feed">

</div>