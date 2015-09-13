params ["_menu"];
disableSerialization;

//-- Common
hint "";

switch (toLower (_menu)) do {

	case "main": {

		//-- Reset variables
		if (!isNil {uiNamespace getVariable "SpyderCommandTablet_MissionPosition"}) then {
			deleteMarkerLocal (uiNamespace getVariable "SpyderCommandTablet_MissionPosition");
			uiNamespace setVariable ["SpyderCommandTablet_MissionPosition", nil];
		};

		//-- Delete objective analysis markers
		if (!isNil {player getVariable "STCObjectiveMarkers"}) then {
			{deleteMarkerLocal _x} forEach (player getVariable "STCObjectiveMarkers");
			player setVariable ["STCObjectiveMarkers", nil];
		};

		//-- Delete unit markers
		if (!isNil {player getVariable "STCUnitMarkers"}) exitWith {
			{deleteMarkerLocal _x} forEach (player getVariable "STCUnitMarkers");
			player setVariable ["STCUnitMarkers", nil];
		};

		//-- Reset objective data
		STCObjectives = nil;

		//-- Delete mission position marker
		if (isNil {uiNamespace getVariable "SpyderCommandTablet_MissionPosition"}) then {
			deleteMarker (uiNamespace getVariable "SpyderCommandTablet_MissionPosition");
			uiNamespace setVariable ["SpyderCommandTablet_MissionPosition", nil];
		};

	};

	case "groupmanager": {

		player setVariable ["STCcurrentGroup", nil];

	};

	case "highcommand": {

		if (!isNil {player getVariable "STCGroups"}) then {
			STCGroups = nil;
		};

		STCHighCommandMode = nil;

		//-- Delete any showing waypoints
		if (!isNil "STCGroupWaypoints") then {{deleteMarkerLocal _x} forEach STCGroupWaypoints;STCGroupWaypoints = nil};
		if (!isNil "STCPlannedWaypoints") then {{deleteMarkerLocal (_x select 0)} forEach STCPlannedWaypoints;STCPlannedWaypoints = nil};
		if (!isNil "STCArrowMarkers") then {{deleteMarkerLocal _x} forEach STCArrowMarkers;STCArrowMarkers = nil};

		//-- Delete unit markers
		if (!isNil {player getVariable "STCUnitMarkers"}) exitWith {
			{deleteMarkerLocal _x} forEach (player getVariable "STCUnitMarkers");
			player setVariable ["STCUnitMarkers", nil];
		};

	};

};