#include <\x\alive\addons\sup_multispawn\script_component.hpp>
SCRIPT(establishingShotCustom);

/* ----------------------------------------------------------------------------
Function: ALiVE_fnc_establishingShotCustom

Description:
Returns all sides of given objects

Parameters:
_this select 0: OBJECT or ARRAY - Target position/object
_this select 1: STRING - Text to display
_this select 2 (Optional): NUMBER - Altitude (in meters)
_this select 3 (Optional): NUMBER - Radius of the circular movement (in meters)
_this select 4 (Optional): NUMBER - Viewing angle (in degrees)
_this select 5 (Optional): NUMBER - Direction of camera movement (0: anti-clockwise, 1: clockwise, default: random)
_this select 6 (Optional): ARRAY -	Objects/positions/groups to display icons over

Syntax: [[icon, color, target, size X, size Y, angle, text, shadow]]
_this select 7 (Optional): NUMBER - Mode (0: normal (default), 1: world scenes)

Returns:
nothing;

Examples:
(begin example)
_sides = ([] call BIS_fnc_ListPlayers) call ALiVE_fnc_establishingShotCustom;
(end)

See Also:
- nil

Author:
Thomas Ryan, Highhead

Peer reviewed:
nil
---------------------------------------------------------------------------- */

private ["_tgt", "_txt", "_alt", "_rad", "_ang", "_dir"];

if !(hasInterface) exitwith {};

_tgt = [_this, 0, objNull, [objNull, []]] call BIS_fnc_param;
_txt = [_this, 1, "", [""]] call BIS_fnc_param;
_alt = [_this, 2, 500, [500]] call BIS_fnc_param;
_rad = [_this, 3, 200, [200]] call BIS_fnc_param;
_ang = [_this, 4, random 360, [0]] call BIS_fnc_param;
_dir = [_this, 5, round random 1, [0]] call BIS_fnc_param;
_condition = [_this, 8, [[],{true}], [[]]] call BIS_fnc_param;

BIS_fnc_establishingShot_icons = [_this, 6, [], [[]]] call BIS_fnc_param;

private ["_mode"];

_mode = [_this, 7, 0, [0]] call BIS_fnc_param;

if (_mode == 0) then {
	enableSaving [false, false];
	BIS_missionStarted = nil;
};

["BIS_fnc_establishingShot",false] call BIS_fnc_blackOut;

// Create fake UAV
if (isNil "BIS_fnc_establishingShot_fakeUAV" || {isnull BIS_fnc_establishingShot_fakeUAV}) then {
	BIS_fnc_establishingShot_fakeUAV = "Camera" camCreate [10,10,10];
};

BIS_fnc_establishingShot_fakeUAV cameraEffect ["INTERNAL", "BACK"];

cameraEffectEnableHUD true;

private ["_pos", "_coords","_mul"];

_mul = [];

switch (typeName _tgt) do {
    case ("OBJECT") : {_pos = position _tgt};
    case ("ARRAY") : {
        if (count _tgt == 0) exitwith {_pos = [0,0,0]};
        
        if (typeName (_tgt select 0) == "SCALAR") then {
            _pos = _tgt;
        } else {
            _pos = position (_tgt select 0);
            _mul = +_tgt; _tgt = _tgt select 0;
        };
    };
};

diag_log _mul;

_coords = [_pos, _rad, _ang] call BIS_fnc_relPos;
_coords set [2, _alt];

BIS_fnc_establishingShot_fakeUAV camPrepareTarget _tgt;
BIS_fnc_establishingShot_fakeUAV camPreparePos _coords;
BIS_fnc_establishingShot_fakeUAV camPrepareFOV 0.700;
BIS_fnc_establishingShot_fakeUAV camCommitPrepared 0;

// Timeout the preload after 3 seconds
BIS_fnc_establishingShot_fakeUAV camPreload 3;

// Apply post-process effects
private ["_ppColor"];
_ppColor = ppEffectCreate ["colorCorrections", 1999];
_ppColor ppEffectEnable true;
_ppColor ppEffectAdjust [1, 1, 0, [1, 1, 1, 0], [0.8, 0.8, 0.8, 0.65], [1, 1, 1, 1.0]];
_ppColor ppEffectCommit 0;

private ["_ppGrain"];
_ppGrain = ppEffectCreate ["filmGrain", 2012];
_ppGrain ppEffectEnable true;
_ppGrain ppEffectAdjust [0.1, 1, 1, 0, 1];
_ppGrain ppEffectCommit 0;

// Disable stuff after simulation starts
[] spawn
{
	waitUntil {time > 0};
	showCinemaBorder false;
	enableEnvironment false;
};

private ["_SITREP", "_key"];

