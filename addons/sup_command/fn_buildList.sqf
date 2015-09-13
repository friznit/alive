params ["_list"];

switch (_list) do {

	//-- Battlefield analysis
	case "battlefieldanalysis": {
		_faction = getText (configfile >> "CfgFactionClasses" >> (faction player) >> "displayName");
		lbAdd [7237, (format ["%1 commander's orders", _faction])];
		lbAdd [7237, "Mark units"];
		lbSetTooltip [7237, 0, "Mark objectives and color code them based on your OPCOM's orders; White\Yellow: Idle, Green: Reserved, Blue: Defend, Red: Attack"];
		lbSetTooltip [7237, 1, "Mark all groups on your side"];
	};

	//-- Missions
	case "missions": {
		lbAdd [7239, "Reinforcements"];
		lbAdd [7239, "Recon"];
		lbAdd [7239, "Assault"];
		lbSetTooltip [7239, 0, "Call for nearby friendly troops to come to the location"];
		lbSetTooltip [7239, 1, "Call for a friendly recon team to move to the area and mark any visible enemies; Only uses one group regardless of settings"];
		lbSetTooltip [7239, 2, "Call for nearby friendly troops to assault a location"];
	};

	//-- Group behaviors
	case "groupbehavior": {

		//-- Behaviors
		_behaviors = ["Careless","Safe","Aware","Combat","Stealth"];

		//-- Build list
		{
			lbAdd [7248, _x];
			lbSetData [7248, _forEachIndex, _x];
		} forEach _behaviors;

		//-- Switches selection to current behavior of group
		switch (toLower (behaviour player)) do {
			case "careless": {lbSetCurSel [7248,0]};
			case "safe": {lbSetCurSel [7248,1]};
			case "aware": {lbSetCurSel [7248,2]};
			case "combat": {lbSetCurSel [7248,3]};
			case "stealth": {lbSetCurSel [7248,4]};
		};

	};

	//-- Group formations
	case "groupformation": {

		//-- Formations
		_formations = [["File","FILE"],["Column","COLUMN"],["Staggered Column","STAG COLUMN"],["Wedge","WEDGE"],["Echelon Left","ECH LEFT"],["Echelon Right","ECH RIGHT"],["Vee","VEE"],["Line","LINE"],["Diamond","DIAMOND"]];

		//-- Build list
		{
			lbAdd [7246, _x select 0];
			lbSetData [7246, _forEachIndex, _x select 1];
		} forEach _formations;

		//-- Switches selection to current formation of group
		switch (toLower (formation group player)) do {
			case "file": {lbSetCurSel [7246,0]};
			case "column": {lbSetCurSel [7246,1]};
			case "stag column": {lbSetCurSel [7246,2]};
			case "wedge": {lbSetCurSel [7246,3]};
			case "ech left": {lbSetCurSel [7246,4]};
			case "ech right": {lbSetCurSel [7246,5]};
			case "vee": {lbSetCurSel [7246,6]};
			case "line": {lbSetCurSel [7246,7]};
			case "diamond": {lbSetCurSel [7246,8]};
		};

	};

	//-- Squadlist
	case "squadlist": {

		//-- Clean any existing displayed squadmates
		lbClear 7245;
		lbClear 7244;

		_units = units group player;
		player setVariable ["STCcurrentGroup", _units];

		//-- Initialize group list
		{
			if (alive _x) then {
				_row = lbAdd [7245,name _x];
			};
		} forEach _units;

	};

	//-- High Command group lister
	case "grouplister": {

		_groups = ["client"] call ALiVE_fnc_getProfilesByType;
		if (count _groups == 0) exitWith {};
		_combinedData = [];

		//-- Combine data into single array (for use with "find" command)
		for "_i" from 0 to ((count _groups) - 1) do {
			_profileArray = _groups select _i;

			{
				_combinedData pushBack _x;
			} forEach _profileArray;
		};
		player setVariable ["STCGroups", _combinedData];


		_groups params ["_infantry","_motorised","_mechanized","_armor","_air","_sea","_artillery","_AAA"];

		_index = 0;
		{
			_text = format ["Infantry Group %1", _forEachIndex + 1];
			lbAdd [7254, _text];
			lbSetData [7254, _index, _x];
			_index = _index + 1;
		} forEach _infantry;

		{
			_text = format ["Motorised Group %1", _forEachIndex + 1];
			lbAdd [7254, _text];
			lbSetData [7254, _index, _x];
			_index = _index + 1;
		} forEach _motorised;

		{
			_text = format ["Mechanized Group %1", _forEachIndex + 1];
			lbAdd [7254, _text];
			lbSetData [7254, _index, _x];
			_index = _index + 1;
		} forEach _mechanized;

		{
			_text = format ["Armor Group %1", _forEachIndex + 1];
			lbAdd [7254, _text];
			lbSetData [7254, _index, _x];
			_index = _index + 1;
		} forEach _armor;

		{
			_text = format ["Air Group %1", _forEachIndex + 1];
			lbAdd [7254, _text];
			lbSetData [7254, _index, _x];
			_index = _index + 1;
		} forEach _air;

		{
			_text = format ["Naval Group %1", _forEachIndex + 1];
			lbAdd [7254, _text];
			lbSetData [7254, _index, _x];
			_index = _index + 1;
		} forEach _sea;

		{
			_text = format ["Artillery Group %1", _forEachIndex + 1];
			lbAdd [7254, _text];
			lbSetData [7254, _index, _x];
			_index = _index + 1;
		} forEach _artillery;

		{
			_text = format ["Anti-Air Group %1", _forEachIndex + 1];
			lbAdd [7254, _text];
			lbSetData [7254, _index, _x];
			_index = _index + 1;
		} forEach _AAA;

	};

	//-- Waypoint types
	case "waypointtype": {

		//-- Waypoint Types
		{
			lbAdd [7265, _x];
			lbSetData [7265, _forEachIndex, toUpper _x];
		} forEach ["Move","SAD","Cycle"];

		switch (toLower STCWaypointType) do {
			case "move": {lbSetCurSel [7265, 0]};
			case "sad": {lbSetCurSel [7265, 1]};
			case "cycle": {lbSetCurSel [7265, 2]};
		};

	};

	//-- Waypoint speeds
	case "waypointspeed": {

		//-- Waypoint Speed
		{
			lbAdd [7267, _x];
			lbSetData [7267, _forEachIndex, toUpper _x];
		} forEach ["Unchanged","Limited","Normal","Full"];

		switch (toLower STCWaypointSpeed) do {
			case "unchanged": {lbSetCurSel [7267, 0]};
			case "limited": {lbSetCurSel [7267, 1]};
			case "normal": {lbSetCurSel [7267, 2]};
			case "full": {lbSetCurSel [7267, 3]};
		};
	};

	//-- Waypoint formations
	case "waypointformation": {

		//-- Waypoint Formation
		{
			lbAdd [7269, _x select 0];
			lbSetData [7269, _forEachIndex, _x select 1];
		} forEach [["File","FILE"],["Column","COLUMN"],["Staggered Column","STAG COLUMN"],["Wedge","WEDGE"],["Echelon Left","ECH LEFT"],["Echelon Right","ECH RIGHT"],["Vee","VEE"],["Line","LINE"],["Diamond","DIAMOND"]];

		switch (toLower STCWaypointFormation) do {
			case "file": {lbSetCurSel [7269, 0]};
			case "column": {lbSetCurSel [7269, 1]};
			case "stag column": {lbSetCurSel [7269, 2]};
			case "wedge": {lbSetCurSel [7269, 3]};
			case "ech left": {lbSetCurSel [7269, 4]};
			case "ech right": {lbSetCurSel [7269, 5]};
			case "vee": {lbSetCurSel [7269, 6]};
			case "line": {lbSetCurSel [7269, 7]};
			case "diamond": {lbSetCurSel [7269, 8]};
		};

	};

	//-- Waypoint behavior
	case "waypointbehavior": {
		{
			lbAdd [7271, _x];
			lbSetData [7271, _forEachIndex, toUpper _x];
		} forEach ["Careless","Safe","Aware","Combat","Stealth"];

		switch (toLower STCWaypointBehavior) do {
			case "careless": {lbSetCurSel [7271, 0]};
			case "safe": {lbSetCurSel [7271, 1]};
			case "aware": {lbSetCurSel [7271, 2]};
			case "combat": {lbSetCurSel [7271, 3]};
			case "stealth": {lbSetCurSel [7271, 4]};
		};
	};
};