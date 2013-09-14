#include <\x\alive\addons\sys_profile\script_component.hpp>
SCRIPT(profileGetGoodSpawnPosition);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_profileGetGoodSpawnPosition

Description:
Returns a good spawn position for the profile

Parameters:
Array - Entity or Vehicle profile

Returns:

Examples:
(begin example)
// get good spawn position
_result = [_profile] call ALIVE_fnc_profileGetGoodSpawnPosition;
(end)

See Also:

Author:
ARJay
---------------------------------------------------------------------------- */

private ["_profile","_debug","_active","_position","_side","_profileID","_type","_objectType","_vehicleAssignments",
"_sector","_sectorData","_sectorTerrain","_sectorTerrainSamples","_samples","_sectors","_spawnPosition",
"_vehicleProfile","_vehicleObjectType","_entitiesInCommandOf","_entitiesInCommandOf","_vehicleClass","_direction",
"_vehicles","_fuel","_ammo","_engineOn","_damage","_despawnPosition","_vehiclesInCommandOf","_vehiclesInCargoOf",
"_unitClasses","_damages","_ranks","_waypoints","_despawnPosition","_hasSimulated",
"_inCommand","_inCar","_inAir","_inShip","_inArmor"];

_profile = _this select 0;

_markerCount = 0;

_createMarker = {	
	private["_position","_text","_profileID","_m"];

	_position = _this select 0;
	_text = _this select 1;
	_profileID = _this select 2;

	_m = createMarkerLocal [format["M%1_%2", _profileID, _markerCount], _position];
	_m setMarkerShapeLocal "ICON";
	_m setMarkerSizeLocal [1, 1];
	_m setMarkerTypeLocal "hd_dot";
	_m setMarkerColorLocal "ColorYellow";
	_m setMarkerTextLocal _text;
	
	_markerCount = _markerCount + 1;
};

/*
	Wolffy.au
[18/08/2013 1:07:38 PM] ARJay: it needs to:
if the profile is a land vehicle
- check that the simulated poistion is not in the sea
- check i f there are nearish roads to spawn as priority
- if not near 500m? of road find an empty space
- if I am part of a group of vehicles spawn me near group but not close enough to explode
*/

_debug = _profile select 2 select 0; //[_profile,"debug"] call ALIVE_fnc_hashGet;
_active = _profile select 2 select 1; //[_profile,"active"] call ALIVE_fnc_hashGet;
_position = _profile select 2 select 2; //[_profile,"position"] call ALIVE_fnc_hashGet;
_side = _profile select 2 select 3; //[_profile, "side"] call MAINCLASS;
_profileID = _profile select 2 select 4; //[_profile,"profileID"] call ALIVE_fnc_hashGet;
_type = _profile select 2 select 5; //[_profile,"type"] call ALIVE_fnc_hashGet;
_objectType = _profile select 2 select 6; //[_profile,"objectType"] call ALIVE_fnc_hashGet;
_vehicleAssignments = _profile select 2 select 7; //[_profile,"vehicleAssignments"] call ALIVE_fnc_hashGet;

//["GGSP [%1] - default position: %2",_profileID,_position] call ALIVE_fnc_dump;

