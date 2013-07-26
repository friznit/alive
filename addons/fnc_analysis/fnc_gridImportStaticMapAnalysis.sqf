#include <\x\alive\addons\fnc_analysis\script_component.hpp>
SCRIPT(gridImportStaticMapAnalysis);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_gridImportStaticMapAnalysis

Description:
Import static map analysis data structures to a grid

Parameters:
Grid - the grid to run the map analysis on
String - world static analysis file to import

Returns:
...

Examples:
(begin example)
// import stratis static map analysis to the passed grid
_result = [_grid,"Stratis"] call ALIVE_fnc_gridImportStaticMapAnalysis;
(end)

See Also:


Author:
ARJay
---------------------------------------------------------------------------- */

private ["_grid","_worldName","_sectors","_staticMapAnalysis","_sector","_sectorID"];

_grid = _this select 0;
_worldName = _this select 1;

_sectors = [_grid, "sectors"] call ALIVE_fnc_sectorGrid;

switch(_worldName) do {
	case "Stratis":{
		call ALIVE_fnc_staticMapAnalysisStratis;
	};
};

{
	_sector = _x;
	_sectorID = [_sector, "id"] call ALIVE_fnc_sector;
	[_sector, "data", [ALIVE_gridData, _sectorID] call ALIVE_fnc_hashGet] call ALIVE_fnc_hashSet;
	
} forEach _sectors;

/*
				case "analyzeclusteroccupation": {
                ASSERT_TRUE(typeName _args == "ARRAY",str _args);
 
                                _side = _args select 0;
                                _distance = _args select 1;
                                _nearForces = [];
                       
                                _forces = ([ALIVE_Profilehandler, "getProfilesByType", "entity"] call ALIVE_fnc_profileHandler);
								
                                {
                                        _item = _x;
                                        _pos = [_item,"center"] call ALiVE_fnc_HashGet;
                                        _id = [_item,"objectiveID"] call ALiVE_fnc_HashGet;
                                        _nearEntities = [];
                       
                                                {
                                                        _ProID = _x;
                                                        _profile = [ALIVE_profileHandler, "getProfile", _ProID] call ALIVE_fnc_profileHandler;
                                                        _posP = [_profile, "position"] call ALIVE_fnc_profileEntity;
														_clear = ({(([([ALIVE_profileHandler, "getProfile", _x] call ALIVE_fnc_profileHandler), "position"] call ALIVE_fnc_profileEntity) distance _pos < _distance) && !(([([ALIVE_profileHandler, "getProfile", _x] call ALIVE_fnc_profileHandler), "side"] call ALIVE_fnc_profileEntity) == _side)} count ([ALIVE_Profilehandler, "getProfilesByType", "entity"] call ALIVE_fnc_profileHandler)) < 1;
                                                        if ((_posP distance _pos < _distance) && _clear) then {_nearEntities set [count _nearEntities,_ProID]};
                                                } foreach _forces;
                                                if (count _nearEntities > 0) then {_nearForces set [count _nearForces,[_id,_nearEntities]]};
                                } foreach ([_logic,"objectives",[]] call AliVE_fnc_HashGet);
                                _result = _nearForces;
                };
*/