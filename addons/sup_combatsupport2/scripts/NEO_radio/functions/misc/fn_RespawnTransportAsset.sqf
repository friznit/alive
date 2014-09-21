private ["_veh", "_grp", "_callsign", "_pos", "_dir","_height","_type", "_respawn","_code","_tasks","_faction","_side","_sides"];

_veh = _this select 0;
_grp = _this select 1;
_callsign = _this select 2;
_pos = _this select 3;
_dir = _this select 4;
_height = _this select 5;
_type = _this select 6;
_respawn = _this select 7;

//define defaults
_code = {};
_tasks = ["Pickup", "Land", "land (Eng off)", "Move", "Circle","Insertion"];
_faction = gettext(configfile >> "CfgVehicles" >> _type >> "faction");
_sides = [WEST,EAST,RESISTANCE,CIVILIAN];

//get side
switch ((getNumber(configfile >> "CfgVehicles" >> _type >> "side"))) do {
	case 0 : {_side = EAST};
	case 1 : {_side = WEST};
	case 2 : {_side = RESISTANCE};
	default {_side = EAST};
};

//Exit if limit is reached
if (TRANS_RESPAWN_LIMIT == 0) exitwith {
    _replen = format ["All units! We are out of transport assets"]; 	
	[[player,_replen,"side"],"NEO_fnc_messageBroadcast",true,true] spawn BIS_fnc_MP;
};

//Start respawning if not exited
sleep _respawn;
TRANS_RESPAWN_LIMIT = TRANS_RESPAWN_LIMIT - 1;

//Remove from all side-lists
_toDelete = [];
{
		private ["_sideArray","_sideIn"];
        _sideIn = _x;
		_sideArray = NEO_radioLogic getVariable [format["NEO_radioTrasportArray_%1", _sideIn],[]];
        {
            if (isnull (_x select 0) || {((_x select 0) == _veh)}) then {
                _toDelete set [count _toDelete,_x];
                
                _sideArray set [_foreachIndex, -1];
				_sideArray = _sideArray - [-1];
            };
        } foreach _sideArray;
        NEO_radioLogic setVariable [format["NEO_radioTrasportArray_%1", _sideIn], _sideArray, true];
} foreach _sides;

//Delete objects and groups
{
                {if !(isPlayer _x) then {deletevehicle _x}} forEach (crew (_x select 0)); 
                deleteVehicle (_x select 0);
                deletegroup (_x select 1);
} foreach _toDelete;

sleep 5;

//Create new units and vehicles
private ["_veh","_grp"];

_grp = createGroup _side;
_veh = createVehicle [_type, _pos, [], 0, "CAN_COLLIDE"];
_veh setPosATL _pos;
_veh setDir _dir;

[_veh, _grp] call BIS_fnc_spawnCrew;

If(_height > 0) then {
	_veh setposASL [getposASL _veh select 0, getposASL _veh select 1, _height];
} else {
	_veh setPosATL _pos;
};
_veh setVelocity [0,0,-1];
_veh lockDriver true;
{_veh lockturret [[_x], true]} forEach [0,1,2];

_hdl = [[(units _grp select 0),_callsign], "fnc_setGroupID", false, false] spawn BIS_fnc_MP;
waituntil {scriptdone _hdl};
sleep 1;

//Set variables and run FSM and optionally passed code
_veh setVariable ["ALIVE_CombatSupport", true];
_veh setVariable ["NEO_transportAvailableTasks", _tasks, true];

//Register to all friendly side-lists
{
	if (_side getfriend _x >= 0.6) then {
		private ["_array"];
        
		_array = NEO_radioLogic getVariable format["NEO_radioTrasportArray_%1", _x];
        _array set [count _array,[_veh, _grp, _callsign]];

        NEO_radioLogic setVariable [format["NEO_radioTrasportArray_%1", _x], _array,true];
	};
} foreach _sides;

//Start FSM
_transportfsm = "\x\alive\addons\sup_combatSupport\scripts\NEO_radio\fsms\transport.fsm";
[_veh, _grp, _callsign, _pos, _dir,_height,_type, _respawn] execFSM _transportfsm;
[_veh] spawn _code;

_replen = format["All units this is %1! We are back on station and are ready for tasking", _callsign] ; 	
[[player,_replen,"side"],"NEO_fnc_messageBroadcast",true,true] spawn BIS_fnc_MP;