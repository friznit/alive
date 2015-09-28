#include <\x\alive\addons\sys_profile\script_component.hpp>
#include <\x\cba\addons\ui_helper\script_dikCodes.hpp>

SCRIPT(profileMenuDef);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_profileMenuDef
Description:
This function controls the View portion of profile.

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
	["call ALIVE_fnc_profileMenuDef","main"]
] call CBA_fnc_flexiMenu_Add;
(end)

See Also:
- <ALIVE_fnc_IED>
- <CBA_fnc_flexiMenu_Add>

Author:
Tupolov, Wolffy

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
		]
	],
	[
		["adminOptions", "Admin Options", "popup"],
		[
		]
	]
];

if (_menuName == "profile") then {
	_menus set [count _menus,
		[
			["profile", localize "STR_ALIVE_PROFILE_SYSTEM", "popup"],
			[
                [localize "STR_ALIVE_PROFILE_SYSTEM_DEBUG_ENABLE",
					{ADDON setVariable ["debug","true", true]; [] call ALIVE_fnc_profileSystemDebug; },
					"",
					localize "STR_ALIVE_PROFILE_SYSTEM_DEBUG_COMMENT",
					"",
					-1,
                    [QUOTE(ADDON)] call ALiVE_fnc_isModuleAvailable,
                    !isnil QUOTE(ADDON) && {!(call compile (ADDON getVariable ["debug","false"]))}
				],
				[localize "STR_ALIVE_PROFILE_SYSTEM_DEBUG_DISABLE",
					{ADDON setVariable ["debug","false", true]; [] call ALIVE_fnc_profileSystemDebug; },
					"",
					localize "STR_ALIVE_PROFILE_SYSTEM_DEBUG_COMMENT",
					"",
					-1,
                    [QUOTE(ADDON)] call ALiVE_fnc_isModuleAvailable,
                    !isnil QUOTE(ADDON) && {(call compile (ADDON getVariable ["debug","false"]))}
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