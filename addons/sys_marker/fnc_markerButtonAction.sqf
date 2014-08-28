#include <\x\alive\addons\sys_marker\script_component.hpp>

SCRIPT(markerButtonAction);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_markerButtonAction
Description:
Handles the button action event for a dialog

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

private ["_params","_display","_controls","_shape","_xm","_y","_h","_w","_idc","_index","_ctrl","_pos","_check","_markerName","_markersHash"];

_display = findDisplay 80001;

_check = uiNamespace getVariable [QGVAR(edit), false];

_markerName = "mkr" + str(random time + 1);
_markersHash = [] call ALIVE_fnc_hashCreate;

// If editing a marker, delete the old one and create a new one.
if (typeName _check != "BOOL") then {
	[MOD(sys_marker), "removeMarker", [_check]] call ALiVE_fnc_marker;
};

// Get all the marker info

_colorIndex = lbCurSel COLOR_LIST;
_color = lbData [COLOR_LIST, _colorIndex];
_pos = uiNamespace getVariable [QGVAR(pos),[0,0,0]];
_size = [parseNumber(ctrlText SIZEA_VALUE), parseNumber(ctrlText SIZEB_VALUE)];
_dir = parseNumber(ctrlText ANGLE_VALUE);
_text = ctrlText LABEL_VALUE;
_shapeIndex = uiNamespace getVariable [QGVAR(shape),0];
_eyesIndex = lbCurSel EYES_LIST;
_eyes = lbData [EYES_LIST,_eyesIndex];

if (_shapeIndex == 0) then {
	_shape = "ICON";
	_size = [1,1];
	_classIndex = lbCurSel CLASS_LIST;
	_typeIndex = lbCurSel ICON_LIST;
	_type = lbData [ICON_LIST, _typeIndex];
	[_markersHash, QGVAR(classIndex), _classIndex] call ALIVE_fnc_hashSet;
	[_markersHash, QGVAR(typeIndex), _typeIndex] call ALIVE_fnc_hashSet;
	[_markersHash, QGVAR(type), _type] call ALIVE_fnc_hashSet;
} else {
	if (_shapeIndex == 1) then {_shape = "RECTANGLE";} else {_shape = "ELLIPSE";};
	_brushIndex = lbCurSel FILL_LIST;
	_brush = lbData [FILL_LIST, _brushIndex];
	[_markersHash, QGVAR(brush), _brush] call ALIVE_fnc_hashSet;
	[_markersHash, QGVAR(brushIndex), _brushIndex] call ALIVE_fnc_hashSet;
};

[_markersHash, QGVAR(shape), _shape] call ALIVE_fnc_hashSet;
[_markersHash, QGVAR(color), _color] call ALIVE_fnc_hashSet;
[_markersHash, QGVAR(size), _size] call ALIVE_fnc_hashSet;
[_markersHash, QGVAR(pos), _pos] call ALIVE_fnc_hashSet;
// [_markersHash, QGVAR(alpha), _alpha] call ALIVE_fnc_hashSet; TO DO
[_markersHash, QGVAR(dir), _dir] call ALIVE_fnc_hashSet;

[_markersHash, QGVAR(text), _text] call ALIVE_fnc_hashSet;

[_markersHash, QGVAR(locality), _eyes] call ALIVE_fnc_hashSet;

switch _eyes do {
	case "SIDE" : {
		[_markersHash, QGVAR(localityValue), str(side (group player))] call ALIVE_fnc_hashSet;
	};
	case "GROUP" : {
		[_markersHash, QGVAR(localityValue), str (group player)] call ALIVE_fnc_hashSet;
	};
	case "FACTION" : {
		[_markersHash, QGVAR(localityValue), faction player] call ALIVE_fnc_hashSet;
	};
};

[_markersHash, QGVAR(colorIndex), _colorIndex] call ALIVE_fnc_hashSet;
// [_markersHash, QGVAR(alphaIndex), _alphaIndex] call ALIVE_fnc_hashSet; TO DO
[_markersHash, QGVAR(shapeIndex), _shapeIndex] call ALIVE_fnc_hashSet;
[_markersHash, QGVAR(localityIndex), _eyesIndex] call ALIVE_fnc_hashSet;
[_markersHash, QGVAR(player), getPlayerUID player] call ALIVE_fnc_hashSet;


_sitrepCheck = _display displayCtrl SITREP_CHECK;
if (cbChecked _sitRepCheck) then {
	[_markersHash, QGVAR(hasSITREP), true] call ALIVE_fnc_hashSet;

	sitRepHash = [] call ALIVE_fnc_hashCreate;

	[ALIVE_SYS_marker, "createSitRep", _sitRepHash] call ALiVE_fnc_marker;

};

// Create a marker

[ALIVE_SYS_marker, "addMarker", [_markerName, _markersHash]] call ALiVE_fnc_marker;

closeDialog 0;
