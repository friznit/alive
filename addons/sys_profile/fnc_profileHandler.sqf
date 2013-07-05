#include <\x\alive\addons\sys_profile\script_component.hpp>
SCRIPT(profileHandler);

/* ----------------------------------------------------------------------------
Function: MAINCLASS
Description:
The main profile handler / repository

Parameters:
Nil or Object - If Nil, return a new instance. If Object, reference an existing instance.
String - The selected function
Array - The selected parameters

Returns:
Any - The new instance or the result of the selected function and parameters

Attributes:
Boolean - debug - Debug enable, disable or refresh
Boolean - state - Store or restore state
Hash - registerProfile - Profile hash to register on the handler
Hash - unregisterProfile - Profile hash to unregister on the handler
String - getProfile - Profile object id to get profile by
None - getProfiles
String - getProfilesByType - String profile type to get filtered array of profiles by
String - getProfilesBySide - String profile side to get filtered array of profiles by
String - getProfilesByVehicleType - String profile vehicle type to get filtered array of profiles by

Examples:
(begin example)
// create a profile handler
_logic = [nil, "create"] call ALIVE_fnc_profileHandler;

// init profile handler
_result = [_logic, "init"] call ALIVE_fnc_profileHandler;

// register a profile
_result = [_logic, "registerProfile", _profile] call ALIVE_fnc_profileHandler;

// unregister a profile
_result = [_logic, "unregisterProfile", _profile] call ALIVE_fnc_profileHandler;

// get a profile by id
_result = [_logic, "getProfile", "agent_01"] call ALIVE_fnc_profileHandler;

// get hash of all profiles
_result = [_logic, "getProfiles"] call ALIVE_fnc_profileHandler;

// get profiles by type
_result = [_logic, "getProfilesByType", "agent"] call ALIVE_fnc_profileHandler;

// get profiles by side
_result = [_logic, "getProfilesBySide", "WEST"] call ALIVE_fnc_profileHandler;

// get profiles by vehicle type
_result = [_logic, "getProfilesByVehicleType", "Car"] call ALIVE_fnc_profileHandler;

// get profiles by company
_result = [_logic, "getProfilesByCompany", "company_01"] call ALIVE_fnc_profileHandler;

// get object state
_state = [_logic, "state"] call ALIVE_fnc_profileHandler;
(end)

See Also:

Author:
ARJay

Peer reviewed:
nil
---------------------------------------------------------------------------- */

#define SUPERCLASS ALIVE_fnc_baseClassHash
#define MAINCLASS ALIVE_fnc_profileHandler

private ["_logic","_operation","_args","_result"];

TRACE_1("profileHandler - input",_this);

_logic = [_this, 0, objNull, [objNull,[]]] call BIS_fnc_param;
_operation = [_this, 1, "", [""]] call BIS_fnc_param;
_args = [_this, 2, objNull, [objNull,[],"",0,true,false]] call BIS_fnc_param;
_result = true;

#define MTEMPLATE "ALiVE_PROFILEHANDLER_%1"