if (_mode == 1) then {
	optionsMenuOpened = {
		disableSerialization;
		{(_x call BIS_fnc_rscLayer) cutText ["", "PLAIN"]} forEach ["BIS_layerStatic", "BIS_layerInterlacing"];
	};
} else {
	// Compile SITREP text

    if (isnil "ALiVE_SUP_MULTISPAWN_TXT_LISTENER") then {ALiVE_SUP_MULTISPAWN_TXT_LISTENER = _txt};

	disableSerialization;

	waitUntil {!(isNull ([] call BIS_fnc_displayMission))};

	// Compile key
	_key = format ["BIS_%1.%2_establishingShot", missionName, worldName];

	// Remove eventhandler if it exists (only happens when restarting)
	if (!(isNil {uiNamespace getVariable "BIS_fnc_establishingShot_skipEH"})) then {
		([] call BIS_fnc_displayMission) displayRemoveEventHandler ["KeyDown", uiNamespace getVariable "BIS_fnc_establishingShot_skipEH"];
		uiNamespace setVariable ["BIS_fnc_establishingShot_skipEH", nil];
	};

	// Add skipping eventhandler
	private ["_skipEH"];
    
    if (isnil {uiNamespace getVariable "BIS_fnc_establishingShot_skipEH"}) then {
		_skipEH = ([] call BIS_fnc_displayMission) displayAddEventHandler [
			"KeyDown",
			format [
				"
					if (_this select 1 == 57) then {
						([] call BIS_fnc_displayMission) displayRemoveEventHandler ['KeyDown', uiNamespace getVariable 'BIS_fnc_establishingShot_skipEH'];
						uiNamespace setVariable ['BIS_fnc_establishingShot_skipEH', nil];
	
						playSound ['click', true];
	
						activateKey '%1';
						BIS_fnc_establishingShot_skip = true;
					};
	
					if (_this select 1 != 1) then {true};
				",
				_key
			]
		];
        uiNamespace setVariable ["BIS_fnc_establishingShot_skipEH", _skipEH];
    };
    
	// Create vignette & tiles
	("BIS_layerEstShot" call BIS_fnc_rscLayer) cutRsc ["RscEstablishingShot", "PLAIN"];

	// Remove effects if video options opened
	optionsMenuOpened = {
		disableSerialization;
		{(_x call BIS_fnc_rscLayer) cutText ["", "PLAIN"]} forEach ["BIS_layerEstShot", "BIS_layerStatic", "BIS_layerInterlacing"];
	};

	optionsMenuClosed = {
		disableSerialization;
		("BIS_layerEstShot" call BIS_fnc_rscLayer) cutRsc ["RscEstablishingShot", "PLAIN"];
	};

	waitUntil {!(isNull (uiNamespace getVariable "RscEstablishingShot"))};
};

// Wait for the camera to load
waitUntil {camPreloaded BIS_fnc_establishingShot_fakeUAV || !(isNil "BIS_fnc_establishingShot_skip")};

private ["_drawEH"];

BIS_fnc_establishingShot_playing = true;

// Create logic to play sounds
BIS_fnc_establishingShot_logic_group = createGroup sideLogic;
BIS_fnc_establishingShot_logic1 = BIS_fnc_establishingShot_logic_group createUnit ["Logic", [10,10,10], [], 0, "NONE"];
BIS_fnc_establishingShot_logic2 = BIS_fnc_establishingShot_logic_group createUnit ["Logic", [10,10,10], [], 0, "NONE"];
BIS_fnc_establishingShot_logic3 = BIS_fnc_establishingShot_logic_group createUnit ["Logic", [10,10,10], [], 0, "NONE"];

[] spawn {
	scriptName "BIS_fnc_establishingShot: UAV sound loop";

	// Determine duration
	private ["_sound", "_duration"];
	_sound = "UAV_loop";
	_duration = getNumber (configFile >> "CfgSounds" >> _sound >> "duration");

	while {!(isNull BIS_fnc_establishingShot_logic1)} do {
		BIS_fnc_establishingShot_logic1 say _sound;
		sleep _duration;

		if (!(isNull BIS_fnc_establishingShot_logic2)) then {
			BIS_fnc_establishingShot_logic2 say _sound;
			sleep _duration;
		};
	};
};

[] spawn {
	scriptName "BIS_fnc_establishingShot: random sounds control";

	while {!(isNull BIS_fnc_establishingShot_logic3)} do {
		// Choose random sound
		private ["_sound", "_duration"];
		_sound = format ["UAV_0%1", round (1 + random 8)];
		_duration = getNumber (configFile >> "CfgSounds" >> _sound >> "duration");

		BIS_fnc_establishingShot_logic3 say _sound;

		sleep (_duration + (5 + random 5));
	};
};

