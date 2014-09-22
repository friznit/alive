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

        private["_actionSelection","_technologySelection","_modulesSelection"];

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

        _currentMission = [] call ALIVE_fnc_hashCreate;

        [_currentMission,"icon","x\alive\addons\sys_tour\data\alive_icons_tour_mission.paa"] call ALIVE_fnc_hashSet;
        [_currentMission,"inactiveLabel","Mission"] call ALIVE_fnc_hashSet;
        [_currentMission,"activeLabel","About the current mission"] call ALIVE_fnc_hashSet;
        [_currentMission,"iconState",["Mission",0,0]] call ALIVE_fnc_hashSet;

        [_selectionOptions,"start",[_technologySelection,_modulesSelection,_actionSelection,_currentMission]] call ALIVE_fnc_hashSet;

        // technology selections

        private["_mapAnalysisSelection","_objectivesSelection","_profileSelection","_opcomSelection","_backSelection"];

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

        _backSelection = [] call ALIVE_fnc_hashCreate;

        [_backSelection,"icon","x\alive\addons\sys_tour\data\alive_icons_tour_back.paa"] call ALIVE_fnc_hashSet;
        [_backSelection,"inactiveLabel","Go Back"] call ALIVE_fnc_hashSet;
        [_backSelection,"activeLabel","Go back to the previous menu"] call ALIVE_fnc_hashSet;
        [_backSelection,"iconState",["Back",0,0]] call ALIVE_fnc_hashSet;

        [_selectionOptions,"Technology",[_mapAnalysisSelection,_objectivesSelection,_battlefieldSelection,_profileSelection,_opcomSelection,_backSelection]] call ALIVE_fnc_hashSet;

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

        _line1 = "<t size='1.5' align='center'>Welcome to the ALiVE Tour</t><br/><br/>";
        _line2 = "<t size='1' align='center'>Discover the technology, modules, and usage of ALiVE</t><br/>";
        _line3 = "<t size='1' align='center'>Information topics will be created around your player</t><br/>";
        _line4 = "<t size='1' align='center'>Walk towards a topic you wish to learn more about</t><br/><br/>";

        _text = format["%1%2%3%4",_line1,_line2,_line3,_line4];

        ["openSplash",0.3] call ALIVE_fnc_displayMenu;
        ["setSplashText",_text] call ALIVE_fnc_displayMenu;

    };

    case "setRandomPlacement": {

        private["_sides","_side","_locationTypes","_locationType","_initialPosition","_position"];

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

        _position = _position findEmptyPosition [10,1000];

        player setPos _position;

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
            _position set [2, 2];

            ALIVE_tourIconPositions set [count ALIVE_tourIconPositions, _position];

        } foreach ALIVE_tourCurrentSelectionValues;


        // run the draw icon 3D routine for the selections

        _eventID = addMissionEventHandler ["Draw3D", {
            {
                private ["_selectionOption","_icon","_inactiveLabel","_activeLabel","_iconState","_iconActive","_iconDistance",
                "_iconID","_iconActiveTime","_position","_distance","_size","_active","_label","_colour"];

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

                if(_distance > 10) then {
                    _size = 2.5;
                    _colour = ALIVE_tourInActiveColour;
                    _label = _inactiveLabel;
                    _iconActiveTime = 0;
                }else{
                    _size = 2.5 + (10 - _distance);

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

                        if(_iconActiveTime > 190) then {
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

        /*

        call BIS_fnc_VRFadeIn;

        _line1 = "<t size='1.5' align='center'>Loading...</t><br/>";
        _line2 = "<t size='1' align='center'></t>";

        _text = format["%1%2",_line1,_line2];

        ["openSplash",0.1] call ALIVE_fnc_displayMenu;
        ["setSplashText",_text] call ALIVE_fnc_displayMenu;

        */

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

        [_logic] spawn {

            private["_logic"];

            _logic = _this select 0;

            private["_line1","_line2","_line3","_line4","_baseCopy"];

            _line1 = "<br/><t size='1.5'>Map Analysis</t><br/><br/>";
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

        [ALIVE_sectorPlotter, "clear"] call ALIVE_fnc_plotSectors;

        _logic setVariable ["selectionState","Technology"];

        [_logic,"displaySelectionState"] call MAINCLASS;

    };

    case "activateSelectionProfiles": {

        [_logic] spawn {

            private["_logic"];

            _logic = _this select 0;

            private["_line1","_line2","_line3","_line4","_line5","_line6","_line7","_baseCopy"];

            _line1 = "<br/><t size='1.5'>Profile System</t><br/><br/>";
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

        [ALIVE_profileHandler, "debug", false] call ALIVE_fnc_profileHandler;

        _logic setVariable ["selectionState","Technology"];

        [_logic,"displaySelectionState"] call MAINCLASS;

    };

    case "activateSelectionOpcom": {

        [_logic] spawn {

            private["_logic"];

            _logic = _this select 0;

            private["_line1","_line2","_line3","_line4","_line5","_line6","_line7","_baseCopy"];

            _line1 = "<br/><t size='1.5'>OPCOM</t><br/><br/>";
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

        [_logic] spawn {

            private["_logic"];

            _logic = _this select 0;

            private["_line1","_line2","_line3","_line4","_line5","_line6","_line7","_baseCopy"];

            _line1 = "<br/><t size='1.5'>Objective Analysis</t><br/><br/>";
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

        [ALIVE_sectorPlotter, "clear"] call ALIVE_fnc_plotSectors;

        _logic setVariable ["selectionState","Technology"];

        [_logic,"displaySelectionState"] call MAINCLASS;

    };

    case "activateSelectionBattlefield": {

        [_logic] spawn {

            private["_logic"];

            _logic = _this select 0;

            private["_line1","_line2","_line3","_line4","_line5","_line6","_line7","_baseCopy"];

            _line1 = "<br/><t size='1.5'>Battlefield Analysis</t><br/><br/>";
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

        [ALIVE_sectorPlotter, "clear"] call ALIVE_fnc_plotSectors;

        _logic setVariable ["selectionState","Technology"];

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

        _title = "<t size='1.5' shadow='1'>OPCOM EVENT</t><br/>";
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

        _title = "<t size='1.5' shadow='1'>OPCOM EVENT</t><br/>";
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

        _title = "<t size='1.5' shadow='1'>OPCOM EVENT</t><br/>";
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

        _title = "<t size='1.5' shadow='1'>OPCOM EVENT</t><br/>";
        _text = format["%1<t>%2 OPCOM has reserved a %3 objective near %4</t>",_title,_side,_type,_nearestTown];

        ["openSideSmall",0.3] call ALIVE_fnc_displayMenu;
        ["setSideSmallText",_text] call ALIVE_fnc_displayMenu;

    };
};

TRACE_1("TOUR - output",_result);
_result;
