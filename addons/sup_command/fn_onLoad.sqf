disableSerialization;
params ["_menu"];	//-- params ["_menu","_display"];

switch (toLower (_menu)) do {

	//-- Main
	case "main": {
		{
			_x call ALiVE_fnc_buildList;
		} forEach ["battlefieldanalysis","missions"];

		//-- Add eventHandler to map
		(findDisplay 723 displayCtrl 7232) ctrlAddEventHandler ["MouseButtonClick","_this spawn ALiVE_fnc_createMarker"];

		//-- Delete unit markers
		if (!isNil {player getVariable "STCUnitMarkers"}) exitWith {
			{deleteMarkerLocal _x} forEach (player getVariable "STCUnitMarkers");
			player setVariable ["STCUnitMarkers", nil];
		};
	};

	//-- Group manager
	case "groupmanager": {

		//-- Build lists
		{
			_x call ALiVE_fnc_buildList;
		} forEach ["squadlist","groupformation","groupbehavior"];

		//-- Track group list selection

		(findDisplay 724 displayCtrl 7245)  ctrlAddEventHandler ["LBSelChanged","
			_index = lbCurSel 7245;
			_units = player getVariable 'STCcurrentGroup';
			_unit = _units select _index;
			[_unit] call ALiVE_fnc_updateGearList;
		"];

	};

	//-- High command
	case "highcommand": {

		//-- Initialize variables
		STCGroupWaypoints = [];
		STCPlannedWaypoints = [];
		STCArrowMarkers = [];


		//-- Create waypoint default settings
		STCWaypointType = "MOVE";
		STCWaypointSpeed = "UNCHANGED";
		STCWaypointFormation = "WEDGE";
		STCWaypointBehavior = "SAFE";

		["grouplister"] call ALiVE_fnc_buildList;

		//-- Keep track of currently selected group
		(findDisplay 725 displayCtrl 7254)  ctrlAddEventHandler ["LBSelChanged","['client'] spawn ALiVE_fnc_onGroupSwitch"];

		STCHighCommandMode = "GroupSelect";
		//-- Select nearest unit when you map is clicked
		(findDisplay 725 displayCtrl 7252) ctrlAddEventHandler ["MouseButtonClick","_this spawn ALiVE_fnc_HighCommandMapClick"];

		//-- Disable Ambient Commands Button - WIP
		ctrlEnable [72510, false];

		//-- Mark units
		if (!isNil {player getVariable "STCUnitMarkers"}) then {
			{deleteMarkerLocal _x} forEach (player getVariable "STCUnitMarkers");
			player setVariable ["STCUnitMarkers", nil];
		};
		waitUntil {isNil {player getVariable "STCUnitMarkers"}};
		[] spawn ALiVE_fnc_markUnits;
	};

	//-- Waypoint Settings
	case "waypointsettings": {

		//-- Build lists
		{
			_x call ALiVE_fnc_buildList;
		} forEach ["waypointtype","waypointspeed","waypointformation","waypointbehavior"];

	};
};