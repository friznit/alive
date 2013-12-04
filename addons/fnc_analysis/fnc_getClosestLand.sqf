#include <\x\alive\addons\fnc_analysis\script_component.hpp>
SCRIPT(getClosestLand);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_getClosestLand

Description:
Gets the closest position that is land

Parameters:
Array - Position center point for search
Scalar - Max Radius of search

Returns:
Array - position

Examples:
(begin example)
// get closest land
_position = [getPos player, 500] call ALIVE_fnc_getClosestLand;
(end)

See Also:


Author:
ARJay
---------------------------------------------------------------------------- */

private ["_position","_radius","_result","_err", "_sector","_sectorData","_sectorTerrain","_sectorTerrainSamples","_samples","_sectors"];
	
_position = _this select 0;
//_radius = _this select 1;

_err = format["get closest land requires a position array - %1",_position];
ASSERT_TRUE(typeName _position == "ARRAY",_err);
//_err = format["get closest land requires a radius scalar - %1",_radius];
//ASSERT_TRUE(typeName _radius == "SCALAR",_err);

_sector = [ALIVE_sectorGrid, "positionToSector", _position] call ALIVE_fnc_sectorGrid;
_sectorData = [_sector, "data"] call ALIVE_fnc_hashGet;
_sectorTerrain = [_sectorData, "terrain"] call ALIVE_fnc_hashGet;

// the positions sector is terrain shore
// we can get a land position there
if(_sectorTerrain == "SHORE") then {

	//["GCL - sector terrain is shore"] call ALIVE_fnc_dump;
	_sectorTerrainSamples = [_sectorData, "terrainSamples"] call ALIVE_fnc_hashGet;
	_samples = [_sectorTerrainSamples, "land"] call ALIVE_fnc_hashGet;
	
	if(count _samples > 0) then {
		//["GCL got land samples: %1",_samples] call ALIVE_fnc_dump;
		_result = _samples select (floor(random((count _samples)-1)));
	};
};

// the positions sector is terrain sea
// get the surrounding sectors to check if there are any shore positions
// if so spawn on a random land position
if(_sectorTerrain == "SEA") then {

	//["GCL - sector terrain is sea"] call ALIVE_fnc_dump;
	_sectors = [ALIVE_sectorGrid, "surroundingSectors", _position] call ALIVE_fnc_sectorGrid;
	//_sectors = [_sectors, "land"] call ALIVE_fnc_sectorFilterBestPlaces;
	_sectors = [_sectors, "SEA"] call ALIVE_fnc_sectorFilterTerrain;
	
	//["GCL - lands sectors count %1",count _sectors] call ALIVE_fnc_dump;
	
	if(count _sectors > 0) then {
		_sectors = [_sectors,_position] call ALIVE_fnc_sectorSortDistance;
		_sector = _sectors select 0;
		_sectorData = [_sector, "data"] call ALIVE_fnc_hashGet;
		_sectorTerrainSamples = [_sectorData, "terrainSamples"] call ALIVE_fnc_hashGet;
		_samples = [_sectorTerrainSamples, "land"] call ALIVE_fnc_hashGet;
		
		if(count _samples > 0) then {
			//["GCL got land samples: %1",_samples] call ALIVE_fnc_dump;
			_result = _samples select (floor(random((count _samples)-1)));
		};
	}else{
	
		//["GCL - no land in surrounding sectors"] call ALIVE_fnc_dump;
		
		// no land within surrounding sectors use radius to find larger area
		_sectors = [ALIVE_sectorGrid, "sectorsInRadius", [_position, 3000]] call ALIVE_fnc_sectorGrid;
		//_sectors = [_sectors, "land"] call ALIVE_fnc_sectorFilterBestPlaces;
		_sectors = [_sectors, "SEA"] call ALIVE_fnc_sectorFilterTerrain;
		
		if(count _sectors > 0) then {
		
			//["GCL - no land in radius sectors"] call ALIVE_fnc_dump;
		
			_sectors = [_sectors,_position] call ALIVE_fnc_sectorSortDistance;
			_sector = _sectors select 0;
			_sectorData = [_sector, "data"] call ALIVE_fnc_hashGet;
			_sectorTerrainSamples = [_sectorData, "terrainSamples"] call ALIVE_fnc_hashGet;
			_samples = [_sectorTerrainSamples, "land"] call ALIVE_fnc_hashGet;
			
			if(count _samples > 0) then {
				//["GCL got land samples: %1",_samples] call ALIVE_fnc_dump;
				_result = _samples select (floor(random((count _samples)-1)));
			};
		}else{
			// not sure what to do here, they are out to sea...
		}
	};
};			

if !(isnil "_result") then {_result set [2,0]; _result} else {_position};