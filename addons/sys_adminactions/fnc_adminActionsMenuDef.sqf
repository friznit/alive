#include <\x\alive\addons\sys_adminactions\script_component.hpp>
#include <\x\cba\addons\ui_helper\script_dikCodes.hpp>

private ["_menuDef", "_target", "_params", "_menuName", "_menuRsc", "_menus"];
// _this==[_target, _menuNameOrParams]

PARAMS_2(_target,_params);

_menuName = "";
_menuRsc = "popup";

if (typeName _params == typeName []) then {
	if (count _params < 1) exitWith {diag_log format["Error: Invalid params: %1, %2", _this, __FILE__];};
	_menuName = _params select 0;
	_menuRsc = if (count _params > 1) then {_params select 1} else {_menuRsc};
} else {
	_menuName = _params;
};
//-----------------------------------------------------------------------------
/*
        ["Menu Caption", "flexiMenu resource dialog", "optional icon folder", menuStayOpenUponSelect],
        [
            ["caption", 
                "action", 
                "icon", 
                "tooltip", 
                {"submenu"|["menuName", "", {0|1} (optional - use embedded list menu)]}, 
                -1 (shortcut DIK code),
                {0|1/"0"|"1"/false|true} (enabled), 
                {-1|0|1/"-1"|"0"|"1"/false|true} (visible)
            ],
             ...
*/
_menus =
[
	[
		["main", "ALiVE", _menuRsc],
		[
			[localize "STR_ALIVE_ADMINACTIONS" + " >",
				"",
				"",
				localize "STR_ALIVE_ADMINACTIONS_COMMENT",
                                ["call ALIVE_fnc_adminActionsMenuDef", "adminActions", 1],
                                -1, 1, call ALIVE_fnc_isServerAdmin
			]
		]
	]
];

if (_menuName == "adminActions") then {
	_menus set [count _menus,
		[
			["adminActions", localize "STR_ALIVE_ADMINACTIONS", "popup"],
			[
				[localize "STR_ALIVE_ADMINACTIONS_GHOST_ENABLE",
					{ player setCaptive true },
					"",
					localize "STR_ALIVE_ADMINACTIONS_GHOST_COMMENT",
					"",
					-1,
					ALIVE_adminActions getVariable ["ghost", 0],
					!captive player
				],
				[localize "STR_ALIVE_ADMINACTIONS_GHOST_DISABLE",
					{ player setCaptive false },
					"",
					localize "STR_ALIVE_ADMINACTIONS_GHOST_COMMENT",
					"",
					-1,
					ALIVE_adminActions getVariable ["ghost", 0],
					captive player
				],
				[localize "STR_ALIVE_ADMINACTIONS_TELEPORT_ENABLE",
					{ ALIVE_adminActions setVariable ["teleport_enabled", true]; onMapSingleClick {player setPos _pos;} },
					"",
					localize "STR_ALIVE_ADMINACTIONS_TELEPORT_COMMENT",
					"",
					-1,
					ALIVE_adminActions getVariable ["teleport", 0],
					!(ALIVE_adminActions getVariable ["teleport_enabled", false])
				],
				[localize "STR_ALIVE_ADMINACTIONS_TELEPORT_DISABLE",
					{ ALIVE_adminActions setVariable ["teleport_enabled", false]; onMapSingleClick DEFAULT_MAPCLICK; },
					"",
					localize "STR_ALIVE_ADMINACTIONS_TELEPORT_COMMENT",
					"",
					-1,
					ALIVE_adminActions getVariable ["teleport", 0],
					(ALIVE_adminActions getVariable ["teleport_enabled", false])
				],
				[localize "STR_ALIVE_ADMINACTIONS_SPECTATE_ENABLE",
					{ [] call ace_fnc_startSpectator },
					"",
					localize "STR_ALIVE_ADMINACTIONS_SPECTATE_COMMENT",
					"",
					-1,
					ALIVE_adminActions getVariable ["spectate", 0],
					!isNil "ace_fnc_startSpectator"
				],
				[localize "STR_ALIVE_ADMINACTIONS_CAMERA_ENABLE",
					{ [player] call BIS_fnc_camera },
					"",
					localize "STR_ALIVE_ADMINACTIONS_CAMERA_COMMENT",
					"",
					-1,
					ALIVE_adminActions getVariable ["camera", 0],
					true
				]
			]
		]
	];
};

//-----------------------------------------------------------------------------
_menuDef = [];
{
	if (_x select 0 select 0 == _menuName) exitWith {_menuDef = _x};
} forEach _menus;

if (count _menuDef == 0) then {
	hintC format ["Error: Menu not found: %1\n%2\n%3", str _menuName, if (_menuName == "") then {_this}else{""}, __FILE__];
	diag_log format ["Error: Menu not found: %1, %2, %3", str _menuName, _this, __FILE__];
};

_menuDef // return value
