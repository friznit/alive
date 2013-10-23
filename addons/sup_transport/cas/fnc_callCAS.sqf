
private["_group","_asloc"];

_asloc = createMarker ["asloc", [0,0,0]];
_asloc setMarkerShape "ICON";
"asloc" setMarkerType "hd_destroy";

openMap true;
hint "Select location for CAS";

ASclick = false;

onMapSingleClick "'asloc' setMarkerPos _pos;ASclick = true;true";

waitUntil{!visibleMap};

onMapSingleClick "";

_group = _this select 0;
_asloc = getMarkerPos "asloc";



g1wp1 = _group addWaypoint [_asloc, 75];
g1wp1 setWaypointBehaviour "COMBAT";
g1wp1 setWaypointStatements  ["true",""];
g1wp1 setWaypointType "SAD";
g1wp1 setWaypointTimeout [600,600, 600];

diag_log format ["Group: %1, Loc: %2", _group, _asloc];