#include <\x\alive\addons\mil_convoy\script_component.hpp>

private ["_logic","_pos","_type","_fac","_facs","_sidex","_side","_grpx","_grps","_grp","_fx","_facx","_s","_spawnGrp","_wp","_nonConfigs"];

_logic = _this select 0;
_pos = _this select 1;
_type = _this select 2;
_fac = nil;
_nonConfigs = [""];

// setup default param
if (count _this > 3) then {_fac = _this select 3};
if (isNil "_fac") then {_fac = east};

_facs = [];
_side = nil;
// get all factions
if(isNil "CONVOY_ALLFACS") then {
	CONVOY_ALLFACS = [] call BIS_fnc_getFactions;
	//hint str CONVOY_ALLFACS;
};
// if default or selection by side
if(typeName _fac == "ANY" || typeName _fac == "SIDE") then {
        if(typeName _fac == "SIDE") then {
                _side = _fac;
        };
        
        switch(_side) do {
                case east: {
                        _sidex = 0;
                };
                case west: {
                        _sidex = 1;
                };
                case resistance: {
                        _sidex = 2;
                };
                case civilian: {
                        _sidex = 3;
                };
        };
        
        {
                _fx = getNumber(configFile >> "CfgFactionClasses" >> _x >> "side");
                if (_fx == _sidex) then {
                        _facs set [count _facs, _x];
                };
        } forEach CONVOY_ALLFACS;
        _fac = nil;
} else {
        switch(toUpper(typeName _fac)) do {
                case "STRING": {
                        _facs = [_fac];
                };
                // if multiple factions
                case "ARRAY": {
                        _facs = _fac;
                };
        };
        _fac = nil;
};
//hint format["FACS1: %1", _facs];

if(!isNil "_facs") then {
        _facx = [];
        {
                _s = switch(_x) do {
                        case resistance: {"Guerrila";};
                        case civilian: {"Civilian";};
                        default {str _x;};
                };
                
                private ["_x"];
                // Confirm there are units for this faction in this type
                {
                        _grpx = count(configFile >> "CfgGroups" >> _s >> _x >> _type);
                        for "_y" from 1 to _grpx - 1 do {
                                if (!(_x in _facx)) then { 
                                        _facx set [count _facx, _x];
                                };
                        };
                } forEach _facs;
        } forEach [west,east,resistance,civilian];
        
        _facs = _facx;
};

//checking if there are factions with groupconfigs and if no are there using fn_randomspawnbytype
if !(count _facs == 0) then {
//hint format["FACS2: %1", _facs];

// pick random faction and validate
_fac = _facs select floor(random count _facs);


if(isNil "_side") then {
        _sidex = getNumber(configFile >> "CfgFactionClasses" >> _fac >> "side");
        _side = nil;
        switch(_sidex) do {
                case 0: {
                        _side = east;
                };
                case 1: {
                        _side = west;
                };
                case 2: {
                        _side = resistance;
                };
                case 3: {
                        _side = civilian;
                };
        };
};
//player globalChat format["Side %1 %2 Fctns: %3 This %4 Type %5", _side, _sidex, _facs, _fac, _type];

_grps = [];
_s = switch(_side) do {
        case resistance: {"Guerrila";};
        case civilian: {"Civilian";};
        default {str _side;};
};

//hint str _s;
_grpx = count(configFile >> "CfgGroups" >> _s >> _fac >> _type);
for "_y" from 1 to _grpx - 1 do {
		private "_cx";
		_cx = configName ((configFile >> "CfgGroups" >> _s >> _fac >> _type) select _y);
		if ( {(_cx == _x)} count _nonConfigs == 0 ) then {	
			_grps set [count _grps, (configFile >> "CfgGroups" >> _s >> _fac >> _type) select _y];			
		};	
};
//hint str _grps;

_grp = _grps select floor(random count _grps);

//player globalChat format["%1 %2 %3 %4", _pos, _s, _side, _grp];
_spawnGrp = [_pos, _side, _grp] call BIS_fnc_spawnGroup;

if(_side == civilian) then {
        _wp = _spawnGrp addWaypoint [_pos, 0];
        _wp setWaypointType "DISMISS";
        _wp setWaypointBehaviour "SAFE";
};

//player globalChat format["type: %1 fac: %2", _type, _fac];

} else {
    //randomspawnbytype
    _side = EAST;
	diag_log format ["ALIVE-%1 fn_randomgroup defaulting fnc_randomgroupbytype", time];
    _spawnGrp = [_logic,_pos,_side,_type] call ALIVE_fnc_randomgroupbytype;
};

if (isnil "_spawnGrp") then {diag_log format ["ALIVE-%1 fn_randomgroup failed, no _group created", time]};
_spawnGrp;
