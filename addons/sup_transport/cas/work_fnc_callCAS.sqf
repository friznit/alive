
private["_group","_asloc"];
_group = "B VIPER";
_asloc = getMarkerPos "asloc";


g1wp1 = _group addWaypoint [_asloc, 75];
g1wp1 setWaypointBehaviour "COMBAT";
g1wp1 setWaypointStatements  ["true",""];
g1wp1 setWaypointType "SAD";
g1wp1 setWaypointTimeout [600,600, 600];
