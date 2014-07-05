#include <\x\alive\addons\sys_adminactions\script_component.hpp>
#include <\x\cba\addons\ui_helper\script_dikCodes.hpp>

SCRIPT(adminActionsMenuDef);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_adminActionsMenuDef
Description:
This function controls the View portion of adminActions.

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
	["call ALIVE_fnc_adminActionsMenuDef","main"]
] call CBA_fnc_flexiMenu_Add;
(end)

See Also:
- <ALIVE_fnc_adminActions>
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
			[localize "STR_ALIVE_ADMINACTIONS" + " >",
				"",
				"",
				localize "STR_ALIVE_ADMINACTIONS_COMMENT",
                                ["call ALiVE_fnc_adminActionsMenuDef", "adminActions", 1],
                                -1, 1, call ALIVE_fnc_isServerAdmin
			]
		]
	]
];

TRACE_4("Menu setup",MOD(adminActions),MOD(adminActions) getVariable "ghost",MOD(adminActions) getVariable "teleport",MOD(adminActions) getVariable "mark_units");

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
					MOD(adminActions) getVariable ["ghost", 0],
					!captive player
				],
				[localize "STR_ALIVE_ADMINACTIONS_GHOST_DISABLE",
					{ player setCaptive false },
					"",
					localize "STR_ALIVE_ADMINACTIONS_GHOST_COMMENT",
					"",
					-1,
					MOD(adminActions) getVariable ["ghost", 0],
					captive player
				],

				[localize "STR_ALIVE_ADMINACTIONS_TELEPORT_ENABLE",
					{ MOD(adminActions) setVariable ["teleport_enabled", true]; onMapSingleClick {vehicle player setPos _pos;} },
					"",
					localize "STR_ALIVE_ADMINACTIONS_TELEPORT_COMMENT",
					"",
					-1,
					MOD(adminActions) getVariable ["teleport", 0],
					!(MOD(adminActions) getVariable ["teleport_enabled", false])
				],
				[localize "STR_ALIVE_ADMINACTIONS_TELEPORT_DISABLE",
					{ MOD(adminActions) setVariable ["teleport_enabled", false]; onMapSingleClick DEFAULT_MAPCLICK; },
					"",
					localize "STR_ALIVE_ADMINACTIONS_TELEPORT_COMMENT",
					"",
					-1,
					MOD(adminActions) getVariable ["teleport", 0],
					(MOD(adminActions) getVariable ["teleport_enabled", false])
				],
                
                [localize "STR_ALIVE_ADMINACTIONS_TELEPORTUNITS",
					{ ["CAManBase"] spawn ALiVE_fnc_AdminActionsTeleportUnits },
					"",
					localize "STR_ALIVE_ADMINACTIONS_TELEPORTUNITS_COMMENT",
					"",
					-1,
					MOD(adminActions) getVariable ["teleport", 0],
					true
				],

				[localize "STR_ALIVE_ADMINACTIONS_MARK_UNITS_ENABLE",
					{ [] call ALIVE_fnc_markUnits },
					"",
					localize "STR_ALIVE_ADMINACTIONS_MARK_UNITS_COMMENT",
					"",
					-1,
					MOD(adminActions) getVariable ["mark_units", 0],
					true
				],
                
                [localize "STR_ALIVE_ADMINACTIONS_CQB_ENABLE",
					{ MOD(adminActions) setVariable ["CQB_enabled", true]; {[_x,"debug",true] call ALiVE_fnc_CQB} foreach (MOD(CQB) getVariable ["instances",[]]); },
					"",
					localize "STR_ALIVE_ADMINACTIONS_CQB_ENABLE_COMMENT",
					"",
					-1,
					["ALiVE_mil_CQB"] call ALiVE_fnc_isModuleAvailable,
					!(MOD(adminActions) getVariable ["CQB_enabled", false])
				],
				[localize "STR_ALIVE_ADMINACTIONS_CQB_DISABLE",
					{ MOD(adminActions) setVariable ["CQB_enabled", false]; {[_x,"debug",false] call ALiVE_fnc_CQB} foreach (MOD(CQB) getVariable ["instances",[]]); },
					"",
					localize "STR_ALIVE_ADMINACTIONS_CQB_DISABLE_COMMENT",
					"",
					-1,
					["ALiVE_mil_CQB"] call ALiVE_fnc_isModuleAvailable,
					(MOD(adminActions) getVariable ["CQB_enabled", false])
				],
                
                [localize "STR_ALIVE_ADMINACTIONS_PROFILES_DEBUG_ENABLE",
					{ MOD(adminActions) setVariable ["PROFILES_enabled", true]; [] call ALIVE_fnc_profileSystemDebug; },
					"",
					localize "STR_ALIVE_ADMINACTIONS_PROFILES_DEBUG_COMMENT",
					"",
					-1,
					["ALiVE_sys_profile"] call ALiVE_fnc_isModuleAvailable,
					!(MOD(adminActions) getVariable ["PROFILES_enabled", false])
				],
				[localize "STR_ALIVE_ADMINACTIONS_PROFILES_DEBUG_DISABLE",
					{ MOD(adminActions) setVariable ["PROFILES_enabled", false]; [] call ALIVE_fnc_profileSystemDebug; },
					"",
					localize "STR_ALIVE_ADMINACTIONS_PROFILES_DEBUG_COMMENT",
					"",
					-1,
					["ALiVE_sys_profile"] call ALiVE_fnc_isModuleAvailable,
					(MOD(adminActions) getVariable ["PROFILES_enabled", false])
				],

				[localize "STR_ALIVE_ADMINACTIONS_CREATE_PROFILES_ENABLE",
                    { [] call ALIVE_fnc_adminCreateProfiles; },
                    "",
                    localize "STR_ALIVE_ADMINACTIONS_CREATE_PROFILES_COMMENT",
                    "",
                    -1,
                    MOD(adminActions) getVariable ["profiles_create", 0],
                    true
                ],

				[localize "STR_ALIVE_ADMINACTIONS_AGENTS_DEBUG_ENABLE",
                    { MOD(adminActions) setVariable ["AGENTS_enabled", true]; [] call ALIVE_fnc_agentSystemDebug; },
                    "",
                    localize "STR_ALIVE_ADMINACTIONS_AGENTS_DEBUG_COMMENT",
                    "",
                    -1,
                    ["ALiVE_amb_civ_population"] call ALiVE_fnc_isModuleAvailable,
                    !(MOD(adminActions) getVariable ["AGENTS_enabled", false])
                ],
                [localize "STR_ALIVE_ADMINACTIONS_AGENTS_DEBUG_DISABLE",
                    { MOD(adminActions) setVariable ["AGENTS_enabled", false]; [] call ALIVE_fnc_agentSystemDebug; },
                    "",
                    localize "STR_ALIVE_ADMINACTIONS_PROFILES_DEBUG_COMMENT",
                    "",
                    -1,
                    ["ALiVE_amb_civ_population"] call ALiVE_fnc_isModuleAvailable,
                    (MOD(adminActions) getVariable ["AGENTS_enabled", false])
                ],

				[localize "STR_ALIVE_ADMINACTIONS_CONSOLE_ENABLE",
					{ createDialog "RscDisplayDebugPublic" },
					"",
					localize "STR_ALIVE_ADMINACTIONS_CONSOLE_COMMENT",
					"",
					-1,
					MOD(adminActions) getVariable ["console", 0],
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
