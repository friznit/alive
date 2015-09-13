//-- Waypoint Type
if !(lbCurSel 7265 == -1) then {
	STCWaypointType = lbData [7265, lbCurSel 7265];
};

//-- Waypoint Speed
if !(lbCurSel 7267 == -1) then {
	STCWaypointSpeed = lbData [7267, lbCurSel 7267];
};

//-- Waypoint Formation
if !(lbCurSel 7269 == -1) then {
	STCWaypointFormation = lbData [7269, lbCurSel 7269];
};

//-- Waypoint Behavior
if !(lbCurSel 7271 == -1) then {
	STCWaypointBehavior = lbData [7271, lbCurSel 7271];
};