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
			["Admin Actions" + " >",
				"",
				"",
				"Server admin functions",
                                ["call ALIVE_fnc_adminActionsMenuDef", "adminActions", 0],
                                -1, 1, call ALIVE_fnc_isServerAdmin
			]
		]
	]
];

if (_menuName == "adminActions") then {
	_menus set [count _menus,
		[
			["adminActions", "Admin Actions", "popup"],
			[
				["Enable Ghost Mode",
					{ player setCaptive true },
					"",
					"Set admin player's visiblity",
					"",
					-1,
					ALIVE_adminActions getVariable ["ghost", 0],
					!captive player
				],
				["Disable Ghost Mode ",
					{ player setCaptive false },
					"",
					"Set admin player's visiblity",
					"",
					-1,
					ALIVE_adminActions getVariable ["ghost", 0],
					captive player
				],
				["Enable Teleport",
					{ alive_adminActions_tp = true; onMapSingleClick {player setPos _pos;} },
					"",
					"Set admin player's teleport ability",
					"",
					-1,
					ALIVE_adminActions getVariable ["teleport", 0],
					!alive_adminActions_tp
				],
				["Disable Teleport",
					{ alive_adminActions_tp = false; onMapSingleClick DEFAULT_MAPCLICK; },
					"",
					"Set admin player's teleport ability",
					"",
					-1,
					ALIVE_adminActions getVariable ["teleport", 0],
					alive_adminActions_tp
				],
				["Enable Spectate",
					{ [] call ace_fnc_startSpectator },
					"",
					"Set admin player's ability to spectate on other players",
					"",
					-1,
					ALIVE_adminActions getVariable ["spectate", 0],
					!isNil "ace_fnc_startSpectator"
				],
				["Enable Camera",
					{ [player] call BIS_fnc_camera },
					"",
					"Set admin player's ability to view camera",
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
