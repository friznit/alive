//#define DEBUG_MODE_FULL
#include <\x\alive\addons\sys_tour\script_component.hpp>
SCRIPT(tour);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_tour
Description:
Tour

Parameters:
Nil or Object - If Nil, return a new instance. If Object, reference an existing instance.
String - The selected function
Array - The selected parameters

Returns:
Any - The new instance or the result of the selected function and parameters

Attributes:
Nil - init - Intiate instance
Nil - destroy - Destroy instance
Boolean - debug - Debug enabled
Array - state - Save and restore module state

Examples:
[_logic, "debug", true] call ALiVE_fnc_tour;

See Also:
- <ALIVE_fnc_tourInit>

Author:
ARJay

Peer Reviewed:
---------------------------------------------------------------------------- */

#define SUPERCLASS ALIVE_fnc_baseClass
#define MAINCLASS ALIVE_fnc_tour
#define MTEMPLATE "ALiVE_TOUR_%1"

private ["_logic","_operation","_args","_result","_debug"];

TRACE_1("TOUR - input",_this);

_logic = [_this, 0, objNull, [objNull]] call BIS_fnc_param;
_operation = [_this, 1, "", [""]] call BIS_fnc_param;
_args = [_this, 2, objNull, [objNull,[],"",0,true,false]] call BIS_fnc_param;
_result = true;

