#include <\x\alive\addons\fnc_analysis\script_component.hpp>
SCRIPT(getClosestSea);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_getClosestSea

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
_position = [getPos player, 500] call ALIVE_fnc_getClosestSea;
(end)

See Also:


Author:
ARJay
---------------------------------------------------------------------------- */

private ["_position","_radius","_result","_err", "_sector","_sectorData","_sectorTerrain","_sectorTerrainSamples","_samples","_sectors"];
	
_position = _this select 0;
//_radius = _this select 1;

_result = _position;

_err = format["get closest sea requires a position array - %1",_position];
ASSERT_TRUE(typeName _position == "ARRAY",_err);
//_err = format["get closest sea requires a radius scalar - %1",_radius];
//ASSERT_TRUE(typeName _radius == "SCALAR",_err);

_sector = [ALIVE_sectorGrid, "positionToSector", _position] call ALIVE_fnc_sectorGrid;
_sectorData = [_sector, "data"] call ALIVE_fnc_hashGet;

if (isnil "_sectorData") exitwith {_position};

_sectorTerrain = [_sectorData, "terrain"] call ALIVE_fnc_hashGet;

// the positions sector is terrain shore
// we can get a sea position there
if(_sectorTerrain == "SHORE") then {

	//["GCL - sector terrain is shore"] call ALIVE_fnc_dump;
	_sectorTerrainSamples = [_sectorData, "terrainSamples"] call ALIVE_fnc_hashGet;
	_samples = [_sectorTerrainSamples, "sea"] call ALIVE_fnc_hashGet;
	
	if(count _samples > 0) then {
		//["GCL got sea samples: %1",_samples] call ALIVE_fnc_dump;
		_result = _samples select (random (count _samples)-1);
		_result set [2,0];
	};
};

// the positions sector is terrain land
// get the surrounding sectors to check if there are any shore positions
// if so spawn on a random sea position
if(_sectorTerrain == "LAND") then {

	//["GCL - sector terrain is land"] call ALIVE_fnc_dump;
	_sectors = [ALIVE_sectorGrid, "surroundingSectors", _position] call ALIVE_fnc_sectorGrid;	
	_sectors = [_sectors, "sea"] call ALIVE_fnc_sectorFilterBestPlaces;
	
	if(count _sectors > 0) then {
		_sectors = [_sectors,_position] call ALIVE_fnc_sectorSortDistance;
		_sector = _sectors select 0;
		_sectorData = [_sector, "data"] call ALIVE_fnc_hashGet;
        
        if (isnil "_sectorData") exitwith {_position};
        
		_sectorTerrainSamples = [_sectorData, "terrainSamples"] call ALIVE_fnc_hashGet;
		_samples = [_sectorTerrainSamples, "sea"] call ALIVE_fnc_hashGet;
		
		if(count _samples > 0) then {
			//["GCL got sea samples: %1",_samples] call ALIVE_fnc_dump;
			_result = _samples select (random (count _samples)-1);
			_result set [2,0];
		};
	}else{
		// not sure what to do here, they are out to sea...
	};
};			

_result