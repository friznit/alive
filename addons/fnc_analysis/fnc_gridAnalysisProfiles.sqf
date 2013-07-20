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

private ["_grid","_err","_profilesBySide","_sectors","_sideProfiles","_side","_profiles","_profile","_profileActive","_leader","_position","_sector","_sectorData","_sideProfile"];

_grid = _this select 0;


// reset existing analysis data

[true] call ALIVE_fnc_timer;

_sectors = [_grid, "sectors"] call ALIVE_fnc_sectorGrid;

{
	_sector = _x;
	
	_sectorData = [_sector, "data"] call ALIVE_fnc_sector;
		
	if("profilesBySide" in (_sectorData select 1)) then {
		_sideProfiles = [_sectorData, "profilesBySide"] call ALIVE_fnc_hashGet;
		[_sideProfiles, "EAST", []] call ALIVE_fnc_hashSet;
		[_sideProfiles, "WEST", []] call ALIVE_fnc_hashSet;
		[_sideProfiles, "CIV", []] call ALIVE_fnc_hashSet;
		[_sideProfiles, "GUER", []] call ALIVE_fnc_hashSet;
		
		[_sector, "data", ["profilesBySide",_sideProfiles]] call ALIVE_fnc_sector;
	};	
	
} forEach _sectors;

[] call ALIVE_fnc_timer;


// run analysis on all profiles

[true] call ALIVE_fnc_timer;

_profilesBySide = [ALIVE_profileHandler, "profilesBySide"] call ALIVE_fnc_hashGet;

{
	_side = _x;
	_profiles = [_profilesBySide, _side] call ALIVE_fnc_hashGet;
	
	{
		_profile = [ALIVE_profileHandler, "getProfile", _x] call ALIVE_fnc_profileHandler;		
		_profileActive = [_profile, "active"] call ALIVE_fnc_hashGet;
		
		if(_profileActive) then {
			_leader = [_entityProfile,"leader"] call ALIVE_fnc_hashGet;
			_position = getPosATL _leader;
		} else {
			_position = [_profile, "position"] call ALIVE_fnc_hashGet;
		};		
			
		_sector = [_grid, "positionToSector", _position] call ALIVE_fnc_sectorGrid;		
		_sectorData = [_sector, "data"] call ALIVE_fnc_sector;
		
		if("profilesBySide" in (_sectorData select 1)) then {
			_sideProfiles = [_sectorData, "profilesBySide"] call ALIVE_fnc_hashGet;
			_sideProfile = [_sideProfiles, _side] call ALIVE_fnc_hashGet;
		}else{
			_sideProfiles = [] call ALIVE_fnc_hashCreate;
			[_sideProfiles, "EAST", []] call ALIVE_fnc_hashSet;
			[_sideProfiles, "WEST", []] call ALIVE_fnc_hashSet;
			[_sideProfiles, "CIV", []] call ALIVE_fnc_hashSet;
			[_sideProfiles, "GUER", []] call ALIVE_fnc_hashSet;
			
			[_sector, "data", ["profilesBySide",_sideProfiles]] call ALIVE_fnc_sector;
			
			_sideProfile = [_sideProfiles, _side] call ALIVE_fnc_hashGet;			
		};		
		
		_sideProfile set [count _sideProfile, _x];
		
		// store the result of the analysis on the sector instance
		[_sector, "data", ["profilesBySide",_sideProfiles]] call ALIVE_fnc_sector;		
		
	} forEach _profiles;
	
} forEach (_profilesBySide select 1);

[] call ALIVE_fnc_timer;