switch(_operation) do {
	default {
		_result = [_logic, _operation, _args] call SUPERCLASS;
	};
	case "destroy": {
		[_logic, "debug", false] call MAINCLASS;
		if (isServer) then {
			// if server
			_logic setVariable ["super", nil];
			_logic setVariable ["class", nil];
			
			[_logic, "destroy"] call SUPERCLASS;
		};
	};
	case "debug": {
		if (typeName _args == "BOOL") then {
			_logic setVariable ["debug", _args];
		} else {
			_args = _logic getVariable ["debug", false];
		};
		if (typeName _args == "STRING") then {
			if(_args == "true") then {_args = true;} else {_args = false;};
			_logic setVariable ["debug", _args];
		};
		ASSERT_TRUE(typeName _args == "BOOL",str _args);
		
		_result = _args;
	};
	case "init": {

		if (isServer) then {
			_logic setVariable ["super", SUPERCLASS];
			_logic setVariable ["class", MAINCLASS];
			_logic setVariable ["moduleType", "ALIVE_TOUR"];
			_logic setVariable ["startupComplete", false];
			_logic setVariable ["selectionState", "start"];
			_logic setVariable ["drawEventID", -1];

			ALIVE_tourInstance = _logic;

			[_logic, "setSelectionOptions"] call MAINCLASS;

			TRACE_1("After module init",_logic);

			[_logic, "start"] call MAINCLASS;
		};
	};
	case "setSelectionOptions": {

        private["_selectionOptions"];

        _selectionOptions = [] call ALIVE_fnc_hashCreate;

        // start selections

        private["_overview","_actionSelection","_technologySelection","_modulesSelection"];

        _overview = [] call ALIVE_fnc_hashCreate;

        [_overview,"icon","x\alive\addons\sys_tour\data\alive_icons_tour_info.paa"] call ALIVE_fnc_hashSet;
        [_overview,"inactiveLabel","Overview"] call ALIVE_fnc_hashSet;
        [_overview,"activeLabel","About ALiVE"] call ALIVE_fnc_hashSet;
        [_overview,"iconState",["Overview",0,0]] call ALIVE_fnc_hashSet;

        _technologySelection = [] call ALIVE_fnc_hashCreate;

        [_technologySelection,"icon","x\alive\addons\sys_tour\data\alive_icons_tour_tech.paa"] call ALIVE_fnc_hashSet;
        [_technologySelection,"inactiveLabel","Technology"] call ALIVE_fnc_hashSet;
        [_technologySelection,"activeLabel","Explore the Core ALiVE Technology"] call ALIVE_fnc_hashSet;
        [_technologySelection,"iconState",["Technology",0,0]] call ALIVE_fnc_hashSet;

        _modulesSelection = [] call ALIVE_fnc_hashCreate;

        [_modulesSelection,"icon","x\alive\addons\sys_tour\data\alive_icons_tour_task.paa"] call ALIVE_fnc_hashSet;
        [_modulesSelection,"inactiveLabel","Modules"] call ALIVE_fnc_hashSet;
        [_modulesSelection,"activeLabel","Learn about the ALiVE modules"] call ALIVE_fnc_hashSet;
        [_modulesSelection,"iconState",["Modules",0,0]] call ALIVE_fnc_hashSet;

        _actionSelection = [] call ALIVE_fnc_hashCreate;

        [_actionSelection,"icon","x\alive\addons\sys_tour\data\alive_icons_tour_weapon.paa"] call ALIVE_fnc_hashSet;
        [_actionSelection,"inactiveLabel","Action"] call ALIVE_fnc_hashSet;
        [_actionSelection,"activeLabel","Get into the action"] call ALIVE_fnc_hashSet;
        [_actionSelection,"iconState",["Action",0,0]] call ALIVE_fnc_hashSet;

        [_selectionOptions,"start",[_overview,_technologySelection,_modulesSelection,_actionSelection]] call ALIVE_fnc_hashSet;

        // overview selections

        private["_whatSelection","_whySelection","_whoSelection""_backSelection"];

        _whatSelection = [] call ALIVE_fnc_hashCreate;

        [_whatSelection,"icon","x\alive\addons\sys_tour\data\alive_icons_tour_what.paa"] call ALIVE_fnc_hashSet;
        [_whatSelection,"inactiveLabel","What"] call ALIVE_fnc_hashSet;
        [_whatSelection,"activeLabel","What is ALiVE"] call ALIVE_fnc_hashSet;
        [_whatSelection,"iconState",["What",0,0]] call ALIVE_fnc_hashSet;

        _whySelection = [] call ALIVE_fnc_hashCreate;

        [_whySelection,"icon","x\alive\addons\sys_tour\data\alive_icons_tour_what.paa"] call ALIVE_fnc_hashSet;
        [_whySelection,"inactiveLabel","Why"] call ALIVE_fnc_hashSet;
        [_whySelection,"activeLabel","Why ALiVE"] call ALIVE_fnc_hashSet;
        [_whySelection,"iconState",["Why",0,0]] call ALIVE_fnc_hashSet;

        _whoSelection = [] call ALIVE_fnc_hashCreate;

        [_whoSelection,"icon","x\alive\addons\sys_tour\data\alive_icons_tour_what.paa"] call ALIVE_fnc_hashSet;
        [_whoSelection,"inactiveLabel","Who"] call ALIVE_fnc_hashSet;
        [_whoSelection,"activeLabel","Who is ALiVE"] call ALIVE_fnc_hashSet;
        [_whoSelection,"iconState",["Who",0,0]] call ALIVE_fnc_hashSet;

        _backSelection = [] call ALIVE_fnc_hashCreate;

        [_backSelection,"icon","x\alive\addons\sys_tour\data\alive_icons_tour_back.paa"] call ALIVE_fnc_hashSet;
        [_backSelection,"inactiveLabel","Go Back"] call ALIVE_fnc_hashSet;
        [_backSelection,"activeLabel","Go back to the previous menu"] call ALIVE_fnc_hashSet;
        [_backSelection,"iconState",["Back",0,0]] call ALIVE_fnc_hashSet;

        [_selectionOptions,"Overview",[_whatSelection,_whySelection,_whoSelection,_backSelection]] call ALIVE_fnc_hashSet;

        // technology selections

        private["_mapAnalysisSelection","_objectivesSelection","_profileSelection","_opcomSelection","_dataSelection","_backSelection"];

        _mapAnalysisSelection = [] call ALIVE_fnc_hashCreate;

        [_mapAnalysisSelection,"icon","x\alive\addons\sys_tour\data\alive_icons_tour_sector.paa"] call ALIVE_fnc_hashSet;
        [_mapAnalysisSelection,"inactiveLabel","Map Analysis"] call ALIVE_fnc_hashSet;
        [_mapAnalysisSelection,"activeLabel","View map analysis"] call ALIVE_fnc_hashSet;
        [_mapAnalysisSelection,"iconState",["Analysis",0,0]] call ALIVE_fnc_hashSet;

        _objectivesSelection = [] call ALIVE_fnc_hashCreate;

        [_objectivesSelection,"icon","x\alive\addons\sys_tour\data\alive_icons_tour_mil_placement.paa"] call ALIVE_fnc_hashSet;
        [_objectivesSelection,"inactiveLabel","Objective Analysis"] call ALIVE_fnc_hashSet;
        [_objectivesSelection,"activeLabel","View objective analysis"] call ALIVE_fnc_hashSet;
        [_objectivesSelection,"iconState",["Objective",0,0]] call ALIVE_fnc_hashSet;

        _battlefieldSelection = [] call ALIVE_fnc_hashCreate;

        [_battlefieldSelection,"icon","x\alive\addons\sys_tour\data\alive_icons_tour_cas.paa"] call ALIVE_fnc_hashSet;
        [_battlefieldSelection,"inactiveLabel","Battlefield Analysis"] call ALIVE_fnc_hashSet;
        [_battlefieldSelection,"activeLabel","View battlefield analysis"] call ALIVE_fnc_hashSet;
        [_battlefieldSelection,"iconState",["Battlefield",0,0]] call ALIVE_fnc_hashSet;

        _profileSelection = [] call ALIVE_fnc_hashCreate;

        [_profileSelection,"icon","x\alive\addons\sys_tour\data\alive_icons_tour_profiles.paa"] call ALIVE_fnc_hashSet;
        [_profileSelection,"inactiveLabel","Profile System"] call ALIVE_fnc_hashSet;
        [_profileSelection,"activeLabel","Details about the profile system"] call ALIVE_fnc_hashSet;
        [_profileSelection,"iconState",["Profiles",0,0]] call ALIVE_fnc_hashSet;

        _opcomSelection = [] call ALIVE_fnc_hashCreate;

        [_opcomSelection,"icon","x\alive\addons\sys_tour\data\alive_icons_tour_opcom.paa"] call ALIVE_fnc_hashSet;
        [_opcomSelection,"inactiveLabel","OPCOM"] call ALIVE_fnc_hashSet;
        [_opcomSelection,"activeLabel","The operation commanders"] call ALIVE_fnc_hashSet;
        [_opcomSelection,"iconState",["Opcom",0,0]] call ALIVE_fnc_hashSet;

        _dataSelection = [] call ALIVE_fnc_hashCreate;

        [_dataSelection,"icon","x\alive\addons\sys_tour\data\alive_icons_tour_data.paa"] call ALIVE_fnc_hashSet;
        [_dataSelection,"inactiveLabel","Persistence"] call ALIVE_fnc_hashSet;
        [_dataSelection,"activeLabel","The central persistence database"] call ALIVE_fnc_hashSet;
        [_dataSelection,"iconState",["Data",0,0]] call ALIVE_fnc_hashSet;

        _warroomSelection = [] call ALIVE_fnc_hashCreate;

        [_warroomSelection,"icon","x\alive\addons\sys_tour\data\alive_icons_tour_task.paa"] call ALIVE_fnc_hashSet;
        [_warroomSelection,"inactiveLabel","WarRoom"] call ALIVE_fnc_hashSet;
        [_warroomSelection,"activeLabel","The WarRoom web system"] call ALIVE_fnc_hashSet;
        [_warroomSelection,"iconState",["Warroom",0,0]] call ALIVE_fnc_hashSet;

        _backSelection = [] call ALIVE_fnc_hashCreate;

        [_backSelection,"icon","x\alive\addons\sys_tour\data\alive_icons_tour_back.paa"] call ALIVE_fnc_hashSet;
        [_backSelection,"inactiveLabel","Go Back"] call ALIVE_fnc_hashSet;
        [_backSelection,"activeLabel","Go back to the previous menu"] call ALIVE_fnc_hashSet;
        [_backSelection,"iconState",["Back",0,0]] call ALIVE_fnc_hashSet;

        [_selectionOptions,"Technology",[_mapAnalysisSelection,_objectivesSelection,_battlefieldSelection,_profileSelection,_opcomSelection,_dataSelection,_warroomSelection,_backSelection]] call ALIVE_fnc_hashSet;

        // module selections

        private["_opcomSelection","_placementSelection","_logisticsSelection","_cqbSelection","_civilianSelection","_supportSelection","_resupplySelection","_c2Selection"];

        _opcomSelection = [] call ALIVE_fnc_hashCreate;

        [_opcomSelection,"icon","x\alive\addons\sys_tour\data\alive_icons_tour_opcom.paa"] call ALIVE_fnc_hashSet;
        [_opcomSelection,"inactiveLabel","OPCOM"] call ALIVE_fnc_hashSet;
        [_opcomSelection,"activeLabel","The OPCOM module"] call ALIVE_fnc_hashSet;
        [_opcomSelection,"iconState",["ModuleOPCOM",0,0]] call ALIVE_fnc_hashSet;

        _placementSelection = [] call ALIVE_fnc_hashCreate;

        [_placementSelection,"icon","x\alive\addons\sys_tour\data\alive_icons_tour_mil_placement.paa"] call ALIVE_fnc_hashSet;
        [_placementSelection,"inactiveLabel","Force Placement"] call ALIVE_fnc_hashSet;
        [_placementSelection,"activeLabel","The force placement modules"] call ALIVE_fnc_hashSet;
        [_placementSelection,"iconState",["ModulePlacement",0,0]] call ALIVE_fnc_hashSet;

        _logisticsSelection = [] call ALIVE_fnc_hashCreate;

        [_logisticsSelection,"icon","x\alive\addons\sys_tour\data\alive_icons_tour_logistics.paa"] call ALIVE_fnc_hashSet;
        [_logisticsSelection,"inactiveLabel","Logistics"] call ALIVE_fnc_hashSet;
        [_logisticsSelection,"activeLabel","The logistics module"] call ALIVE_fnc_hashSet;
        [_logisticsSelection,"iconState",["ModuleLogistics",0,0]] call ALIVE_fnc_hashSet;

        _cqbSelection = [] call ALIVE_fnc_hashCreate;

        [_cqbSelection,"icon","x\alive\addons\sys_tour\data\alive_icons_tour_cqb.paa"] call ALIVE_fnc_hashSet;
        [_cqbSelection,"inactiveLabel","Close Quarters Battle"] call ALIVE_fnc_hashSet;
        [_cqbSelection,"activeLabel","The close quarters battle module"] call ALIVE_fnc_hashSet;
        [_cqbSelection,"iconState",["ModuleCQB",0,0]] call ALIVE_fnc_hashSet;

        _civilianSelection = [] call ALIVE_fnc_hashCreate;

        [_civilianSelection,"icon","x\alive\addons\sys_tour\data\alive_icons_tour_civ.paa"] call ALIVE_fnc_hashSet;
        [_civilianSelection,"inactiveLabel","Civilian Population"] call ALIVE_fnc_hashSet;
        [_civilianSelection,"activeLabel","The civilian population module"] call ALIVE_fnc_hashSet;
        [_civilianSelection,"iconState",["ModuleCivilian",0,0]] call ALIVE_fnc_hashSet;

        _supportSelection = [] call ALIVE_fnc_hashCreate;

        [_supportSelection,"icon","x\alive\addons\sys_tour\data\alive_icons_tour_cs.paa"] call ALIVE_fnc_hashSet;
        [_supportSelection,"inactiveLabel","Combat Support"] call ALIVE_fnc_hashSet;
        [_supportSelection,"activeLabel","The combat support module"] call ALIVE_fnc_hashSet;
        [_supportSelection,"iconState",["ModuleCombatSupport",0,0]] call ALIVE_fnc_hashSet;

        _resupplySelection = [] call ALIVE_fnc_hashCreate;

        [_resupplySelection,"icon","x\alive\addons\sys_tour\data\alive_icons_tour_logistics.paa"] call ALIVE_fnc_hashSet;
        [_resupplySelection,"inactiveLabel","Player Resupply"] call ALIVE_fnc_hashSet;
        [_resupplySelection,"activeLabel","The player resupply module"] call ALIVE_fnc_hashSet;
        [_resupplySelection,"iconState",["ModuleResupply",0,0]] call ALIVE_fnc_hashSet;

        _c2Selection = [] call ALIVE_fnc_hashCreate;

        [_c2Selection,"icon","x\alive\addons\sys_tour\data\alive_icons_tour_intel.paa"] call ALIVE_fnc_hashSet;
        [_c2Selection,"inactiveLabel","C2ISTAR"] call ALIVE_fnc_hashSet;
        [_c2Selection,"activeLabel","The C2ISTAR module"] call ALIVE_fnc_hashSet;
        [_c2Selection,"iconState",["ModuleC2",0,0]] call ALIVE_fnc_hashSet;

        _backSelection = [] call ALIVE_fnc_hashCreate;

        [_backSelection,"icon","x\alive\addons\sys_tour\data\alive_icons_tour_back.paa"] call ALIVE_fnc_hashSet;
        [_backSelection,"inactiveLabel","Go Back"] call ALIVE_fnc_hashSet;
        [_backSelection,"activeLabel","Go back to the previous menu"] call ALIVE_fnc_hashSet;
        [_backSelection,"iconState",["Back",0,0]] call ALIVE_fnc_hashSet;


        [_selectionOptions,"Modules",[_opcomSelection,_placementSelection,_logisticsSelection,_cqbSelection,_civilianSelection,_supportSelection,_resupplySelection,_c2Selection,_backSelection]] call ALIVE_fnc_hashSet;

        // store all the selection options

        _logic setVariable ["selectionOptions", _selectionOptions];

	};

	case "resetSelectionState": {

	    private["_selectionOptions","_iconState"];

	    _selectionOptions = _logic getVariable "selectionOptions";

	    _selectionOptions call ALIVE_fnc_inspectHash;

	    {
            {
                _iconState = _x select 2 select 3;
                _iconState set [1,0];
                _iconState set [2,0];
            } forEach _x;
	    } forEach (_selectionOptions select 2);

	    _selectionOptions call ALIVE_fnc_inspectHash;

	};

	case "start": {

        if(isServer) then {

            // start listening for events
            [_logic,"listen"] call MAINCLASS;

            player setCaptive true;

            // display loading
            [_logic,"displayStartLoadingScreen"] call MAINCLASS;

            // setup placement
            [_logic,"setRandomPlacement"] call MAINCLASS;

            // create initial interactive icons
            [_logic,"displaySelectionState"] call MAINCLASS;

            // set module as startup complete
            _logic setVariable ["startupComplete", true];

        };

    };

    case "displayStartLoadingScreen": {

        private["_line1","_line2","_line3","_line4","_text"];

        call BIS_fnc_VRFadeIn;

        _line1 = "<t size='1.5' color='#68a7b7' align='center'>Welcome to the ALiVE Tour</t><br/><br/>";
        _line2 = "<t size='1' align='center'>Discover the technology, modules, and usage of ALiVE.</t><br/>";
        _line3 = "<t size='1' align='center'>Information topics will be created around your player.</t><br/>";
        _line4 = "<t size='1' align='center'>Walk towards a topic you wish to learn more about.</t><br/><br/>";

        _text = format["%1%2%3%4",_line1,_line2,_line3,_line4];

        ["openSplash",0.3] call ALIVE_fnc_displayMenu;
        ["setSplashText",_text] call ALIVE_fnc_displayMenu;

    };

    case "setRandomPlacement": {

        private["_sides","_side","_locationTypes","_locationType","_initialPosition","_position","_emptyPosition"];

        waitUntil {!(isNil "ALIVE_REQUIRE_INITIALISED")};
        waitUntil {ALIVE_REQUIRE_INITIALISED};

        _sides = ["EAST","WEST"];
        _side = _sides call BIS_fnc_selectRandom;
        _locationTypes = ["Short","Medium","Long"];
        _locationType = _locationTypes call BIS_fnc_selectRandom;

        _initialPosition = position _logic;

        _position = [_initialPosition,_locationType,_side] call ALIVE_fnc_taskGetSideCluster;

        if(count _position == 0) then {
            _position = [_initialPosition,_locationType,_side] call ALIVE_fnc_taskGetSideSectorCompositionPosition;
        };

        if(count _position > 0) then {
            _position = [_position,"overwatch"] call ALIVE_fnc_taskGetSectorPosition;
        }else{
            _position = _initialPosition;
        };

        _emptyPosition = _position findEmptyPosition [10,1000];

        if(count _emptyPosition > 0) then {
            if!(surfaceIsWater _emptyPosition) then {
                player setPos _emptyPosition;
            };
        }else{
            if!(surfaceIsWater _position) then {
                player setPos _position;
            };
        };

    };

    case "displaySelectionState": {

        // set some defaults

        ALIVE_tourActiveColour = [1,1,1,1];
        ALIVE_tourInActiveColour = [1,1,1,1];


        // get the current selections

        private["_currentSelectionState","_selectionOptions","_countSelections"];

        _currentSelectionState = _logic getVariable "selectionState";
        _selectionOptions = _logic getVariable "selectionOptions";

        ALIVE_tourCurrentSelectionValues = [_selectionOptions,_currentSelectionState] call ALIVE_fnc_hashGet;

        _countSelections = count ALIVE_tourCurrentSelectionValues;


        // define the positions for the selection icons

        private["_offset","_rad","_degStep","_position","_eventID"];

        _offset = 15;
        _rad = (_offset * _countSelections) / (2 * pi);
        _degStep = 360 / _countSelections;

        ALIVE_tourIconPositions = [];

        {
            _position = [getPos player, _rad, _degStep * _forEachIndex] call BIS_fnc_relPos;
            _position set [2, (100) + (_forEachIndex * 10)];

            ALIVE_tourIconPositions set [count ALIVE_tourIconPositions, _position];

        } foreach ALIVE_tourCurrentSelectionValues;


        // run the draw icon 3D routine for the selections

        _eventID = addMissionEventHandler ["Draw3D", {
            {
                private ["_selectionOption","_icon","_inactiveLabel","_activeLabel","_iconState","_iconActive","_iconDistance",
                "_iconID","_iconActiveTime","_position","_distance","_size","_active","_label","_colour","_soundSource"];

                _selectionOption = _x;

                _icon = _selectionOption select 2 select 0;
                _inactiveLabel = _selectionOption select 2 select 1;
                _activeLabel = _selectionOption select 2 select 2;
                _iconState = _selectionOption select 2 select 3;

                _iconID = _iconState select 0;
                _iconDistance = _iconState select 1;
                _iconActiveTime = _iconState select 2;

                _position = ALIVE_tourIconPositions select _forEachIndex;

                _distance = (getPos player) distance _position;

                _colour = ALIVE_tourInActiveColour;
                _size = 2.5;
                _label = _inactiveLabel;

                if(_distance > 6) then {
                    _size = 2.5;
                    _colour = ALIVE_tourInActiveColour;
                    _label = _inactiveLabel;
                    _iconActiveTime = 0;

                    if(_position select 2 > 2) then {
                        _position set [2, (_position select 2) - 1];
                        ALIVE_tourIconPositions set [_forEachIndex,_position];
                    };

                    if(_position select 2 == 3) then {
                        _soundSource = "RoadCone_L_F" createVehicle _position;
                        hideObjectGlobal _soundSource;
                        _soundSource say3d "FD_Finish_F";
                    };
                }else{
                    _size = 2.5 + (24 - (_distance * 4));

                    if(_distance < 6) then {
                        _label = _activeLabel;
                        _colour = ALIVE_tourActiveColour;

                        if(_iconDistance >= _distance) then {
                            _iconActiveTime = _iconActiveTime + 1;
                        }else{
                            if(_iconActiveTime > 0) then {
                                _iconActiveTime = _iconActiveTime - 1;
                            };
                        };

                        if(_iconActiveTime > 130) then {

                            _soundSource = "RoadCone_L_F" createVehicle _position;
                            hideObjectGlobal _soundSource;
                            _soundSource say3d "FD_CP_Not_Clear_F";

                            [ALIVE_tourInstance,"handleIconActivated",_iconID] call ALIVE_fnc_tour;
                        };

                    }else{
                        if(_distance > 6) then {
                            _label = _inactiveLabel;
                            _colour = ALIVE_tourInActiveColour;
                        };
                    };
                };

                _iconState set [1,_distance];
                _iconState set [2,_iconActiveTime];

                drawIcon3D [_icon,_colour,_position,_size,_size,0,_label,1,0.06];

            } foreach ALIVE_tourCurrentSelectionValues;
        }];

        _logic setVariable ["drawEventID", _eventID];

    };

    case "handleIconActivated": {

        private["_eventID","_currentSelectionState"];

        [_logic,"resetSelectionState"] call MAINCLASS;

        _eventID = _logic getVariable "drawEventID";

        removeMissionEventHandler ["Draw3D",_eventID];

        _currentSelectionState = _logic getVariable "selectionState";

        if(_currentSelectionState == "start") then {

            _logic setVariable ["selectionState",_args];

            [_logic,"displaySelectionState"] call MAINCLASS;

        }else{

            [_logic,format["activateSelection%1",_args]] call MAINCLASS;

        };
    };

    case "activateSelectionBack": {
        _logic setVariable ["selectionState","start"];
        [_logic,"displaySelectionState"] call MAINCLASS;
    };

    case "handleMenuCallback": {

        private["_action","_id"];

        ["HANDLE MENU CALLBACK: %1",_args] call ALIVE_fnc_dump;

        _action = _args select 0;
        _id = _args select 1;

        switch(_action) do {
            case "close": {

                [_logic,"resetSelectionState"] call MAINCLASS;

                [_logic,format["deactivateSelection%1",_id]] call MAINCLASS;
            };
        };

    };

    case "activateSelectionAnalysis": {

        ALIVE_tourActiveScript = [_logic] spawn {

            private["_logic"];

            _logic = _this select 0;

            private["_line1","_line2","_line3","_line4","_baseCopy"];

            _line1 = "<br/><t size='1.5' color='#68a7b7' >Map Analysis</t><br/><br/>";
            _line2 = "<t size='1'>ALiVE needs to make many decisions about the environment in which it operates. To make informed decisions, as detailed a view of the world as possible is required.</t><br/><br/>";
            _line3 = "<t size='1'>To facilitate this ALiVE uses a series of analysis and calculation functions to store, evaluate and retrieve information about the current map.</t><br/><br/>";
            _line4 = "<t size='1'>These demonstrations display some of the analytic powers of ALiVE plotted on the world map.</t><br/><br/>";

            _baseCopy = format["%1%2%3%4",_line1,_line2,_line3,_line4];

            ["openMapFull",[_logic,"handleMenuCallback","Analysis"]] call ALIVE_fnc_displayMenu;
            ["setFullMapText",_baseCopy] call ALIVE_fnc_displayMenu;

            private["_mapSize","_mapCenter"];

            _mapSize = [] call ALIVE_fnc_getMapBounds;
            _mapCenter = [(_mapSize/2),(_mapSize/2)];
            ["setFullMapAnimation",[0.5,0.7,_mapCenter]] call ALIVE_fnc_displayMenu;


            private["_allSectors","_landSectors","_playerSector","_surroundingSectors","_highSectors","_playerSectorData","_playerSectorCenterPosition"];

            _allSectors = [ALIVE_sectorGrid, "sectors"] call ALIVE_fnc_sectorGrid;
            _landSectors = [_allSectors, "SEA"] call ALIVE_fnc_sectorFilterTerrain;
            _playerSector = [ALIVE_sectorGrid, "positionToSector", getPos player] call ALIVE_fnc_sectorGrid;
            _playerSectorData = [_playerSector, "data"] call ALIVE_fnc_hashGet;
            _playerSectorCenterPosition = [_playerSector, "center"] call ALIVE_fnc_sector;
            _surroundingSectors = [ALIVE_sectorGrid, "surroundingSectors", getPos player] call ALIVE_fnc_sectorGrid;

            private ["_createMarker"];

            _createMarker = {
                private ["_markerID","_position","_dimensions","_alpha","_color","_shape","_m"];

                _markerID = _this select 0;
                _position = _this select 1;
                _dimensions = _this select 2;
                _color = _this select 3;

                _m = createMarkerLocal [_markerID, _position];
                _m setMarkerShapeLocal "ICON";
                _m setMarkerSizeLocal _dimensions;
                _m setMarkerTypeLocal "mil_dot";
                _m setMarkerColorLocal _color;
                _m setMarkerTextLocal _markerID;
                _m
            };


            [ALIVE_sectorPlotter, "plot", [_allSectors, "elevation"]] call ALIVE_fnc_plotSectors;

            private["_line","_currentCopy"];

            _line = "<t size='1'>Current analysis: sector elevation</t><br/><br/>";
            _currentCopy = format["%1%2",_baseCopy,_line];
            ["setFullMapText",_currentCopy] call ALIVE_fnc_displayMenu;

            sleep 20;

            [ALIVE_sectorPlotter, "clear"] call ALIVE_fnc_plotSectors;



            private["_highSectors","_sortedHighSectors"];

            _highSectors = [_landSectors, 100, 200] call ALIVE_fnc_sectorFilterElevation;
            _sortedHighSectors = [_highSectors, getPos player] call ALIVE_fnc_sectorSortDistance;

            [ALIVE_sectorPlotter, "plot", [_sortedHighSectors, "elevation"]] call ALIVE_fnc_plotSectors;

            _line = "<t size='1'>Current analysis: highest elevation sectors</t><br/><br/>";
            _currentCopy = format["%1%2",_baseCopy,_line];
            ["setFullMapText",_currentCopy] call ALIVE_fnc_displayMenu;

            sleep 20;

            [ALIVE_sectorPlotter, "clear"] call ALIVE_fnc_plotSectors;



            [ALIVE_sectorPlotter, "plot", [_allSectors, "terrain"]] call ALIVE_fnc_plotSectors;

            _line = "<t size='1'>Current analysis: sector terrain types (land,shore,sea)</t><br/><br/>";
            _currentCopy = format["%1%2",_baseCopy,_line];
            ["setFullMapText",_currentCopy] call ALIVE_fnc_displayMenu;

            sleep 20;



            ["setFullMapAnimation",[0.5,0.2,_playerSectorCenterPosition]] call ALIVE_fnc_displayMenu;


            [ALIVE_sectorPlotter, "clear"] call ALIVE_fnc_plotSectors;
            [ALIVE_sectorPlotter, "plot", [[_playerSector], "terrainSamples"]] call ALIVE_fnc_plotSectors;

            _line = "<t size='1'>Current analysis: in sector terrain type sampling</t><br/><br/>";
            _currentCopy = format["%1%2",_baseCopy,_line];
            ["setFullMapText",_currentCopy] call ALIVE_fnc_displayMenu;

            sleep 10;

            [ALIVE_sectorPlotter, "clear"] call ALIVE_fnc_plotSectors;


            private["_sortedElevationData","_lowestElevationInSector","_highestElevationInSector","_m","_m1","_m2","_m3"];

            _sortedElevationData = [_playerSectorData, "elevationLand", []] call ALIVE_fnc_sectorDataSort;

            if(count _sortedElevationData > 0) then {
                _lowestElevationInSector = _sortedElevationData select 0;
                _m1 = ["Lowest Elevation",(_lowestElevationInSector select 0),[1,1],"ColorGreen"] call _createMarker;

                _highestElevationInSector = _sortedElevationData select count(_sortedElevationData)-1;
                _m2 = ["Highest Elevation",(_highestElevationInSector select 0),[1,1],"ColorRed"] call _createMarker;

                _line = "<t size='1'>Current analysis: lowest and highest points in sector</t><br/><br/>";
                _currentCopy = format["%1%2",_baseCopy,_line];
                ["setFullMapText",_currentCopy] call ALIVE_fnc_displayMenu;

                sleep 10;
                deleteMarkerLocal _m1;
                deleteMarkerLocal _m2;
            };

            private["_sortedShorePositions","_nearestShorePosition"];

            _sortedShorePositions = [_playerSectorData, "terrain", [getPos player,"shore"]] call ALIVE_fnc_sectorDataSort;

            if(count _sortedShorePositions > 0) then {
            	_nearestShorePosition = _sortedShorePositions select 0;
            	_m2 = ["Nearest Shore",_nearestShorePosition,[1,1],"ColorKhaki"] call _createMarker;

            	_line = "<t size='1'>Current analysis: nearest shore position</t><br/><br/>";
                _currentCopy = format["%1%2",_baseCopy,_line];
                ["setFullMapText",_currentCopy] call ALIVE_fnc_displayMenu;

            	sleep 10;
            	deleteMarkerLocal _m2;
            };

            private["_sortedSeaPositions","_nearestSeaPosition"];

            _sortedSeaPositions = [_playerSectorData, "terrain", [getPos player,"sea"]] call ALIVE_fnc_sectorDataSort;

            if(count _sortedSeaPositions > 0) then {
            	_nearestSeaPosition = _sortedSeaPositions select 0;
            	_m3 = ["Nearest Sea",_nearestSeaPosition,[1,1],"ColorBlue"] call _createMarker;

            	_line = "<t size='1'>Current analysis: nearest sea position</t><br/><br/>";
                _currentCopy = format["%1%2",_baseCopy,_line];
                ["setFullMapText",_currentCopy] call ALIVE_fnc_displayMenu;

            	sleep 10;
            	deleteMarkerLocal _m3;
            };


            [ALIVE_sectorPlotter, "plot", [[_playerSector], "bestPlaces"]] call ALIVE_fnc_plotSectors;

            _line = "<t size='1'>Current analysis: environment types</t><br/><br/>";
            _currentCopy = format["%1%2",_baseCopy,_line];
            ["setFullMapText",_currentCopy] call ALIVE_fnc_displayMenu;

            sleep 10;

            [ALIVE_sectorPlotter, "clear"] call ALIVE_fnc_plotSectors;

            private["_sortedForestPositions","_nearestForestPosition"];

            _sortedForestPositions = [_playerSectorData, "bestPlaces", [getPos player,"forest"]] call ALIVE_fnc_sectorDataSort;

            if(count _sortedForestPositions > 0) then {
                _nearestForestPosition = _sortedForestPositions select 0;
                _m1 = ["Nearest Forest",_nearestForestPosition,[1,1],"ColorGreen"] call _createMarker;

                _line = "<t size='1'>Current analysis: nearest vegetation</t><br/><br/>";
                _currentCopy = format["%1%2",_baseCopy,_line];
                ["setFullMapText",_currentCopy] call ALIVE_fnc_displayMenu;

                sleep 10;
                deleteMarkerLocal _m1;
            };

            private["_sortedHillPositions","_nearestHillPosition"];

            _sortedHillPositions = [_playerSectorData, "bestPlaces", [getPos player,"exposedHills"]] call ALIVE_fnc_sectorDataSort;

            if(count _sortedHillPositions > 0) then {
            	_nearestHillPosition = _sortedHillPositions select 0;
            	_m3 = ["Nearest Exposed Hill",_nearestHillPosition,[1,1],"ColorOrange"] call _createMarker;

            	_line = "<t size='1'>Current analysis: nearest exposed hill</t><br/><br/>";
                _currentCopy = format["%1%2",_baseCopy,_line];
                ["setFullMapText",_currentCopy] call ALIVE_fnc_displayMenu;

            	sleep 10;
            	deleteMarkerLocal _m3;
            };


            [ALIVE_sectorPlotter, "plot", [[_playerSector], "flatEmpty"]] call ALIVE_fnc_plotSectors;

            _line = "<t size='1'>Current analysis: empty spaces</t><br/><br/>";
            _currentCopy = format["%1%2",_baseCopy,_line];
            ["setFullMapText",_currentCopy] call ALIVE_fnc_displayMenu;

            sleep 10;

            [ALIVE_sectorPlotter, "clear"] call ALIVE_fnc_plotSectors;

            private["_sortedFlatEmptyPositions","_nearestFlatEmptyPosition"];

            _sortedFlatEmptyPositions = [_playerSectorData, "flatEmpty", [getPos player]] call ALIVE_fnc_sectorDataSort;

            if(count _sortedFlatEmptyPositions > 0) then {
            	_nearestFlatEmptyPosition = _sortedFlatEmptyPositions select 0;
            	_m = ["Nearest Flat Empty",_nearestFlatEmptyPosition,[1,1],"ColorRed"] call _createMarker;

            	_line = "<t size='1'>Current analysis: nearest empty space</t><br/><br/>";
                _currentCopy = format["%1%2",_baseCopy,_line];
                ["setFullMapText",_currentCopy] call ALIVE_fnc_displayMenu;

            	sleep 10;
                deleteMarkerLocal _m;
            };


            [ALIVE_sectorPlotter, "plot", [[_playerSector], "roads"]] call ALIVE_fnc_plotSectors;

            _line = "<t size='1'>Current analysis: roads</t><br/><br/>";
            _currentCopy = format["%1%2",_baseCopy,_line];
            ["setFullMapText",_currentCopy] call ALIVE_fnc_displayMenu;

            sleep 10;

            [ALIVE_sectorPlotter, "clear"] call ALIVE_fnc_plotSectors;

            private["_sortedRoadPositions","_nearestRoadPosition"];

            _sortedRoadPositions = [_playerSectorData, "roads", [getPos player, "road"]] call ALIVE_fnc_sectorDataSort;

            if(count _sortedRoadPositions > 0) then {
            	_nearestRoadPosition = _sortedRoadPositions select 0;
            	_m = ["Nearest Road",(_nearestRoadPosition select 0),[1,1],"ColorGreen"] call _createMarker;

            	_line = "<t size='1'>Current analysis: nearest road</t><br/><br/>";
                _currentCopy = format["%1%2",_baseCopy,_line];
                ["setFullMapText",_currentCopy] call ALIVE_fnc_displayMenu;

            	sleep 10;
            	deleteMarkerLocal _m;
            };

            private["_sortedCrossroadPositions","_nearestCrossroadPosition"];

            _sortedCrossroadPositions = [_playerSectorData, "roads", [getPos player, "crossroad"]] call ALIVE_fnc_sectorDataSort;

            if(count _sortedCrossroadPositions > 0) then {
            	_nearestCrossroadPosition = _sortedCrossroadPositions select 0;
            	_m = ["Nearest Crossroad",(_nearestCrossroadPosition select 0),[1,1],"ColorOrange"] call _createMarker;

            	_line = "<t size='1'>Current analysis: nearest crossroad</t><br/><br/>";
                _currentCopy = format["%1%2",_baseCopy,_line];
                ["setFullMapText",_currentCopy] call ALIVE_fnc_displayMenu;

            	sleep 10;
            	deleteMarkerLocal _m;
            };

            private["_sortedTerminusPositions","_nearestTerminusPosition"];

            _sortedTerminusPositions = [_playerSectorData, "roads", [getPos player, "terminus"]] call ALIVE_fnc_sectorDataSort;

            if(count _sortedTerminusPositions > 0) then {
            	_nearestTerminusPosition = _sortedTerminusPositions select 0;
            	_m = ["Nearest Terminus",(_nearestTerminusPosition select 0),[1,1],"ColorRed"] call _createMarker;

            	_line = "<t size='1'>Current analysis: nearest road terminus</t><br/><br/>";
                _currentCopy = format["%1%2",_baseCopy,_line];
                ["setFullMapText",_currentCopy] call ALIVE_fnc_displayMenu;

            	sleep 10;
            	deleteMarkerLocal _m;
            };

            [ALIVE_sectorPlotter, "clear"] call ALIVE_fnc_plotSectors;


            _line = "<t size='1'>Demonstration complete</t><br/><br/>";
            _currentCopy = format["%1%2",_baseCopy,_line];
            ["setFullMapText",_currentCopy] call ALIVE_fnc_displayMenu;

        };

    };

    case "deactivateSelectionAnalysis": {

        if!(isNil "ALIVE_tourActiveScript") then {
            if!(scriptDone ALIVE_tourActiveScript) then {
                terminate ALIVE_tourActiveScript;
            };
        };

        [ALIVE_sectorPlotter, "clear"] call ALIVE_fnc_plotSectors;

        _logic setVariable ["selectionState","Technology"];

        [_logic,"displaySelectionState"] call MAINCLASS;

    };

    case "activateSelectionProfiles": {

        ALIVE_tourActiveScript = [_logic] spawn {

            private["_logic"];

            _logic = _this select 0;

            private["_line1","_line2","_line3","_line4","_line5","_line6","_line7","_baseCopy"];

            _line1 = "<br/><t size='1.5' color='#68a7b7' >Profile System</t><br/><br/>";
            _line2 = "<t size='1'>To enable truly whole map operations, the ALiVE development team have developed a group and vehicle profiling system that stores the complete state of in game AI objects.</t><br/><br/>";
            _line3 = "<t size='1'>These objects can then be spawned or despawned depending on distance to players. This system goes beyond previous unit caching systems, to store a representantive data structure describing units.</t><br/><br/>";
            _line4 = "<t size='1'>Caching for performance is one obvious benefit of the profile system, another is simulation of the virtualised profiles.</t><br/><br/>";
            _line5 = "<t size='1'>The map is now displaying the profile system at work, full opacity markers denote spawned real groups and vehicles. Transparent markers display virtualised, and simulated units.</t><br/><br/>";
            _line6 = "<t size='1'>Virtual waypoints are display using x markers, the profile system seamlessly translates virtual waypoints to in game waypoints when profiles are spawned and despawned.</t><br/><br/>";
            _line7 = "<t size='1'>Another benefit to the profile system is that it provides a convienient format for saving the state of the game using the ALiVE persistent central database.</t><br/><br/>";

            _baseCopy = format["%1%2%3%4%5%6%7",_line1,_line2,_line3,_line4,_line5,_line6,_line7];

            ["openMapFull",[_logic,"handleMenuCallback","Profiles"]] call ALIVE_fnc_displayMenu;
            ["setFullMapText",_baseCopy] call ALIVE_fnc_displayMenu;

            private["_mapSize","_mapCenter"];

            _mapSize = [] call ALIVE_fnc_getMapBounds;
            _mapCenter = [(_mapSize/2),(_mapSize/2)];
            ["setFullMapAnimation",[0.5,0.7,_mapCenter]] call ALIVE_fnc_displayMenu;

            [ALIVE_profileHandler, "debug", true] call ALIVE_fnc_profileHandler;

        };

    };

    case "deactivateSelectionProfiles": {

        if!(isNil "ALIVE_tourActiveScript") then {
            if!(scriptDone ALIVE_tourActiveScript) then {
                terminate ALIVE_tourActiveScript;
            };
        };

        [ALIVE_profileHandler, "debug", false] call ALIVE_fnc_profileHandler;

        _logic setVariable ["selectionState","Technology"];

        [_logic,"displaySelectionState"] call MAINCLASS;

    };

    case "activateSelectionOpcom": {

        ALIVE_tourActiveScript = [_logic] spawn {

            private["_logic"];

            _logic = _this select 0;

            private["_line1","_line2","_line3","_line4","_line5","_line6","_line7","_baseCopy"];

            _line1 = "<br/><t size='1.5' color='#68a7b7' >OPCOM</t><br/><br/>";
            _line2 = "<t size='1'>The AI Operation Commanders (OPCOM) are intelligent battlefield commanders that controls an entire sides strategy, tactics, and logistics.</t><br/><br/>";
            _line3 = "<t size='1'>OPCOM prioritises a list of objectives and then plans and executes missions with available units. Op Commanders will react to the changing environment and attack, defend, withdraw or resupply depending on the current tactical situation. OPCOM continues to work with profiled groups, controlling a virtual battlefield out of visual range of players.</t><br/><br/>";
            _line4 = "<t size='1'>OPCOM consists of two core elements: Operational Command (OPCOM) and Tactical Command (TACOM). OPCOM takes the objectives of any synced Military or Civilian Placement modules and prioritises them depending on the user defined variables. It also regularly analyses the map, relative troop strengths and available assets required to capture and hold objectives in its area of operations. OPCOM gives missions to TACOM, which in turn executes the tactical level orders to units and reports back its state once that mission is complete.</t><br/><br/>";
            _line5 = "<t size='1'>OPCOM is a Virtual AI Commander, as it controls only profiled groups. TACOM is a low level tactical commander that deals with Visual AI groups when players are nearby. This means it is possible to transfer the status of groups and objectives seamlessly between the Visual (spawned) Layer and the Virtual (unspawned or cached) Layer. This allows huge ongoing virtual battles, from offensive operations with blazing battlefronts to insurgency deployments with a high degree of realism and minimal impact on performance.</t><br/><br/>";

            _baseCopy = format["%1%2%3%4%5%6%7",_line1,_line2,_line3,_line4,_line5];

            ["openMapFull",[_logic,"handleMenuCallback","Opcom"]] call ALIVE_fnc_displayMenu;
            ["setFullMapText",_baseCopy] call ALIVE_fnc_displayMenu;

            private["_mapSize","_mapCenter"];

            _mapSize = [] call ALIVE_fnc_getMapBounds;
            _mapCenter = [(_mapSize/2),(_mapSize/2)];
            ["setFullMapAnimation",[0.5,0.7,_mapCenter]] call ALIVE_fnc_displayMenu;

            private["_moduleType","_handler","_objectives","_side","_sideDisplay","_line","_currentCopy","_profiles","_markers"];

            {
                _moduleType = _x getVariable "moduleType";
                if!(isNil "_moduleType") then {

                    if(_moduleType == "ALIVE_OPCOM") then {

                        _handler = _x getVariable "handler";
                        _objectives = [_handler,"objectives"] call ALIVE_fnc_hashGet;
                        _side = [_handler,"side"] call ALIVE_fnc_hashGet;
                        _sideDisplay = [_side] call ALIVE_fnc_sideTextToLong;

                        if!(isNil "_profiles") then {
                            {
                                _profileID = _x;
                                _profile = [ALIVE_profileHandler, "getProfile", _profileID] call ALIVE_fnc_profileHandler;
                                if !(isnil "_profile") then {
                                    [_profile, "deleteMarker"] call ALIVE_fnc_profileEntity;
                                };
                            } forEach _profiles;

                            {
                                deleteMarker _x;
                            } forEach _markers;
                        };

                        sleep 1;

                        _line = format["<t size='1'>Currently viewing OPCOM strategic view for %1</t><br/><br/>",_sideDisplay];
                        _currentCopy = format["%1%2",_baseCopy,_line];
                        ["setFullMapText",_currentCopy] call ALIVE_fnc_displayMenu;

                        private ["_center","_size","_priority","_type","_state","_section","_objectiveID",
                        "_profileID","_profile","_alpha","_marker","_color","_dir","_position","_icon","_text","_m"];

                        _color = "ColorYellow";

                        // set the side color
                        switch(_side) do {
                            case "EAST":{
                                _color = "ColorRed";
                            };
                            case "WEST":{
                                _color = "ColorBlue";
                            };
                            case "CIV":{
                                _color = "ColorYellow";
                            };
                            case "GUER":{
                                _color = "ColorGreen";
                            };
                            default {
                                _color = "ColorYellow";
                            };
                        };

                        _profiles = [];
                        _markers = [];

                        {
                            _center = [_x,"center"] call ALIVE_fnc_hashGet;
                            _size = [_x,"size"] call ALIVE_fnc_hashGet;
                            _priority = [_x,"priority"] call ALIVE_fnc_hashGet;
                            _type = [_x,"type"] call ALIVE_fnc_hashGet;
                            _state = [_x,"tacom_state"] call ALIVE_fnc_hashGet;
                            _section = [_x,"section"] call ALIVE_fnc_hashGet;
                            _objectiveID = [_x,"objectiveID"] call ALIVE_fnc_hashGet;

                            _alpha = 1;

                            if!(isNil "_section") then {

                                // create the profile marker
                                {
                                    _profileID = _x;
                                    _profile = [ALIVE_profileHandler, "getProfile", _profileID] call ALIVE_fnc_profileHandler;
                                    if !(isnil "_profile") then {
                                        _position = _profile select 2 select 2;

                                        if!(surfaceIsWater _position) then {
                                            _m = [_profile, "createMarker", [_alpha]] call ALIVE_fnc_profileEntity;
                                            _markers = _markers + _m;
                                            _profiles set [count _profiles, _profileID];
                                        };

                                        _dir = [_position, _center] call BIS_fnc_dirTo;
                                    };
                                } forEach _section;
                            };


                            // create the objective area marker
                            _m = createMarker [format[MTEMPLATE, _objectiveID], _center];
                            _m setMarkerShape "Ellipse";
                            _m setMarkerBrush "FDiagonal";
                            _m setMarkerSize [_size, _size];
                            _m setMarkerColor _color;
                            _m setMarkerAlpha _alpha;

                            _markers = _markers + [_m];

                            _icon = "EMPTY";
                            _text = "";

                            if!(isNil "_state") then {
                                switch(_state) do {
                                    case "reserve":{
                                        _icon = "mil_marker";
                                        _text = " occupied";
                                    };
                                    case "defend":{
                                        _icon = "mil_marker";
                                        _text = " occupied";
                                    };
                                    case "recon":{

                                        // create direction marker
                                        _m = createMarker [format[MTEMPLATE, format["%1_dir", _objectiveID]], [_position, 100, _dir] call BIS_fnc_relPos];
                                        _m setMarkerShape "ICON";
                                        _m setMarkerSize [0.5,0.5];
                                        _m setMarkerType "mil_arrow";
                                        _m setMarkerColor _color;
                                        _m setMarkerAlpha _alpha;
                                        _m setMarkerDir _dir;

                                        _markers = _markers + [_m];

                                        _icon = "EMPTY";
                                        _text = " sighting";
                                    };
                                    case "capture":{

                                        // create direction marker
                                        _m = createMarker [format[MTEMPLATE, format["%1_dir", _objectiveID]], [_position, 100, _dir] call BIS_fnc_relPos];
                                        _m setMarkerShape "ICON";
                                        _m setMarkerSize [0.5,0.5];
                                        _m setMarkerType "mil_arrow2";
                                        _m setMarkerColor _color;
                                        _m setMarkerAlpha _alpha;
                                        _m setMarkerDir _dir;

                                        _markers = _markers + [_m];

                                        _icon = "mil_warning";
                                        _text = " captured";
                                    };
                                };
                            };

                            // create type marker
                            _m = createMarker [format[MTEMPLATE, format["%1_type", _objectiveID]], _center];
                            _m setMarkerShape "ICON";
                            _m setMarkerSize [0.5, 0.5];
                            _m setMarkerType _icon;
                            _m setMarkerColor _color;
                            _m setMarkerAlpha _alpha;
                            _m setMarkerText _text;

                            _markers = _markers + [_m];

                        } forEach _objectives;

                        _logic setVariable ["opcomMarkers",_markers];
                        _logic setVariable ["opcomProfiles",_profiles];

                        sleep 20;
                    };
                }
            } forEach (entities "Module_F");


        };

    };

    case "deactivateSelectionOpcom": {

        private["_markers","_profiles","_profileID","_profile"];

        if!(isNil "ALIVE_tourActiveScript") then {
            if!(scriptDone ALIVE_tourActiveScript) then {
                terminate ALIVE_tourActiveScript;
            };
        };

        _markers = _logic getVariable "opcomMarkers";
        _profiles = _logic getVariable "opcomProfiles";

        {
            _profileID = _x;
            _profile = [ALIVE_profileHandler, "getProfile", _profileID] call ALIVE_fnc_profileHandler;
            if !(isnil "_profile") then {
                [_profile, "deleteMarker"] call ALIVE_fnc_profileEntity;
            };
        } forEach _profiles;

        {
            deleteMarker _x;
        } forEach _markers;

        _logic setVariable ["selectionState","Technology"];

        [_logic,"displaySelectionState"] call MAINCLASS;

    };

    case "activateSelectionObjective": {

        ALIVE_tourActiveScript = [_logic] spawn {

            private["_logic"];

            _logic = _this select 0;

            private["_line1","_line2","_line3","_line4","_line5","_line6","_line7","_baseCopy"];

            _line1 = "<br/><t size='1.5' color='#68a7b7' >Objective Analysis</t><br/><br/>";
            _line2 = "<t size='1'>To enable the AI Operational Commanders (OPCOM) to devise a battle plan they need to know what objectives exist on a given map, what priority the objectives are, and the type and composition of the objectives.</t><br/><br/>";
            _line3 = "<t size='1'>ALiVE uses an in depth indexing of ARMA maps to evaluate clusters of building objects to determine the size, priority and composition of map objectives.</t><br/><br/>";
            _line4 = "<t size='1'>In this demonstration is the display of various objective types in the current mission and map.</t><br/><br/>";

            _baseCopy = format["%1%2%3%4%5%6%7",_line1,_line2,_line3,_line4];

            ["openMapFull",[_logic,"handleMenuCallback","Objective"]] call ALIVE_fnc_displayMenu;
            ["setFullMapText",_baseCopy] call ALIVE_fnc_displayMenu;

            private["_mapSize","_mapCenter"];

            _mapSize = [] call ALIVE_fnc_getMapBounds;
            _mapCenter = [(_mapSize/2),(_mapSize/2)];
            ["setFullMapAnimation",[0.5,0.7,_mapCenter]] call ALIVE_fnc_displayMenu;

            private["_allSectors","_landSectors","_playerSector","_surroundingSectors","_highSectors","_playerSectorData","_playerSectorCenterPosition","_line","_currentCopy"];

            _allSectors = [ALIVE_sectorGrid, "sectors"] call ALIVE_fnc_sectorGrid;
            _landSectors = [_allSectors, "SEA"] call ALIVE_fnc_sectorFilterTerrain;
            _playerSector = [ALIVE_sectorGrid, "positionToSector", getPos player] call ALIVE_fnc_sectorGrid;
            _playerSectorData = [_playerSector, "data"] call ALIVE_fnc_hashGet;
            _playerSectorCenterPosition = [_playerSector, "center"] call ALIVE_fnc_sector;
            _surroundingSectors = [ALIVE_sectorGrid, "surroundingSectors", getPos player] call ALIVE_fnc_sectorGrid;


            [ALIVE_sectorPlotter, "plot", [_landSectors, "clustersMil"]] call ALIVE_fnc_plotSectors;

            _line1 = "<t size='1'>Displaying military objectives</t><br/><br/>";
            _line2 = "<t size='1'>Green: military infrastructure</t><br/>";
            _line3 = "<t size='1'>Blue: military air infrastructure</t><br/>";
            _line4 = "<t size='1'>Orange: military helicopter infrastructure</t><br/>";
            _currentCopy = format["%1%2%3%4%5",_baseCopy,_line1,_line2,_line3,_line4];
            ["setFullMapText",_currentCopy] call ALIVE_fnc_displayMenu;

            sleep 20;

            [ALIVE_sectorPlotter, "clear"] call ALIVE_fnc_plotSectors;


            [ALIVE_sectorPlotter, "plot", [_landSectors, "clustersCiv"]] call ALIVE_fnc_plotSectors;

            _line1 = "<t size='1'>Displaying civilian objectives</t><br/><br/>";
            _line2 = "<t size='1'>Black / Green: civilian settlements</t><br/>";
            _line3 = "<t size='1'>Yellow: civilian power infrastructure</t><br/>";
            _line4 = "<t size='1'>White: civilian communications infrastructure</t><br/>";
            _line5 = "<t size='1'>Blue: civilian marine infrastructure</t><br/>";
            _line6 = "<t size='1'>Orange: civilian fuel infrastructure</t><br/>";
            _currentCopy = format["%1%2%3%4%5%6%7",_baseCopy,_line1,_line2,_line3,_line4,_line5,_line6];
            ["setFullMapText",_currentCopy] call ALIVE_fnc_displayMenu;

            sleep 20;

            [ALIVE_sectorPlotter, "clear"] call ALIVE_fnc_plotSectors;

            _line = "<t size='1'>Demonstration complete</t><br/><br/>";
            _currentCopy = format["%1%2",_baseCopy,_line];
            ["setFullMapText",_currentCopy] call ALIVE_fnc_displayMenu;


        };

    };

    case "deactivateSelectionObjective": {

        if!(isNil "ALIVE_tourActiveScript") then {
            if!(scriptDone ALIVE_tourActiveScript) then {
                terminate ALIVE_tourActiveScript;
            };
        };

        [ALIVE_sectorPlotter, "clear"] call ALIVE_fnc_plotSectors;

        _logic setVariable ["selectionState","Technology"];

        [_logic,"displaySelectionState"] call MAINCLASS;

    };

    case "activateSelectionBattlefield": {

        ALIVE_tourActiveScript = [_logic] spawn {

            private["_logic"];

            _logic = _this select 0;

            private["_line1","_line2","_line3","_line4","_line5","_line6","_line7","_baseCopy"];

            _line1 = "<br/><t size='1.5' color='#68a7b7' >Battlefield Analysis</t><br/><br/>";
            _line2 = "<t size='1'>Current events on the battlefield are key information for OPCOM and other ALiVE systems, allowing real time adjustments to strategy and planning.</t><br/><br/>";
            _line3 = "<t size='1'>An event system connects the ALiVE modules to ensure that when something of interest occurs on the battlefield all interested systems can receive the information.</t><br/><br/>";
            _line4 = "<t size='1'>In this demonstration is displayed various on demand battlefield analysis routines.</t><br/><br/>";

            _baseCopy = format["%1%2%3%4%5%6%7",_line1,_line2,_line3,_line4];

            ["openMapFull",[_logic,"handleMenuCallback","Battlefield"]] call ALIVE_fnc_displayMenu;
            ["setFullMapText",_baseCopy] call ALIVE_fnc_displayMenu;

            private["_mapSize","_mapCenter"];

            _mapSize = [] call ALIVE_fnc_getMapBounds;
            _mapCenter = [(_mapSize/2),(_mapSize/2)];
            ["setFullMapAnimation",[0.5,0.7,_mapCenter]] call ALIVE_fnc_displayMenu;

            private["_allSectors","_landSectors","_playerSector","_surroundingSectors","_highSectors","_playerSectorData","_playerSectorCenterPosition","_line","_currentCopy"];

            _allSectors = [ALIVE_sectorGrid, "sectors"] call ALIVE_fnc_sectorGrid;
            _landSectors = [_allSectors, "SEA"] call ALIVE_fnc_sectorFilterTerrain;
            _playerSector = [ALIVE_sectorGrid, "positionToSector", getPos player] call ALIVE_fnc_sectorGrid;
            _playerSectorData = [_playerSector, "data"] call ALIVE_fnc_hashGet;
            _playerSectorCenterPosition = [_playerSector, "center"] call ALIVE_fnc_sector;
            _surroundingSectors = [ALIVE_sectorGrid, "surroundingSectors", getPos player] call ALIVE_fnc_sectorGrid;


            [ALIVE_sectorPlotter, "plot", [_landSectors, "activeClusters"]] call ALIVE_fnc_plotSectors;

            _line = "<t size='1'>Displaying active objectives and their occupation state</t><br/><br/>";
            _currentCopy = format["%1%2",_baseCopy,_line];
            ["setFullMapText",_currentCopy] call ALIVE_fnc_displayMenu;

            sleep 20;

            [ALIVE_sectorPlotter, "clear"] call ALIVE_fnc_plotSectors;


            [ALIVE_sectorPlotter, "plot", [_landSectors, "casualties"]] call ALIVE_fnc_plotSectors;

            _line = "<t size='1'>Displaying sector casualty levels</t><br/><br/>";
            _currentCopy = format["%1%2",_baseCopy,_line];
            ["setFullMapText",_currentCopy] call ALIVE_fnc_displayMenu;

            sleep 20;

            [ALIVE_sectorPlotter, "clear"] call ALIVE_fnc_plotSectors;


            _line = "<t size='1'>Demonstration complete</t><br/><br/>";
            _currentCopy = format["%1%2",_baseCopy,_line];
            ["setFullMapText",_currentCopy] call ALIVE_fnc_displayMenu;


        };

    };

    case "deactivateSelectionBattlefield": {

        if!(isNil "ALIVE_tourActiveScript") then {
            if!(scriptDone ALIVE_tourActiveScript) then {
                terminate ALIVE_tourActiveScript;
            };
        };

        [ALIVE_sectorPlotter, "clear"] call ALIVE_fnc_plotSectors;

        _logic setVariable ["selectionState","Technology"];

        [_logic,"displaySelectionState"] call MAINCLASS;

    };

    case "activateSelectionData": {

        ALIVE_tourActiveScript = [_logic] spawn {

            private["_logic"];

            _logic = _this select 0;

            private["_line1","_line2","_line3","_line4","_line5","_line6","_line7","_baseCopy"];

            _line1 = "<br/><t size='1.5' color='#68a7b7'>Central Persistence Database</t><br/><br/>";
            _line2 = "<t size='1'>In order to store in game statistics, live operation feeds, player gear, and all other persistence layer operations, the ALiVE dev team have developed technology to store data in a central database.</t><br/><br/>";
            _line3 = "<t size='1'>Built using modern data transfer and storage technologies (JSON,NoSQL) the ALiVE data tech provides seamless transfer from in game to storage and storage back to game.</t><br/><br/>";

            _baseCopy = format["%1%2%3%4%5%6%7",_line1,_line2,_line3];

            ["openFull",[_logic,"handleMenuCallback","Data"]] call ALIVE_fnc_displayMenu;
            ["setFullText",_baseCopy] call ALIVE_fnc_displayMenu;

        };

    };

    case "deactivateSelectionData": {

        if!(isNil "ALIVE_tourActiveScript") then {
            if!(scriptDone ALIVE_tourActiveScript) then {
                terminate ALIVE_tourActiveScript;
            };
        };

        _logic setVariable ["selectionState","Technology"];

        [_logic,"displaySelectionState"] call MAINCLASS;

    };

    case "activateSelectionWarroom": {

        ALIVE_tourActiveScript = [_logic] spawn {

            private["_logic"];

            _logic = _this select 0;

            private["_line1","_line2","_line3","_line4","_line5","_line6","_line7","_baseCopy"];

            _line1 = "<br/><t size='1.5' color='#68a7b7' >WarRoom</t><br/><br/>";
            _line2 = "<t size='1'>ALiVE introduces revolutionary web services integration by streaming ARMA 3 in game data to our ALiVE War Room web platform. War Room allows players and groups to review current and past operations as well keep track of individual and group performance statistics.</t><br/><br/>";
            _line3 = "<t size='1'>War Room offers groups membership to a virtual task force operating across the various AO's offered by the ARMA 3 engine. War Room exposes task force wins, losses and leaderboards for performance. The platform provides live streaming capabilities for BLUFOR tracking, group management tools, after action reporting, and ALiVE module controls from the web.</t><br/><br/>";
            _line4 = "<t size='1'>Beside events, statistics and streaming, War Room provides the platform for persisting Multiplayer Campaigns. This allows groups to run 'multi-session operations' by storing game state to a cloud based database. Group admins can update campaign data via the War Room, such as adding map markers, objectives, editing loadouts or adding vehicles and units to the campaign - all via the web platform.</t><br/><br/>";

            _baseCopy = format["%1%2%3%4%5%6%7",_line1,_line2,_line3,_line4];

            ["openImageFull",[_logic,"handleMenuCallback","Warroom"]] call ALIVE_fnc_displayMenu;
            ["setFullImageText",_baseCopy] call ALIVE_fnc_displayMenu;
            ["setFullImage","x\alive\addons\sys_tour\data\warroom1.paa"] call ALIVE_fnc_displayMenu;

            sleep 1;

            private["_line","_currentCopy"];

            _line = "<t size='1'>Image: WarRoom global operations map</t><br/><br/>";
            _currentCopy = format["%1%2",_baseCopy,_line];
            ["setFullImageText",_currentCopy] call ALIVE_fnc_displayMenu;

            sleep 20;

            _line = "<t size='1'>Image: Player stats overview</t><br/><br/>";
            _currentCopy = format["%1%2",_baseCopy,_line];
            ["setFullImageText",_currentCopy] call ALIVE_fnc_displayMenu;
            ["setFullImage","x\alive\addons\sys_tour\data\warroom2.paa"] call ALIVE_fnc_displayMenu;

            sleep 20;

            _line = "<t size='1'>Image: Player experience</t><br/><br/>";
            _currentCopy = format["%1%2",_baseCopy,_line];
            ["setFullImageText",_currentCopy] call ALIVE_fnc_displayMenu;
            ["setFullImage","x\alive\addons\sys_tour\data\warroom3.paa"] call ALIVE_fnc_displayMenu;

            sleep 20;

            _line = "<t size='1'>Image: Operation AAR</t><br/><br/>";
            _currentCopy = format["%1%2",_baseCopy,_line];
            ["setFullImageText",_currentCopy] call ALIVE_fnc_displayMenu;
            ["setFullImage","x\alive\addons\sys_tour\data\warroom4.paa"] call ALIVE_fnc_displayMenu;

        };

    };

    case "deactivateSelectionWarroom": {

        if!(isNil "ALIVE_tourActiveScript") then {
            if!(scriptDone ALIVE_tourActiveScript) then {
                terminate ALIVE_tourActiveScript;
            };
        };

        _logic setVariable ["selectionState","Technology"];

        [_logic,"displaySelectionState"] call MAINCLASS;

    };

    case "activateSelectionWhat": {

        ALIVE_tourActiveScript = [_logic] spawn {

            private["_logic"];

            _logic = _this select 0;

            private["_line1","_line2","_line3","_line4","_line5","_line6","_line7","_baseCopy"];

            _line1 = "<br/><t size='1.5' color='#68a7b7'>What is ALiVE?</t><br/><br/>";
            _line2 = "<t size='1'>ALIVE is a missions makers framework. Developed by Arma community veterans, the easy to use modular system provides everything that players and mission makers need to set up and run realistic military operations in almost any scenario up to Company level, including command, combat support, service support and logistics.</t><br/><br/>";
            _line3 = "<t size='1'>The editor placed modules are designed to be intuitive but highly flexible so you can create a huge range of different scenarios by simply placing a few modules and markers. The AI Commanders have an overall mission and a prioritised list of objectives that they will work through autonomously. Players can choose to tag along with the AI and join the fight, take your own squad of AI or other players and tackle your own objectives or just sit back and watch it all unfold.</t><br/><br/>";
            _line4 = "<t size='1'>Mission makers may wish to use ALiVE modules as a backdrop for dynamic missions and campaigns, enhancing scenarios created with traditional editing techniques. ALiVE can significantly reduce the effort required to make a complex mission by adding ambience, support and persistence at the drop of a module.</t><br/><br/>";

            _baseCopy = format["%1%2%3%4%5%6%7",_line1,_line2,_line3,_line4];

            ["openImageFull",[_logic,"handleMenuCallback","What"]] call ALIVE_fnc_displayMenu;
            ["setFullImageText",_baseCopy] call ALIVE_fnc_displayMenu;
            ["setFullImage","x\alive\addons\ui\logo_alive_square.paa"] call ALIVE_fnc_displayMenu;

        };

    };

    case "deactivateSelectionWhat": {

        if!(isNil "ALIVE_tourActiveScript") then {
            if!(scriptDone ALIVE_tourActiveScript) then {
                terminate ALIVE_tourActiveScript;
            };
        };

        _logic setVariable ["selectionState","Overview"];

        [_logic,"displaySelectionState"] call MAINCLASS;

    };

    case "activateSelectionWhy": {

        ALIVE_tourActiveScript = [_logic] spawn {

            private["_logic"];

            _logic = _this select 0;

            private["_line1","_line2","_line3","_line4","_line5","_line6","_line7","_baseCopy"];

            _line1 = "<br/><t size='1.5' color='#68a7b7'>Why ALiVE?</t><br/><br/>";
            _line2 = "<t size='1'>ALiVE was designed to enhance the ARMA 3 experience for groups and players who want to create a credibly realistc mission or campaign.</t><br/><br/>";
            _line3 = "<t size='1'>Coming from development of the MSO mod in ARMA 2, the lessons learned there have influenced the development of ALiVE:</t><br/><br/>";
            _line4 = "<t size='1'>Moving from an entirely script based platform to taking advantage of the ARMA module framework to enable much easier usage by mission editors</t><br/><br/>";
            _line5 = "<t size='1'>Opting for a centralised database as opposed to supporting individual group database installations.</t><br/><br/>";
            _line6 = "<t size='1'>Going from largely random in game events to a much more environment and event driven AI and generation systems.</t><br/><br/>";

            _baseCopy = format["%1%2%3%4%5%6%7",_line1,_line2,_line3,_line4,_line5,_line6];

            ["openImageFull",[_logic,"handleMenuCallback","Why"]] call ALIVE_fnc_displayMenu;
            ["setFullImageText",_baseCopy] call ALIVE_fnc_displayMenu;
            ["setFullImage","x\alive\addons\ui\logo_alive_square.paa"] call ALIVE_fnc_displayMenu;

        };

    };

    case "deactivateSelectionWhy": {

        if!(isNil "ALIVE_tourActiveScript") then {
            if!(scriptDone ALIVE_tourActiveScript) then {
                terminate ALIVE_tourActiveScript;
            };
        };

        _logic setVariable ["selectionState","Overview"];

        [_logic,"displaySelectionState"] call MAINCLASS;

    };

    case "activateSelectionWho": {

        ALIVE_tourActiveScript = [_logic] spawn {

            private["_logic"];

            _logic = _this select 0;

            private["_line1","_line2","_line3","_line4","_line5","_line6","_line7","_line8","_line9","_line10","_line11","_line12","_line13","_line14","_line15","_line16","_baseCopy"];

            _line1 = "<br/><t size='1.5' color='#68a7b7'>Who are the dev's?</t><br/><br/>";
            _line2 = "<t size='1'>ALiVE has been in constant development since the release of ARMA 3 early access.</t><br/><br/>";
            _line3 = "<t size='1'>Developed by a global team from 5 countries, ALiVE continues to be a compelling hobby project for the largely IT professional developers.</t><br/><br/>";
            _line4 = "<t size='1'>ARJay</t><br/>";
            _line5 = "<t size='1'>Cameroon</t><br/>";
            _line6 = "<t size='1'>Friznit</t><br/>";
            _line7 = "<t size='1'>Gunny</t><br/>";
            _line8 = "<t size='1'>Haze</t><br/>";
            _line9 = "<t size='1'>Highhead</t><br/>";
            _line10 = "<t size='1'>Jman</t><br/>";
            _line11 = "<t size='1'>Naught</t><br/>";
            _line12 = "<t size='1'>Raptor</t><br/>";
            _line13 = "<t size='1'>Rye</t><br/>";
            _line14 = "<t size='1'>Tupolov</t><br/>";
            _line15 = "<t size='1'>WobblyHeadedBob</t><br/>";
            _line16 = "<t size='1'>Wolffy.au</t><br/>";

            _baseCopy = format["%1%2%3%4%5%6%7%8%9%10%11%12%13%14%15%16",_line1,_line2,_line3,_line4,_line5,_line6,_line7,_line8,_line9,_line10,_line11,_line12,_line13,_line14,_line15,_line16];

            ["openImageFull",[_logic,"handleMenuCallback","Who"]] call ALIVE_fnc_displayMenu;
            ["setFullImageText",_baseCopy] call ALIVE_fnc_displayMenu;
            ["setFullImage","x\alive\addons\sys_tour\data\devteam.paa"] call ALIVE_fnc_displayMenu;

        };

    };

    case "deactivateSelectionWho": {

        if!(isNil "ALIVE_tourActiveScript") then {
            if!(scriptDone ALIVE_tourActiveScript) then {
                terminate ALIVE_tourActiveScript;
            };
        };

        _logic setVariable ["selectionState","Overview"];

        [_logic,"displaySelectionState"] call MAINCLASS;

    };

    case "activateSelectionModuleOPCOM": {

        ALIVE_tourActiveScript = [_logic] spawn {

            private["_logic"];

            _logic = _this select 0;

            private["_line1","_line2","_line3","_line4","_line5","_line6","_line7","_baseCopy"];

            _line1 = "<br/><t size='1.5' color='#68a7b7'>OPCOM</t><br/><br/>";
            _line2 = "<t size='1'>The OPCOM module prioritises a list of objectives and then plans and executes missions with available units. Op Commanders will react to the changing environment and attack, defend, withdraw or resupply depending on the current tactical situation. OPCOM continues to work with virtualised groups, controlling a virtual battlefield out of visual range of players.</t><br/><br/>";
            _line3 = "<t size='1'>OPCOM consists of two core elements: Operational Command (OPCOM) and Tactical Command (TACOM). OPCOM takes the objectives of any synced Military or Civilian Placement modules and prioritises them depending on the user defined variables. It also regularly analyses the map, relative troop strengths and available assets required to capture and hold objectives in its area of operations. OPCOM gives missions to TACOM, which in turn executes the tactical level orders to units and reports back its state once that mission is complete.</t><br/><br/>";

            _baseCopy = format["%1%2%3%4%5%6%7",_line1,_line2,_line3];

            ["openFull",[_logic,"handleMenuCallback","ModuleOPCOM"]] call ALIVE_fnc_displayMenu;
            ["setFullText",_baseCopy] call ALIVE_fnc_displayMenu;

            private["_opcomModules","_moduleType","_handler","_objectives","_side","_sideDisplay","_shuffledModules"];

            _opcomModules = [];

            {
                _moduleType = _x getVariable "moduleType";
                if!(isNil "_moduleType") then {

                    if(_moduleType == "ALIVE_OPCOM") then {
                        _opcomModules set [count _opcomModules,_x];
                    };
                };
            } forEach (entities "Module_F");

            _shuffledModules = [_opcomModules] call CBA_fnc_shuffle;

            {

                _handler = _x getVariable "handler";
                _objectives = [_handler,"objectives"] call ALIVE_fnc_hashGet;
                _side = [_handler,"side"] call ALIVE_fnc_hashGet;
                _sideDisplay = [_side] call ALIVE_fnc_sideTextToLong;

                {
                    private["_center","_size","_priority","_type","_state","_section","_objectiveID","_action","_nearestTownToObjective"];

                    _center = [_x,"center"] call ALIVE_fnc_hashGet;
                    _size = [_x,"size"] call ALIVE_fnc_hashGet;
                    _priority = [_x,"priority"] call ALIVE_fnc_hashGet;
                    _type = [_x,"type"] call ALIVE_fnc_hashGet;
                    _orders = [_x,"opcom_orders"] call ALIVE_fnc_hashGet;
                    _section = [_x,"section"] call ALIVE_fnc_hashGet;
                    _objectiveID = [_x,"objectiveID"] call ALIVE_fnc_hashGet;

                    _action = "";
                    _objective = "";
                    _nearestTownToObjective = [_center] call ALIVE_fnc_taskGetNearestLocationName;

                    if(_type == "MIL") then {
                        _objective = "Military objective";
                    }else{
                        _objective = "Civilian objective";
                    };

                    if!(isNil "_orders") then {
                        switch(_orders) do {
                            case "attack":{
                                _action = format["<t>Ordered by OPCOM to attack %1 near %2</t>",_objective,_nearestTownToObjective];
                            };
                            case "defend":{
                                _action = format["<t>Ordered by OPCOM to defend %1 near %2</t>",_objective,_nearestTownToObjective];
                            };
                            case "recon":{
                                _action = format["<t>Ordered by OPCOM to recon %1 near %2</t>",_objective,_nearestTownToObjective];
                            };
                        };
                    };

                    if!(isNil "_section") then {

                        {

                            private["_profileID","_profile","_position","_faction","_line1","_group","_unit","_nearestTown","_factionName","_title","_text","_target","_duration"];

                            _profileID = _x;
                            _profile = [ALIVE_profileHandler, "getProfile", _profileID] call ALIVE_fnc_profileHandler;

                            if !(isnil "_profile") then {


                                _faction = _profile select 2 select 29;

                                call BIS_fnc_VRFadeIn;

                                _line1 = "<t size='1.5' color='#68a7b7' align='center'>Moving position...</t><br/><br/>";

                                ["openSplash",0.3] call ALIVE_fnc_displayMenu;
                                ["setSplashText",_line1] call ALIVE_fnc_displayMenu;

                                _position = _profile select 2 select 2;

                                if(surfaceIsWater _position) then {
                                    _position = [_position] call ALIVE_fnc_getClosestLand;
                                };

                                player setPos _position;
                                hideObjectGlobal player;

                                waitUntil{_profile select 2 select 1};

                                _group = _profile select 2 select 13;
                                _unit = (units _group) call BIS_fnc_selectRandom;

                                _duration = 20;

                                _target = "RoadCone_L_F" createVehicle _center;
                                hideObjectGlobal _target;

                                if!(isNil "_unit") then {

                                    [_logic, "createDynamicCamera", [_duration,player,_unit,_target]] call MAINCLASS;

                                    _nearestTown = [_position] call ALIVE_fnc_taskGetNearestLocationName;
                                    _factionName = getText(configfile >> "CfgFactionClasses" >> _faction >> "displayName");

                                    _title = "<t size='1.5' color='#68a7b7' shadow='1'>OPCOM Troops</t><br/>";
                                    _text = format["%1<t>%2 group %3 near %4</t><br/>%5",_title,_factionName,_group,_nearestTown,_action];

                                    ["openSideSmall"] call ALIVE_fnc_displayMenu;
                                    ["setSideSmallText",_text] call ALIVE_fnc_displayMenu;

                                    sleep _duration;

                                    deleteVehicle _target;

                                    [_logic, "deleteDynamicCamera"] call MAINCLASS;
                                };

                            };

                        } forEach _section;
                    };

                } forEach _objectives;

            } forEach _shuffledModules;

        };

    };

    case "createDynamicCamera": {

        private ["_source","_target1","_target2","_duration","_targetIsPlayer","_targetIsMan","_targetInVehicle","_cameraAngles",
        "_initialAngle","_diceRoll","_cameraShots","_shot","_target2","_randomPosition"];

        _duration = _args select 0;
        _source = _args select 1;
        _target1 = _args select 2;
        _target2 = if(count _this > 3) then {_this select 3} else {nil};

        _sourceIsPlayer = false;
        if(isPlayer _source) then {
            _sourceIsPlayer = true;
        };

        _targetIsMan = false;
        _targetInVehicle = false;
        if(_target1 isKindOf "Man" && alive _target1) then {
            _targetIsMan = true;
            if(vehicle _target1 != _target1) then {
                _targetInVehicle = true;
                _target1 = vehicle _target1;
            };
        };

        _cameraAngles = ["DEFAULT","LOW","EYE","HIGH","BIRDS_EYE","UAV","SATELITE"];
        _initialAngle = _cameraAngles call BIS_fnc_selectRandom;

        ["CINEMATIC DURATION: %1",_duration] call ALIVE_fnc_dump;
        ["SOURCE IS PLAYER: %1",_sourceIsPlayer] call ALIVE_fnc_dump;
        ["TARGET IS MAN: %1",_targetIsMan] call ALIVE_fnc_dump;
        ["TARGET IS IN VEHICLE: %1",_targetInVehicle] call ALIVE_fnc_dump;

        ALIVE_cameraType = "CAMERA";

        if(_targetIsMan && !(_targetInVehicle)) then {
            _diceRoll = random 1;
            if(_diceRoll > 0.5) then {
                ALIVE_cameraType = "SWITCH";
            };
        };

        ["CAMERA TYPE IS: %1",ALIVE_cameraType] call ALIVE_fnc_dump;

        _cameraShots = ["FLY_IN","PAN","STATIC"];

        if(_targetIsMan && _targetInVehicle) then {
            _cameraShots = ["CHASE","CHASE_SIDE","CHASE_WHEEL","CHASE_ANGLE"];
        };

        _shot = _cameraShots call BIS_fnc_selectRandom;

        ["CAMERA SHOT IS: %1",_shot] call ALIVE_fnc_dump;
        ["CAMERA ANGLE IS: %1",_initialAngle] call ALIVE_fnc_dump;

        if(ALIVE_cameraType == "CAMERA") then {

            if!(_shot == "PAN") then {
                ALIVE_tourCamera = [_source,false,_initialAngle] call ALIVE_fnc_addCamera;
                [ALIVE_tourCamera,true] call ALIVE_fnc_startCinematic;
            };

            switch(_shot) do {
                case "FLY_IN":{
                    [ALIVE_tourCamera,_target1,_duration] call ALIVE_fnc_flyInShot;
                };
                case "PAN":{

                    if(isNil "_target2") then {
                        _randomPosition = [position _source, (random(400)), random(360)] call BIS_fnc_relPos;
                        _target2 = "RoadCone_L_F" createVehicle _randomPosition;
                    };

                    ALIVE_tourCamera = [_source,false,_initialAngle] call ALIVE_fnc_addCamera;
                    [ALIVE_tourCamera,true] call ALIVE_fnc_startCinematic;
                    [ALIVE_tourCamera,_target1,_target2,_duration] call ALIVE_fnc_panShot;
                };
                case "STATIC":{
                    [ALIVE_tourCamera,_target1,_duration] call ALIVE_fnc_staticShot;
                };
                case "CHASE":{
                    [ALIVE_tourCamera,_target1,_duration] call ALIVE_fnc_chaseShot;
                };
                case "CHASE_SIDE":{
                    [ALIVE_tourCamera,_target1,_duration] spawn ALIVE_fnc_chaseSideShot;
                };
                case "CHASE_WHEEL":{
                    [ALIVE_tourCamera,_target1,_duration] spawn ALIVE_fnc_chaseWheelShot;
                };
                case "CHASE_ANGLE":{
                    [ALIVE_tourCamera,_target1,_duration] spawn ALIVE_fnc_chaseAngleShot;
                };
            };

        }else{

            [_target1,"FIRST_PERSON"] call ALIVE_fnc_switchCamera;

        };

    };

    case "deleteDynamicCamera": {

        if(ALIVE_cameraType == "CAMERA") then {

            [ALIVE_tourCamera,true] call ALIVE_fnc_stopCinematic;
            [ALIVE_tourCamera] call ALIVE_fnc_removeCamera;

        }else{

            [true] call ALIVE_fnc_revertCamera;

        };

        player hideObjectGlobal false;

    };

    case "deactivateSelectionModuleOPCOM": {

        if!(isNil "ALIVE_tourActiveScript") then {
            if!(scriptDone ALIVE_tourActiveScript) then {
                terminate ALIVE_tourActiveScript;
            };
        };

        if!(isNil "ALIVE_cameraType") then {
            if(ALIVE_cameraType == "CAMERA") then {
                if!(isNil "ALIVE_tourCamera") then {
                    [ALIVE_tourCamera,true] call ALIVE_fnc_stopCinematic;
                    [ALIVE_tourCamera] call ALIVE_fnc_removeCamera;
                };
            }else{
                [true] call ALIVE_fnc_revertCamera;
            };
        };

        _logic setVariable ["selectionState","Modules"];

        [_logic,"displaySelectionState"] call MAINCLASS;

    };

    case "activateSelectionModulePlacement": {

        ALIVE_tourActiveScript = [_logic] spawn {

            private["_logic"];

            _logic = _this select 0;

            private["_moduleType","_placementModules"];

            _placementModules = [];

            {
                _moduleType = _x getVariable "moduleType";
                if!(isNil "_moduleType") then {

                    ["TYPE: %1",_moduleType] call ALIVE_fnc_dump;
                    if(_moduleType == "ALIVE_MP" || _moduleType == "ALIVE_CMP") then {
                        _placementModules set [count _placementModules, _x];
                    };
                };
            } forEach (entities "Module_F");

            private["_module","_moduleType","_objectives","_faction","_position","_size","_playerPosition","_emptyPosition",
            "_camera","_line1","_line2","_line3","_line4","_line5","_line6","_line7","_baseCopy","_nearestTown","_factionName",
            "_target","_title","_text","_duration"];

            _line1 = "<br/><t size='1.5' color='#68a7b7'>Military Placement</t><br/><br/>";
            _line2 = "<t size='1'>The military placement modules place starting forces in areas defined by the mission maker.</t><br/><br/>";
            _line3 = "<t size='1'>Based on the given area defined by the mission maker ALiVE will create forces in and around key objectives.</t><br/><br/>";
            _line4 = "<t size='1'>These modules can spawn ambient vehicles, and ammo crates. If static weapons are near, the modules will man them with units, and also garrison units in defensible positions.</t><br/><br/>";
            _line5 = "<t size='1'>The custom military placement module can also spawn ALiVE predfined compositions to give maps a fresh layout.</t><br/><br/>";

            _baseCopy = format["%1%2%3%4%5%6%7",_line1,_line2,_line3,_line4,_line5];

            ["openFull",[_logic,"handleMenuCallback","ModulePlacement"]] call ALIVE_fnc_displayMenu;
            ["setFullText",_baseCopy] call ALIVE_fnc_displayMenu;

            {
                _module = _x;
                _moduleType = _module getVariable "moduleType";

                if(_moduleType == "ALIVE_MP") then {

                    _objectives = _module getVariable "objectives";
                    _faction = _module getVariable "faction";

                    _objective = _objectives call BIS_fnc_selectRandom;

                    _position = [_objective,"center"] call ALIVE_fnc_hashGet;
                    _size = [_objective,"size"] call ALIVE_fnc_hashGet;

                    _playerPosition = [_position, random 360, _size] call BIS_fnc_relPos;

                    _emptyPosition = _playerPosition findEmptyPosition [1,100];

                    if(count _emptyPosition > 0) then {
                        _playerPosition = _emptyPosition;
                    };

                    call BIS_fnc_VRFadeIn;

                    _line1 = "<t size='1.5' color='#68a7b7' align='center'>Moving position...</t><br/><br/>";

                    ["openSplash",0.2] call ALIVE_fnc_displayMenu;
                    ["setSplashText",_line1] call ALIVE_fnc_displayMenu;

                    player setPos _playerPosition;

                    sleep 3;

                    _target = "RoadCone_L_F" createVehicle _position;
                    _target hideObjectGlobal true;

                    _duration = 35;

                    [_logic, "createDynamicCamera", [_duration,player,_target]] call MAINCLASS;


                    _nearestTown = [_position] call ALIVE_fnc_taskGetNearestLocationName;
                    _factionName = getText(configfile >> "CfgFactionClasses" >> _faction >> "displayName");

                    _title = "<t size='1.5' color='#68a7b7' shadow='1'>Military Objective</t><br/>";
                    _text = format["%1<t>Objective near %2 initially held by: %3</t>",_title,_nearestTown,_factionName];

                    ["openSideSmall"] call ALIVE_fnc_displayMenu;
                    ["setSideSmallText",_text] call ALIVE_fnc_displayMenu;


                }else{

                    _objectives = _module getVariable "objectives";
                    _faction = _module getVariable "faction";

                    _objective = _objectives call BIS_fnc_selectRandom;

                    _position = [_objective,"center"] call ALIVE_fnc_hashGet;
                    _size = [_objective,"size"] call ALIVE_fnc_hashGet;

                    _playerPosition = [_position, random 360, _size] call BIS_fnc_relPos;

                    _emptyPosition = _playerPosition findEmptyPosition [1,100];

                    if(count _emptyPosition > 0) then {
                        _playerPosition = _emptyPosition;
                    };


                    call BIS_fnc_VRFadeIn;

                    _line1 = "<t size='1.5' color='#68a7b7' align='center'>Moving position...</t><br/><br/>";

                    ["openSplash",0.2] call ALIVE_fnc_displayMenu;
                    ["setSplashText",_line1] call ALIVE_fnc_displayMenu;

                    player setPos _playerPosition;

                    sleep 3;

                    _target = "RoadCone_L_F" createVehicle _position;
                    _target hideObjectGlobal true;

                    _duration = 35;

                    [_logic, "createDynamicCamera", [_duration,player,_target]] call MAINCLASS;


                    _nearestTown = [_position] call ALIVE_fnc_taskGetNearestLocationName;
                    _factionName = getText(configfile >> "CfgFactionClasses" >> _faction >> "displayName");

                    _title = "<t size='1.5' color='#68a7b7' shadow='1'>Military Objective</t><br/>";
                    _text = format["%1<t>Objective near %2 initially held by: %3</t>",_title,_nearestTown,_factionName];

                    ["openSideSmall"] call ALIVE_fnc_displayMenu;
                    ["setSideSmallText",_text] call ALIVE_fnc_displayMenu;

                };

                sleep _duration;

                deleteVehicle _target;
                [_logic, "deleteDynamicCamera"] call MAINCLASS;

            } forEach _placementModules;

        };

    };

    case "deactivateSelectionModulePlacement": {

        if!(isNil "ALIVE_tourActiveScript") then {
            if!(scriptDone ALIVE_tourActiveScript) then {
                terminate ALIVE_tourActiveScript;
            };
        };

        if!(isNil "ALIVE_cameraType") then {
            if(ALIVE_cameraType == "CAMERA") then {
                if!(isNil "ALIVE_tourCamera") then {
                    [ALIVE_tourCamera,true] call ALIVE_fnc_stopCinematic;
                    [ALIVE_tourCamera] call ALIVE_fnc_removeCamera;
                };
            }else{
                [true] call ALIVE_fnc_revertCamera;
            };
        };

        _logic setVariable ["selectionState","Modules"];

        [_logic,"displaySelectionState"] call MAINCLASS;

    };

    case "activateSelectionModuleLogistics": {

        ALIVE_tourActiveScript = [_logic] spawn {

            private["_logic"];

            _logic = _this select 0;

            private["_line1","_line2","_line3","_line4","_line5","_line6","_line7","_baseCopy"];

            _line1 = "<br/><t size='1.5' color='#68a7b7'>Military Logistics</t><br/><br/>";
            _line2 = "<t size='1'>The Battlefield Logistics System is responsible for maintaining operational effectiveness of all units in the Theatre of Operations, delivering resupplies and Battle Casualty Replacements to the front line.</t><br/><br/>";
            _line3 = "<t size='1'>BCRs require a suitable objective held by friendly forces where they will muster before moving to join front line units. OPCOM requests BCRs when Combat Effectiveness falls below acceptable levels.</t><br/><br/>";
            _line4 = "<t size='1'>The Logistics Commander (LOGCOM) assesses the tactical situation and determines the best location to bring in BCRs and then dispatches a convoy with the required troops and vehicles. Replacements may come in by Air or Land depending on the location and availability of landing sites and the type of replacements requested. Large airfields have a higher capacity to deliver logistics than small patrol bases.</t><br/><br/>";

            _baseCopy = format["%1%2%3%4%5%6%7",_line1,_line2,_line3,_line4];

            ["openFull",[_logic,"handleMenuCallback","ModuleLogistics"]] call ALIVE_fnc_displayMenu;
            ["setFullText",_baseCopy] call ALIVE_fnc_displayMenu;

            private["_position","_faction","_side","_forceMakeup","_event","_eventID","_logisticsModules","_logisticsModule",
            "_logisticsEvent","_eventState","_transportProfiles","_transportProfile","_position","_group","_leader","_vehicle"];

            _logisticsModules = [];

            {
                _moduleType = _x getVariable "moduleType";
                if!(isNil "_moduleType") then {

                    ["TYPE: %1",_moduleType] call ALIVE_fnc_dump;
                    if(_moduleType == "ALIVE_ML") then {
                        _logisticsModules set [count _logisticsModules, _x];
                    };
                };
            } forEach (entities "Module_F");

            _logisticsModule = _logisticsModules call BIS_fnc_selectRandom;

            if!(isNil "_logisticsModule") then {

                _side = _logisticsModule getVariable "side";
                _factions = _logisticsModule getVariable "factions";
                _faction = _factions select 0 select 1 select 0;
                _eventQueue = _logisticsModule getVariable "eventQueue";
                _forcePool = _logisticsModule getVariable "forcePool";

                _position = [getPos player, 20, 180] call BIS_fnc_relPos;

                _forceMakeup = [
                    3, // infantry
                    0, // motorised
                    0, // mechanised
                    0, // armour
                    0, // plane
                    0  // heli
                ];

                _event = ['LOGCOM_REQUEST', [_position,_faction,_side,_forceMakeup,"HELI_INSERT"],"OPCOM"] call ALIVE_fnc_event;
                _eventID = [ALIVE_eventLog, "addEvent",_event] call ALIVE_fnc_eventLog;

                sleep 5;

                _logisticsEvent = [_eventQueue, _eventID] call ALIVE_fnc_hashGet;

                if!(isNil "_logisticsEvent") then {

                    waitUntil{
                        sleep 1;
                        _eventState = [_logisticsEvent,"state"] call ALIVE_fnc_hashGet;
                        (_eventState == "heliTransport" || _eventState == "eventComplete")
                    };

                    if(_eventState == "heliTransport") then {

                        _transportProfiles = [_logisticsEvent,"transportProfiles"] call ALIVE_fnc_hashGet;
                        _transportProfile = _transportProfiles call BIS_fnc_selectRandom;

                        _transportProfile = [ALIVE_profileHandler, "getProfile", _transportProfile] call ALIVE_fnc_profileHandler;
                        if!(isNil "_transportProfile") then {
                            _position = _transportProfile select 2 select 2;

                            call BIS_fnc_VRFadeIn;

                            _line1 = "<t size='1.5' color='#68a7b7' align='center'>Moving position...</t><br/><br/>";

                            ["openSplash",0.2] call ALIVE_fnc_displayMenu;
                            ["setSplashText",_line1] call ALIVE_fnc_displayMenu;

                            player setPos _position;

                            waitUntil {(_transportProfile select 2 select 1)};

                            _group = _transportProfile select 2 select 13;
                            _leader = leader _group;
                            _vehicle = vehicle _leader;

                            ALIVE_tourCamera = [player,false,"UAV"] call ALIVE_fnc_addCamera;
                            [ALIVE_tourCamera,true] call ALIVE_fnc_startCinematic;
                            [ALIVE_tourCamera,_vehicle,100] call ALIVE_fnc_chaseShot;
                        };
                    };
                };
            };

        };

    };

    case "deactivateSelectionModuleLogistics": {

        if!(isNil "ALIVE_tourActiveScript") then {
            if!(scriptDone ALIVE_tourActiveScript) then {
                terminate ALIVE_tourActiveScript;
            };
        };

        if!(isNil "ALIVE_tourCamera") then {

            [ALIVE_tourCamera,true] call ALIVE_fnc_stopCinematic;
            [ALIVE_tourCamera] call ALIVE_fnc_removeCamera;
        };

        _logic setVariable ["selectionState","Modules"];

        [_logic,"displaySelectionState"] call MAINCLASS;

    };

    case "activateSelectionModuleCQB": {

        ALIVE_tourActiveScript = [_logic] spawn {

            private["_logic"];

            _logic = _this select 0;

            private["_line1","_line2","_line3","_line4","_line5","_line6","_line7","_baseCopy"];

            _line1 = "<br/><t size='1.5' color='#68a7b7'>CQB</t><br/><br/>";
            _line2 = "<t size='1'>The close quarters combat module automatically populates a civilian and military buidlings with dismounted infantry units when a player moves within range. The groups occupy buildings, patrol the streets and react to enemy presence.</t><br/><br/>";
            _line3 = "<t size='1'>CQB detects the dominant AI faction in the area (ignoring players) and spawns the appropriate units accordingly.</t><br/><br/>";
            _line4 = "<t size='1'></t><br/><br/>";
            _line5 = "<t size='1'></t><br/><br/>";
            _line6 = "<t size='1'></t><br/><br/>";
            _line7 = "<t size='1'></t><br/><br/>";

            _baseCopy = format["%1%2%3%4%5%6%7",_line1,_line2];

            ["openFull",[_logic,"handleMenuCallback","ModuleCQB"]] call ALIVE_fnc_displayMenu;
            ["setFullText",_baseCopy] call ALIVE_fnc_displayMenu;

            private["_position","_faction","_side","_CQBModules","_CQBModule","_factions","_houses","_position","_group","_leader"];

            _CQBModules = [];

            {
                _CQBModules set [count _CQBModules, _x];
            } foreach (MOD(CQB) getVariable ["instances",[]]);

            _CQBModule = _CQBModules call BIS_fnc_selectRandom;

            if!(isNil "_CQBModule") then {

                _factions = _CQBModule getVariable "factions";
                _houses = _CQBModule getVariable "houses";

                {

                    if ([_x] call ALiVE_fnc_isHouseEnterable) then {

                        call BIS_fnc_VRFadeIn;

                        _line1 = "<t size='1.5' color='#68a7b7' align='center'>Moving position...</t><br/><br/>";

                        ["openSplash",0.2] call ALIVE_fnc_displayMenu;
                        ["setSplashText",_line1] call ALIVE_fnc_displayMenu;

                        _position = position _x;

                        player setPos _position;
                        hideObjectGlobal player;

                        sleep 3;

                        waitUntil {
                            _group = _x getVariable "group";
                            !(isNil "_group")
                        };

                        _group = _x getVariable "group";

                        waitUntil {
                            _group = _x getVariable "group";
                            (typeName _group == "GROUP")
                        };

                        _leader = leader _group;

                        [_leader,"FIRST_PERSON"] call ALIVE_fnc_switchCamera;

                        sleep 30;

                    };

                } forEach _houses;

            };

        };

    };

    case "deactivateSelectionModuleCQB": {

        if!(isNil "ALIVE_tourActiveScript") then {
            if!(scriptDone ALIVE_tourActiveScript) then {
                terminate ALIVE_tourActiveScript;
            };
        };

        player hideObjectGlobal false;

        [true] call ALIVE_fnc_revertCamera;

        _logic setVariable ["selectionState","Modules"];

        [_logic,"displaySelectionState"] call MAINCLASS;

    };

    case "activateSelectionModuleCivilian": {

        ALIVE_tourActiveScript = [_logic] spawn {

            private["_logic"];

            _logic = _this select 0;

            private["_line1","_line2","_line3","_line4","_line5","_line6","_line7","_baseCopy"];

            _line1 = "<br/><t size='1.5' color='#68a7b7'>Civilian Settlement</t><br/><br/>";
            _line2 = "<t size='1'></t><br/><br/>";
            _line3 = "<t size='1'></t><br/><br/>";
            _line4 = "<t size='1'></t><br/><br/>";
            _line5 = "<t size='1'></t><br/><br/>";
            _line6 = "<t size='1'></t><br/><br/>";
            _line7 = "<t size='1'></t><br/><br/>";

            _baseCopy = format["%1%2%3%4%5%6%7",_line1,_line2,_line3,_line4,_line5,_line6,_line7];

            ["openFull",[_logic,"handleMenuCallback","ModuleCivilian"]] call ALIVE_fnc_displayMenu;
            ["setFullText",_baseCopy] call ALIVE_fnc_displayMenu;

            private["_civilianAgents","_activeCommands","_profile","_type","_line1","_position","_unit",
            "_faction","_id","_duration","_nearestTown","_factionName","_title","_text","_command"];



            if!(isNil "ALIVE_agentHandler") then {
                _civilianAgents = [ALIVE_agentHandler,"getAgents"] call ALIVE_fnc_agentHandler;
                _activeCommands = [ALIVE_civCommandRouter,"commandState"] call ALIVE_fnc_hashGet;

                {
                    _profile = _x;

                    _type = _profile select 2 select 4;

                    if(_type == "agent") then {

                        call BIS_fnc_VRFadeIn;

                        _line1 = "<t size='1.5' color='#68a7b7' align='center'>Moving position...</t><br/><br/>";

                        ["openSplash",0.3] call ALIVE_fnc_displayMenu;
                        ["setSplashText",_line1] call ALIVE_fnc_displayMenu;

                        _position = _profile select 2 select 2;

                        if(surfaceIsWater _position) then {
                            _position = [_position] call ALIVE_fnc_getClosestLand;
                        };

                        player setPos _position;
                        hideObjectGlobal player;

                        waitUntil{_profile select 2 select 1};

                        _unit = _profile select 2 select 5;
                        _faction = _profile select 2 select 7;
                        _id = _profile select 2 select 3;

                        _duration = 20;

                        _target = "RoadCone_L_F" createVehicle _position;
                        hideObjectGlobal _target;

                        if!(isNil "_unit") then {

                            _command = [_activeCommands,_id] call ALIVE_fnc_hashGet;
                            _command = _command select 1;
                            _command call ALIVE_fnc_inspectArray;

                            [_logic, "createDynamicCamera", [_duration,player,_unit,_target]] call MAINCLASS;

                            _nearestTown = [_position] call ALIVE_fnc_taskGetNearestLocationName;
                            _factionName = getText(configfile >> "CfgFactionClasses" >> _faction >> "displayName");

                            _title = "<t size='1.5' color='#68a7b7' shadow='1'>Civilian</t><br/>";
                            _text = format["%1<t>%3 near %2</t><br/>%5",_title,_nearestTown,_factionName];

                            ["openSideSubtitle"] call ALIVE_fnc_displayMenu;
                            ["setSideSubtitleSmallText",_text] call ALIVE_fnc_displayMenu;

                            sleep _duration;

                            deleteVehicle _target;

                            [_logic, "deleteDynamicCamera"] call MAINCLASS;
                        };
                    };

                } forEach (_civilianAgents select 2);

            };

        };

    };

    case "deactivateSelectionModuleCivilian": {

        if!(isNil "ALIVE_tourActiveScript") then {
            if!(scriptDone ALIVE_tourActiveScript) then {
                terminate ALIVE_tourActiveScript;
            };
        };

        if!(isNil "ALIVE_cameraType") then {
            if(ALIVE_cameraType == "CAMERA") then {
                if!(isNil "ALIVE_tourCamera") then {
                    [ALIVE_tourCamera,true] call ALIVE_fnc_stopCinematic;
                    [ALIVE_tourCamera] call ALIVE_fnc_removeCamera;
                };
            }else{
                [true] call ALIVE_fnc_revertCamera;
            };
        };

        _logic setVariable ["selectionState","Modules"];

        [_logic,"displaySelectionState"] call MAINCLASS;

    };

    case "activateSelectionModuleCombatSupport": {

        ALIVE_tourActiveScript = [_logic] spawn {

            private["_logic"];

            _logic = _this select 0;

            private["_line1","_line2","_line3","_line4","_line5","_line6","_line7","_baseCopy"];

            _line1 = "<br/><t size='1.5' color='#68a7b7'>Combat Support</t><br/><br/>";
            _line2 = "<t size='1'></t><br/><br/>";
            _line3 = "<t size='1'></t><br/><br/>";
            _line4 = "<t size='1'></t><br/><br/>";
            _line5 = "<t size='1'></t><br/><br/>";
            _line6 = "<t size='1'></t><br/><br/>";
            _line7 = "<t size='1'></t><br/><br/>";

            _baseCopy = format["%1%2%3%4%5%6%7",_line1,_line2,_line3,_line4,_line5,_line6,_line7];

            ["openSideFull"] call ALIVE_fnc_displayMenu;
            ["setSideFullText",_baseCopy] call ALIVE_fnc_displayMenu;

            ["radio"] call ALIVE_fnc_radioAction;

            sleep 1;

            waitUntil { sleep 1; _display = findDisplay 655555;(isNull _display)};

            1005 cutText ["", "PLAIN"];

            [_logic,"deactivateSelectionModuleCombatSupport"] call MAINCLASS;

        };

    };

    case "deactivateSelectionModuleCombatSupport": {

        if!(isNil "ALIVE_tourActiveScript") then {
            if!(scriptDone ALIVE_tourActiveScript) then {
                terminate ALIVE_tourActiveScript;
            };
        };

        _logic setVariable ["selectionState","Modules"];

        [_logic,"displaySelectionState"] call MAINCLASS;

    };

    case "activateSelectionModuleResupply": {

        ALIVE_tourActiveScript = [_logic] spawn {

            private["_logic"];

            _logic = _this select 0;

            private["_line1","_line2","_line3","_line4","_line5","_line6","_line7","_baseCopy"];

            _line1 = "<br/><t size='1.5' color='#68a7b7'>Player Resupply</t><br/><br/>";
            _line2 = "<t size='1'></t><br/><br/>";
            _line3 = "<t size='1'></t><br/><br/>";
            _line4 = "<t size='1'></t><br/><br/>";
            _line5 = "<t size='1'></t><br/><br/>";
            _line6 = "<t size='1'></t><br/><br/>";
            _line7 = "<t size='1'></t><br/><br/>";

            _baseCopy = format["%1%2%3%4%5%6%7",_line1,_line2,_line3,_line4,_line5,_line6,_line7];

            ["openSideFull"] call ALIVE_fnc_displayMenu;
            ["setSideFullText",_baseCopy] call ALIVE_fnc_displayMenu;

            ["OPEN",[]] call ALIVE_fnc_PRTabletOnAction;

            sleep 1;

            waitUntil { sleep 1; _display = findDisplay 60001;(isNull _display)};

            1005 cutText ["", "PLAIN"];

            [_logic,"deactivateSelectionModuleResupply"] call MAINCLASS;

        };

    };

    case "deactivateSelectionModuleResupply": {

        if!(isNil "ALIVE_tourActiveScript") then {
            if!(scriptDone ALIVE_tourActiveScript) then {
                terminate ALIVE_tourActiveScript;
            };
        };

        _logic setVariable ["selectionState","Modules"];

        [_logic,"displaySelectionState"] call MAINCLASS;

    };

    case "activateSelectionModuleC2": {

        ALIVE_tourActiveScript = [_logic] spawn {

            private["_logic"];

            _logic = _this select 0;

            private["_line1","_line2","_line3","_line4","_line5","_line6","_line7","_baseCopy"];

            _line1 = "<br/><t size='1.5' color='#68a7b7'>C2ISTAR</t><br/><br/>";
            _line2 = "<t size='1'></t><br/><br/>";
            _line3 = "<t size='1'></t><br/><br/>";
            _line4 = "<t size='1'></t><br/><br/>";
            _line5 = "<t size='1'></t><br/><br/>";
            _line6 = "<t size='1'></t><br/><br/>";
            _line7 = "<t size='1'></t><br/><br/>";

            _baseCopy = format["%1%2%3%4%5%6%7",_line1,_line2,_line3,_line4,_line5,_line6,_line7];

            ["openSideFull"] call ALIVE_fnc_displayMenu;
            ["setSideFullText",_baseCopy] call ALIVE_fnc_displayMenu;

            ["OPEN",[]] call ALIVE_fnc_C2TabletOnAction;

            sleep 1;

            waitUntil { sleep 1; _display = findDisplay 70001;(isNull _display)};

            1005 cutText ["", "PLAIN"];

            [_logic,"deactivateSelectionModuleC2"] call MAINCLASS;

        };

    };

    case "deactivateSelectionModuleC2": {

        if!(isNil "ALIVE_tourActiveScript") then {
            if!(scriptDone ALIVE_tourActiveScript) then {
                terminate ALIVE_tourActiveScript;
            };
        };

        _logic setVariable ["selectionState","Modules"];

        [_logic,"displaySelectionState"] call MAINCLASS;

    };

    case "listen": {
        private["_listenerID"];

        _listenerID = [ALIVE_eventLog, "addListener",[_logic, [
            "OPCOM_RECON",
            "OPCOM_CAPTURE",
            "OPCOM_DEFEND",
            "OPCOM_RESERVE"
        ]]] call ALIVE_fnc_eventLog;
        _logic setVariable ["listenerID", _listenerID];
    };
    case "handleEvent": {
        private["_event","_id","_type","_eventData"];

        if(typeName _args == "ARRAY") then {

            _event = _args;

            _id = [_event, "id"] call ALIVE_fnc_hashGet;
            _type = [_event, "type"] call ALIVE_fnc_hashGet;
            _eventData = [_event, "data"] call ALIVE_fnc_hashGet;

            [_logic, _type, [_id,_eventData]] call MAINCLASS;

        };
    };
    case "OPCOM_RECON": {
        private["_eventID","_eventData","_side","_position","_size","_type","_priority","_clusterID","_nearestTown","_title","_text"];

        _eventID = _args select 0;
        _eventData = _args select 1;

        _side = _eventData select 0;
        _position = _eventData select 1 select 2 select 1;
        _size = _eventData select 1 select 2 select 2;
        _type = _eventData select 1 select 2 select 3;
        _priority = _eventData select 1 select 2 select 4;
        _clusterID = _eventData select 1 select 2 select 6;

        _nearestTown = [_position] call ALIVE_fnc_taskGetNearestLocationName;

        switch(_type) do {
            case "MIL":{
                _type = "military";
            };
            case "CIV":{
                _type = "civilian";
            };
        };

        switch(_side) do {
            case "EAST":{
                _side = "OPFOR";
            };
            case "WEST":{
                _side = "BLUFOR";
            };
            case "GUER":{
                _side = "INDEP";
            };
        };

        _title = "<t size='1.5' color='#68a7b7'  shadow='1'>OPCOM EVENT</t><br/>";
        _text = format["%1<t>%2 OPCOM has requested recon of a %3 objective near %4</t>",_title,_side,_type,_nearestTown];

        ["openSideSmall",0.3] call ALIVE_fnc_displayMenu;
        ["setSideSmallText",_text] call ALIVE_fnc_displayMenu;

    };
    case "OPCOM_CAPTURE": {
        private["_eventID","_eventData","_side","_position","_size","_type","_priority","_clusterID","_nearestTown","_title","_text"];

        _eventID = _args select 0;
        _eventData = _args select 1;

        _side = _eventData select 0;
        _position = _eventData select 1 select 2 select 1;
        _size = _eventData select 1 select 2 select 2;
        _type = _eventData select 1 select 2 select 3;
        _priority = _eventData select 1 select 2 select 4;
        _clusterID = _eventData select 1 select 2 select 6;

        _nearestTown = [_position] call ALIVE_fnc_taskGetNearestLocationName;

        switch(_type) do {
            case "MIL":{
                _type = "military";
            };
            case "CIV":{
                _type = "civilian";
            };
        };

        switch(_side) do {
            case "EAST":{
                _side = "OPFOR";
            };
            case "WEST":{
                _side = "BLUFOR";
            };
            case "GUER":{
                _side = "INDEP";
            };
        };

        _title = "<t size='1.5' color='#68a7b7'  shadow='1'>OPCOM EVENT</t><br/>";
        _text = format["%1<t>%2 OPCOM is capturing a %3 objective near %4</t>",_title,_side,_type,_nearestTown];

        ["openSideSmall",0.3] call ALIVE_fnc_displayMenu;
        ["setSideSmallText",_text] call ALIVE_fnc_displayMenu;

    };
    case "OPCOM_DEFEND": {
        private["_eventID","_eventData","_side","_position","_size","_type","_priority","_clusterID","_nearestTown","_title","_text"];

        _eventID = _args select 0;
        _eventData = _args select 1;

        _side = _eventData select 0;
        _position = _eventData select 1 select 2 select 1;
        _size = _eventData select 1 select 2 select 2;
        _type = _eventData select 1 select 2 select 3;
        _priority = _eventData select 1 select 2 select 4;
        _clusterID = _eventData select 1 select 2 select 6;

        _nearestTown = [_position] call ALIVE_fnc_taskGetNearestLocationName;

        switch(_type) do {
            case "MIL":{
                _type = "military";
            };
            case "CIV":{
                _type = "civilian";
            };
        };

        switch(_side) do {
            case "EAST":{
                _side = "OPFOR";
            };
            case "WEST":{
                _side = "BLUFOR";
            };
            case "GUER":{
                _side = "INDEP";
            };
        };

        _title = "<t size='1.5' color='#68a7b7'  shadow='1'>OPCOM EVENT</t><br/>";
        _text = format["%1<t>%2 OPCOM is defending a %3 objective near %4</t>",_title,_side,_type,_nearestTown];

        ["openSideSmall",0.3] call ALIVE_fnc_displayMenu;
        ["setSideSmallText",_text] call ALIVE_fnc_displayMenu;

    };
    case "OPCOM_RESERVE": {
        private["_eventID","_eventData","_side","_position","_size","_type","_priority","_clusterID","_nearestTown","_title","_text"];

        _eventID = _args select 0;
        _eventData = _args select 1;

        _side = _eventData select 0;
        _position = _eventData select 1 select 2 select 1;
        _size = _eventData select 1 select 2 select 2;
        _type = _eventData select 1 select 2 select 3;
        _priority = _eventData select 1 select 2 select 4;
        _clusterID = _eventData select 1 select 2 select 6;

        _nearestTown = [_position] call ALIVE_fnc_taskGetNearestLocationName;

        switch(_type) do {
            case "MIL":{
                _type = "military";
            };
            case "CIV":{
                _type = "civilian";
            };
        };

        switch(_side) do {
            case "EAST":{
                _side = "OPFOR";
            };
            case "WEST":{
                _side = "BLUFOR";
            };
            case "GUER":{
                _side = "INDEP";
            };
        };

        _title = "<t size='1.5' color='#68a7b7'  shadow='1'>OPCOM EVENT</t><br/>";
        _text = format["%1<t>%2 OPCOM has reserved a %3 objective near %4</t>",_title,_side,_type,_nearestTown];

        ["openSideSmall",0.3] call ALIVE_fnc_displayMenu;
        ["setSideSmallText",_text] call ALIVE_fnc_displayMenu;

    };
};

TRACE_1("TOUR - output",_result);
_result;
