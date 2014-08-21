#include <\x\alive\addons\sys_marker\script_component.hpp>
#define ICON_LIST 80104
#define FILL_LIST 80110
#define COLOR_LIST 80105

SCRIPT(markerOnLoad);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_markerOnLoad
Description:
Handles the onload event for a dialog

Parameters:
_this select 0: DISPLAY - Reference to calling display

Returns:
Nil

See Also:
- <ALIVE_fnc_marker>

Author:
Tupolov

Peer Reviewed:
nil
---------------------------------------------------------------------------- */

// SPAGHETTI!

private ["_params","_display","_color","_ValueIcon","_ValueSize","_ValueClass","_ValueFill","_class","_brush","_type","_i","_Marker","_pos","_data"];

_params = _this select 0;

_pos = uiNamespace getVariable [QGVAR(pos),[0,0,0]];

// Load config info if it doesn't exist
_data = uiNamespace getVariable QGVAR(CfgMarkers);

if (isNil "_data") then {

	private ["_config","_entry","_ar","_configClasses","_pic"];

	_configClasses = ["CfgMarkers","CfgMarkerClasses","CfgMarkerColors","CfgMarkerBrushes",["CfgChainOfCommand","Sizes"]];
	{
		private ["_config","_entry","_ar"];
		_ar = [];
		if (typeName _x != "ARRAY") then {
			_config = configFile >> _x;
		} else {
			_config = configFile >> (_x select 0) >> (_x select 1);
		};
		for "_i" from 0 to (count _config) - 1 do {
		  _entry = _config select _i;
		  if (isClass _entry) then {
		  	private ["_scope"];
		  	_scope = getNumber (_entry >> "scope");
		  	if (   ( configName(inheritsFrom(_entry)) == ""  && _scope == 0 && (configName _entry != "Flag")) || _scope > 0 ) then {
			    _ar set [count _ar, configName _entry];
			};
		  };
		};
		if (typeName _x != "ARRAY") then {
			uiNamespace setVariable [format["ALIVE_SYS_marker_%1",_x], _ar];
		} else {
			uiNamespace setVariable [format["ALIVE_SYS_marker_%1",(_x select 0)], _ar];
		};
	} foreach _configClasses;

};


//--- Listbox colors (marker textures are white, wee need to set darker background)
_color = ["GUI","BCG_RGB"] call bis_fnc_displaycolorget;
{_color set [_foreachindex,_x];} foreach _color;
_color set [3,1];

_display = _params select 0;

// Icon Classes ----------------------------------------------------------------------------
_ValueClass = _display displayctrl 80120;
_ValueClass ctrladdeventhandler [
	"lbselchanged",
	"
			[_this, 80120] call ALIVE_fnc_markerlbselchanged;
	"
];

{
	private ["_index", "_class"];
	_class = (gettext (configfile >> "cfgmarkerclasses" >> _x >> "displayName"));
	_index = _ValueClass lbAdd _class;
	_ValueClass lbSetData [_index, _x];
} foreach (uiNamespace getVariable QGVAR(CfgMarkerClasses));
//-----------------------------------------------------------------------------------------

// Icon Types - updated in LBSelChanged
_ValueIcon = _display displayctrl ICON_LIST;
_ValueIcon ctrladdeventhandler [
	"lbselchanged",
	"
			[_this, 80104] call ALIVE_fnc_markerlbselchanged;
			[_this, 80105] call ALIVE_fnc_markerlbselchanged;

	"
];
//lbsort _ValueIcon;
//_ValueIcon ctrlsetbackgroundcolor _color;	//done in rscCommon.inc
_ValueIcon ctrlsettextcolor [1,1,1,1];


//--- Fill
_ValueFill = _display displayctrl FILL_LIST;
_ValueFill ctrladdeventhandler [
	"lbselchanged",
	"
			[_this, 80110] call ALIVE_fnc_markerlbselchanged;
			[_this, 80105] call ALIVE_fnc_markerlbselchanged;

	"
];

