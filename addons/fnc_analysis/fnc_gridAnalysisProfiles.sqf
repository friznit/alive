#include <\x\alive\addons\fnc_analysis\script_component.hpp>
SCRIPT(gridAnalysisProfiles);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_gridAnalysisProfiles

Description:
Perform analysis of profile positions on passed grid

Parameters:
None

Returns:
...

Examples:
(begin example)
// add profile units to sector data
_result = [_grid] call ALIVE_fnc_gridAnalysisProfiles;
(end)

See Also:


Author:
ARJay
---------------------------------------------------------------------------- */

private ["_grid","_err","_profilesBySide","_sectors","_sideProfiles","_side","_profiles","_profile","_profileType","_profileActive","_leader","_position","_sector","_sectorData","_sideProfile"];

_grid = _this select 0;


// reset existing analysis data

//[true] call ALIVE_fnc_timer;

_sectors = [_grid, "sectors"] call ALIVE_fnc_sectorGrid;

{
	_sector = _x;
	
	_sectorData = [_sector, "data"] call ALIVE_fnc_sector;
		
	if("entitiesBySide" in (_sectorData select 1)) then {
		_sideProfiles = [_sectorData, "entitiesBySide"] call ALIVE_fnc_hashGet;
		[_sideProfiles, "EAST", []] call ALIVE_fnc_hashSet;
		[_sideProfiles, "WEST", []] call ALIVE_fnc_hashSet;
		[_sideProfiles, "CIV", []] call ALIVE_fnc_hashSet;
		[_sideProfiles, "GUER", []] call ALIVE_fnc_hashSet;
		
		[_sector, "data", ["entitiesBySide",_sideProfiles]] call ALIVE_fnc_sector;
	};

	if("vehiclesBySide" in (_sectorData select 1)) then {
		_sideProfiles = [_sectorData, "vehiclesBySide"] call ALIVE_fnc_hashGet;
		[_sideProfiles, "EAST", []] call ALIVE_fnc_hashSet;
		[_sideProfiles, "WEST", []] call ALIVE_fnc_hashSet;
		[_sideProfiles, "CIV", []] call ALIVE_fnc_hashSet;
		[_sideProfiles, "GUER", []] call ALIVE_fnc_hashSet;
		
		[_sector, "data", ["vehiclesBySide",_sideProfiles]] call ALIVE_fnc_sector;
	};
	
} forEach _sectors;

//[] call ALIVE_fnc_timer;


// run analysis on all profiles

//[true] call ALIVE_fnc_timer;

_profilesBySide = [ALIVE_profileHandler, "profilesBySide"] call ALIVE_fnc_hashGet;

{
	_side = _x;
	_profiles = [_profilesBySide, _side] call ALIVE_fnc_hashGet;
	
	{
		_profile = [ALIVE_profileHandler, "getProfile", _x] call ALIVE_fnc_profileHandler;

		if(count _profile > 0) then {
		
			_profileType = [_profile,"type"] call ALIVE_fnc_hashGet;
			_profileActive = [_profile, "active"] call ALIVE_fnc_hashGet;
			
			switch(_profileType) do {
				case "entity": {
				
					if(_profileActive) then {
						_leader = [_profile,"leader"] call ALIVE_fnc_hashGet;
						_position = getPosATL _leader;
					} else {
						_position = [_profile, "position"] call ALIVE_fnc_hashGet;
					};		
						
					_sector = [_grid, "positionToSector", _position] call ALIVE_fnc_sectorGrid;		
					_sectorData = [_sector, "data"] call ALIVE_fnc_sector;
					
					if("entitiesBySide" in (_sectorData select 1)) then {
						_sideProfiles = [_sectorData, "entitiesBySide"] call ALIVE_fnc_hashGet;
						_sideProfile = [_sideProfiles, _side] call ALIVE_fnc_hashGet;
					}else{
						_sideProfiles = [] call ALIVE_fnc_hashCreate;
						[_sideProfiles, "EAST", []] call ALIVE_fnc_hashSet;
						[_sideProfiles, "WEST", []] call ALIVE_fnc_hashSet;
						[_sideProfiles, "CIV", []] call ALIVE_fnc_hashSet;
						[_sideProfiles, "GUER", []] call ALIVE_fnc_hashSet;
						
						[_sector, "data", ["entitiesBySide",_sideProfiles]] call ALIVE_fnc_sector;
						
						_sideProfile = [_sideProfiles, _side] call ALIVE_fnc_hashGet;			
					};		
					
					_sideProfile set [count _sideProfile, [_x,_position]];
					
					// store the result of the analysis on the sector instance
					[_sector, "data", ["entitiesBySide",_sideProfiles]] call ALIVE_fnc_sector;
					
				};
				case "vehicle": {
					
					if(_profileActive) then {
						_vehicle = [_profile,"vehicle"] call ALIVE_fnc_hashGet;
						_position = getPosATL _vehicle;
					} else {
						_position = [_profile, "position"] call ALIVE_fnc_hashGet;
					};		
						
					_sector = [_grid, "positionToSector", _position] call ALIVE_fnc_sectorGrid;		
					_sectorData = [_sector, "data"] call ALIVE_fnc_sector;
					
					if("vehiclesBySide" in (_sectorData select 1)) then {
						_sideProfiles = [_sectorData, "vehiclesBySide"] call ALIVE_fnc_hashGet;
						_sideProfile = [_sideProfiles, _side] call ALIVE_fnc_hashGet;
					}else{
						_sideProfiles = [] call ALIVE_fnc_hashCreate;
						[_sideProfiles, "EAST", []] call ALIVE_fnc_hashSet;
						[_sideProfiles, "WEST", []] call ALIVE_fnc_hashSet;
						[_sideProfiles, "CIV", []] call ALIVE_fnc_hashSet;
						[_sideProfiles, "GUER", []] call ALIVE_fnc_hashSet;
						
						[_sector, "data", ["vehiclesBySide",_sideProfiles]] call ALIVE_fnc_sector;
						
						_sideProfile = [_sideProfiles, _side] call ALIVE_fnc_hashGet;			
					};		
					
					_sideProfile set [count _sideProfile, [_x,_position]];
					
					// store the result of the analysis on the sector instance
					[_sector, "data", ["vehiclesBySide",_sideProfiles]] call ALIVE_fnc_sector;
				};
			};			
		};
		
	} forEach _profiles;
	
} forEach (_profilesBySide select 1);

//[] call ALIVE_fnc_timer;