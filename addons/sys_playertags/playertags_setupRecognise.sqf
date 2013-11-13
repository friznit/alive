#include <\x\alive\addons\sys_playertags\script_component.hpp>

private ["_distance", "_tolerance", "_scale"];
PARAMS_3(_distance,_tolerance,_scale);

playertags_distance = _distance; 
playertags_tolerance = _tolerance;
playertags_scale = _scale;

	if(PLAYERTAGS_DEBUG) then {
		["ALIVE Player Tags - playertags_distance: %1, playertags_tolerance: %2, playertags_scale:, %3",playertags_distance, playertags_tolerance, playertags_scale] call ALIVE_fnc_dump;
	};

playertags_recognise = compile preprocessFileLineNumbers "\x\alive\addons\sys_playertags\playertags_recognise.sqf";
playertags_recogniseHandler = compile preprocessFileLineNumbers "\x\alive\addons\sys_playertags\playertags_recogniseHandler.sqf";
playertags_recogniseOverlayCtrl = compile preprocessFileLineNumbers "\x\alive\addons\sys_playertags\playertags_recogniseOverlayCtrl.sqf";
playertags_generateLabelText = compile preprocessFileLineNumbers "\x\alive\addons\sys_playertags\playertags_generateLabelText.sqf";
0 cutRsc ["playertagsOverlayRsc", "PLAIN"];
