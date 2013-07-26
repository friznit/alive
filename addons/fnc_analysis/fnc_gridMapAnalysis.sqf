#include <\x\alive\addons\fnc_analysis\script_component.hpp>
SCRIPT(gridMapAnalysis);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_gridMapAnalysis

Description:
Perform analysis of terrain for a grid

Parameters:
Grid - the grid to run the map analysis on
Bool - export - exports the results of the analysis to the clipboard once completed
Bool - debug - debug mode

Returns:
...

Examples:
(begin example)
// analyse
_result = [_grid] call ALIVE_fnc_gridMapAnalysis;
(end)

See Also:


Author:
ARJay
---------------------------------------------------------------------------- */

private ["_grid","_export","_debug","_sectors","_exportString","_landSectors","_sector","_sectorData","_sectorID","_subGrid","_subGridSectors","_plotter"];

_grid = _this select 0;
_export = if(count _this > 1) then {_this select 1} else {false};
_debug = if(count _this > 2) then {_this select 2} else {false};

// reset existing analysis data

//[true] call ALIVE_fnc_timer;

_sectors = [_grid, "sectors"] call ALIVE_fnc_sectorGrid;

if(_export) then {
	_exportString = 'ALIVE_gridData = [] call ALIVE_fnc_hashCreate;';
};

// DEBUG -------------------------------------------------------------------------------------
if(_debug) then {
	["----------------------------------------------------------------------------------------"] call ALIVE_fnc_dump;
	["ALIVE Starting Map Analysis"] call ALIVE_fnc_dump;
};
// DEBUG -------------------------------------------------------------------------------------