switch(_operation) do {
        case "init": {
                /*
                MODEL - no visual just reference data
                - nodes
                - center
                - size
                */

                if (isServer) then {
						private["_profilesByType","_profilesBySide"];

                        // if server, initialise module game logic
						[_logic,"super"] call ALIVE_fnc_hashRem;
						[_logic,"class"] call ALIVE_fnc_hashRem;
                        TRACE_1("After module init",_logic);

						// set defaults
						[_logic,"debug",false] call ALIVE_fnc_hashSet;
						[_logic,"profiles",[] call ALIVE_fnc_hashCreate] call ALIVE_fnc_hashSet;

						_profilesByType = [] call ALIVE_fnc_hashCreate;
						[_profilesByType, "entity", []] call ALIVE_fnc_hashSet;
						[_profilesByType, "mil", []] call ALIVE_fnc_hashSet;
						[_profilesByType, "civ", []] call ALIVE_fnc_hashSet;
						[_profilesByType, "vehicle", []] call ALIVE_fnc_hashSet;
						[_logic,"profilesByType",_profilesByType] call ALIVE_fnc_hashSet;

						_profilesBySide = [] call ALIVE_fnc_hashCreate;
						[_profilesBySide, "EAST", []] call ALIVE_fnc_hashSet;
						[_profilesBySide, "WEST", []] call ALIVE_fnc_hashSet;
						[_profilesBySide, "GUER", []] call ALIVE_fnc_hashSet;
						[_profilesBySide, "CIV", []] call ALIVE_fnc_hashSet;
						[_logic,"profilesBySide",_profilesBySide] call ALIVE_fnc_hashSet;
						
						_profilesByVehicleType = [] call ALIVE_fnc_hashCreate;
						[_profilesByVehicleType, "Car", []] call ALIVE_fnc_hashSet;
						[_profilesByVehicleType, "Tank", []] call ALIVE_fnc_hashSet;
						[_profilesByVehicleType, "Truck", []] call ALIVE_fnc_hashSet;
						[_profilesByVehicleType, "Ship", []] call ALIVE_fnc_hashSet;
						[_profilesByVehicleType, "Helicopter", []] call ALIVE_fnc_hashSet;
						[_profilesByVehicleType, "Plane", []] call ALIVE_fnc_hashSet;
						[_profilesByVehicleType, "StaticWeapon", []] call ALIVE_fnc_hashSet;
						[_logic,"profilesByVehicleType",_profilesByVehicleType] call ALIVE_fnc_hashSet;

						[_logic,"profilesByCompany",[] call ALIVE_fnc_hashCreate] call ALIVE_fnc_hashSet;

						[_logic,"profilesActive",[]] call ALIVE_fnc_hashSet;
						[_logic,"profilesInActive",[]] call ALIVE_fnc_hashSet;
                };

                /*
                VIEW - purely visual
                */

                /*
                CONTROLLER  - coordination
                */
        };
        case "destroy": {
                [_logic, "debug", false] call MAINCLASS;
                if (isServer) then {
						[_logic, "destroy"] call SUPERCLASS;
                };

        };
        case "debug": {
				private["_profiles"];

                if(typeName _args != "BOOL") then {
						_args = [_logic,"debug"] call ALIVE_fnc_hashGet;
                } else {
						[_logic,"debug",_args] call ALIVE_fnc_hashSet;
                };
                ASSERT_TRUE(typeName _args == "BOOL",str _args);

				_profiles = [_logic, "profiles"] call ALIVE_fnc_hashGet;

				if(count _profiles > 0) then {
					{
						_profileType = [_x, "type"] call ALIVE_fnc_hashGet;
						switch(_profileType) do {
								case "entity": {
									_result = [_x, "debug", false] call ALIVE_fnc_profileEntity;
								};
								case "mil": {
									_result = [_x, "debug", false] call ALIVE_fnc_profileMil;
								};
								case "civ": {
									_result = [_x, "debug", false] call ALIVE_fnc_profileCiv;
								};
								case "vehicle": {
									_result = [_x, "debug", false] call ALIVE_fnc_profileVehicle;
								};
						};
					} forEach (_profiles select 2);

					if(_args) then {
                        {
							_profileType = [_x, "type"] call ALIVE_fnc_hashGet;
							switch(_profileType) do {
									case "entity": {
										_result = [_x, "debug", true] call ALIVE_fnc_profileEntity;
									};
									case "mil": {
										_result = [_x, "debug", true] call ALIVE_fnc_profileMil;
									};
									case "civ": {
										_result = [_x, "debug", true] call ALIVE_fnc_profileCiv;
									};
									case "vehicle": {
										_result = [_x, "debug", true] call ALIVE_fnc_profileVehicle;
									};
							};
						} forEach (_profiles select 2);
					};
				};
				
				// DEBUG -------------------------------------------------------------------------------------
				if(_args) then {
					["----------------------------------------------------------------------------------------"] call ALIVE_fnc_dump;
					["ALIVE Profile Handler State"] call ALIVE_fnc_dump;
					_state = [ALIVE_profileHandler, "state"] call ALIVE_fnc_profileHandler;
					_state call ALIVE_fnc_inspectHash;
				};

                _result = _args;
        };
		case "state": {
				private["_state"];

				if(typeName _args != "ARRAY") then {

						// Save state

                        _state = [] call ALIVE_fnc_hashCreate;

						// loop the class hash and set vars on the state hash
						{
							if(!(_x == "super") && !(_x == "class")) then {
								[_state,_x,[_logic,_x] call ALIVE_fnc_hashGet] call ALIVE_fnc_hashSet;
							};
						} forEach (_logic select 1);

                        _result = _state;

                } else {
						ASSERT_TRUE(typeName _args == "ARRAY",str typeName _args);

                        // Restore state

						// loop the passed hash and set vars on the class hash
                        {
							[_logic,_x,[_args,_x] call ALIVE_fnc_hashGet] call ALIVE_fnc_hashSet;
						} forEach (_args select 1);
                };
        };
		case "registerProfile": {
				private["_profile","_profileID","_profiles","_profilesByType","_profilesBySide","_profilesByVehicleType","_profilesActive","_profilesInActive","_profilesByCompany",
				"_profileType","_profilesType","_profileSide","_profilesSide","_profileActive","_profileCompany","_profleByCompanyArray","_profileVehicleType",
				"_profilesVehicleType"];

				if(typeName _args == "ARRAY") then {
						_profile = _args;

						_profiles = [_logic, "profiles"] call ALIVE_fnc_hashGet;
						_profilesByType = [_logic, "profilesByType"] call ALIVE_fnc_hashGet;
						_profilesBySide = [_logic, "profilesBySide"] call ALIVE_fnc_hashGet;
						_profilesByVehicleType = [_logic, "profilesByVehicleType"] call ALIVE_fnc_hashGet;
						_profilesActive = [_logic, "profilesActive"] call ALIVE_fnc_hashGet;
						_profilesInActive = [_logic, "profilesInActive"] call ALIVE_fnc_hashGet;
						_profilesByCompany = [_logic, "profilesByCompany"] call ALIVE_fnc_hashGet;

						// store on main profiles hash
						_profileID = [_profile, "profileID"] call ALIVE_fnc_hashGet;
						[_profiles, _profileID, _profile] call ALIVE_fnc_hashSet;

						// store reference to main profile on by type hash
						_profileType = [_profile, "type"] call ALIVE_fnc_hashGet;
						_profilesType = [_profilesByType, _profileType] call ALIVE_fnc_hashGet;
						_profilesType set [count _profilesType, _profileID];
						
						
						// DEBUG -------------------------------------------------------------------------------------
						if([_logic,"debug"] call ALIVE_fnc_hashGet) then {
							[_profile,"debug",true] call ALIVE_fnc_hashSet;
							["ALIVE Profile Handler"] call ALIVE_fnc_dump;
							["Register Profile [%1]",_profileID] call ALIVE_fnc_dump;
							_profile call ALIVE_fnc_inspectHash;
						};
						// DEBUG -------------------------------------------------------------------------------------

						
						if(_profileType == "entity" || _profileType == "mil" || _profileType == "civ" || _profileType == "vehicle") then {

							// store reference to main profile on by side hash
							_profileSide = [_profile, "side"] call ALIVE_fnc_hashGet;
							_profilesSide = [_profilesBySide, _profileSide] call ALIVE_fnc_hashGet;
							_profilesSide set [count _profilesSide, _profileID];

							// store active state on active or inactive array
							_profileActive = [_profile, "active"] call ALIVE_fnc_hashGet;

							if(_profileActive) then {
								_profilesActive set [count _profilesActive, _profileID];
							}else{
								_profilesInActive set [count _profilesInActive, _profileID];
							};

							if!(_profileType == "vehicle") then {
								// if company id is set
								_profileCompany = [_profile, "companyID"] call ALIVE_fnc_hashGet;
								if!(_profileCompany == "") then {
									if!([_profilesByCompany, _profileCompany] call CBA_fnc_hashHasKey) then {
										_profleByCompanyArray = [_profileID];
										[_profilesByCompany, _profileCompany, _profleByCompanyArray] call ALIVE_fnc_hashSet;
									} else {
										_profleByCompanyArray = [_profilesByCompany, _profileCompany] call ALIVE_fnc_hashGet;
										_profleByCompanyArray set [count _profleByCompanyArray, _profileID];
									};
								};								
							}else{
								// vehicle type
								_profileVehicleType = [_profile, "vehicleType"] call ALIVE_fnc_hashGet;
								_profilesVehicleType = [_profilesByVehicleType,_profileVehicleType] call ALIVE_fnc_hashGet;
								_profilesVehicleType set [count _profilesVehicleType, _profileID];
							};
						};
                };
        };
		case "unregisterProfile": {
				private["_profile","_profileID","_profiles","_profilesByType","_profilesBySide","_profilesByVehicleType","_profilesActive","_profilesInActive","_profilesByCompany",
				"_profileType","_profilesType","_profileSide","_profilesSide","_profileActive","_profleByCompanyArray","_profileVehicleType",
				"_profilesVehicleType"];

				if(typeName _args == "ARRAY") then {
						_profile = _args;

						_profiles = [_logic, "profiles"] call ALIVE_fnc_hashGet;
						_profilesByType = [_logic, "profilesByType"] call ALIVE_fnc_hashGet;
						_profilesBySide = [_logic, "profilesBySide"] call ALIVE_fnc_hashGet;
						_profilesByVehicleType = [_logic, "profilesByVehicleType"] call ALIVE_fnc_hashGet;
						_profilesActive = [_logic, "profilesActive"] call ALIVE_fnc_hashGet;
						_profilesInActive = [_logic, "profilesInActive"] call ALIVE_fnc_hashGet;
						_profilesByCompany = [_logic, "profilesByCompany"] call ALIVE_fnc_hashGet;

						// remove on main profiles hash
						_profileID = [_profile, "profileID"] call ALIVE_fnc_hashGet;
						[_profiles, _profileID] call ALIVE_fnc_hashRem;

						// remove reference to main profile on by type hash
						_profileType = [_profile, "type"] call ALIVE_fnc_hashGet;
						_profilesType = [_profilesByType, _profileType] call ALIVE_fnc_hashGet;
						_profilesType = _profilesType - [_profileID];
						[_profilesByType, _profileType, _profilesType] call ALIVE_fnc_hashSet;
						
						
						// DEBUG -------------------------------------------------------------------------------------
						if([_logic,"debug"] call ALIVE_fnc_hashGet) then {
							["ALIVE Profile Handler"] call ALIVE_fnc_dump;
							["Un-Register Profile [%1]",_profileID] call ALIVE_fnc_dump;
							_profile call ALIVE_fnc_inspectHash;
						};
						// DEBUG -------------------------------------------------------------------------------------
						

						if(_profileType == "entity" || _profileType == "mil" || _profileType == "civ" || _profileType == "vehicle") then {

							// remove reference to main profile on by side hash
							_profileSide = [_profile, "side"] call ALIVE_fnc_hashGet;
							_profilesSide = [_profilesBySide, _profileSide] call ALIVE_fnc_hashGet;
							_profilesSide = _profilesSide - [_profileID];
							[_profilesBySide, _profileSide, _profilesSide] call ALIVE_fnc_hashSet;

							// remove active state on active or inactive array
							_profileActive = [_profile, "active"] call ALIVE_fnc_hashGet;

							if(_profileActive) then {
								_profilesActive = _profilesActive - [_profileID];
								[_logic, "profilesActive", _profilesActive] call ALIVE_fnc_hashSet;
							}else{
								_profilesInActive = _profilesInActive - [_profileID];
								[_logic, "profilesInActive", _profilesInActive] call ALIVE_fnc_hashSet;
							};

							if!(_profileType == "vehicle") then {
								// if company id is set
								_profileCompany = [_profile, "companyID"] call ALIVE_fnc_hashGet;
								if!(_profileCompany == "") then {
									_profleByCompanyArray = [_profilesByCompany, _profileCompany] call ALIVE_fnc_hashGet;
									_profleByCompanyArray = _profleByCompanyArray - [_profileID];
									[_profilesByCompany, _profileCompany, _profleByCompanyArray] call ALIVE_fnc_hashSet;
								};
							}else{
								// vehicle type
								_profileVehicleType = [_profile, "vehicleType"] call ALIVE_fnc_hashGet;
								_profilesVehicleType = [_profilesByVehicleType, _profileVehicleType] call ALIVE_fnc_hashGet;
								_profilesVehicleType = _profilesVehicleType - [_profileID];
								[_profilesByVehicleType, _profileVehicleType, _profilesVehicleType] call ALIVE_fnc_hashSet;
							};
						};
                };
        };
		case "getProfile": {
				private["_profileID","_profiles"];

				if(typeName _args == "STRING") then {
					_profileID = _args;

					_profiles = [_logic, "profiles"] call ALIVE_fnc_hashGet;

					_result = [[_logic, "profiles"] call ALIVE_fnc_hashGet, _profileID] call ALIVE_fnc_hashGet;
				};
		};
		case "getProfiles": {
				_result = [_logic, "profiles"] call ALIVE_fnc_hashGet;
		};
		case "getProfilesByType": {
				private["_type","_profilesByType"];

				if(typeName _args == "STRING") then {
					_type = _args;

					_profilesByType = [_logic, "profilesByType"] call ALIVE_fnc_hashGet;

					_result = [_profilesByType, _type] call ALIVE_fnc_hashGet;
				};
		};
		case "getProfilesBySide": {
				private["_type","_profilesBySide"];

				if(typeName _args == "STRING") then {
					_side = _args;

					_profilesBySide = [_logic, "profilesBySide"] call ALIVE_fnc_hashGet;

					_result = [_profilesBySide, _side] call ALIVE_fnc_hashGet;
				};
		};
		case "getProfilesByVehicleType": {
				private["_type","_profilesByVehicleType"];

				if(typeName _args == "STRING") then {
					_type = _args;

					_profilesByVehicleType = [_logic, "profilesByVehicleType"] call ALIVE_fnc_hashGet;

					_result = [_profilesByVehicleType, _type] call ALIVE_fnc_hashGet;
				};
		};
		case "getProfilesByCompany": {
				private["_type","_profilesByCompany"];

				if(typeName _args == "STRING") then {
					_company = _args;

					_profilesByCompany = [_logic, "profilesByCompany"] call ALIVE_fnc_hashGet;

					_result = [_profilesByCompany, _company] call ALIVE_fnc_hashGet;
				};
		};
        default {
                _result = [_logic, _operation, _args] call SUPERCLASS;
        };
};
TRACE_1("profileHandler - output",_result);
_result;