// Move camera in a circle
[_pos, _alt, _rad, _ang, _dir,_mul] spawn {
	scriptName "BIS_fnc_establishingShot: camera control";

	private ["_pos", "_alt", "_rad", "_ang", "_dir"];
	_pos = _this select 0;
	_alt = _this select 1;
	_rad = _this select 2;
	_ang = _this select 3;
	_dir = _this select 4;
    _mul = _this select 5;
    
    _time = time;

	while {isNil "BIS_missionStarted"} do {
		private ["_coords"];
		_coords = [_pos, _rad, _ang] call BIS_fnc_relPos;
		_coords set [2, _alt];

        if (count _mul > 0 && {time - _time > 20}) then {
            
            _mul = _mul - [objNull];
            
            _tgt = (_mul call BIS_fnc_SelectRandom);
            _pos = position _tgt;

            _coords = [_pos, _rad, _ang] call BIS_fnc_relPos; _coords set [2, _alt];
            
            BIS_fnc_establishingShot_fakeUAV camPrepareTarget _tgt;
			BIS_fnc_establishingShot_fakeUAV camPreparePos _coords;
			BIS_fnc_establishingShot_fakeUAV camPrepareFOV 0.700;
			BIS_fnc_establishingShot_fakeUAV camCommitPrepared 0;
            
            // Update SITREP
			BIS_fnc_establishingShot_SITREP = [
				[
					[((call ALiVE_fnc_compileReadableDate) select 0) + " ", ""],
					[((call ALiVE_fnc_compileReadableDate) select 1), "font = 'PuristaMedium'"],
					["", "<br/>"],
                    ["Grid: " + (mapGridPosition _tgt),""],
                    ["", "<br/>"],
                    ["Target: " + getText(configFile >> "cfgVehicles" >> typeof _tgt >> "displayName"),""],
                    ["", "<br/>"],
					[ALiVE_SUP_MULTISPAWN_TXT_LISTENER, ""]
				],
				0.015 * safeZoneW + safeZoneX,
				0.015 * safeZoneH + safeZoneY,
				false,
				"<t align = 'left' size = '1.0' font = 'PuristaLight'>%1</t>"
			] spawn BIS_fnc_typeText2;
            
            _time = time;
        } else {

			BIS_fnc_establishingShot_fakeUAV camPreparePos _coords;
			BIS_fnc_establishingShot_fakeUAV camCommitPrepared 0.5;
        };

		waitUntil {camCommitted BIS_fnc_establishingShot_fakeUAV || !(isNil "BIS_missionStarted")};

		BIS_fnc_establishingShot_fakeUAV camPreparePos _coords;
		BIS_fnc_establishingShot_fakeUAV camCommitPrepared 0;
		
		_ang = if (_dir == 0) then {_ang - 0.5} else {_ang + 0.5};
	};
};

// Display SITREP
BIS_fnc_establishingShot_SITREP = [
	[
		[((call ALiVE_fnc_compileReadableDate) select 0) + " ", ""],
		[((call ALiVE_fnc_compileReadableDate) select 1), "font = 'PuristaMedium'"],
		["", "<br/>"],
		[toUpper ALiVE_SUP_MULTISPAWN_TXT_LISTENER, ""]
	],
	0.015 * safeZoneW + safeZoneX,
	0.015 * safeZoneH + safeZoneY,
	false,
	"<t align = 'left' size = '1.0' font = 'PuristaLight'>%1</t>"
] spawn BIS_fnc_typeText2;

sleep 1;

enableEnvironment true;
2 fadeSound 1;

// Static fade-in
("BIS_layerStatic" call BIS_fnc_rscLayer) cutRsc ["RscStatic", "PLAIN"];
waitUntil {!(isNull (uiNamespace getVariable "RscStatic_display")) || !(isNil "BIS_fnc_establishingShot_skip")};
waitUntil {isNull (uiNamespace getVariable "RscStatic_display")  || !(isNil "BIS_fnc_establishingShot_skip")};

// Show interlacing
("BIS_layerInterlacing" call BIS_fnc_rscLayer) cutRsc ["RscInterlacing", "PLAIN"];

// Show screen
("BIS_fnc_blackOut" call BIS_fnc_rscLayer) cutText ["","PLAIN",10e10];

// Add interlacing to optionsMenuClosed
optionsMenuClosed = if (_mode == 0) then {
	{
		("BIS_layerEstShot" call BIS_fnc_rscLayer) cutRsc ["RscEstablishingShot", "PLAIN"];
		("BIS_layerInterlacing" call BIS_fnc_rscLayer) cutRsc ["RscInterlacing", "PLAIN"];
	};
} else {
	{
		("BIS_layerInterlacing" call BIS_fnc_rscLayer) cutRsc ["RscInterlacing", "PLAIN"];
	};
};