{
	_sector = _x;
	_sectorData = [_sector, "data"] call ALIVE_fnc_sector;
	_sectorID = [_sector, "id"] call ALIVE_fnc_sector;
	
	// DEBUG -------------------------------------------------------------------------------------
	if(_debug) then {
		["----------------------------------------------------------------------------------------"] call ALIVE_fnc_dump;
		["Map Analysis sector [%1] creating sub dividing grid",_sectorID] call ALIVE_fnc_dump;
		[true] call ALIVE_fnc_timer;
	};
	// DEBUG -------------------------------------------------------------------------------------
	
	_subGrid = [_sector,10,format["Grid_%1",_forEachIndex]] call ALIVE_fnc_sectorSubGrid;
	_subGridSectors = [_subGrid, "sectors"] call ALIVE_fnc_sectorGrid;
	
	// DEBUG -------------------------------------------------------------------------------------
	if(_debug) then {
		["----------------------------------------------------------------------------------------"] call ALIVE_fnc_dump;
		["sub dividing grid created"] call ALIVE_fnc_dump;
		[] call ALIVE_fnc_timer;
		["start terrain analysis"] call ALIVE_fnc_dump;
		[true] call ALIVE_fnc_timer;
	};
	// DEBUG -------------------------------------------------------------------------------------
		
	[_subGridSectors] call ALIVE_fnc_sectorAnalysisTerrain;
	
	// DEBUG -------------------------------------------------------------------------------------
	if(_debug) then {
		["----------------------------------------------------------------------------------------"] call ALIVE_fnc_dump;
		["terrain analysis completed"] call ALIVE_fnc_dump;
		[] call ALIVE_fnc_timer;
		["start elevation analysis"] call ALIVE_fnc_dump;
		[true] call ALIVE_fnc_timer;
	};
	// DEBUG -------------------------------------------------------------------------------------
	
	[_subGridSectors] call ALIVE_fnc_sectorAnalysisElevation;
		
	// DEBUG -------------------------------------------------------------------------------------
	if(_debug) then {
		["----------------------------------------------------------------------------------------"] call ALIVE_fnc_dump;
		["elevation analysis completed"] call ALIVE_fnc_dump;
		[] call ALIVE_fnc_timer;
		["start best places analysis"] call ALIVE_fnc_dump;
		[true] call ALIVE_fnc_timer;
	};
	// DEBUG -------------------------------------------------------------------------------------
	
	[_subGridSectors,2] call ALIVE_fnc_sectorAnalysisBestPlaces;
	
	// DEBUG -------------------------------------------------------------------------------------
	if(_debug) then {
		["----------------------------------------------------------------------------------------"] call ALIVE_fnc_dump;
		["best places analysis completed"] call ALIVE_fnc_dump;
		[] call ALIVE_fnc_timer;
		["start compilation of sub sector data into parent sector"] call ALIVE_fnc_dump;
		[true] call ALIVE_fnc_timer;
	};
	// DEBUG -------------------------------------------------------------------------------------	
	
	private ["_elevationSamples","_elevation","_terrainSamples","_terrain","_forestPlaces","_hillPlaces","_meadowPlaces","_treePlaces","_housePlaces","_seaPlaces","_bestPlaces"];
	
	_elevationSamples = [];
	_elevation = 0;
	_terrainSamples = [];
	_terrain = "";
	_forestPlaces = [];
	_hillPlaces = [];
	_meadowPlaces = [];
	_treePlaces = [];
	_housePlaces = [];
	_seaPlaces = [];
	
	// copy all sub grid sector data into this parent sector data
	{
		private ["_subGridSector","_subGridSectorData","_subGridElevationSamples","_subGridTerrainSamples","_subGridBestPlaces",
		"_subGridForestPlaces","_subGridHillPlaces","_subGridMeadowPlaces","_subGridTreePlaces","_subGridHousePlaces","_subGridSeaPlaces","_countIsWater"];
		
		_subGridSector = _x;
		_subGridSectorData = [_subGridSector, "data"] call ALIVE_fnc_sector;
		_subGridElevationSamples = [_subGridSectorData, "elevationSamples"] call ALIVE_fnc_hashGet;
		_subGridTerrainSamples = [_subGridSectorData, "terrainSamples"] call ALIVE_fnc_hashGet;
		_subGridBestPlaces = [_subGridSectorData, "bestPlaces"] call ALIVE_fnc_hashGet;
		
		_subGridForestPlaces = [_subGridBestPlaces, "forest"] call ALIVE_fnc_hashGet;
		_subGridHillPlaces = [_subGridBestPlaces, "exposedHills"] call ALIVE_fnc_hashGet;
		_subGridMeadowPlaces = [_subGridBestPlaces, "meadow"] call ALIVE_fnc_hashGet;
		_subGridTreePlaces = [_subGridBestPlaces, "exposedTrees"] call ALIVE_fnc_hashGet;
		_subGridHousePlaces = [_subGridBestPlaces, "houses"] call ALIVE_fnc_hashGet;
		_subGridSeaPlaces = [_subGridBestPlaces, "sea"] call ALIVE_fnc_hashGet;
		
		_forestPlaces = _forestPlaces + _subGridForestPlaces;
		_hillPlaces = _hillPlaces + _subGridHillPlaces;
		_meadowPlaces = _meadowPlaces + _subGridMeadowPlaces;
		_treePlaces = _treePlaces + _subGridTreePlaces;
		_housePlaces = _housePlaces + _subGridHousePlaces;
		_seaPlaces = _seaPlaces + _subGridSeaPlaces;
		
		_elevationSamples = _elevationSamples + _subGridElevationSamples;
		_terrainSamples = _terrainSamples + _subGridTerrainSamples;		
		
	} forEach _subGridSectors;
	
	// calculate average elevation for the sector
	{
		_elevation = _elevation + (_x select 1);
	} forEach _elevationSamples;
	
	_elevation = _elevation / ((count _elevationSamples)-1);
	
	// determine terrain type
	_countIsWater = 0;
	{
		_terrain = _x select 1;
		if(_terrain == "SEA") then {
			_countIsWater = _countIsWater + 1;
		};
	} forEach _terrainSamples;
	
	if(_countIsWater == (count _terrainSamples)) then {
		_terrain = "SEA";
	};
	
	if(_countIsWater == 0) then {
		_terrain = "LAND";
	};
	
	if(_countIsWater > 0 && _countIsWater < (count _terrainSamples)) then {
		_terrain = "SHORE";
	};
	
	// store all data
	_bestPlaces = [] call ALIVE_fnc_hashCreate;
	[_bestPlaces,"forest",_forestPlaces] call ALIVE_fnc_hashSet;
	[_bestPlaces,"exposedHills",_hillPlaces] call ALIVE_fnc_hashSet;
	[_bestPlaces,"meadow",_meadowPlaces] call ALIVE_fnc_hashSet;
	[_bestPlaces,"exposedTrees",_treePlaces] call ALIVE_fnc_hashSet;
	[_bestPlaces,"houses",_housePlaces] call ALIVE_fnc_hashSet;
	[_bestPlaces,"sea",_seaPlaces] call ALIVE_fnc_hashSet;
	
	[_sectorData, "elevationSamples",_elevationSamples] call ALIVE_fnc_hashSet;
	[_sectorData, "elevation",_elevation] call ALIVE_fnc_hashSet;
	[_sectorData, "terrainSamples",_terrainSamples] call ALIVE_fnc_hashSet;
	[_sectorData, "terrain",_terrain] call ALIVE_fnc_hashSet;
	[_sectorData, "bestPlaces",_bestPlaces] call ALIVE_fnc_hashSet;	
	
	
	if(_export) then {
		_exportString = _exportString + '_sectorData = [] call ALIVE_fnc_hashCreate;';
		
		_exportString = _exportString + format['[_sectorData,"elevationSamples",%1] call ALIVE_fnc_hashSet;',_elevationSamples];
		_exportString = _exportString + format['[_sectorData,"elevation",%1] call ALIVE_fnc_hashSet;',_elevation];
		_exportString = _exportString + format['[_sectorData,"terrainSamples",%1] call ALIVE_fnc_hashSet;',_terrainSamples];
		_exportString = _exportString + format['[_sectorData,"terrain","%1"] call ALIVE_fnc_hashSet;',_terrain];
		
		_exportString = _exportString + '_bestPlaces = [] call ALIVE_fnc_hashCreate;';
		
		_exportString = _exportString + format['[_bestPlaces,"forest",%1] call ALIVE_fnc_hashSet;',_forestPlaces];
		_exportString = _exportString + format['[_bestPlaces,"exposedHills",%1] call ALIVE_fnc_hashSet;',_hillPlaces];
		_exportString = _exportString + format['[_bestPlaces,"meadow",%1] call ALIVE_fnc_hashSet;',_meadowPlaces];
		_exportString = _exportString + format['[_bestPlaces,"exposedTrees",%1] call ALIVE_fnc_hashSet;',_treePlaces];
		_exportString = _exportString + format['[_bestPlaces,"houses",%1] call ALIVE_fnc_hashSet;',_housePlaces];
		_exportString = _exportString + format['[_bestPlaces,"sea",%1] call ALIVE_fnc_hashSet;',_seaPlaces];
		
		_exportString = _exportString + format['[_sectorData,"bestPlaces",_bestPlaces] call ALIVE_fnc_hashSet;'];
		
		_exportString = _exportString + format['[ALIVE_gridData, "%1", _sectorData] call ALIVE_fnc_hashSet;',_sectorID];
	};
	
	// DEBUG -------------------------------------------------------------------------------------
	if(_debug) then {
		["----------------------------------------------------------------------------------------"] call ALIVE_fnc_dump;
		["compilation of sub sector data into parent sector completed"] call ALIVE_fnc_dump;
		_sectorData call ALIVE_fnc_inspectHash;
		[] call ALIVE_fnc_timer;
	};
	// DEBUG -------------------------------------------------------------------------------------
		
	/*
	private ["_plotter"];
	_plotter = [nil, "create"] call ALIVE_fnc_plotSectors;
	[_plotter, "init"] call ALIVE_fnc_plotSectors;
	[_plotter, "id", format["Plotter_%1",_forEachIndex]] call ALIVE_fnc_plotSectors;
	[_plotter, "plot", [_subGridSectors, "elevation"]] call ALIVE_fnc_plotSectors;
	[_plotter, "plot", [_subGridSectors, "terrain"]] call ALIVE_fnc_plotSectors;
	[_plotter, "plot", [_subGridSectors, "bestPlaces"]] call ALIVE_fnc_plotSectors;
	*/
	
	[_subGrid, "destroy"] call ALIVE_fnc_sectorGrid;
	
	
} forEach _sectors;


if(_export) then {
	copyToClipboard _exportString;
};

//[] call ALIVE_fnc_timer;