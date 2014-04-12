//#define DEBUG_MODE_FULL
#include <\x\alive\addons\mil_opcom\script_component.hpp>
SCRIPT(OPCOM);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_OPCOM
Description:
Virtual AI Controller (WIP) 

Base class for OPCOM objects to inherit from

Parameters:
Nil or Object - If Nil, return a new instance. If Object, reference an existing instance.
String - The selected function
Array - The selected parameters

Returns:
Any - The new instance or the result of the selected function and parameters

Attributes:
Boolean - debug - Debug enable, disable or refresh
init
createhashobject
createobjectivesbydistance
objectives
analyzeclusteroccupation
setorders
synchronizeorders
NearestAvailableSection
setstatebyclusteroccupation
selectordersbystate

Examples:
(begin example)
// create OPCOM objectives of SEP (ingame object for now) objectives and distance
_objectives = [_logic, "createobjectivesbydistance",SEP] call ALIVE_fnc_OPCOM;
(end)

See Also:

Author:
Highhead

Peer reviewed:
nil
---------------------------------------------------------------------------- */

#define SUPERCLASS ALIVE_fnc_baseClassHash
#define MAINCLASS ALIVE_fnc_OPCOM

private ["_logic","_operation","_args","_result"];

TRACE_1("OPCOM - input",_this);

_logic = [_this, 0, objNull, [objNull,[]]] call BIS_fnc_param;
_operation = [_this, 1, "", [""]] call BIS_fnc_param;
_args = [_this, 2, objNull, [objNull,[],"",0,true,false]] call BIS_fnc_param;
_result = nil;

#define MTEMPLATE "ALiVE_OPCOM_%1"

