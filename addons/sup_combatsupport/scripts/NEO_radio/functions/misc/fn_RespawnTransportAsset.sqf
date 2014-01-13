private ["_veh", "_grp", "_callsign", "_pos", "_dir","_height","_type", "_respawn","_code","_tasks"];

_veh = _this select 0;
_grp = _this select 1;
_callsign = _this select 2;
_pos = _this select 3;
_dir = _this select 4;
_height = _this select 5;
_type = _this select 6;
_respawn = _this select 7;
_code ={};
_tasks = ["Pickup", "Land", "land (Eng off)", "Move", "Circle","Insertion"];



/*TRANS_RESPAWN_LIMIT = TRANS_RESPAWN_LIMIT -1;
{
	if (TRANS_RESPAWN_LIMIT = 0) then 
		{
_replen = format ["All Units this we are out of Transport Assets"] ; 	
	
[[player,_replen,"side"],"NEO_fnc_messageBroadcast",true,true] spawn BIS_fnc_MP;
	}
else
	{*/
sleep _respawn;
 private ["_array", "_index","_side"];

 _side = getNumber(configfile >> "CfgVehicles" >> _type >> "side");
								
			                    switch (_side) do {
			                		case 0 : {_side = EAST};
			                		case 1 : {_side = WEST};
			                		case 2 : {_side = RESISTANCE};
			                		default {_side = EAST};
			            		};
			_array = NEO_radioLogic getVariable format ["NEO_radioTrasportArray_%1", _side];
			_index = 99;
			
			{
				if ((_x select 2) == _callsign) then
				{
					_index = _forEachIndex;
				};
			} forEach _array;
			
			if (_index != 99) then
			{
				{
					switch (_forEachIndex) do
					{
						case 0 : { { if (!isPlayer _x) then { deletevehicle _x } } forEach crew _x; deleteVehicle _x };
						case 1 : { deleteGroup _x };
					};
				} forEach (_array select _index);
				
				_array set [_index, "DELETEPLEASE"];
				_array = _array - ["DELETEPLEASE"];
				NEO_radioLogic setVariable [format ["NEO_radioTrasportArray_%1", _side], _array, true];
			}
			else
			{
				diag_log format ["Support with callsign %1 not found in Transport units", _callsign];
			};

			sleep 5;

		 						 _faction = gettext(configfile >> "CfgVehicles" >> _type >> "faction");
								_side = getNumber(configfile >> "CfgVehicles" >> _type >> "side");
								
			                    switch (_side) do {
			                		case 0 : {_side = EAST};
			                		case 1 : {_side = WEST};
			                		case 2 : {_side = RESISTANCE};
			                		default {_side = EAST};
			            		};

	private ["_veh"];
								_veh = createVehicle [_type, _pos, [], 0, "CAN_COLLIDE"];
								_veh setDir _dir;
								_veh setPosATL _pos;
								
								If(_height > 0) then {
								_veh setposasl [getposASL _veh select 0, getposASL _veh select 1, _height];
							} else {
							_veh setPosATL _pos;

							};
								_veh setVelocity [0,0,-1];

							
								
								private ["_grp"];
								_grp = createGroup _side;

								[_veh, _grp] call BIS_fnc_spawnCrew;
								_veh lockDriver true;
								{ _veh lockturret [[_x], true] } forEach [0,1,2];
								[[(units _grp select 0),_callsign], "fnc_setGroupID", false, false] spawn BIS_fnc_MP;
								//[nil, (units _grp select 0), "per", SETGROUPID, _callsign] spawn BIS_fnc_MP;
								[_veh] spawn _code;
								_veh setVariable ["ALIVE_CombatSupport", true];
								_veh setVariable ["NEO_transportAvailableTasks", _tasks, true];
						
								_transportfsm = "\x\alive\addons\sup_combatSupport\scripts\NEO_radio\fsms\transport.fsm";
								[_veh, _grp, _callsign, _pos, _dir,_height,_type, _respawn] execFSM _transportfsm;
								
							private ["_transportArray"];
			_transportArray = NEO_radioLogic getVariable format ["NEO_radioTrasportArray_%1", _side];
			_transportArray set [count _transportArray, [_veh, _grp, _callsign]];
			NEO_radioLogic setVariable [format ["NEO_radioTrasportArray_%1", _side], _transportArray, true];

_replen = format ["All Units this is %1, We are back on Station and are ready for tasking", _callsign] ; 	
	
[[player,_replen,"side"],"NEO_fnc_messageBroadcast",true,true] spawn BIS_fnc_MP;
//);