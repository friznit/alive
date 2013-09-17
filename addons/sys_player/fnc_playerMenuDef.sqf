#include <\x\alive\addons\sys_player\script_component.hpp>
#include <\x\cba\addons\ui_helper\script_dikCodes.hpp>

SCRIPT(playerMenuDef);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_playerMenuDef
Description:
This function controls the View portion of player.

Parameters:
Object - The object to attach the menu too
Array - The menu parameters

Returns:
Array - Returns the menu definitions for FlexiMenu

Examples:
(begin example)
// initialise main menu
[
	"player",
	[221,[false,false,false]],
	-9500,
	["call ALIVE_fnc_playerMenuDef","main"]
] call CBA_fnc_flexiMenu_Add;
(end)

See Also:
- <ALIVE_fnc_player>
- <CBA_fnc_flexiMenu_Add>

Author:
Wolffy.au

Peer reviewed:
nil
---------------------------------------------------------------------------- */
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
			[localize "STR_ALIVE_player" + " >",
				"",
				"",
				localize "STR_ALIVE_player_COMMENT",
                                ["call ALiVE_fnc_playerMenuDef", "player", 1],
                                -1, 1, call ALIVE_fnc_isServerAdmin
			]
		]
	]
];

if (_menuName == "player") then {
	_menus set [count _menus,
		[
			["player", localize "STR_ALIVE_player", "popup"],
			[
				[localize "STR_ALIVE_player_ALLOWRESET_ENABLE",
					{ player setCaptive true },
					"",
					localize "STR_ALIVE_player_ALLOWRESET_COMMENT",
					"",
					-1,
					MOD(player) getVariable ["ALLOWRESET", 0],
					!captive player
				],
				[localize "STR_ALIVE_player_ALLOWRESET_DISABLE",
					{ player setCaptive false },
					"",
					localize "STR_ALIVE_player_ALLOWRESET_COMMENT",
					"",
					-1,
					MOD(player) getVariable ["ALLOWRESET", 0],
					captive player
				],

				[localize "STR_ALIVE_player_ALLOWDIFFCLASS_ENABLE",
					{ MOD(player) setVariable ["ALLOWDIFFCLASS", true]; onMapSingleClick {vehicle player setPos _pos;} },
					"",
					localize "STR_ALIVE_player_ALLOWDIFFCLASS_COMMENT",
					"",
					-1,
					MOD(player) getVariable ["ALLOWDIFFCLASS", 0],
					!(MOD(player) getVariable ["ALLOWDIFFCLASS", false])
				],
				[localize "STR_ALIVE_player_ALLOWDIFFCLASS_DISABLE",
					{ MOD(player) setVariable ["ALLOWDIFFCLASS", false]; onMapSingleClick DEFAULT_MAPCLICK; },
					"",
					localize "STR_ALIVE_player_ALLOWDIFFCLASS_COMMENT",
					"",
					-1,
					MOD(player) getVariable ["ALLOWDIFFCLASS", 0],
					(MOD(player) getVariable ["teleport_enabled", false])
				],

				[localize "STR_ALIVE_player_AUTOSAVE_ENABLE",
					{ [] execVM "\x\alive\addons\sys_player\mark_units.sqf"; },
					"",
					localize "STR_ALIVE_player_AUTOSAVE_COMMENT",
					"",
					-1,
					MOD(player) getVariable ["AUTOSAVE", 0],
					true
				],

				[localize "STR_ALIVE_player_AUTOSAVETIME_SET",
					{ createDialog "RscDisplayDebugPublic" },
					"",
					localize "STR_ALIVE_player_AUTOSAVETIME_COMMENT",
					"",
					-1,
					MOD(player) getVariable ["console", 0],
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