switch(_operation) do {
        // Main process
		case "init": {
			if (isServer) then {
				// if server, initialise module game logic
				_logic setVariable ["super", SUPERCLASS];
				_logic setVariable ["class", MAINCLASS];
				_logic setVariable ["moduleType", "ALIVE_OPCOM"];
				_logic setVariable ["startupComplete", false];
				TRACE_1("After module init",_logic);

                [_logic,"start"] call MAINCLASS;
			};
		};
		case "start": {                
                /*
                MODEL - no visual just reference data
                - nodes
                - center
                - size
                */
                
                if (isServer) then {

					//Retrieve module-object variables
                    _type = _logic getvariable ["controltype","invasion"];
                    _faction1 = _logic getvariable ["faction1","OPF_F"];
                    _faction2 = _logic getvariable ["faction2","NONE"];
                    _faction3 = _logic getvariable ["faction3","NONE"];
                    _faction4 = _logic getvariable ["faction4","NONE"];
                    _factions = [_logic, "convert", _logic getvariable ["factions",[]]] call ALiVE_fnc_OPCOM;
                    
                    _debug = call compile (_logic getvariable ["debug","false"]);
                    _persistent = call compile (_logic getvariable ["persistent","false"]);
                    _tasksEnabled = call compile (_logic getvariable ["playertaskings","true"]);
                    
                    //Get position
                    _position = getposATL _logic;
                    
                    //Collect factions and determine sides
                    //If missionmaker did not overwrite default factions then use the ones from the module dropdowns
                    if ((count _factions) == 0) then {
						{if (!(_x == "NONE") && {!(_x in _factions)}) then {_factions set [count _factions,_x]}} foreach [_faction1,_faction2,_faction3,_faction4];
                    };

                    _side = "EAST";
                    switch (getNumber(configfile >> "CfgFactionClasses" >> _factions select 0 >> "side")) do {
                		case 0 : {_side = "EAST"};
                		case 1 : {_side = "WEST"};
                		case 2 : {_side = "GUER"};
                		default {_side = "EAST"};
            		};
                    
                    //Thank you, BIS...
                    if (_side == "GUER") then {_side = "RESISTANCE"};
                    
                    _sides = ["EAST","WEST","RESISTANCE"];
                    _sidesEnemy = []; {if (((call compile _side) getfriend (call compile _x)) < 0.6) then {_sidesEnemy set [count _sidesEnemy,_x]}} foreach (_sides - [_side]);
                    _sidesFriendly = (_sides - _sidesEnemy);
                    
                    //Thank you again, BIS...
                    if (_side == "RESISTANCE") then {_side = "GUER"};
                    {if (_x == "RESISTANCE") then {_sidesEnemy set [_foreachIndex,"GUER"]}} foreach _sidesEnemy;
                    {if (_x == "RESISTANCE") then {_sidesFriendly set [_foreachIndex,"GUER"]}} foreach _sidesFriendly;
                    
					//Finally
                    
                    //Create OPCOM #Hash#Datahandler
					_handler = [nil, "createhashobject"] call ALIVE_fnc_OPCOM;
                    
                    //Set handler on module
                    _logic setVariable ["handler",_handler];
                   
					call compile format["OPCOM_%1 = _handler",count (missionNameSpace getvariable ["OPCOM_instances",[]])];
                    missionNameSpace setVariable ["OPCOM_instances",(missionNameSpace getvariable ["OPCOM_instances",[]]) + [_handler]];
                    _opcomID = str(floor(_position select 0)) + str(floor(_position select 1));
                    
					[_handler, "side",_side] call ALiVE_fnc_HashSet;
					[_handler, "factions",_factions] call ALiVE_fnc_HashSet;
					[_handler, "sidesenemy",_sidesEnemy] call ALiVE_fnc_HashSet;
					[_handler, "sidesfriendly",_sidesFriendly] call ALiVE_fnc_HashSet;
					[_handler, "controltype",_type] call ALiVE_fnc_HashSet;
					[_handler, "position",_position] call ALiVE_fnc_HashSet;
					[_handler, "simultanobjectives",10] call ALiVE_fnc_HashSet;
					[_handler, "tasksenabled",_tasksEnabled] call ALiVE_fnc_HashSet;
					[_handler, "opcomID",_opcomID] call ALiVE_fnc_HashSet;
					[_handler, "debug",_debug] call ALiVE_fnc_HashSet;
					[_handler, "persistent",_persistent] call ALiVE_fnc_HashSet;
					[_handler, "module",_logic] call ALiVE_fnc_HashSet;
                    
                    switch (_type) do {
						case ("invasion") : {
								[_handler, "sectionsamount_attack", 4] call ALiVE_fnc_HashSet;
								[_handler, "sectionsamount_reserve", 1] call ALiVE_fnc_HashSet;
								[_handler, "sectionsamount_defend", 2] call ALiVE_fnc_HashSet;
						};
						case ("occupation") : {
								[_handler, "sectionsamount_attack", 4] call ALiVE_fnc_HashSet;
								[_handler, "sectionsamount_reserve", 1] call ALiVE_fnc_HashSet;
								[_handler, "sectionsamount_defend", 5] call ALiVE_fnc_HashSet;
						};
					};

					/*
					CONTROLLER  - coordination
					*/
                    
                    ///////////
                    //Before starting check if startup parameters are ok!
                    ///////////
                    
                    //Check if a SYS Profile Module is available
                    _errorMessage = "No Profiles module was found! Please place a Profile System module! %1 %2";
                    _error1 = ""; _error2 = ""; //defaults
                    if !(["ALiVE_sys_profile"] call ALiVE_fnc_isModuleAvailable) exitwith {
						[_errorMessage,_error1,_error2] call ALIVE_fnc_dumpR;
                    };
                    
                    //Wait for virtual profiles ready
                    waituntil {!(isnil "ALiVE_ProfileHandler") && {[ALiVE_ProfileSystem,"startupComplete",false] call ALIVE_fnc_hashGet}};
                    
                    //Load Data from DB
                    private ["_objectives"];
                    
                    if ([_handler,"persistent",false] call ALIVE_fnc_HashGet) then {
                    	_objectives = [_handler,"loadObjectivesDB"] call ALiVE_fnc_OPCOM;
                    };
                    
                    if (!(isnil "_objectives") && {count _objectives > 0}) then {
                        ["ALiVE OPCOM loaded %1 objectives from DB!",count _objectives] call ALiVE_fnc_DumpMPH;
                    } else {
	                    //If no data was loaded from DB then get objectives data from other modules or placed Location logics!

                    	_objectives = [];
                   
	                    //Iterate through all synchronized modules
	                    for "_i" from 0 to ((count synchronizedObjects _logic)-1) do {
							private ["_obj","_mod","_size","_type","_priority"];
	                        
	                        _mod = (synchronizedObjects _logic) select _i;
	                        
	                        if ((typeof _mod) in ["ALiVE_mil_placement","ALiVE_civ_placement"]) then {
                                while {_startupComplete = _mod getVariable ["startupComplete", false]; !(_startupComplete)} do {};
                                
								_obj = [_mod,"objectives",objNull,[]] call ALIVE_fnc_OOsimpleOperation;
		                        _objectives = _objectives + _obj;
	                        } else {
                                //Is it a synced editor location-gamelogic?
	                            if (_mod iskindof "LocationBase_F") then {
	                                
                                    //These two values can be overwritten with f.e. *this setvariable ["size",700]* in init-field of editorobject...
	                                _size = _mod getvariable ["size",150];
	                                _priority = _mod getvariable ["priority",200];
                                    
                                    //Get type of location-logic from config
	                                _type = getText(configfile >> "CfgVehicles" >> (typeOf _mod) >> "displayName");
	                                
                                    //Create #Hash objective for this location
	                    			_obj = [nil, "createhashobject"] call ALIVE_fnc_OPCOM;
	                                [_obj,"center",getposATL _mod] call ALiVE_fnc_HashSet;
									[_obj,"size",_size] call ALiVE_fnc_hashSet;
									[_obj,"type",_type] call ALiVE_fnc_hashSet;
									[_obj,"priority",_priority] call ALiVE_fnc_hashSet;
	                                [_obj,"clusterID",""] call ALiVE_fnc_hashSet;
	                                [_obj,"nodes",[]] call ALiVE_fnc_HashSet;
	                                
	                                _objectives = _objectives + [_obj];
	                            };
                            };
						};
                        
                        switch (_type) do {
							case ("occupation") : {
								_objectives = [_handler,"objectives",[_handler,"createobjectives",[_objectives,"strategic"]] call ALiVE_fnc_OPCOM] call ALiVE_fnc_OPCOM;
							};
							case ("invasion") : {
								_objectives = [_handler,"objectives",[_handler,"createobjectives",[_objectives,"distance"]] call ALiVE_fnc_OPCOM] call ALiVE_fnc_OPCOM;
							};
						};
                    };
					
                    //Check if there are any objectives
                    _errorMessage = "There are %1 objectives for this OPCOM instance! %2";
                    _error1 = count _objectives; _error2 = "Please assign Military or Civilian Placement Objectives!"; //defaults
                    if ((count _objectives) == 0) exitwith {
						[_errorMessage,_error1,_error2] call ALIVE_fnc_dumpR;
                    };
                    
                	//Perform initial cluster occupation and troops analysis as MP modules are finished
                	_clusterOccupationAnalysis = [_handler,_side,_sidesEnemy,_sidesFriendly] call {[_this select 0,"analyzeclusteroccupation",[_this select 3,_this select 2]] call ALiVE_fnc_OPCOM};
					_troopsAnalysis = [_handler] call {[_this select 0,"scantroops"] call ALiVE_fnc_OPCOM};
                	["ALiVE OPCOM %1 Initial analysis done...",_side] call ALiVE_fnc_Dump; 
                    
                    //Check if there are any profiles available
                    _errorMessage = "There are no profiles for this OPCOM instance! %2";
                    _error1 = ""; _error2 = "Please assign troops to this OPCOM!"; //defaults
                    _profiles_count = 0;
					{
						_profiles_count_tmp = ([ALIVE_profileHandler, "getProfilesByFaction",_x] call ALIVE_fnc_profileHandler); 
						if !(isnil "_profiles_count_tmp") then {_profiles_count = _profiles_count + (count _profiles_count_tmp)};
					} foreach _factions;
                    if (_profiles_count == 0) exitwith {
						[_errorMessage,_error1,_error2] call ALIVE_fnc_dumpR;
                    };

					//Ok? Check if there is no selected faction used by another OPCOM
                    _OPCOMS = (missionNameSpace getvariable ["OPCOM_instances",[]]) - [_handler];
                    _errorMessage = "Faction %1 is already used by another OPCOM (side: %2)! Please change the faction!";
                    _error1 = ""; _error2 = ""; _exit = false; //defaults
                    {
                        _Selected_OPCOM = _x;
                        //Wait until init has passed on that instance
                        waituntil {!(isnil {[_Selected_OPCOM, "factions"] call ALiVE_fnc_HashGet})};
                        
                        _pos_OPCOM_selected = [_Selected_OPCOM, "position"] call ALiVE_fnc_HashGet;
                        _side_OPCOM_selected = [_Selected_OPCOM, "side"] call ALiVE_fnc_HashGet;
                        _factions_OPCOM_selected = [_Selected_OPCOM, "factions"] call ALiVE_fnc_HashGet;
                        
                        //Not really beautiful to identify opcom by position (array check wont work), but it works...
                        if !(str(_position) == str(_pos_OPCOM_selected)) then {
	                        {
	                            _own_faction = _x;
	                            if (_own_faction in _factions_OPCOM_selected) exitwith {
	                                _exit = true; _error1 = _own_faction; _error2 = _side_OPCOM_selected};
	                        } foreach _factions;
	                        if (_exit) exitwith {_exit = true};
                        };
                    } foreach _OPCOMS;
                    if (_exit) exitwith {
						[_errorMessage,_error1,_error2] call ALIVE_fnc_dumpR;
                    };
                    
                    //Still there? Awesome, check if there are different sides within the factions
                    _errorMessage = "There are different sides within this OPCOM %1! Please only select one side per OPCOM!%2";
                    _error1 = _side; _error2 = ""; _exit = false;  //defaults
                    _exit = !(({(getNumber(configfile >> "CfgFactionClasses" >> (_factions select 0) >> "side")) == (getNumber(configfile >> "CfgFactionClasses" >> _x >> "side"))} count _factions) == (count _factions));
                    if (_exit) exitwith {
						[_errorMessage,_error1,_error2] call ALIVE_fnc_dumpR;
                    };
                    
                    //Mega, lets summarize...
                    if (_debug) then {
                    	["OPCOM %1 starts with %2 profiles and %3 objectives!",_side,_profiles_count,count _objectives] call ALIVE_fnc_dumpR;
                	};

                    ///////////
                    //Startup
                    ///////////

                    //done this way to easily switch between spawn and call for testing purposes
                    ["OPCOM and TACOM starting..."] call ALiVE_fnc_Dump;
                    _OPCOM = [_handler] call {
                        _handler = _this select 0;
                        
						_OPCOM = [_handler] execFSM "\x\alive\addons\mil_opcom\opcom.fsm";
						_TACOM = [_handler] execFSM "\x\alive\addons\mil_opcom\tacom.fsm";
                        
						[_handler, "OPCOM_FSM",_OPCOM] call ALiVE_fnc_HashSet;
                        [_handler, "TACOM_FSM",_TACOM] call ALiVE_fnc_HashSet;
                    };
                    
					// set module as startup complete
					_logic setVariable ["startupComplete", true];
                    [_handler,"startupComplete",true] call ALiVE_fnc_HashSet;
                };
                
                /*
                VIEW - purely visual
                */
                
        };
        
        case "pause": {
			if(isNil "_args") then {
				// if no new value was provided return current setting
                _args = [_logic,"pause",objNull,false] call ALIVE_fnc_OOsimpleOperation;
			} else {
					// if a new value was provided set groups list
					ASSERT_TRUE(typeName _args == "BOOL",str typeName _args);
                    
                    private ["_state"];
                    _state = [_logic,"pause",objNull,false] call ALIVE_fnc_OOsimpleOperation;
                    if (_state && _args) exitwith {};
                    
                    //Set value
                    _args = [_logic,"pause",_args,false] call ALIVE_fnc_OOsimpleOperation;
                    
                    _OPCOM_FSM = [_logic,"opcom_fsm",-1] call ALiVE_fnc_HashGet;
                    _TACOM_FSM = [_logic,"tacom_fsm",-1] call ALiVE_fnc_HashGet;
                    
                    _TACOM_FSM setFSMvariable ["_pause",_args];
                    _OPCOM_FSM setFSMvariable ["_pause",_args];
                    
                    ["ALiVE Pausing state of %1 instance set to %2!",QMOD(ADDON),_args] call ALiVE_fnc_DumpR;
			};
			_result = _args;
		};
        
        case "stop": {
            private ["_opcomID","_opcomFSM","_tacomFSM"];
            
            _opcomID = [_logic,"opcomID",""] call ALiVE_fnc_HashGet;
			_opcomFSM = [_logic, "OPCOM_FSM",-1] call ALiVE_fnc_HashGet;
            _tacomFSM = [_logic, "TACOM_FSM",-1] call ALiVE_fnc_HashGet;
            
	        _tacomFSM setFSMvariable ["_exitFSM",true];
            _opcomFSM setFSMvariable ["_exitFSM",true];
	        _opcomFSM setFSMvariable ["_busy",false];
	        _tacomFSM setFSMvariable ["_busy",false];
	
	        waituntil {sleep 1; isnil {[_logic, "TACOM_FSM"] call ALiVE_fnc_HashGet}};
            waituntil {sleep 1; isnil {[_logic, "OPCOM_FSM"] call ALiVE_fnc_HashGet}};
            
            ["ALiVE OPCOM stopped..."] call ALIVE_fnc_dumpMPH;
            
            _result = true;
        };
        
        case "createhashobject": {                
                if (isServer) then {
                        _result = [nil, "create"] call ALIVE_fnc_OPCOM;
						[_result,"super"] call ALIVE_fnc_hashRem;
						[_result,"class"] call ALIVE_fnc_hashRem;
                };
        };
        
        case "convert": {
	    	if !(isNil "_args") then {
				if(typeName _args == "STRING") then {
		            if !(_args == "") then {
						_args = [_args, " ", ""] call CBA_fnc_replace;
	                    _args = [_args, "[", ""] call CBA_fnc_replace;
	                    _args = [_args, "]", ""] call CBA_fnc_replace;
	                    _args = [_args, """", ""] call CBA_fnc_replace;
						_args = [_args, ","] call CBA_fnc_split;
                        
						if !(count _args > 0) then {
							_args = [];
		            	};
                    } else {
                        _args = [];
                    };
                };
                _result = _args;
            };
		};

        case "saveData": {
            private ["_objectives","_exportObjectives","_objective","_objectiveID","_exportObjective","_objectivesGlobal","_save"];

            if (isDedicated) then {

                if (!isNil "ALIVE_sys_data" && {!ALIVE_sys_data_DISABLED}) then {

                    private ["_datahandler","_exportProfiles","_async","_missionName"];
                    
                    ["ALiVE SAVE OPCOM DATA TRIGGERED"] call ALIVE_fnc_dumpMPH;

                    //Save only every 60 seconds, bad hack because of this http://dev.withsix.com/issues/74321
                    //For normal each instance would save their own objectives but the hack collects all objectives of all OPCOMs on one save, FIFO principle
                    if (isnil QGVAR(OBJECTIVES_DB_SAVE) || {!(isnil QGVAR(OBJECTIVES_DB_SAVE)) && {time - (GVAR(OBJECTIVES_DB_SAVE) select 1) > 300}}) then {
                        
	                    _objectivesGlobal = [];
	                    {
	                    	_objectivesGlobal = _objectivesGlobal + ([_x, "objectives",[]] call ALiVE_fnc_HashGet);
	                    } foreach OPCOM_instances;

                        GVAR(OBJECTIVES_DB_SAVE) = [_objectivesGlobal,time];
                        {
                            ["ALiVE SAVE OPCOM DATA Objective prepared for DB: %1",_x] call ALiVE_fnc_Dump;
                        } foreach (GVAR(OBJECTIVES_DB_SAVE) select 0);
                        _save = true;
                    };
                    if (isnil "_save") exitwith {["ALiVE SAVE OPCOM DATA Please wait at least 5 minutes before saving again!"] call ALiVE_fnc_DumpMPH; _result = nil};
                    
                    //If I didnt send you to hell - go and save, the feck!
                    ["ALiVE SAVE OPCOM DATA - SYS DATA EXISTS"] call ALIVE_fnc_dump;
                    
                    _datahandler = [nil, "create"] call ALIVE_fnc_Data;
                    [_datahandler,"storeType",true] call ALIVE_fnc_Data;
                    
		            _exportObjectives = [] call ALIVE_fnc_hashCreate;
		
		            {
		                _objective = _x;
		                _objectiveID = [_objective,"objectiveID",""] call ALiVE_fnc_HashGet;
		
		                _exportObjective = [_objective, [], [
							"nodes"
		                ]] call ALIVE_fnc_hashCopy;
		
		                if([_exportObjective, "_rev"] call ALIVE_fnc_hashGet == "") then {
		                    [_exportObjective, "_rev"] call ALIVE_fnc_hashRem;
		                };
		
		                [_exportObjectives, _objectiveID, _exportObjective] call ALIVE_fnc_hashSet;
		                _exportObjective call ALIVE_fnc_inspectHash;
		            } forEach (GVAR(OBJECTIVES_DB_SAVE) select 0);

                    _async = false; // Wait for response from server
                    _missionName = [missionName, " ","-"] call CBA_fnc_replace;
                    _missionName = format["%1_%2", ALIVE_sys_data_GROUP_ID, _missionName]; // must include group_id to ensure mission reference is unique across groups

                    ["ALiVE SAVE OPCOM DATA NOW - MISSION NAME: %1! PLEASE WAIT...",_missionName] call ALIVE_fnc_dumpMPH;

                    _result = [_datahandler, "save", ["mil_opcom", _exportObjectives, _missionName, _async]] call ALIVE_fnc_Data;

                    ["ALiVE SAVE OPCOM DATA RESULT (maybe truncated in RPT, dont worry): %1",_result] call ALIVE_fnc_dump;
                    ["ALiVE SAVE OPCOM DATA SAVING COMPLETE!"] call ALIVE_fnc_dumpMPH;
                };
            };
        };
        
        case "loadData": {
			private ["_stopped","_result"];

            if !(isDedicated && {!(isNil "ALIVE_sys_data")} && {!(ALIVE_sys_data_DISABLED)}) exitwith {["ALiVE LOAD OPCOM DATA FROM DB NOT POSSIBLE! NO SYS DATA MODULE AVAILABLE OR NOT DEDICATED!"] call ALIVE_fnc_dumpR};
            
            //Stop OPCOM
            _stopped = [_logic,"stop"] call ALiVE_fnc_OPCOM;
            
            //Load from DB
			_objectives = [_logic,"loadObjectivesDB"] call ALiVE_fnc_OPCOM;
            
            //Reset objectives
			[_logic,"objectives",_objectives] call ALiVE_fnc_HashSet;

			//Restart OPCOM
        	["ALiVE OPCOM and TACOM re-starting..."] call ALiVE_fnc_DumpMPH;
        	[_logic] call {
            	_handler = _this select 0;
            
				_OPCOM = [_handler] execFSM "\x\alive\addons\mil_opcom\opcom.fsm";
				_TACOM = [_handler] execFSM "\x\alive\addons\mil_opcom\tacom.fsm";
            
				[_handler, "OPCOM_FSM",_OPCOM] call ALiVE_fnc_HashSet;
            	[_handler, "TACOM_FSM",_TACOM] call ALiVE_fnc_HashSet;
        	};

            ["ALiVE LOAD OPCOM DATA Imported %1 objectives from DB!",count ([_logic,"objectives",[]] call ALiVE_fnc_HashGet)] call ALIVE_fnc_dumpMPH;
        
            _result = _objectives;
        };
        
        case "loadObjectivesDB": {
			private["_objectives","_exportObjectives","_objective","_objectiveID","_exportObjective","_opcomFSM","_tacomFSM"];
            
            _opcomID = [_logic,"opcomID",""] call ALiVE_fnc_HashGet;
			_objectives = [];

            if (isDedicated) then {

                if (!isNil "ALIVE_sys_data" && {!ALIVE_sys_data_DISABLED}) then {
                    private ["_datahandler","_importProfiles","_async","_missionName","_result","_stopped","_i"];

                    //defaults
                	_async = false;
					_missionName = [missionName, " ","-"] call CBA_fnc_replace;
					_missionName = format["%1_%2", ALIVE_sys_data_GROUP_ID, _missionName];
                    
                    ["ALiVE LOAD OPCOM DATA - MISSION: %1",_missionName] call ALIVE_fnc_dumpMPH;

                    //Load only every 5 minutes
                    if (isnil QGVAR(OBJECTIVES_DB_LOAD) || {!(isnil QGVAR(OBJECTIVES_DB_LOAD)) && {time - (GVAR(OBJECTIVES_DB_LOAD) select 1) > 300}}) then {
                        
                        ["ALiVE LOAD OPCOM DATA FROM DB, PLEASE WAIT..."] call ALIVE_fnc_dumpMPH;
                        
						_datahandler = [nil, "create"] call ALIVE_fnc_Data;
						[_datahandler,"storeType",true] call ALIVE_fnc_Data;
                        
                        [true] call ALIVE_fnc_timer;
                        GVAR(OBJECTIVES_DB_LOAD) = [[_datahandler, "load", ["mil_opcom", _missionName, _async]] call ALIVE_fnc_Data,time];
                        [] call ALIVE_fnc_timer;
                        
                        //Exit if no loaded data
                        if (((typeName (GVAR(OBJECTIVES_DB_LOAD) select 0)) == "BOOL") && {!(GVAR(OBJECTIVES_DB_LOAD) select 0)}) exitwith {};

                        {
                            ["ALiVE LOAD OPCOM DATA OBJECTIVES LOADED FROM DB: %1",_x] call ALiVE_fnc_Dump;
                        } foreach ((GVAR(OBJECTIVES_DB_LOAD) select 0) select 2);
                    } else {
                        ["ALiVE LOAD OPCOM DATA FROM CACHE!"] call ALiVE_fnc_DumpMPH;
                    };
                    
                    _result = GVAR(OBJECTIVES_DB_LOAD) select 0;

                    if (!(isnil "_result") && {typename _result == "ARRAY"} && {count _result > 0} && {count (_result select 2) > 0}) then {

                        _objectives = [];
						{
                            _id = [_x,"opcomID",""] call ALiVE_fnc_HashGet;
                            
                            if (_id == _opcomID) then {
                                
                                //["ALiVE LOAD OPCOM DATA RESETTING RESULT %1/%2!",_foreachIndex,(count _objectives)] call ALiVE_fnc_DumpMPH;
                                
                                _rev = [_x,"_rev",""] call ALiVE_fnc_HashGet;

		                		[_x, "_id"] call ALIVE_fnc_hashRem;
                                [_x, "_rev"] call ALIVE_fnc_hashRem;

                                [_x,"_rev",_rev] call ALiVE_fnc_HashSet;
								[_x,"nodes",[]] call ALiVE_fnc_HashSet;
                                
                                _objectives set [count _objectives,_x];
                            };
	                    } foreach (_result select 2);

                        {
                            private ["_keys","_values","_entry"];
                            
                            //["ALiVE LOAD OPCOM DATA CLEANING HASH %1/%2!",_foreachIndex,(count _objectives)] call ALiVE_fnc_DumpMPH;
                            
                            _entry = _x;
                            _values = [];
                            _keys = ["objectiveID","center","size","type","priority","opcom_state","clusterID","nodes","opcomID","opcom_orders","danger","sectionAssist","section","tacom_state","_rev"];
                            
                            {
                                _values set [_foreachIndex,([_entry,_x] call ALiVE_fnc_HashGet)];
                            } foreach _keys;
                            
                            _entry set [1,_keys];
                            _entry set [2,_values];
                            
                        } foreach _objectives;

	                    [_logic,"objectives",_objectives] call ALiVE_fnc_HashSet;
                        [_logic,"clusteroccupation",[]] call ALiVE_fnc_HashSet;
                        
						_i = 10;
                        _objectives = [_logic,"objectives",[]] call ALiVE_fnc_HashGet;
                        {
                            private ["_oID","_section","_orders","_state"];

                            _entry = _x;

                            if (_i == 10) then {
                                _i = 0;
                            	["ALiVE LOAD OPCOM DATA REBUILDING OBJECTIVE %1/%2!",_foreachIndex,(count _objectives)] call ALiVE_fnc_DumpMPH;
                            };
                            _i = _i + 1;
                            
							_oID = [_entry,"objectiveID",""] call ALiVE_fnc_HashGet;
							_section = [_entry,"section",[]] call ALiVE_fnc_HashGet;
                            
                            if !(isnil "_section") then {
                            	{[_logic,"resetorders",_x] call ALiVE_fnc_OPCOM} foreach _section;
                            };
                            if !(isnil "_oID") then {
                            	[_logic,"resetObjective",_oID] call ALiVE_fnc_OPCOM;
                            };
						} foreach _objectives;
                        
						[_logic,"objectives",_objectives] call ALiVE_fnc_HashSet;
                        _objectives = [_logic,"objectives",[]] call ALiVE_fnc_HashGet;

	                    ["ALiVE LOAD OPCOM DATA IMPORTED %1 OBJECTIVES FROM DB!",count _objectives] call ALIVE_fnc_dumpMPH;
                    } else {
                        ["ALiVE LOAD OPCOM DATA LOADING FROM DB FAILED!"] call ALIVE_fnc_dumpR;
                    };
                } else {
                    ["ALiVE LOAD OPCOM DATA FROM DB NOT POSSIBLE! NO SYS DATA MODULE AVAILABLE!"] call ALIVE_fnc_dumpR;
                };
            };

            _result = _objectives;
        };

		case "objectives": {
                if(isnil "_args") then {
						_args = [_logic,"objectives",[]] call ALIVE_fnc_hashGet;
                } else {
						[_logic,"objectives",_args] call ALIVE_fnc_hashSet;
                };                
                ASSERT_TRUE(typeName _args == "ARRAY",str _args);
                
                _result = _args;
        };
                
        case "addObjective": {
                if(isnil "_args") then {
					_args = [_logic,"objectives"] call ALIVE_fnc_hashGet;
                } else {
                    ASSERT_TRUE(typeName _args == "ARRAY",str _args);
                    ASSERT_TRUE(count _args > 2,str _args);
                    
                    private ["_debug","_params","_id","_pos","_size","_type","_priority","_opcom_state","_clusterID","_nodes","_target","_objectives"];

                    _debug = [_logic, "debug",false] call ALIVE_fnc_HashGet;
                    _params = _args;
                    
                    _id = _params select 0;
                    _pos = _params select 1;
                    _size = _params select 2;
                    
                    if (count _params > 3) then {_type = _params select 3};
                    if (count _params > 4) then {_priority = _params select 4};
                    if (count _params > 5) then {_opcom_state = _params select 5};
                    if (count _params > 6) then {_clusterID = _params select 6};
                    if (count _params > 7) then {_nodes = _params select 7};
                    if (count _params > 8) then {_opcomID = _params select 8};
                    
                    if (isnil "_type") then {_type = "unknown"};
                    if (isnil "_priority") then {_priority = 100};
                    if (isnil "_opcom_state") then {_opcom_state = "unassigned"};
                    if (isnil "_clusterID") then {_clusterID = "none"};
                    if (isnil "_nodes") then {_nodes = []};
                    
                    _target = [nil, "createhashobject"] call ALIVE_fnc_OPCOM;
                    [_target, "objectiveID",_id] call ALIVE_fnc_HashSet;
                    [_target, "center",_pos] call ALIVE_fnc_HashSet;
                    [_target, "size",_size] call ALIVE_fnc_HashSet;
                    [_target, "type",_type] call ALIVE_fnc_HashSet;
                    [_target, "priority",_priority] call ALIVE_fnc_HashSet;
                    [_target, "opcom_state",_opcom_state] call ALIVE_fnc_HashSet;
                    [_target, "clusterID",_clusterID] call ALIVE_fnc_HashSet;
                    [_target, "nodes",_nodes] call ALIVE_fnc_HashSet;
                    [_target, "opcomID",_opcomID] call ALIVE_fnc_HashSet;
                    [_target,"_rev",""] call ALIVE_fnc_hashSet;
                    
					if  (_debug) then {
						_m = createMarkerLocal [_id, _pos];
						_m setMarkerShapeLocal "RECTANGLE";
						_m setMarkerSizeLocal [_size, _size];
						_m setMarkerBrushLocal "FDiagonal";
						_m setMarkerColorLocal "ColorYellow";
						
						_m = createMarkerLocal [format["%1_label",_id], _pos];
						_m setMarkerShapeLocal "ICON";
						_m setMarkerSizeLocal [0.5, 0.5];
						_m setMarkerTypeLocal "mil_dot";
						_m setMarkerColorLocal "ColorYellow";
                        
                        /*
                        switch (_side) do {
                            case "EAST" : {_m setMarkerTextLocal format["Objective %2 Priority %1",_foreachIndex,_side]};
                            case "WEST" : {_m setMarkerTextLocal format["Objective                 %2 Priority %1",_foreachIndex,_side]};
                        };
                        */
					};
                    
                    _objectives = [_logic,"objectives",[]] call ALiVE_fnc_HashGet;
                    _objectives set [count _objectives,_target] call ALiVE_fnc_HashSet;
                    [_logic,"objectives",_objectives] call ALiVE_fnc_HashSet;
                    
                    _args = _target;
                };
                _result = _args;
        };

		case "createobjectives": {
                if(isnil "_args") then {
						_args = [_logic,"objectives"] call ALIVE_fnc_hashGet;
                } else {
                    
                    private ["_objectives","_opcomID","_startpos","_side","_type","_typeOp","_pos","_height","_debug","_clusterID","_target"];
                    
                    	//Collect objectives from SEP and order by distance from OPCOM module (for now)
                        _objectives = _args select 0;
                        _typeOp = _args select 1;
                        
                        _startpos = [_logic,"position"] call ALiVE_fnc_HashGet;
                        _side = [_logic,"side"] call ALiVE_fnc_HashGet;
                        _factions = [_logic,"factions"] call ALiVE_fnc_HashGet;
                        _debug = [_logic,"debug",false] call ALiVE_fnc_HashGet;
                        _opcomID = [_logic,"opcomID",""] call ALiVE_fnc_HashGet;

						_objectives_unsorted = [];
						{
                            private ["_target","_pos","_size","_type","_priority","_clusterID","_height"];
									_target = _x;
									_pos = [_target,"center"] call ALiVE_fnc_hashGet;
									_size = [_target,"size"] call ALiVE_fnc_hashGet;
									_type = [_target,"type"] call ALiVE_fnc_hashGet;
									_priority = [_target,"priority"] call ALiVE_fnc_hashGet;
                                    _clusterID = [_target,"clusterID"] call ALiVE_fnc_hashGet;
                                    _nodes = [_target,"nodes"] call ALiVE_fnc_HashGet;
                                    _height = (ATLtoASL [_pos select 0, _pos select 1,0]) select 2;
                                    
									_objectives_unsorted set [count _objectives_unsorted, [_pos,_size,_type,_priority,_height,_clusterID,_nodes,_opcomID]];
						} foreach _objectives;
						
						//Create objectives for OPCOM and set it on the OPCOM Handler 
						//GetObjectivesByPriority
                        //_OID = (count (missionNameSpace getvariable ["OPCOM_instances",[]]))-1;
						{
                            private ["_target","_id","_pos","_size","_type","_priority","_clusterID","_opcom_state"];
									_id = format["OPCOM_%1_objective_%2",_opcomID,_foreachIndex];
									_pos = _x select 0; 
									_size = _x select 1; 
									_type = _x select 2; 
									_priority = _x select 3; 
									_opcom_state = "unassigned";
									_clusterID = _x select 5;
                                    _nodes = _x select 6;
                                    _opcomID = _x select 7;
                                    
                                    [_logic,"addObjective",[_id,_pos,_size,_type,_priority,_opcom_state,_clusterID,_nodes,_opcomID]] call ALiVE_fnc_OPCOM;
						 } foreach _objectives_unsorted;
                         [_logic,"sortObjectives",_typeOp] call ALiVE_fnc_OPCOM;
                         
                         _args = [_logic,"objectives",[]] call ALiVE_fnc_HashGet;
                };
                ASSERT_TRUE(typeName _args == "ARRAY",str _args);
                
                _result = _args;
        };

        case "getobjectivebyid": {
            	ASSERT_TRUE(typeName _args == "STRING",str _args);
                
			    private ["_objective","_id"];
				_id = _args;
				{
					if (([_x,"objectiveID"] call ALiVE_fnc_hashGet) == _id) exitwith {_objective = _x};
				} foreach ([_logic, "objectives"] call ALIVE_fnc_HashGet);

				_result = _objective;
		};
                        
	    case "sortObjectives": {
	        if(isnil "_args") then {
				_args = [_logic,"objectives"] call ALIVE_fnc_hashGet;
	        } else {
                private ["_objectives","_type"];
                
                _type = _args;
                _objectives = [_logic,"objectives",[]] call ALiVE_fnc_HashGet;
                
                switch (_type) do {
                            //by distance
                            case ("distance") : {_objectives = [_objectives,[],{([_logic, "position"] call ALIVE_fnc_HashGet) distance (_x select 2 select 1)},"ASCEND"] call BIS_fnc_sortBy};
                            
                            //by size and height
                            case ("strategic") : {_objectives = [_objectives,[],{_height = (ATLtoASL [(_x select 2 select 1) select 0,(_x select 2 select 1) select 1,0]) select 2; ((_x select 2 select 2) + (_x select 2 select 4) + (_height/2)) - ((([_logic, "position"] call ALIVE_fnc_HashGet) distance (_x select 2 select 1))/10)},"DESCEND"] call BIS_fnc_sortBy};
                            case ("size") : {};
                            default {};
                };
                [_logic,"objectives",_objectives] call ALiVE_fnc_HashSet;
                _args = _objectives;
            };
            _result = _args;
	    };
        
        case "resetObjective": {
        	if(isnil "_args") then {
					_args = [_logic,"objectives",[]] call ALIVE_fnc_hashGet;
            } else {
            	ASSERT_TRUE(typeName _args == "STRING",str _args);
                private ["_objective"];
                
                _objective = [_logic,"getobjectivebyid",_args] call ALiVE_fnc_OPCOM;
                _debug = [_logic,"debug",false] call ALiVE_fnc_HashGet;

	        	[_objective,"tacom_state","none"] call AliVE_fnc_HashSet;
	        	[_objective,"opcom_state","unassigned"] call AliVE_fnc_HashSet;
	        	[_objective,"danger",-1] call AliVE_fnc_HashSet;
	        	[_objective,"section",[]] call AliVE_fnc_HashSet;
	        	[_objective,"opcom_orders","none"] call AliVE_fnc_HashSet;
                
                // debug ---------------------------------------
				if (_debug) then {_args setMarkerColorLocal "ColorWhite"};
				// debug ---------------------------------------
                
                _args = [_logic,"objectives",[]] call ALIVE_fnc_hashGet;
            };
            _result = _args;
        };
        
        case "removeObjective": {
        	if(isnil "_args") then {
					_args = [_logic,"objectives",[]] call ALIVE_fnc_hashGet;
            } else {
            	ASSERT_TRUE(typeName _args == "STRING",str _args);
                private ["_objective","_section","_debug","_objectiveID","_index"];
                
                _objectiveID = _args;
                
                _objectives = [_logic,"objectives",[]] call ALiVE_fnc_HashGet;
                _debug = [_logic,"debug",false] call ALiVE_fnc_HashGet;

                {
                    _oID = [_x,"objectiveID",""] call ALiVE_fnc_HashGet;
                    
                    if (_oID == _objectiveID) exitwith {
                		_section = [_x,"section",[]] call ALiVE_fnc_HashGet;
                        
                        {[_logic,"resetorders",_x] call ALiVE_fnc_OPCOM} foreach _section;
                		[_logic,"resetObjective",_objectiveID] call ALiVE_fnc_OPCOM;
                        
                        _index = _foreachIndex;
                    };
                } foreach _objectives;
                
                if !(isnil "_index") then {
	                _objectives set [_index,objNull];
	                _objectives = _objectives - [objNull];
	                
	                [_logic,"objectives", _objectives] call ALiVE_fnc_HashSet;
                };
                
                _args = _objectives;
                
                // debug ---------------------------------------
				if (_debug) then {deletemarkerLocal _objectiveID};
				// debug ---------------------------------------
            };
            _result = _args;
        };

        case "addTask": {
            _operation = _args select 0;
            _pos = _args select 1;
            _section = _args select 2;
            _TACOM_FSM = [_logic,"TACOM_FSM"] call ALiVE_fnc_HashGet;
            
            _objective = [_logic,"addObjective",[_pos,100,"internal"]] call ALiVE_fnc_OPCOM;
            [_objective,"section",_section] call AliVE_fnc_HashSet;
            
            _TACOM_FSM setFSMVariable ["_busy",false];
            _TACOM_FSM setFSMVariable ["_TACOM_DATA",["true",nil]];
            
            switch (_operation) do {
                case ("recon") : {
                    _recon = [_objective,_section];
                    _TACOM_FSM setFSMVariable ["_recon",_recon];
                };
                case ("capture") : {
                    _capture = [_objective,_section];
                    _TACOM_FSM setFSMVariable ["_capture",_capture];
                };
                case ("defend") : {
                    _defend = [_objective,_section];
                	_TACOM_FSM setFSMVariable ["_defend",_defend];
                };
                case ("reserve") : {
                    _reserve = [_objective,_section];
                    _TACOM_FSM setFSMVariable ["_reserve",_reserve];
                };
            };
        };
        
        //This will be merged out to the tasks module in RC2
        case "addplayertask": {
                if(isnil "_args") then {
						_args = [_logic,"playertasks",[]] call ALIVE_fnc_hashGet;
                } else {
                    //Exit if no players online to not clutter map
                    if ((count ([] call BIS_fnc_listPlayers) == 0)) exitwith {_result = [_logic,"playertasks",[]] call ALIVE_fnc_hashGet};
                    
                    private ["_pos","_type","_conditionwin","_conditionFail","_objective","_ostate","_objectives","_cid","_id","_object","_messageWin","_messageFail","_message","_desc","_state","_oType","_buildingTypes","_clusterHandler"];
                    
                    _objective = _args select 0;
                    _type = _args select 1;
                    if (count _args > 2) then {_condition = _this select 2};
                    
                    _side = [_logic,"side"] call ALiVE_fnc_HashGet;
                    _tasks = [_logic,"playertasks",[]] call ALiVE_fnc_HashGet;
                    
                    //Thank you, BIS...
                    if (_side == "GUER") then {_side = "RESISTANCE"};
                    
                    _object = objNull;
                    _timeout = 3600;
                    _state = "ASSIGNED";
                    
                    switch (_type) do {
                        case ("objective_sabotage") : {
                            //Select building types by objective type (CIV/MIL)
                            _otype = [_objective,"type"] call ALiVE_fnc_HashGet;
                            switch (_oType) do {
                                case ("MIL") : {_buildingTypes = ALIVE_militaryHQBuildingTypes};
                                case ("CIV") : {_buildingTypes = ALIVE_civilianCommsBuildingTypes + ALIVE_civilianPowerBuildingTypes + ALIVE_civilianFuelBuildingTypes};
                            	default {_buildingTypes = ALIVE_militaryHQBuildingTypes};
                            };

                            //Get building-objects from nodes
							_nodes = [_objective, "nodes"] call ALIVE_fnc_hashGet;
							_buildings = [_nodes, _buildingTypes] call ALIVE_fnc_findBuildingsInClusterNodes;
							
                            //Remove destroyed buildings
                            {if (damage _x > 0.98) then {_buildings set [_foreachIndex,"x"]}} foreach _buildings; _buildings = _buildings - ["x"];

							//Exit if no buildings of type were found
                            if (count _buildings == 0) exitwith {};
							
                            //Get the needed nearest building variables
                            _object = _buildings select 0;
                            _pos = getposATL _object;
                            _objectType = getText(configFile >> "CfgVehicles" >> (typeOf _object) >> "displayName");
                            
                            //Prepare Task Data
                            _id = str(floor(_pos select 0)) + str(floor(_pos select 1));
                            _desc = format["Disable the %1 at %2!",_objectType, _pos];
                            _conditionwin = [[_object],{(damage (_this select 0)) > 0.98}]; //true if building is disabled
                            _conditionFail = [[],{false}]; //false if unneeded and only timeout shall happen
                            _message = format["Destroy %1!",_objectType];
                            _messageWin = format["Mission accomplished!",_objectType];
                            _messageFail = format["Sabotage failed!",_objectType];
                        };
                        
                        case ("objective_hold") : {
                            //Get objective data
							_cid = [_objective,"clusterID"] call ALiVE_fnc_HashGet;
                            _ostate = [_objective,"opcom_state"] call ALiVE_fnc_HashGet;
                            _pos = [_objective,"center"] call ALiVE_fnc_HashGet;
                            
                            //Overwrite timeout to happen after half an hour
                            _timeout = 1800;
                            
                            //Prepare Task data
                            _id = str(floor(_pos select 0)) + str(floor(_pos select 1));
                            _desc = format["Hold objective %1 at %2 for 30 minutes!",_cid, _pos];
                            _conditionWin = [[_objective,_ostate],{
                                _objective = _this select 0;
                                _ostateOld = _this select 1;
                                _ostateNew = [_objective,"opcom_state"] call ALiVE_fnc_HashGet;

								!(_ostateOld == _ostateNew) && {(_ostateNew == "idle")}; //true if objective status changed to idle (secured)
                            }];
                            _conditionFail = [[],{false}]; //false if unneeded and only timeout shall happen
                            _message = format["Hold %1!",_cid];
                            _messageWin = format["Objective held!",_cid];
                            _messageFail = format["Objective lost!",_cid];
                        };
                    };
                    
					//Exit if no Task data has been prepared
                    if (isnil "_id") exitwith {_args = false};
                    
                    ///*//INTREP WIP
                    _center = [_objective,"center"] call ALIVE_fnc_hashGet;
                    
                    if !(isnil "ALIVE_sectorGrid") then {
	         			_sector = [ALIVE_sectorGrid, "positionToSector", _center] call ALIVE_fnc_sectorGrid;
	         			_sectorData = [_sector, "data"] call ALIVE_fnc_hashGet;
	                    _sectorTerrainSamples = [_sectordata,"terrainSamples",[]] call ALiVE_fnc_HashGet;
	         			_milClusters = [_sectordata,"clustersMil",[]] call ALiVE_fnc_HashGet;
	                    _civClusters = [_sectordata,"clustersCiv",[]] call ALiVE_fnc_HashGet;
	                    
	                    _highest = ([_sectordata,"elevationSamplesLand",[]] call ALiVE_fnc_HashGet) select ((count ([_sectordata,"elevationSamplesLand"] call ALiVE_fnc_HashGet))-1);
	                    _lowest = ([_sectordata,"elevationSamplesLand",[]] call ALiVE_fnc_HashGet) select 0;
	                    _shore = [_sectorTerrainSamples,"shore",[]] call ALiVE_fnc_HashGet;
                        
                        _messageIntel = (format["The highest point in this sector is the hill at %1!",_highest]);
                        
                        if (!(isnil "_civClusters") && {count _civClusters > 0}) then {
		                    _consolidated = [_civClusters,"consolidated",[]] call ALivE_fnc_HashGet;
							_power =  [_civClusters,"power",[]] call ALivE_fnc_HashGet;
							_comms =  [_civClusters,"comms",[]] call ALivE_fnc_HashGet;
							_marine = [_civClusters,"marine",[]] call ALivE_fnc_HashGet;
							_fuel = [_civClusters,"fuel",[]] call ALivE_fnc_HashGet;
							_rail = [_civClusters,"rail",[]] call ALivE_fnc_HashGet;
							_construction = [_civClusters,"construction",[]] call ALivE_fnc_HashGet;
							_settlement = [_civClusters,"settlement",[]] call ALivE_fnc_HashGet;
		                    
		                    if (count (_power + _comms + _marine + _fuel + _rail + _settlement) > 0) then {
		                        if (count _power > 0) then {
		                        	_messageIntel = _messageIntel + " " + (format["Power infrastructure is found near %1!",_power select 0 select 0]);
		                        };
		                        if (count _comms > 0) then {
		                        	_messageIntel = _messageIntel + " " + (format["There are communication towers at %1!",_comms select 0 select 0]);
		                        };
		                    	if (count _fuel > 0) then {
		                        	_messageIntel = _messageIntel + " " + (format["Fuel supplies are located at %1!",_fuel select 0 select 0]);
		                        };
		                        if (count _settlement > 0) then {
		                        	_messageIntel = _messageIntel + " " + (format["A nearby civilian settlement is around %1!",_settlement select 0 select 0]);
		                        };
		                    };
                        };
	                   
	                    _enemies = [];
	                    {
	                        _enemies = _enemies + ([_pos, 1000, [_x,"entity"]] call ALIVE_fnc_getNearProfiles);
	                    } foreach ([_logic,"sidesenemy",[]] call ALiVE_fnc_HashGet);
	                    
	                    _strength = "minimal";
	                    if (count _enemies > 10) then {_strength = "light"};
	                    if (count _enemies > 30) then {_strength = ""};
	                    if (count _enemies > 50) then {_strength = "heavy"};
	                    
	                    _messageIntel = (format["You have to expect %1 enemy resistance!",_strength]) + " " + _messageIntel;
	                    _desc = _desc + " " + _messageIntel;
                    };
                    //*/
                    
                    _taskParams = [
                    	_id,
                        call compile _side,
                        	[
                            	_desc,
                                _message,
                                _message
                            ],
                        _pos,
                        _state,
                        1,
                        true,
                        true
                    ];
                    
                    _handle = [_logic,_taskParams,_conditionWin,_messageWin,_conditionFail,_messageFail,_timeout] spawn {
                        
                        _logic = _this select 0;
                        _taskParams = _this select 1;
                        
                        _conditionWin = _this select 2;
                        _conditionWinParams = _conditionWin select 0;
                        _conditionWinCode = _conditionWin select 1;
                        _messageWin = _this select 3;
                        
                        _conditionFail = _this select 4;
                        _conditionFailParams = _conditionFail select 0;
                        _conditionFailCode = _conditionFail select 1;
                        _messageFail = _this select 5;
                       
                        _timeout = _this select 6;
                        
                        _tasks = [_logic,"playertasks",[]] call ALiVE_fnc_HashGet;
                        _time = time;
                        
                        _id = _taskParams call BIS_fnc_setTask;
                        [_logic,"playertasks",_tasks + [_id]] call ALiVE_fnc_HashSet; 
                        
                        waituntil {
							sleep 5;
							((_conditionWinParams call _conditionWinCode) || {_conditionFailParams call _conditionFailCode} ||  {time - _time > _timeout});
						};
                        
                        if (_conditionWinParams call _conditionWinCode) then {
                            _taskParams set [4,"SUCCEEDED"];
							_taskParams set [2,[_taskParams select 2 select 0, _messageWin, _taskParams select 2 select 2]];
                            
						} else {
                            if (_conditionFailParams call _conditionFailCode) then {
								_taskParams set [4,"FAILED"];
	                            _taskParams set [2,[_taskParams select 2 select 0, _messageFail, _taskParams select 2 select 2]];
							} else {
                                _taskParams set [4,"CANCELED"];
                                _taskParams set [2,[_taskParams select 2 select 0, "Task canceled!", _taskParams select 2 select 2]];
                            };
                        };
                        
                        _id = _taskParams call BIS_fnc_setTask;
                        [_logic,"playertasks",_tasks - [_id]] call ALiVE_fnc_HashSet;
                    };
                    _args = _id;
                };
                _result = _args;
        };

        case "cleanupduplicatesections": {
            private ["_objectives","_objective","_section","_proID","_state","_size_reserve","_pending_orders","_profile","_wayPoints","_orders","_profileIDs"];
            
            	_objectives = [_logic,"objectives",[]] call ALiVE_fnc_HashGet;
                _pending_orders = [_logic,"pendingorders",[]] call ALiVE_fnc_HashGet;
                _size_reserve = [_logic,"sectionsamount_reserve",1] call ALiVE_fnc_HashGet;
                _factions = [_logic,"factions"] call ALiVE_fnc_HashGet;
                //_profileIDs = [ALIVE_profileHandler, "getProfilesBySide",[_logic,"side"] call ALiVE_fnc_HashGet] call ALIVE_fnc_profileHandler;
                
                _profileIDs = [];
                {
                    _profileIDs = _profileIDs + ([ALIVE_profileHandler, "getProfilesByFaction",_x] call ALIVE_fnc_profileHandler);
                } foreach _factions;
            
            {
                private ["_objective","_section","_state","_idlestates","_wps"];
                
                _objective = _x;
                _section = [_objective,"section",[]] call ALiVE_fnc_HashGet;
                _state = [_objective,"opcom_state",[]] call ALiVE_fnc_HashGet;
                _idlestates = ["unassigned","idle"];
                
                _wps = 0;
                {
                    private ["_profile"];
                    
                	_profile = [ALiVE_ProfileHandler,"getProfile",_x] call ALiVE_fnc_ProfileHandler;
                    
                    if !(isnil "_profile") then {
                        _wps = _wps + (count (_profile select 2 select 16));
                    } else {
						[_logic,"resetorders",_x] call ALiVE_fnc_OPCOM;
                    };
                } foreach _section;
                
                _section = [_objective,"section",_section] call ALiVE_fnc_HashGet;
                if (!(_state in _idlestates) && {count _section > 0} && {_wps == 0}) then {
                    {[_logic,"resetorders",_x] call ALiVE_fnc_OPCOM} foreach _section;
                    [_logic,"resetObjective",([_objective,"objectiveID"] call ALiVE_fnc_HashGet)] call ALiVE_fnc_OPCOM;
                };
            } foreach _objectives;
        };

        case "NearestAvailableSection": {
            
            private ["_st","_troopsunsorted","_types","_pos","_size","_troops","_busy","_section","_reserved","_profileIDs","_profile"];
            
            _pos = _args select 0;
            _size = _args select 1; 
            if (count _args > 2) then {_types = _args select 2} else {_types = ["infantry"]};

			_troops = [];
            {
                _troops = _troops + ([_logic,_x,[]] call ALiVE_fnc_HashGet);
            } foreach _types;

            //subtract busy and reserved profiles
            _busy = [];
            {_busy set [count _busy,_x select 1]} foreach ([_logic,"pendingorders",[]] call ALiVE_fnc_HashGet);
            {_busy = _busy + ([_x,"section",[]] call ALiVE_fnc_HashGet)} foreach ([_logic,"objectives",[]] call ALiVE_fnc_HashGet);
            _reserved = [_logic,"ProfileIDsReserve",[]] call ALiVE_fnc_HashGet;
            _busy = _busy - _reserved;
            
            if (_size >= 5) then {
            	_troops = _troops - _reserved;
            } else {
                _troops = _troops - (_busy + _reserved);
            };
            
            //["Busy %1 | Reserved %2 | Troops %3",count _busy, count _reserved,count _troops] call ALiVE_fnc_DumpR;
            
            _st = 2000;
            waituntil
            {
            
            	_nearProfiles = [_pos, _st, [([_logic,"side","EAST"] call ALiVE_fnc_HashGet),"entity"]] call ALIVE_fnc_getNearProfiles;
	            _troopsUnsorted = [];
	            {
	                _pi = _x select 2 select 4;
	                _pp = _x select 2 select 2;
	                
	                if (_pi in _troops) then {_troopsUnsorted set [count _troopsUnsorted,_pi]};
	            } foreach _nearProfiles;
                
                _st = _st + 2000;
	            ((count _troopsUnsorted >= _size) || {_st > 15000});
            };
            
            //Sort by distance
            _troops = [_troopsUnsorted,[],{if !(isnil "_x") then {_p = nil; _p = [ALiVE_ProfileHandler,"getProfile",_x] call ALiVE_fnc_ProfileHandler; if !(isnil "_p") then {([_p,"position",_pos] call ALiVE_fnc_HashGet) distance _pos} else {[0,0,0] distance _pos}} else {[0,0,0] distance _pos}},"ASCEND"] call BIS_fnc_sortBy;
            
            //Collect section
            _section = [];
            for "_i" from 0 to (_size - 1) do {
                if (_i > ((count _troops)-1)) exitwith {};
                _section set [count _section,_troops select _i];
            };
            
			_result = _section;
        };
        
        case "entitiesnearsector": {
            	ASSERT_TRUE(typeName _args == "ARRAY",str _args);
                
                private ["_ent","_entArr","_side","_pos","_posP","_id","_profiles"];
                
        		_pos = _args select 0; _pos set [2,0];
	            _side = _args select 1;
                _canSee = _args select 2;
                
                _ent = [];
                _entArr = [];
                _seeArr = [];
                
                if (isnil "_pos") exitwith {_result = []; _result};
                
                _profiles = [_pos, 800, [_side,"entity"]] call ALIVE_fnc_getNearProfiles;
                {
                    if (count _profiles > 0) then {
                        _entArr set [count _entArr,[(_x select 2 select 4),(_x select 2 select 2)]];
                    };
                } foreach _profiles;
                _result = _entArr;
                
                if (_canSee) then {
                    
                    _pos = ATLtoASL _pos;
                    _pos set [2,(_pos select 2) + 2];
                    
                    if ({(_x select 1) distance _pos < 600} count _entArr > 0) then {
                        {
                            _id = _x select 0;
                            (_x select 1) set [2,0]; 
                            _posP = ATLtoASL (_x select 1);
                            _posP set [2,(_posP select 2) + 2];
                            
                            if (((_x select 1) distance _pos < 500) && {!(terrainIntersectASL [_pos, _posP])}) then {
                                _seeArr set [count _seeArr, _x];
                            };
                        } foreach _entArr;
                    };
                    _result = _seeArr;
                };
        };
        
        case "attackentity": {
            ASSERT_TRUE(typeName _args == "ARRAY",str _args);
            
            private ["_target","_reserved","_sides","_size","_type","_proIDs","_knownE","_attackedE","_pos","_profiles","_profileIDs","_profile","_section","_profileID","_i","_waypoints","_posAttacker","_dist"];
            
            _target = _args select 0;
            _size = _args select 1;
            _type = _args select 2;
            
            _side = [_logic,"side"] call ALiVE_fnc_Hashget;
            _factions = [_logic,"factions"] call ALiVE_fnc_HashGet;
            _sides = [_logic,"sidesenemy",["EAST"]] call ALiVE_fnc_HashGet;
            _knownE = [_logic,"knownentities",[]] call ALiVE_fnc_HashGet;
            _attackedE = [_logic,"attackedentities",[]] call ALiVE_fnc_HashGet;
            _reserved = [_logic,"ProfileIDsReserve",[]] call ALiVE_fnc_HashGet;
            _profile = [ALiVE_ProfileHandler,"getProfile",_target] call ALiVE_fnc_ProfileHandler; 
           
           	_section = [];
            _profileIDs = [];
            _dist = 1000;
            
            if (isnil "_profile") exitwith {_result = _section};
            
           {
                _proIDs = [ALIVE_profileHandler, "getProfilesBySide",_x] call ALIVE_fnc_profileHandler;
                _profileIDs = _profileIDs + _proIDs;
            } foreach _sides;
            
            _pos = [_profile,"position"] call ALiVE_fnc_HashGet;

            {
                if ((isnil "_x") || {_x select 0 == _target} || {!((_x select 0) in _profileIDs)}) then {
                    _knownE set [_foreachIndex,"x"];
                    _knownE = _knownE - ["x"];
                    
                    [_logic,"knownentities",_knownE] call ALiVE_fnc_HashSet;
                };
            } foreach _knownE;
            
            {
            	if ((isnil "_x") || {time - (_x select 3) > 90} || {!((_x select 0) in _profileIDs)}) then {
                    _attackedE set [_foreachIndex,"x"];
                    _attackedE = _attackedE - ["x"];
                    
                    [_logic,"attackedentities",_attackedE] call ALiVE_fnc_HashSet;
                };
            } foreach _attackedE;
            
            if ({!(isnil "_x") && {_x select 0 == _target}} count _attackedE < 1) then {
	            switch (_type) do {
	                case ("infantry") : {
                        _profiles = [_logic,"infantry"] call ALiVE_fnc_HashGet;
                        _dist = 1000;
	                };
	                case ("mechandized") : {
	                    _profiles = [_logic,"mechandized"] call ALiVE_fnc_HashGet;
	                };
	                case ("armored") : {
                        _profiles = [_logic,"armored"] call ALiVE_fnc_HashGet;
                        _dist = 3000;
                    };
                    case ("artillery") : {
                        _profiles = [_logic,"artillery"] call ALiVE_fnc_HashGet;
                        _dist = 5000;
                    };
                    case ("AAA") : {
                        _profiles = [_logic,"AAA"] call ALiVE_fnc_HashGet;
                        _dist = 5000;
                    };
	                case ("air") : {
                        _profiles = [_logic,"air"] call ALiVE_fnc_HashGet;
                        _dist = 15000;
                    };
	            };
                
                if (count _profiles > 0) then {
                    
                    _profilesUnsorted = _profiles;
                    _profiles = [_profilesUnsorted,[],{if !(isnil "_x") then {_p = nil; _p = [ALiVE_ProfileHandler,"getProfile",_x] call ALiVE_fnc_ProfileHandler; if !(isnil "_p") then {([_p,"position",_pos] call ALiVE_fnc_HashGet) distance _pos} else {[0,0,0] distance _pos}} else {[0,0,0] distance _pos}},"ASCEND"] call BIS_fnc_sortBy;

                    _i = 0;
	                while {count _section < _size} do {
                        private ["_profileWaypoint","_profileID"];

                        if (_i >= count _profiles) exitwith {};
                        
                   		_profileID = (_profiles select _i);
                    	_profile = ([ALiVE_ProfileHandler,"getProfile",_profileID] call ALiVE_fnc_profileHandler);
                        
                        if !(isnil "_profile") then {
	                       	_posAttacker = [_profile, "position"] call ALiVE_fnc_HashGet;
	                        
	                        if (!(isnil "_profile") && {_pos distance _posAttacker < _dist} && {!(_profileID in _reserved)}) then {
	
		                        _waypoints = [_profile,"waypoints"] call ALIVE_fnc_hashGet;
	                        
		                        if (({!(isnil "_x") && {_profileID in (_x select 2)}} count _attackedE) < 1 && {count _waypoints <= 2}) then {
		                            _profileWaypoint = [_pos, 50] call ALIVE_fnc_createProfileWaypoint;
									[_profile,"insertWaypoint",_profileWaypoint] call ALIVE_fnc_profileEntity;
		                        	_section set [count _section, _profileID];
		                        } else {
		                            //player sidechat format["Entity %1 is already on attack mission...!",_profileID];
		                        };
	                        };
                        };
                            
                        _i = _i + 1;
            		};
                    
                    if (count _section > 0) then {
                    	_attackedE set [count _attackedE,[_target,_pos,_section,time]];
	                	[_logic,"attackedentities",_attackedE] call ALiVE_fnc_HashSet;
                        //player sidechat format["Group %1 is attacked by %2",_target, _section];
                    };
                };
            } else {
                //player sidechat format["Target %1 already beeing attacked, dead or not existing for any reason...!",_target];
            };

            _result = _section;
        };
        
        case "analyzeclusteroccupation": {
            	ASSERT_TRUE(typeName _args == "ARRAY",str _args);
                
                private ["_pos","_item","_type","_prios","_side","_sides","_id","_entArr","_ent","_sectors","_entities","_state","_controltype"];

				_sides = _args;
                _sidesF = _sides select 0;
                _sidesE = _sides select 1;
                _objectives = [_logic,"objectives",[]] call ALiVE_fnc_HashGet;
                _controltype = [_logic, "controltype","invasion"] call ALiVE_fnc_HashGet;
                
				//_distance = _args select 1;
                _result_tmp = [];
                for "_i" from 0 to ((count _sides)-1) do {
                    _sideX = _sides select _i;
                    _nearForces = [];
                    
                    {
  		                for "_z" from 0 to ((count _objectives)-1) do {
		                    _item = _objectives select _z;
							_pos = [_item,"center"] call ALiVE_fnc_HashGet;
							_id = [_item,"objectiveID"] call ALiVE_fnc_HashGet;
	                        _state = [_item,"opcom_state","unassigned"] call ALiVE_fnc_HashGet;
	                        _size_reserve = [_logic,"sectionsamount_reserve",1] call ALiVE_fnc_HashGet;
	                        _section = [_item,"section",[]] call ALiVE_fnc_HashGet;
                            
                            _type = "surroundingsectors";
	                        _entArr = [];
	                        _entities = [];
	                        
	                       if (count _section < 1) then {[_item,"opcom_state","unassigned"] call ALiVE_fnc_HashSet; [_item,"opcom_orders","none"] call ALiVE_fnc_HashSet; [_item,"danger",-1] call ALiVE_fnc_HashSet};
	
	                       _profiles = [_pos, 500, [_x,"entity"]] call ALIVE_fnc_getNearProfiles;
				            {
				                if (typeName (_x select 2 select 4) == "STRING") then {
				                	_entities set [count _entities,_x select 2 select 4];
                                    
                                    //player sidechat format["Entities: %1, count total %2 val %3",_entities,count _entities,(_x select 2 select 4)];
	                       			//diag_log format["Entities: %1, count total %2 val %3",_entities,count _entities,(_x select 2 select 4)];
				            	};
	                            //sleep 0.03;
				            } foreach _profiles;
	                        
	                    
		                    if (count _entities > 0) then {_nearForces set [count _nearForces,[_id,_entities]]};
	                    };
                    } foreach _sideX;
                    
                    _result_tmp set [count _result_tmp,_nearForces];
                };
            
	            _targetsTaken1 =  _result_tmp select 0;
	            _targetsTaken2 =  _result_tmp select 1;
	            
	        	_targetsAttacked1 = [];
                _remover1 = [];
				{
					_targetID = _x select 0;
					_entities = _x select 1;
					
					if (({(_x select 0) == _targetID} count _targetsTaken2 > 0) && {(typename _x == "ARRAY")}) then {
						_targetsAttacked1 set [count _targetsAttacked1,_x];
						_remover1 set [count _remover1,_foreachIndex];
					};
                    //sleep 0.03;
				} foreach _targetsTaken1;
	
				_targetsAttacked2 = [];
                _remover2 = [];
				{
					_targetID = _x select 0;
					_entities = _x select 1;
					
					if (({(_x select 0) == _targetID} count _targetsTaken1 > 0) && {(typename _x == "ARRAY")}) then {
						_targetsAttacked2 set [count _targetsAttacked2,_x];
						_remover2 set [count _remover2,_foreachIndex];
					};
                    //sleep 0.03;
				} foreach _targetsTaken2;
                

                {
                	if !(_x > ((count _targetsTaken1)-1)) then {
                   		_targetsTaken1 set [_x,"x"];
                   		_targetsTaken1 = _targetsTaken1 - ["x"];
                	};
                    //sleep 0.03;
                } foreach _remover1;
                
                _targetsTaken1 = _targetsTaken1 - [objNull];
                
                {
                    if !(_x > ((count _targetsTaken2)-1)) then {
                   		_targetsTaken2 set [_x,"x"];
                   		_targetsTaken2 = _targetsTaken2 - ["x"];
                    };
                    //sleep 0.03;
                } foreach _remover2;
                
                _targetsTaken2 = _targetsTaken2 - [objNull];
               
	            _result = [_targetsTaken1, _targetsAttacked1, _targetsTaken2, _targetsAttacked2,time];
                [_logic,"clusteroccupation",_result] call AliVE_fnc_HashSet;
                
        		_targetsTaken = _result select 0;
				_targetsAttacked = _result select 1;
				_targetsTakenEnemy = _result select 2;
				_targetsAttackedEnemy = _result select 3;
                
                switch (_controltype) do {
					case ("invasion") : {
						_prios = [
							[_targetsTaken,"reserve"],
							[_targetsTakenEnemy,"attack"],
							[_targetsAttackedEnemy,"defend"]
						];
                    };
                    
                    case ("occupation") : {
						_prios = [
							[_targetsTaken,"reserve"],
							[_targetsTakenEnemy,"attack"],
							[_targetsAttackedEnemy,"defend"]
						];
                    };
				};
                
				{
					[_logic,"setstatebyclusteroccupation",[(_x select 0),(_x select 1)]] call ALiVE_fnc_OPCOM;
				} foreach _prios;
                
                //diag_log format ["%5: Taken %1 | Attacked %2 // %6: Taken %3 | Attacked %4",_targetsTaken, _targetsAttackedEnemy, _targetsTakenEnemy, _targetsAttackedEnemy,_sidesF,_sidesE];
                //player sidechat format ["%5: Taken %1 | Attacked %2 // %6: Taken %3 | Attacked %4",_targetsTaken, _targetsAttackedEnemy, _targetsTakenEnemy, _targetsAttackedEnemy,_sidesF,_sidesE];
		};
                
        case "scanenemies": {
            ASSERT_TRUE(typeName _args == "ARRAY",str _args);
            
            private ["_pos","_posP","_sidesEnemy","_visibleEnemies","_id","_knownEntities"];
            
            _pos = _args;
            _sidesEnemy = [_logic,"sidesenemy",["EAST"]] call ALiVE_fnc_HashGet;
            _knownEntities = [_logic,"knownentities",[]] call ALiVE_fnc_HashGet;
            _knownEntities = _knownEntities - ["x"];
            
            _visibleEnemies = [];
           {
               private ["_vis"];
               _vis = [_logic,"entitiesnearsector",[_pos,_x,true]] call ALiVE_fnc_OPCOM;
               _visibleEnemies = _visibleEnemies + _vis;
           } foreach _sidesEnemy;
            
			if (count _visibleEnemies > 0) then {
                {
                	_id = _x select 0;
                    _posP = _x select 1;

                   if !({(!(isnil "_x") && {(_x select 0) == _id})} count _knownEntities > 0) then {
                        _knownEntities set [count _knownEntities,_x];
                    };
                } foreach _visibleEnemies;
                [_logic,"knownentities",_knownEntities] call ALiVE_fnc_HashSet;
			};
            
            _result = _knownEntities;
        };

        case "scantroops" : {
            
            private ["_inf","_mot","_mech","_arm","_air","_sea","_profileIDs","_artilleryClasses","_AAA","_AAAClasses"];
            
            _artilleryClasses = ["B_MBT_01_arty_F","B_MBT_01_mlrs_F","O_MBT_02_arty_F"];
            _AAAClasses = ["O_APC_Tracked_02_AA_F","B_APC_Tracked_01_AA_F"];
            _factions = [_logic,"factions"] call ALiVE_fnc_HashGet;
            
            _profileIDs = [];
            {
                _profileIDs = _profileIDs + ([ALIVE_profileHandler, "getProfilesByFaction",_x] call ALIVE_fnc_profileHandler);
            } foreach _factions;
            
            _inf = [];
            _mot = [];
            _AAA = [];
            _arm = [];
            _air = [];
            _sea = [];
            _mech = [];
            _arty = [];
            
            {
                private ["_profile","_assignment","_type","_objectType","_vehicleClass"];
                
                _profile = [ALIVE_profileHandler, "getProfile",_x] call ALIVE_fnc_profileHandler;
                
                if !(isnil "_profile") then {
                
	                _assignments = [_profile,"vehicleAssignments"] call ALIVE_fnc_hashGet;
	                _type = [_profile,"type"] call ALIVE_fnc_hashGet;
	                _objectType = [_profile,"objectType"] call ALIVE_fnc_hashGet;
	                _vehicleClass = [_profile,"vehicleClass"] call ALIVE_fnc_hashGet;
	
	                switch (tolower _type) do {
	                    case ("vehicle") : {
		                        switch (tolower _objectType) do {
		                			case "car":{
	                                    if ((count (_assignments select 1)) > 0) then {
	                                        {if !(_x in _mot) then {_mot set [count _mot,_x]}} foreach (_assignments select 1);
	                                    };
									};
									case "tank":{
	                                    if ((count (_assignments select 1)) > 0) then {
                                            if (_vehicleClass in (_artilleryClasses + _AAAClasses)) then {
                                                if (_vehicleClass in _artilleryClasses) then {{if !(_x in _arty) then {_arty set [count _arty,_x]}} foreach (_assignments select 1)};
                                                if (_vehicleClass in _AAAClasses) then {{if !(_x in _AAA) then {_AAA set [count _AAA,_x]}} foreach (_assignments select 1)};
                                            } else {
                                                {if !(_x in _arm) then {_arm set [count _arm,_x]}} foreach (_assignments select 1);
                                            };
	                                    };
	                                };
									case "armored":{
	                                    if ((count (_assignments select 1)) > 0) then {
											{if !(_x in _mech) then {_mech set [count _mech,_x]}} foreach (_assignments select 1);
	                                    };
									};
									case "truck":{
	                                    if ((count (_assignments select 1)) > 0) then {
	                                    	{if !(_x in _mot) then {_mot set [count _mot,_x]}} foreach (_assignments select 1);
	                                    };
									};
									case "ship":{
	                                    if ((count (_assignments select 1)) > 0) then {
											{if !(_x in _sea) then {_sea set [count _sea,_x]}} foreach (_assignments select 1);
	                                    };
									};
									case "helicopter":{
	                                    if ((count (_assignments select 1)) > 0) then {
											{if !(_x in _air) then {_air set [count _air,_x]}} foreach (_assignments select 1);
	                                    };
									};
									case "plane":{
	                                    if ((count (_assignments select 1)) > 0) then {
											{if !(_x in _air) then {_air set [count _air,_x]}} foreach (_assignments select 1);
	                                    };
									};
		                        };
	                        };
	                        
	                        case ("entity") : {
	                            if ((count (_assignments select 1)) == 0) then {
	                                _inf set [count _inf,_x];
	                            };
	                        };
	                };
                };
            } foreach _profileIDs;
            
            [_logic,"infantry",_inf] call ALiVE_fnc_HashSet;
            [_logic,"motorized",_mot] call ALiVE_fnc_HashSet;
            [_logic,"mechanized",_mech] call ALiVE_fnc_HashSet;
            [_logic,"armored",_arm] call ALiVE_fnc_HashSet;
            [_logic,"artillery",_arty] call ALiVE_fnc_HashSet;
            [_logic,"AAA",_AAA] call ALiVE_fnc_HashSet;
            [_logic,"air",_air] call ALiVE_fnc_HashSet;
            [_logic,"sea",_sea] call ALiVE_fnc_HashSet;
            
            _result = [_inf,_mot,_mech,_arm,_air,_sea,_arty,_AAA];
        };

        case "setorders": {
            	ASSERT_TRUE(typeName _args == "ARRAY",str _args);
        
        		private ["_section","_profile","_profileID","_objectiveID","_pos","_orders","_pending_orders","_objectives","_id"];

				_pos = _args select 0;
				_profileID = _args select 1;
				_objectiveID = _args select 2;
				_orders = _args select 3;
                _TACOM_FSM = [_logic,"TACOM_FSM"] call ALiVE_fnc_HashGet;
                _objectives = [_logic,"objectives"] call ALiVE_fnc_HashGet;
                
                {
                    _id = [_x,"objectiveID"] call ALiVE_fnc_HashGet;
                    _section = [_x,"section",[]] call ALiVE_fnc_HashGet;
                    
                    if ((_profileID in _section) && {!(_objectiveID == _id)}) then {
                        [_logic,"resetorders",_profileID] call ALiVE_fnc_OPCOM;
                    };
                } foreach _objectives;
                
                _pending_orders = [_logic,"pendingorders",[]] call ALiVE_fnc_HashGet;
                _pending_orders_tmp = _pending_orders;
                
                if (({(_x select 1) == _profileID} count _pending_orders_tmp) > 0) then {
                    {
                        if ((_x select 1) == _profileID) then {_pending_orders_tmp set [_foreachIndex,"x"]};
                    } foreach _pending_orders_tmp;
                    _pending_orders = _pending_orders_tmp - ["x"];
                };

				_profile = [ALIVE_profileHandler, "getProfile", _profileID] call ALIVE_fnc_profileHandler;

				[_profile, "clearWaypoints"] call ALIVE_fnc_profileEntity;
				_profileWaypoint = [_pos, 15] call ALIVE_fnc_createProfileWaypoint;

				_var = ["_TACOM_DATA",["completed",[_ProfileID,_objectiveID,_orders]]];
				_statements = format["[] spawn {sleep (random 10); %1 setfsmvariable %2}",_TACOM_FSM,_var];
				[_profileWaypoint,"statements",["true",_statements]] call ALIVE_fnc_hashSet;
                [_profileWaypoint,"behaviour","AWARE"] call ALIVE_fnc_hashSet;
                [_profileWaypoint,"speed","NORMAL"] call ALIVE_fnc_hashSet;

				[_profile, "addWaypoint", _profileWaypoint] call ALIVE_fnc_profileEntity;
                
                _ordersFull = [_pos,_ProfileID,_objectiveID,time];
                [_logic,"pendingorders",_pending_orders + [_ordersFull]] call ALiVE_fnc_HashSet;

                _result = _profileWaypoint;
		};
        
        case "synchronizeorders": {
            	ASSERT_TRUE(typeName _args == "STRING",str _args);
                
                private ["_ProfileIDInput","_profiles","_orders_pending","_synchronized","_item","_objectiveID","_profileID"];
        
    			_ProfileIDInput = _args;
				_profiles = ([ALIVE_profileHandler, "getProfiles","entity"] call ALIVE_fnc_profileHandler) select 1;
				_orders_pending = ([_logic,"pendingorders",[]] call ALiVE_fnc_HashGet);
				_synchronized = false;

				for "_i" from 0 to ((count _orders_pending)-1) do {
					if (_i >= (count _orders_pending)) exitwith {};
			
					_item = _orders_pending select _i;
                    
                    if (typeName _item == "ARRAY") then {
						_pos = _item select 0;
						_profileID = _item select 1;
						_objectiveID = _item select 2;
						_time = _item select 3;
						_dead = !(_ProfileID in _profiles);
						_timeout = (time - _time) > 3600;
				
						if ((_dead) || {_timeout} || {_ProfileID == _ProfileIDInput}) then {
							_orders_pending set [_i,"x"]; _orders_pending = _orders_pending - ["x"];
	                        [_logic,"pendingorders",_orders_pending] call ALiVE_fnc_HashSet;
	                        if (({_objectiveID == (_x select 2)} count (_orders_pending)) == 0) then {_synchronized = true};
						};
                    };
				};
				_result = _synchronized;
        };
        
        case "resetorders": {
            ASSERT_TRUE(typeName _args == "STRING",str _args);
			private ["_active","_profileID","_profile","_ProfileIDsBusy","_profileIDx","_pendingOrders","_ProfileIDsReserve","_section","_objectives"];
            
        	_profileID = _args;
            
            //Reset busy queue if there is an entry for the entitiy
			[_logic,"ProfileIDsBusy",([_logic,"ProfileIDsBusy",[]] call ALiVE_fnc_HashGet) - [_profileID]] call ALiVE_fnc_HashSet;
            
            //Reset reserve queue if there is an entry for the entitiy
            [_logic,"ProfileIDsReserve",([_logic,"ProfileIDsReserve",[]] call ALiVE_fnc_HashGet) - [_profileID]] call ALiVE_fnc_HashSet;
            
            //Reset pending orders if there is an entry for the entitiy
            _pendingOrders = [_logic,"pendingorders",[]] call ALiVE_fnc_HashGet;
            {
				_profileIDx = _x select 1;
                
                if (_profileIDx == _profileID) then {
                    _pendingOrders set [_foreachIndex,"x"];
                };
			} foreach _pendingOrders;
            _pendingOrders = _pendingOrders - ["x"];
            [_logic,"pendingorders",_pendingOrders] call ALiVE_fnc_HashSet;
            
            //Reset section entry on objectives if the entitiy is still assigned to an objective
            _objectives = [_logic,"objectives",[]] call ALiVE_fnc_HashGet;
            {
                _section = [_x,"section",[]] call ALiVE_fnc_HashGet;
				[_x,"sectionAssist",[]] call ALiVE_fnc_HashSet;
                
                if !(isnil "_section") then {
	                if (_profileID in _section) then {
	                    _section = _section - [_profileID];
	                    [_x,"section",_section] call ALiVE_fnc_HashSet;
	                };
	                
	                if ((count _section) == 0) then {
	                    [_logic,"resetObjective",([_x,"objectiveID"] call ALiVE_fnc_HashGet)] call ALiVE_fnc_OPCOM;
	                };
                };
            } foreach _objectives;
            
            _profile = [ALIVE_profileHandler, "getProfile", _profileID] call ALIVE_fnc_profileHandler;
            if !(isnil "_profile") then {
               _active = [_profile, "active", false] call ALIVE_fnc_HashGet;

               if !(_active) then {
	            	[_profile, "clearActiveCommands"] call ALIVE_fnc_profileEntity;
					[_profile, "setActiveCommand", ["ALIVE_fnc_ambientMovement","spawn",200]] call ALIVE_fnc_profileEntity;
               };
            };
            
            _result = true;
        };

        case "setstatebyclusteroccupation": {
            	ASSERT_TRUE(typeName _args == "ARRAY",str _args);
                
				private ["_objectives","_operation","_idleStates","_stateX","_target"];
				_objectives = _args select 0;
				_operation = _args select 1;

				switch (_operation) do {
                	case ("unassigned") : {_idleStates = ["internal","unassigned"]};
                    case ("attack") : {_idleStates = ["internal","attack","attacking","defend","defending"]};
                    case ("defend") : {_idleStates = ["internal","defend","defending","attack","attacking"]};
                    case ("reserve") : {_idleStates = ["internal","attack","attacking","defend","defending","reserve","reserving","idle"]};
                    default {_idleStates = ["internal","reserve","reserving","idle"]};
                };

				{
					_id = _x; if (typeName _x == "ARRAY") then {_id = _x select 0};
					_target = [_logic,"getobjectivebyid",_id] call ALiVE_fnc_OPCOM;
                    
                    //player sidechat format["input: ID %1 | operation: %2",_id,_operation];
					
                    _pos = [_target,"center"] call AliVE_fnc_HashGet;
					_stateX = [_target,"opcom_state"] call AliVE_fnc_HashGet;
	                if !(_stateX in _idleStates) then {
                        //player sidechat format["output: state %1 | operation: %2",_stateX,_operation];
                    	[_target,"opcom_state",_operation] call AliVE_fnc_HashSet;
                    };
                } foreach _objectives;
                
                if !(isnil "_target") then {_result = [_target,_operation]} else {_result = nil};
		};
        
        case "selectordersbystate": {
            	private ["_target","_state","_DATA_TMP","_ord","_module"];
            	ASSERT_TRUE(typeName _args == "STRING",str _args);
                
                _state = _args;
                _module = [_logic,"module"] call ALiVE_fnc_HashGet;
                
                _DATA_TMP = nil;
                _ord = nil;

            	switch (_state) do {
					case ("attack") : {
						{
							_state = [_x,"opcom_state"] call AliVE_fnc_HashGet;

							//Set attack only if any synchronized triggers are activated
							if ((_state == "attack") && {{((typeof _x) == "EmptyDetector") && {!(triggerActivated _x)}} count (synchronizedObjects _module) == 0}) exitwith {_target = _x};
						} foreach ([_logic,"objectives",[]] call AliVE_fnc_HashGet);
		
						//Trigger order execution
                        if !(isnil "_target") then {
                            _ord = [_target,"opcom_orders","none"] call AliVE_fnc_HashGet;
							[_target,"opcom_orders","attack"] call AliVE_fnc_HashSet;
							_DATA_TMP = ["execute",_target];
                        };
					};
					case ("unassigned") : {
						{
							_state = [_x,"opcom_state"] call AliVE_fnc_HashGet;
                            
                            //Set attack only if any synchronized triggers are activated
							if ((_state == "unassigned") && {{((typeof _x) == "EmptyDetector") && {!(triggerActivated _x)}} count (synchronizedObjects _module) == 0}) exitwith {_target = _x};
						} foreach ([_logic,"objectives",[]] call AliVE_fnc_HashGet);
		
						//Trigger order execution
                        if !(isnil "_target") then {
                        	_ord = [_target,"opcom_orders","none"] call AliVE_fnc_HashGet;
                            //if (!(_ord == "attack")) then {
								[_target,"opcom_orders","attack"] call AliVE_fnc_HashSet;
								_DATA_TMP = ["execute",_target];
                            //};
                        };
					};
                    case ("defend") : {
						{
							_state = [_x,"opcom_state"] call AliVE_fnc_HashGet;
							if (_state == "defend") exitwith {_target = _x};
						} foreach ([_logic,"objectives",[]] call AliVE_fnc_HashGet);
		
						//Trigger order execution
                        if !(isnil "_target") then {
                            _ord = [_target,"opcom_orders","none"] call AliVE_fnc_HashGet;
                            //if (!(_ord == "defend")) then {
								[_target,"opcom_orders","defend"] call AliVE_fnc_HashSet;
								_DATA_TMP = ["execute",_target];
                            //};
                        };
					};
					case ("reserve") : {
						{
							_state = [_x,"opcom_state"] call AliVE_fnc_HashGet;
							if (_state == "reserve") exitwith {_target = _x};
						} foreach ([_logic,"objectives",[]] call AliVE_fnc_HashGet);;
		
						//Trigger order execution
                        if !(isnil "_target") then {
                            _ord = [_target,"opcom_orders","none"] call AliVE_fnc_HashGet;
                            //if (!(_ord == "reserve")) then {
								[_target,"opcom_orders","reserve"] call AliVE_fnc_HashSet;
								_DATA_TMP = ["execute",_target];
                            //};
                        };
					};
        		};

                if !(isnil "_DATA_TMP") then {_result = _DATA_TMP} else {_result = nil};
		};
       
        case "destroy": {                
                [_logic, "debug", false] call MAINCLASS;
                if (isServer) then {
					[_logic, "destroy"] call SUPERCLASS;
                };                
        };
        case "debug": {
                if(typeName _args != "BOOL") then {
						_args = [_logic,"debug"] call ALIVE_fnc_hashGet;
                } else {
						[_logic,"debug",_args] call ALIVE_fnc_hashSet;
                };
                ASSERT_TRUE(typeName _args == "BOOL",str _args);
                
                _result = _args;
        };
        
        case "OPCOM_monitor": {
            ASSERT_TRUE(typeName _args == "BOOL",str _args);
            
            //private ["_hdl","_side","_state","_FSM","_cycleTime"];
            
            _hdl = [_logic,"monitor",false] call AliVE_fnc_HashGet;
            
            if (!(_args) && {!(typeName _hdl == "BOOL")}) then {
                    terminate _hdl;
                    [_logic,"monitor",nil] call AliVE_fnc_HashSet;
            } else {
                _hdl = _logic spawn {
                    
                    // debug ---------------------------------------
					if ([_this,"debug",false] call ALiVE_fnc_HashGet) then {
						["OPCOM and TACOM monitoring started..."] call ALIVE_fnc_dumpR;
					};
					// debug ---------------------------------------
					_FSM_OPCOM = [_this,"OPCOM_FSM"] call AliVE_fnc_HashGet;
					_FSM_TACOM = [_this,"TACOM_FSM"] call AliVE_fnc_HashGet;
                    
					while {true} do {

							_state = _FSM_OPCOM getfsmvariable "_OPCOM_status"; 
							_state_TACOM = _FSM_TACOM getfsmvariable "_TACOM_status";
							_side = _FSM_OPCOM getfsmvariable "_side";
							_cycleTime = _FSM_OPCOM getfsmvariable "_cycleTime";
							_timestamp = floor(time - (_FSM_OPCOM getfsmvariable "_timestamp"));
                            
                            //Exit if FSM has ended
                            if (isnil "_cycleTime") exitwith {["Exiting OPCOM Monitor"] call ALiVE_fnc_Dump};

							_maxLimit = _cycleTime + ((count allunits)*2);
                            
                            if (_timestamp > _maxLimit) then {
                            //if (true) then {
                                // debug ---------------------------------------
								if ([_this,"debug",false] call ALiVE_fnc_HashGet) then {
                                    _message = parsetext (format["<t align=left>OPCOM side: %1<br/><br/>WARNING! Max. duration exceeded!<br/>state OPCOM: %2<br/>state TACOM: %4<br/>duration: %3</t>",_side,_state,_timestamp,_state_TACOM]);
									[_message] call ALIVE_fnc_dump; hintsilent _message;
                                    
                                    if (_timestamp > 900) then {
                                        _FSM_OPCOM setfsmvariable ["_OPCOM_DATA",nil];
                                        _FSM_OPCOM setfsmvariable ["_busy",false];
                                    };
								};
								// debug ---------------------------------------
                            };
                            
                            sleep 1;
                     };
				};
                [_logic,"monitor",_hdl] call AliVE_fnc_HashSet;
			};
            _result = _hdl;
		};
        
		case "state": {
				private["_state"];
                
				if(typeName _args != "ARRAY") then {
						
						// Save state
				
                        _state = [] call ALIVE_fnc_hashCreate;
						
						// BaseClassHash CHANGE 
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
						
						// BaseClassHash CHANGE 
						// loop the passed hash and set vars on the class hash
                        {
							[_logic,_x,[_args,_x] call ALIVE_fnc_hashGet] call ALIVE_fnc_hashSet;
						} forEach (_args select 1);
                };
        };
        default {
                _result = [_logic, _operation, _args] call SUPERCLASS;
        };
};
TRACE_1("OPCOM - output",_result);
if !(isnil "_result") then {_result} else {nil};