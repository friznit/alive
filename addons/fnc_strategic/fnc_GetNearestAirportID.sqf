private ["_Airports","_Airport","_pos","_i"];

_pos = _this select 0;

_Primary = getArray(configFile >> "cfgWorlds" >> WorldName >> "ilsPosition");
_Secondary = (configFile >> "cfgWorlds" >> WorldName >> "SecondaryAirports");
_Airport = [[_Primary,0]];

for "_i" from 0 to ((count _Secondary)-1) do {
	_ILS = getArray(((configFile >> "cfgWorlds" >> WorldName >> "SecondaryAirports") select _i) >> "ilsPosition");
	_Airport set [count _Airport,[_ILS,_i+1]];
};

_Airport = [_Airport,[],{(getposATL player) distance (_x select 0)},"ASCEND"] call BIS_fnc_sortBy;
_Airport select 0 select 1;