switch(_type) do {
	case "entity": {
		_vehiclesInCommandOf = _profile select 2 select 8; //[_profile,"vehiclesInCommandOf",[]] call ALIVE_fnc_hashSet;
		_vehiclesInCargoOf = _profile select 2 select 9; //[_profile,"vehiclesInCargoOf",[]] call ALIVE_fnc_hashSet;
		_unitClasses = _profile select 2 select 11; //[_profile,"unitClasses"] call ALIVE_fnc_hashGet;
		_despawnPosition = _profile select 2 select 23; //[_profile,"despawnPosition"] call ALIVE_fnc_hashGet;
		_hasSimulated = _profile select 2 select 24; //[_profile,"hasSimulated"] call ALIVE_fnc_hashGet;

		_inCommand = false;
		_inCar = false;
		_inAir = false;
		_inShip = false;
		_inArmor = false;
		
		//["GGSP [%1] - commanding vehicles: %2 cargo vehicles: %3 simulated: %4",_profileID,_vehiclesInCommandOf,_vehiclesInCargoOf,_hasSimulated] call ALIVE_fnc_dump;
	
		// the profile has been moved via simulation
		if(_hasSimulated) then {
			
			// entity is not in the cargo of a vehicle
			if(count _vehiclesInCargoOf == 0) then {	
			
				// we are commanding vehicles 
				// need to take the vehicle types etc into account
				if(count _vehiclesInCommandOf > 0) then {
					_vehicles = [];
					_inCommand = true;
					{
						_vehicleProfile = [ALIVE_profileHandler, "getProfile", _x] call ALIVE_fnc_profileHandler;
                        
                        if !(isnil "_vehicleProfile") then {
							//_vehicleClass = _vehicleProfile select 2 select 11; //[_profile,"vehicleClass"] call ALIVE_fnc_hashGet;
							_vehicleObjectType = _vehicleProfile select 2 select 6; //[_profile,"objectType"] call ALIVE_fnc_hashGet;
							
							_vehicles set [count _vehicles, _vehicleProfile];
							
							if(_vehicleObjectType == "Car" || _vehicleObjectType == "Truck" || _vehicleObjectType == "Armored") then {
								_inCar = true;
							};
							if(_vehicleObjectType == "Plane" || _vehicleObjectType == "Helicopter") then {
								_inAir = true;
							};
							if(_vehicleObjectType == "Ship") then {
								_inShip = true;
							};
                        };
					} forEach _vehiclesInCommandOf;
				};
				
				_spawnPosition = _position;
				
				//[_spawnPosition,"DEF",_profileID] call _createMarker;
				
				//["GGSP [%1] - command: %2 car: %3 air: %4 ship: %5",_profileID,_inCommand,_inCar,_inAir,_inShip] call ALIVE_fnc_dump;
			
				// if the entity is not commanding any vehicles
				if!(_inCommand) then {
				
					// spawn position is in the water
					if(surfaceIsWater _position) then {
					
						//["GGSP [%1] - the position is water",_profileID] call ALIVE_fnc_dump;
						_spawnPosition = [_position] call ALIVE_fnc_getClosestLand;				

						//[_spawnPosition,"LAND",_profileID] call _createMarker;
					};
				};
				
				// if the entity is in a ship
				if(_inShip) then {
				
					// spawn position is not in the water
					if!(surfaceIsWater _position) then {
					
						//["GGSP [%1] - ship - the position is land",_profileID] call ALIVE_fnc_dump;
						_spawnPosition = [_position] call ALIVE_fnc_getClosestSea;

						//[_spawnPosition,"SEA",_profileID] call _createMarker;
					};
				};
				
				// if the entity is in a car
				if(_inCar) then {
				
					//["GGSP [%1] - car",_profileID] call ALIVE_fnc_dump;
					_spawnPosition = [_position] call ALIVE_fnc_getClosestRoad;	

					//[_spawnPosition,"ROAD",_profileID] call _createMarker;					
				};
								
				// update the entities position
				[_profile,"position",_spawnPosition] call ALIVE_fnc_hashSet;
				[_profile,"mergePositions"] call ALIVE_fnc_profileEntity;
				
				// update any vehicle profile positions
				if(_inCommand) then {
				
					//["GGSP [%1] - IN COMMAND count vehicle: %2",_profileID,count _vehicles] call ALIVE_fnc_dump;
				
					if(count _vehicles > 1) then  {
					
						// lead vehicle
						_vehicleProfile = _vehicles select 0;
						[_vehicleProfile,"position",_spawnPosition] call ALIVE_fnc_profileVehicle;
						_direction = [_vehicleProfile,"direction"] call ALIVE_fnc_profileVehicle;
						[_vehicleProfile,"mergePositions"] call ALIVE_fnc_profileVehicle;
						
						_vehicles = _vehicles - [_vehicleProfile];
						
						//[_spawnPosition,"LEAD",_profileID] call _createMarker;	
					
						{
							_position = [_spawnPosition, (20 * _forEachIndex), _direction] call BIS_fnc_relPos;
							
							//[_position,"SQ",_profileID] call _createMarker;
							_vehicleProfile = _x;
							[_vehicleProfile,"position",_position] call ALIVE_fnc_profileVehicle;
							//[_vehicleProfile,"direction",_direction] call ALIVE_fnc_profileVehicle;
							[_vehicleProfile,"mergePositions"] call ALIVE_fnc_profileVehicle;
							
							if(_inAir) then {
								[_vehicleProfile,"engineOn", true] call ALIVE_fnc_profileVehicle;
							};
							
						} forEach _vehicles;
					
					} else {
						
						_vehicleProfile = _vehicles select 0;
						[_vehicleProfile,"position",_spawnPosition] call ALIVE_fnc_profileVehicle;
						//[_vehicleProfile,"direction",_direction] call ALIVE_fnc_profileVehicle;
						[_vehicleProfile,"mergePositions"] call ALIVE_fnc_profileVehicle;
						
						if(_inAir) then {
							[_vehicleProfile,"engineOn", true] call ALIVE_fnc_profileVehicle;
						};						
					};
				};
			};
		// the profile has not been moved via simulation
		// set the position to the position it was despawned in
		} else {
		
			if(((_despawnPosition select 0) + (_despawnPosition select 1)) == 0) then {
				_spawnPosition = _position;
			}else{
				_spawnPosition = _despawnPosition;			
				//[_spawnPosition,"DESP",_profileID] call _createMarker;				
			};		

			[_profile,"position",_spawnPosition] call ALIVE_fnc_hashSet;
			[_profile,"mergePositions"] call ALIVE_fnc_profileEntity;
				
			//["GGSP [%1] - not simulated - set pos as despawn position: %2",_profileID,_spawnPosition] call ALIVE_fnc_dump;
		}
	};
	case "vehicle": {
		/*
		_entitiesInCommandOf = _profile select 2 select 8; //[_profile,"entitiesInCommandOf",[]] call ALIVE_fnc_hashSet;
		_entitiesInCommandOf = _profile select 2 select 9; //[_profile,"entitiesInCargoOf",[]] call ALIVE_fnc_hashSet;
		_vehicleClass = _profile select 2 select 11; //[_profile,"vehicleClass"] call ALIVE_fnc_hashGet;
		_direction = _profile select 2 select 12; //[_profile,"direction"] call ALIVE_fnc_hashGet;
		_fuel = _profile select 2 select 13; //[_profile,"fuel"] call ALIVE_fnc_hashGet;
		_ammo = _profile select 2 select 14; //[_profile,"ammo"] call ALIVE_fnc_hashGet;
		_engineOn = _profile select 2 select 15; //[_profile,"engineOn"] call ALIVE_fnc_hashGet;
		_damage = _profile select 2 select 16; //[_profile,"damage"] call ALIVE_fnc_hashGet;
		*/
		_despawnPosition = _profile select 2 select 20; //[_profile,"despawnPosition"] call ALIVE_fnc_hashGet;
		_hasSimulated = _profile select 2 select 21; //[_profile,"hasSimulated"] call ALIVE_fnc_hashGet;
		
		// the vehicle has been simulated 
		// let the entity profile in command of the vehicle
		// deal with positioning
		if(_hasSimulated) then {
			
		// the profile has not been moved via simulation
		// set the position to the position it was despawned in
		}else{
			
			if(((_despawnPosition select 0) + (_despawnPosition select 1)) == 0) then {
				_spawnPosition = _position;
			}else{
				_spawnPosition = _despawnPosition;			
				//[_spawnPosition,"DESP",_profileID] call _createMarker;				
			};
			
			[_profile,"position",_spawnPosition] call ALIVE_fnc_hashSet;
			
			//["GGSP [%1] - not simulated - set pos as despawn position: %2",_profileID,_result] call ALIVE_fnc_dump;
		};
	};
};