{
	private "_index";
	_index = _ValueFill lbAdd (gettext (configfile >> "cfgmarkerbrushes" >> _x >> "name"));
	_ValueFill lbSetData [_index, _x];
} foreach (uiNamespace getVariable QGVAR(CfgMarkerBrushes));

//_ValueFill ctrlsetbackgroundcolor _color;	//done in rscCommon.inc
_ValueFill ctrlsettextcolor [1,1,1,1];

for "_i" from 0 to (lbsize _ValueFill - 1) do {
	_class = _ValueFill lbdata _i;
	_brush = gettext (configfile >> "cfgmarkerbrushes" >> _class >> "texture");
	if (_brush == "") then {_brush = "#(argb,8,8,3)color(1,1,1,0.5)";};
	_ValueFill lbsetpicture [_i,_brush];
	_ValueFill lbsetcolor [_i,[0,0,0,1]];
};

//--- Color
_ValueColorName = _display displayctrl COLOR_LIST;
_ValueColorName ctrladdeventhandler [
	"lbselchanged",
	"
			[_this, 80105] call ALIVE_fnc_markerlbselchanged;

	"
];

{
	private "_index";
	_index = _ValueColorName lbAdd (gettext (configfile >> "cfgmarkercolors" >> _x >> "name"));
	_ValueColorName lbSetData [_index, _x];
} foreach (uiNamespace getVariable QGVAR(CfgMarkerColors));

for "_i" from 0 to (lbsize _ValueColorName - 1) do {
	_class = _ValueColorName lbdata _i;
	_color = (configfile >> "cfgmarkercolors" >> _class >> "color") call BIS_fnc_colorConfigToRGBA;
	_ValueColorName lbsetpicture [_i,format ["#(argb,8,8,3)color(%1,%2,%3,%4)",_color select 0,_color select 1,_color select 2,_color select 3]];
};

//--- Shape
_Marker = _display displayctrl 80103;
_Marker ctrladdeventhandler ["toolboxSelChanged",
	"
		_id = _this select 1;
			if (_id == 0) then {
				ctrlShow [80104, true];
				ctrlShow [80110, false];
				ctrlShow [80120, true];
				ctrlShow [80119, true];
				ctrlSetText [80109, 'TYPE:'];
				[_this, 80104] call ALIVE_fnc_markerlbselchanged;
			} else {
				ctrlShow [80104, false];
				ctrlShow [80110, true];
				ctrlShow [80120, false];
				ctrlShow [80119, false];
				ctrlSetText [80109, 'FILL:'];
				[_this, 80110] call ALIVE_fnc_markerlbselchanged;
			};
			[_this, 80105, true] call ALIVE_fnc_markerlbselchanged;
	"
];

// Enemy Side/Faction/Type
_enemyGroup = _display displayctrl 801013;
_enemyGroup ctrladdeventhandler [
	"lbselchanged",
	"
			[_this, 801013] call ALIVE_fnc_markerlbselchanged;

	"
];

private ["_sides","_i"];
_sides = configFile >> "CfgGroups";
for "_i" from 0 to count _sides -1 do {
	private ["_side","_f"];
	_side = _sides select _i;
	if (isClass _side) then {
		for "_f" from 0 to count _side -1 do {
			private ["_faction","_index"];
			if ( configName _side != "Empty") then {
				_faction = _side select _f;
				if (isClass _faction) then {
					_index = _enemyGroup lbAdd format ["%1 - %2", gettext ( _side >> "name"), gettext ( _faction >> "name")];
					_enemyGroup lbSetData [_index, str(_faction)];
				};
			};
		};
	};
};

// Size
_ValueSize = _display displayctrl 801024;
{
	private ["_index", "_class","_size"];
	_class = (gettext (configfile >> "CfgChainOfCommand" >> "Sizes" >> _x >> "name"));
	if (_class != "") then {
		_size = getNumber (configfile >> "CfgChainOfCommand" >> "Sizes" >> _x >> "size");
		if (_class == "Fireteam" && _size == 2) then {
			_class = "Section";
		};
		_index = _ValueSize lbAdd _class;
		_ValueSize lbSetValue [_index, _size];
		_ValueSize lbSetData [_index, _x];
	};
} foreach (uiNamespace getVariable QGVAR(CfgChainOfCommand));

