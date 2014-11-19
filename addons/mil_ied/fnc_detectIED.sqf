// Detect - ran on client only
#include <\x\alive\addons\mil_IED\script_component.hpp>
SCRIPT(detectIED);
private ["_IED", "_radius","_players"];

_IED = _this select 0;
_radius = _this select 1;
_players = _this select 2;

{
	if ("MineDetector" in (items _x)) then {
		[format["IED detected within %1 meters.", floor(_x distance _IED)], "hint", _x, false] call BIS_fnc_MP;
	};

} foreach _players;


