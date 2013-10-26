private ["_Airports","_pos","_i","_Primary","_Secondary","_ILS"];

_pos = _this select 0;

_Primary = getArray(configFile >> "cfgWorlds" >> WorldName >> "ilsPosition");
_Secondary = (configFile >> "cfgWorlds" >> WorldName >> "SecondaryAirports");
_Airports = [[_Primary,0]];

for "_i" from 0 to ((count _Secondary)-1) do {
	_ILS = getArray(((configFile >> "cfgWorlds" >> WorldName >> "SecondaryAirports") select _i) >> "ilsPosition");
	_Airports set [count _Airports,[_ILS,_i+1]];
};

_Airports = [_Airports,[],{_pos distance (_x select 0)},"ASCEND"] call BIS_fnc_sortBy;
_Airports select 0 select 1;