lbSortByValue _ValueSize;

// Activity
_activityControl = _display displayctrl 801018;
_activity = [
	["ATTACKING", 1],
	["DEFENDING", 2],
	["RESUPPLY", 3],
	["WITHDRAWING", 4],
	["STATIC", 5],
	["PATROL", 6],
	["DESTROYED", 7]
];

{
	_index = _activityControl lbAdd (_x select 0);
	_activityControl lbSetData [_index, str(_x select 1)];
} foreach _activity;

// Friendly Activity
_actionControl = _display displayctrl 801027;
_action = [
	["ATTACKING", 1],
	["DEFENDING", 2],
	["OBSERVING", 3],
	["WITHDRAWING", 4],
	["RE-ORG", 5],
	["AWAITING FURTHER ORDERS", 6],
	["CONTINUING MISSION", 7]
];

{
	_index = _actionControl lbAdd (_x select 0);
	_actionControl lbSetData [_index, str(_x select 1)];
} foreach _action;

// Eyes Only
_eyesControl = _display displayctrl 801019;
_eyes = [
	["UNCLASSIFIED (PUBLIC)", "GLOBAL"],
	[format ["CLASSIFIED Confidential (%1 ONLY)", side player], "SIDE"],
	[format ["CLASSIFIED Secret (%1 ONLY)", getText (configFile >> "CfgFactionClasses" >> faction player >> "displayName")], "FACTION"],
	[format ["CLASSIFIED Top Secret (%1 ONLY)", group player], "GROUP"],
	["PRIVATE", "LOCAL"]
];

{
	_index = _eyesControl lbAdd (_x select 0);
	_eyesControl lbSetData [_index, (_x select 1)];
} foreach _eyes;

//--- Initial icon set (after delay to distinguish icon/brush)
[] spawn {
		private ["_ValueIcon","_ValueColorName","_pos"];
		_pos = uiNamespace getVariable [QGVAR(pos),[0,0,0]];
		diag_log str _pos;

		disableSerialization;
		_ValueIcon = (findDisplay 80001) displayCtrl 80104;
		_ValueColorName = (findDisplay 80001) displayCtrl 80105;

		_ValueIcon ctrlShow true;
		ctrlShow [80110, false];
		lbSetCurSel [80120, 5];
		ctrlSetText [80109, 'TYPE:'];
		ctrlSetText [80102, str(player)];
		ctrlSetText [80111, [date] call ALIVE_fnc_dateToDTG];
		ctrlSetText [80106,"20"];
		ctrlSetText [80107,"20"];
		ctrlSetText [80108,"0"];
		ctrlSetText [801009, [date] call ALIVE_fnc_dateToDTG];
		ctrlSetText [801011, mapGridPosition _pos];
		lbSetCurSel [801019, 1];

		[[_ValueIcon], if (ctrlshown _ValueIcon) then {80104} else {80110}] call ALIVE_fnc_markerlbselchanged;
		[[_ValueColorName], 80105] call ALIVE_fnc_markerlbselchanged;

};


//Sets all static texts toUpper---------------------------------------------------------------------------------------------
_classInsideControls = configfile >> "RscDisplayALIVEInsertMarker" >> "controls";

for "_i" from 0 to (count _classInsideControls - 1) do {   //go to all subclasses
	_current = _classInsideControls select _i;

	//do not toUpper texts inserted by player
	if ( (configName(inheritsFrom(_current)) != "RscEdit")
		&& (configName(inheritsFrom(_current)) != "RscToolbox")
		&& (configName(inheritsFrom(_current)) != "ALIVE_ValueName")  ) then
	{
		//search inside main controls class
		_idc = getnumber (_current >> "idc");
		_control = _display displayctrl _idc;
		// Set combos to 0
		if (getnumber (_current >> "type") == 4) then {
			_control lbSetCurSel 0;
		} else {
			_control ctrlSetText (toUpper (ctrlText _control));
		};

	};
};
//Sets all static texts toUpper---------------------------------------------------------------------------------------------
