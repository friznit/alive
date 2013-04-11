#include "\A3\ui_f\hpp\defineResincl.inc"
#include "\A3\ui_f\hpp\defineResinclDesign.inc"

disableserialization;

_mode = _this select 0;
_params = _this select 1;
_class = _this select 2;

switch _mode do {

	case "onLoad": {
		_display = _params select 0;

		//--- Initial loading - maintain visual style of RscDisplayStart
		if !(uinamespace getvariable ["BIS_initGame",false]) exitwith
		{
			_ctrlLoadingStartLogo = _display displayctrl IDC_LOADINGSTART_LOGO;
			
			if((productVersion select 1) == "Arma3AlphaLite") then
			{
				_ctrlLoadingStartLogo ctrlSetText "\x\alive\addons\Main\logo_alive.paa";
			}
			else
			{
				_ctrlLoadingStartLogo ctrlSetText "\x\alive\addons\Main\logo_alive.paa";
			};
		};

		///////////////////////////////////////////////////////////////////////////////////////////

		//--- Hide start loading screen
		_ctrlLoadingStart = _display displayctrl IDC_LOADINGSTART_LOADINGSTART;
		_ctrlLoadingStart ctrlsetfade 1;
		_ctrlLoadingStart ctrlcommit 0;
		_pictureShot = "";

		//--- Map
		if (worldname != "") then {
			_ctrlMap = _display displayctrl IDC_LOADING_MAP;
			_ctrlMapName = _display displayctrl IDC_LOADING_MAPNAME;
			_ctrlMapAuthor = _display displayctrl IDC_LOADING_MAPAUTHOR;
			_ctrlMapDescription = _display displayctrl IDC_LOADING_MAPDESCRIPTION;

			_cfgWorld = configfile >> "cfgworlds" >> worldname;
			_worldName = gettext (_cfgWorld >> "description");
			_pictureMap = gettext (_cfgWorld >> "pictureMap");
			_pictureShot = gettext (_cfgWorld >> "pictureShot");
			if (_pictureMap == "") then {_pictureMap = "#(argb,8,8,3)color(1,1,1,0.2)";};
			_author = gettext (_cfgWorld >> "author");
			if (_author == "") then {_author = "Unknown Community Author"}; //--- ToDo: Localize
			_author = if (_author == "") then {""} else {format ["by %1",_author]}; //--- ToDo: Localize

			_ctrlMap ctrlsettext _pictureMap;
			_ctrlMapName ctrlsettext toupper _worldName;
			_ctrlMapAuthor ctrlsettext _author;
			//_ctrlMapDescription ctrlsettext "The Spartan, a monument placed on southernmost part of Stratis, was build in honor of downed pilot from the first Altisian Conflict.";
		};

		//--- Mission
		_fnc_loadMission = {

			disableserialization;
			_display = _this select 0;

			_ctrlMissionType = _display displayctrl IDC_LOADING_MISSIONGAMETYPE;
			_ctrlMissionName = _display displayctrl IDC_LOADING_MISSIONNAME;
			_ctrlMissionAuthor = _display displayctrl IDC_LOADING_MISSIONAUTHOR;
			_ctrlMissionPicture = _display displayctrl IDC_LOAD_MISSION_PICTURE;
			_ctrlMissionProgress = _display displayctrl IDC_PROGRESS_TIME;
			_ctrlMissionDescription = _display displayctrl IDC_LOADING_MISSIONDESCRIPTION;
			_ctrlMissionDescriptionEngine = _display displayctrl IDC_LOAD_MISSION_NAME;
			
			_ctrlALIVELogo = _display displayctrl 1202;
			_ctrlALIVELogo ctrlsettext "\x\alive\addons\UI\logo_alive.paa";

			_author = gettext (missionconfigfile >> "dev");
			if (_author == "" || !cheatsEnabled) then {_author = gettext (missionconfigfile >> "author");};
			_loadingPicture = gettext (missionconfigfile >> "loadScreen");
			_loadingName = gettext (missionconfigfile >> "onLoadName");
			_loadingTextConfig = if (false) then {gettext (missionconfigfile >> "onLoadIntro")} else {gettext (missionconfigfile >> "onLoadMission")};
			_loadingText = ctrltext _ctrlMissionDescriptionEngine;
			if (_loadingText in ["",localize "str_load_world"]) then {_loadingText = _loadingTextConfig;};
			_gameType = gettext (missionconfigfile >> "Header" >> "gameType");
			_gameTypeName = gettext (configfile >> "CfgMPGameTypes" >> _gameType >> "name");

			//_showMission = if (false) then {missionconfigfile >> "onLoadIntroTime"} else {missionconfigfile >> "onLoadMissionTime"};
			//_showMission = if (isnumber _showMission) then {getnumber _showMission > 0} else {true};

			//if (_showMission && (_loadingText != "" || _loadingPicture != "")) then {
			if (str missionconfigfile != "") then {
				_loadingName = _loadingName call (uinamespace getvariable "bis_fnc_localize");
				_loadingText = _loadingText call (uinamespace getvariable "bis_fnc_localize");

				if (_loadingName == "") then {_loadingName = "Unnamed Mission"}; //--- ToDo: Localize
				if (_author == "") then {_author = "Unknown Community Author"}; //--- ToDo: Localize

				_author = if (_author == "") then {} else {format ["by %1",_author]}; //--- ToDo: Localize
				if (_loadingPicture == "") then {_loadingPicture = _pictureShot;};

				if (_gameTypeName == "") then {_ctrlMissionType ctrlshow false;};

				_ctrlMissionType ctrlsettext toupper _gameTypeName;
				_ctrlMissionName ctrlsettext toupper _loadingName;
				_ctrlMissionAuthor ctrlsettext _author;
				_ctrlMissionPicture ctrlsettext _loadingPicture;
				_ctrlMissionDescription ctrlsetstructuredtext parsetext _loadingText;

				//--- Set height based on text
				_ctrlMissionDescriptionPos = ctrlposition _ctrlMissionDescription;
				_ctrlMissionDescriptionPos set [3,ctrltextheight _ctrlMissionDescription + 0.01];
				if (_loadingText == "") then {_ctrlMissionDescriptionPos set [3,0];};
				_ctrlMissionDescription ctrlsetposition _ctrlMissionDescriptionPos;
				_ctrlMissionDescription ctrlcommit 0;
			} else {
				_ctrlMission ctrlsetfade 1;
				_ctrlMission ctrlcommit 0;
			};
		};

		_ctrlMission = _display displayctrl IDC_LOADING_MISSION;
		if !(isnull _ctrlMission) then {
			[_display,0] call _fnc_loadMission;
			//[_display,1] spawn _fnc_loadMission; //--- Spawn it for detecting text passed to the scripted loading, not used in the engine loading
		};

		//--- Disclaimer
		_color = (["GUI","BCG_RGB"] call bis_fnc_displaycolorget);
		_color = +_color;
		_color set [3,1];

		_ctrlDisclaimerDescription = _display displayctrl IDC_LOADING_DISCLAIMERDESCRIPTION;
		_ctrlDisclaimerDescriptionLite = _display displayctrl IDC_LOADING_DISCLAIMERDESCRIPTIONLITE;

		_ctrlDisclaimerDescription ctrlsettextcolor _color;
		_ctrlDisclaimerDescriptionLite ctrlsettextcolor _color;

		//--- Hide Lite disclaimer
		if ((productVersion select 1) != "Arma3AlphaLite") then {
			_ctrlDisclaimerDescriptionLite ctrlshow false;
		};

		//--- Track mission time
/*
		if (str _display == "Display #101") then {
			[] call bis_fnc_trackMissionTime;
		};
*/
	};
};