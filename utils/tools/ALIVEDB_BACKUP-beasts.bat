
REM start CouchDB service
net.exe start "Apache CouchDB"

set TARGET=http://aliveadmin:tupolov@localhost:5984
set SOURCE=http://aliveadmin:tupolov@db.alivemod.com:5984

REM Add admin user
REM curl -X PUT http://localhost:5984/_config/admins/aliveadmin -d "\"tupolov\""

REM curl -k -H "Content-Type:application/json" -vX PUT %TARGET%/_users/org.couchdb.user:aliveadmin -d "{\"_id\": \"org.couchdb.user:aliveadmin\",\"name\": \"aliveadmin\",\"roles\": [\"reader\",\"writer\",\"admin\"],\"type\": \"user\",\"password\": \"tupolov\"}" 

REM Configure JSONP
curl -k -H "Content-Type: application/json" -vX PUT %TARGET%/_config/httpd/allow_jsonp -d \"true\"

REM Set require valid user
curl -k -H "Content-Type: application/json" -vX PUT %TARGET%/_config/httpd/require_valid_user -d \"true\"

REM Add databases
curl -k -vX PUT %TARGET%/credits
curl -k -vX PUT %TARGET%/events
curl -k -vX PUT %TARGET%/groups
curl -k -vX PUT %TARGET%/players
curl -k -vX PUT %TARGET%/sys_data
curl -k -vX PUT %TARGET%/sys_perf
curl -k -vX PUT %TARGET%/sys_player
curl -k -vX PUT %TARGET%/mil_cqb
curl -k -vX PUT %TARGET%/mil_logistics
curl -k -vX PUT %TARGET%/mil_opcom
curl -k -vX PUT %TARGET%/sys_aar
curl -k -vX PUT %TARGET%/sys_logistics
curl -k -vX PUT %TARGET%/sys_marker
curl -k -vX PUT %TARGET%/sys_patrolrep
curl -k -vX PUT %TARGET%/sys_profile
curl -k -vX PUT %TARGET%/sys_sitrep
curl -k -vX PUT %TARGET%/sys_spotrep
curl -k -vX PUT %TARGET%/sys_tasks

REM PULL REPLICATION

REM Replicate design documents only for events
curl -H "Content-Type: application/json" -vX POST %TARGET%/_replicator/ -d "{\"source\": \"%SOURCE%/events\",\"target\": \"%TARGET%/events\",\"doc_ids\":[\"_design/kill\",\"_design/playerTable\",\"_design/playerPage\",\"_design/groupTable\",\"_design/groupPage\",\"_design/homePage\",\"_design/operationsTable\",\"_design/operationPage\",\"_design/blockAnonWrites\",\"_design/blockUpdates\",\"_design/classes\",\"_design/pruneEvents\"],\"user_ctx\": {\"name\":\"aliveadmin\",\"roles\": [\"reader\",\"writer\"]}}"

REM Replicate design docs for sys_perf
curl -H "Content-Type: application/json" -vX POST %TARGET%/_replicator/ -d "{\"source\": \"%SOURCE%/sys_perf\",\"target\": \"%TARGET%/sys_perf\",\"doc_ids\":[\"_design/sys_perf\",\"_design/blockAnonWrites\"],\"user_ctx\": {\"name\":\"aliveadmin\",\"roles\": [\"reader\",\"writer\"]}}"

REM Replicate design docs for sys_player
curl -H "Content-Type: application/json" -vX POST %TARGET%/_replicator/ -d "{\"source\": \"%SOURCE%/sys_player\",\"target\": \"%TARGET%/sys_player\",\"doc_ids\":[\"_design/blockAnonWrites\"],\"user_ctx\": {\"name\":\"aliveadmin\",\"roles\": [\"reader\",\"writer\"]}}"

REM Replicate design docs for sys_data
curl -H "Content-Type: application/json" -vX POST %TARGET%/_replicator/ -d "{\"source\": \"%SOURCE%/sys_data\",\"target\": \"%TARGET%/sys_data\",\"doc_ids\":[\"_design/blockAnonWrites\",\"config\"],\"user_ctx\": {\"name\":\"aliveadmin\",\"roles\": [\"reader\",\"writer\"]}}"

REM Replicate design docs for sys_marker
curl -H "Content-Type: application/json" -vX POST %TARGET%/_replicator/ -d "{\"source\": \"%SOURCE%/sys_marker\",\"target\": \"%TARGET%/sys_marker\",\"doc_ids\":[\"_design/blockAnonWrites\",\"_design/markers\"],\"user_ctx\": {\"name\":\"aliveadmin\",\"roles\": [\"reader\",\"writer\"]}}"

REM Replicate design docs for sys_AAR
curl -H "Content-Type: application/json" -vX POST %TARGET%/_replicator/ -d "{\"source\": \"%SOURCE%/sys_AAR\",\"target\": \"%TARGET%/sys_AAR\",\"doc_ids\":[\"_design/blockAnonWrites\",\"_design/AAR\"],\"user_ctx\": {\"name\":\"aliveadmin\",\"roles\": [\"reader\",\"writer\"]}}"

REM Replicate all data for Players and Groups - REM THIS OUT IF YOU DON'T WANT DATA FROM WEBSITE
curl -H "Content-Type: application/json" -vX POST %TARGET%/_replicator/ -d "{\"source\": \"%SOURCE%/players\",\"target\": \"%TARGET%/players\",\"user_ctx\": {\"name\":\"aliveadmin\",\"roles\": [\"reader\",\"writer\"]}}"

curl -H "Content-Type: application/json" -vX POST %TARGET%/_replicator/ -d "{\"source\": \"%SOURCE%/groups\",\"target\": \"%TARGET%/groups\",\"user_ctx\": {\"name\":\"aliveadmin\",\"roles\": [\"reader\",\"writer\"]}}"

curl -H "Content-Type: application/json" -vX POST %TARGET%/_replicator/ -d "{\"source\": \"%SOURCE%/_users\",\"target\": \"%TARGET%/_users\",\"user_ctx\": {\"name\":\"aliveadmin\",\"roles\": [\"reader\",\"writer\"]}}"

REM All Credits data
curl -H "Content-Type: application/json" -vX POST %TARGET%/_replicator/ -d "{\"source\": \"%SOURCE%/credits\",\"target\": \"%TARGET%/credits\",\"user_ctx\": {\"name\":\"aliveadmin\",\"roles\": [\"reader\",\"writer\"]}}"

