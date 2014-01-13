private ["_veh","_grp","_callsign","_pos", "_dir", "_type", "_airport", "_code","_height","_side","_respawn"];
								
								_veh = _this select 0;
								_grp = _this select 1;
								_callsign = _this select 2;
								_pos = _this select 3;
								_dir = _this select 4;
								_height = _this select 5;
								_type = _this select 6;
								_airport = _this select 7;
								_respawn = _this select 8;
								_code = {};

/*CAS_RESPAWN_LIMIT = CAS_RESPAWN_LIMIT -1;
{
	if (CAS_RESPAWN_LIMIT = 0) then 
		{
_replen = format ["All Units this we are out of CAS Assets"] ; 	
	
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
								

			_array = NEO_radioLogic getVariable format ["NEO_radioCasArray_%1", _side];
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
						case 0 : { { deletevehicle _x } forEach crew _x; deleteVehicle _x };
						case 1 : { deleteGroup _x };
					};
				} forEach (_array select _index);
				
				_array set [_index, "DELETEPLEASE"];
				_array = _array - ["DELETEPLEASE"];
				NEO_radioLogic setVariable [format ["NEO_radioCasArray_%1", _side], _array, true];
			}
			else
			{
				diag_log format ["Support with callsign %1 not found in Cas units", _callsign];
			};

	sleep 5;

                                
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

							

								_veh setVariable ["ALIVE_CombatSupport", true];
								
								private ["_grp"];
								_grp = createGroup _side;
								if(getNumber(configFile >> "CfgVehicles" >> _type >> "isUav")==1) then {
								createVehicleCrew _veh;   
								} else {
								[_veh, _grp] call BIS_fnc_spawnCrew;
								_veh lockDriver true;
								{ _veh lockturret [[_x], true] } forEach [0,1,2];
								
								[[(units _grp select 0),_callsign], "fnc_setGroupID", false, false] spawn BIS_fnc_MP;
								//[nil, (units _grp select 0), "per", SETGROUPID, _callsign] spawn BIS_fnc_MP;
								[_veh] spawn _code; };
								
								//FSM
								
								_casfsm = "\x\alive\addons\sup_combatSupport\scripts\NEO_radio\fsms\cas.fsm";
								
								//FSM
								[_veh, _grp, _callsign, _pos, _airport, _dir, _height, _type, CS_RESPAWN] execFSM _casfsm;
								
								private ["_casArray"];
			_casArray = NEO_radioLogic getVariable format ["NEO_radioCasArray_%1", _side];
			_casArray set [count _casArray, [_veh, _grp, _callsign]];
			NEO_radioLogic setVariable [format ["NEO_radioCasArray_%1", _side], _casArray, true];

      _replen = format ["All Units this is %1, We are back on Station and are ready for tasking", _callsign] ; 	
	
[[player,_replen,"side"],"NEO_fnc_messageBroadcast",true,true] spawn BIS_fnc_MP;
//};