// Show icons
if (count BIS_fnc_establishingShot_icons > 0) then {
	_drawEH = addMissionEventHandler [
		"Draw3D",
		{
			{
				private ["_icon", "_color", "_target", "_sizeX", "_sizeY", "_angle", "_text", "_shadow"];
				_icon = [_x, 0, "", [""]] call BIS_fnc_param;
				_color = [_x, 1, [], [[]]] call BIS_fnc_param;
				_target = [_x, 2, [], [[], objNull, grpNull]] call BIS_fnc_param;
				_sizeX = [_x, 3, 1, [1]] call BIS_fnc_param;
				_sizeY = [_x, 4, 1, [1]] call BIS_fnc_param;
				_angle = [_x, 5, random 360, [0]] call BIS_fnc_param;
				_text = [_x, 6, "", [""]] call BIS_fnc_param;
				_shadow = [_x, 7, 0, [0]] call BIS_fnc_param;

				// Determine condition and position
				private ["_condition", "_position"];
				_condition = true;
				_position = _target;

				switch (typeName _target) do {
					// Object
					case typeName objNull: {
						_condition = alive _target;
						_position = getPosATL _target;
					};

					// Group
					case typeName grpNull: {
						_condition = {alive _x} count units _target > 0;
						_position = getPosATL leader _target;
					};
				};

				// Draw icon
				if (_condition) then {
					drawIcon3D [_icon, _color, _position, _sizeX, _sizeY, _angle, _text, _shadow];
				};
			} forEach BIS_fnc_establishingShot_icons;
		}
	];
};

if (_mode == 0) then {

	waitUntil {(_condition select 0) call (_condition select 1)};

	BIS_fnc_establishingShot_UAVDone = true;
};


if (_mode == 0) then {
	waitUntil {{!(isNil _x)} count ["BIS_fnc_establishingShot_UAVDone"] > 0};

	// Remove skipping eventhandler if it wasn't removed already
	if (!(isNil {uiNamespace getVariable "BIS_fnc_establishingShot_skipEH"})) then {
		([] call BIS_fnc_displayMission) displayRemoveEventHandler ["KeyDown", uiNamespace getVariable "BIS_fnc_establishingShot_skipEH"];
		uiNamespace setVariable ["BIS_fnc_establishingShot_skipEH", nil];
	};

	// Static fade-out
	2 fadeSound 0;

	("BIS_layerStatic" call BIS_fnc_rscLayer) cutRsc ["RscStatic", "PLAIN"];
	waitUntil {!(isNull (uiNamespace getVariable "RscStatic_display"))};
	waitUntil {isNull (uiNamespace getVariable "RscStatic_display")};
	
	// Remove SITREP
	if (!(isNil "BIS_fnc_establishingShot_SITREP")) then {
		terminate BIS_fnc_establishingShot_SITREP;
		["", 0, 0, 5, 0, 0, 90] spawn BIS_fnc_dynamicText;
	};

	// Delete sound logics and group
	{if (!(isNil _x)) then {deleteVehicle (missionNamespace getVariable _x)}} forEach ["BIS_fnc_establishingShot_logic1", "BIS_fnc_establishingShot_logic2", "BIS_fnc_establishingShot_logic3"];
	if (!(isNil "BIS_fnc_establishingShot_logic_group")) then {deleteGroup BIS_fnc_establishingShot_logic_group};

	// Remove HUD
	optionsMenuOpened = nil;
	optionsMenuClosed = nil;

	if (!(isNil "_drawEH")) then {
		removeMissionEventHandler ["Draw3D", _drawEH];
	};

	if (!(isNull (uiNamespace getVariable "RscEstablishingShot"))) then {
		((uiNamespace getVariable "RscEstablishingShot") displayCtrl 2500) ctrlSetFade 1;
		((uiNamespace getVariable "RscEstablishingShot") displayCtrl 2500) ctrlCommit 0;
	};

	{
		private ["_layer"];
		_layer = _x call BIS_fnc_rscLayer;
		_layer cutText ["", "PLAIN"];
	} forEach ["BIS_layerEstShot", "BIS_layerStatic", "BIS_layerInterlacing"];

	enableEnvironment false;
	("BIS_fnc_blackOut" call BIS_fnc_rscLayer) cutText ["","BLACK FADED",10e10];

	sleep 1;

	enableSaving [true, true];

	BIS_fnc_establishingShot_fakeUAV cameraEffect ["TERMINATE", "BACK"];
	//camDestroy BIS_fnc_establishingShot_fakeUAV;

	ppEffectDestroy _ppColor;
	ppEffectDestroy _ppGrain;

	// Clear existing global variables
	BIS_fnc_establishingShot_icons = nil;
	BIS_fnc_establishingShot_spaceEH = nil;
	BIS_fnc_establishingShot_skip = nil;
	BIS_fnc_establishingShot_UAVDone = nil;

	["BIS_fnc_establishingShot"] call BIS_fnc_blackIn;

	// Start mission
	BIS_missionStarted = true;
	BIS_fnc_establishingShot_playing = false;
};

true