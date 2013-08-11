#include <\x\alive\addons\sys_profile\script_component.hpp>
SCRIPT(vehicleGenerateEmptyPositionData);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_vehicleGenerateEmptyPositionData

Description:
Outputs all empty vehicle positions to RPT file in hash format

Parameters:

Returns:

Examples:
(begin example)
// generate vehcile position hash
_result = [] call ALIVE_fnc_vehicleGenerateEmptyPositionData;
(end)

See Also:
ALIVE_fnc_vehicleCountEmptyPositions
ALIVE_fnc_vehicleGetEmptyPositions

Author:
ARJay
---------------------------------------------------------------------------- */

[] spawn {

	private ["_cfg","_pos","_exportString","_item","_class","_type","_scope","_vehicle","_countPositions","_positions"];
		
	_cfg = configFile >> "CfgVehicles";
	_pos = getPos player;
	_exportString = "";
	
	for "_i" from 0 to (count _cfg)-1 do {
	
		_item = _cfg select _i;
		
		if(isClass _item) then
		{
			_class = configName _item;
			_type = getNumber(_item >> "type");
			_scope = getNumber(_item >> "scope");
			
			if(_scope == 2) then {
						
				_vehicle = createVehicle [_class, _pos, [], 0, "NONE"];
				_vehicle setPos _pos;
				
				sleep 1;
				
				_countPositions = [_vehicle] call ALIVE_fnc_vehicleCountEmptyPositions;
							
				if(_countPositions > 0) then {
					_positions = [_vehicle] call ALIVE_fnc_vehicleGetEmptyPositions;
					
					_exportString = _exportString + format['[ALIVE_vehiclePositions,"%1",%2] call ALIVE_fnc_hashSet;',_class,_positions];
				};		
				
				deleteVehicle _vehicle;
				
				sleep 1;
			};
		};
	};	
	
	copyToClipboard _exportString;
	["Generate vehicle empty positions analysis complete, results have been copied to the clipboard"] call ALIVE_fnc_dump;
};