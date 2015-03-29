#include "\A3\ui_f\hpp\defineResincl.inc"
#include "\A3\ui_f\hpp\defineResinclDesign.inc"

disableserialization;

_mode = _this select 0;
_params = _this select 1;
_class = _this select 2;

switch _mode do {

	case "onLoad": {
		_display = _params select 0;
		RscDisplayLoading_display = _display;

		//--- Initial loading - maintain visual style of RscDisplayStart
		if !(uinamespace getvariable ["BIS_initGame",false]) exitwith
		{
			_ctrlLoadingStartLogo = _display displayctrl IDC_LOADINGSTART_LOGO;

/*			if((productVersion select 1) == "Arma3AlphaLite") then
			{
				_ctrlLoadingStartLogo ctrlSetText "\x\alive\addons\Main\logo_alive.paa";
			}
			else
			{
				_ctrlLoadingStartLogo ctrlSetText "\x\alive\addons\Main\logo_alive.paa";
			};
*/
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
			if (_pictureMap == "") then {_pictureMap = "#(argb,8,8,3)color(1,1,1,0.2)";};
			_pictureShot = gettext (_cfgWorld >> "pictureShot");
			_loadingTexts = getarray (_cfgWorld >> "loadingTexts");
			_loadingText = if (count _loadingTexts > 0) then {
				_loadingTexts select floor (((diag_ticktime / 10) % (count _loadingTexts)));
			} else {
				""
			};

			//--- Randomized map Y coordinate
			_worldType = uinamespace getvariable ["RscDisplayLoading_worldType",""];
			_ran = uinamespace getvariable ["RscDisplayLoading_ran",random 1];
			if (worldname != _worldType) then {
				_ran = random 1;
				uinamespace setvariable ["RscDisplayLoading_ran",_ran];
				uinamespace setvariable ["RscDisplayLoading_worldType",worldname];
			};
			_ctrlMapPos = ctrlposition _ctrlMap;
			_ctrlMapPos set [1,linearconversion [0,1,_ran,(safezoneY + safezoneH - (_ctrlMapPos select 3)),safezoneY,true]];
			_ctrlMap ctrlsetposition _ctrlMapPos;
			_ctrlMap ctrlcommit 0;

			//--- Set texts
			_ctrlMap ctrlsettext _pictureMap;
			_ctrlMapName ctrlsettext toupper _worldName;
			_ctrlMapAuthor ctrlsettext _author;
			_ctrlMapDescription ctrlsetstructuredtext parsetext _loadingText;

			[_cfgWorld,_ctrlMapAuthor] call bis_fnc_overviewauthor;
		};

		//--- Mission
		_fnc_loadMission = {

			disableserialization;
			_display = _this select 0;
			_isMultiplayer = servertime > 0;

			_ctrlMissionType = _display displayctrl IDC_LOADING_MISSIONGAMETYPE;
			_ctrlMissionName = _display displayctrl IDC_LOADING_MISSIONNAME;
			_ctrlMissionAuthor = _display displayctrl IDC_LOADING_MISSIONAUTHOR;
			_ctrlMissionPicture = _display displayctrl IDC_LOAD_MISSION_PICTURE;
			_ctrlMissionProgress = _display displayctrl IDC_PROGRESS_TIME;
			_ctrlMissionDescription = _display displayctrl IDC_LOADING_MISSIONDESCRIPTION;
			_ctrlMissionDescriptionEngine = _display displayctrl IDC_LOAD_MISSION_NAME;

			_ctrlALIVELogo = _display displayctrl 1202;
			_ctrlALIVELogo ctrlsettext "\x\alive\addons\UI\logo_alive.paa";

			//--- Picture
			_loadingPicture = gettext (missionconfigfile >> "loadScreen");
			if (_loadingPicture == "") then {_loadingPicture = gettext (missionconfigfile >> "overviewPicture");}; //--- Use overview data

			//--- Mission name
			_loadingName = gettext (missionconfigfile >> "onLoadName");

			//--- Description
			_loadingTextConfig = if (false) then {gettext (missionconfigfile >> "onLoadIntro")} else {gettext (missionconfigfile >> "onLoadMission")};
			_loadingText = ctrltext _ctrlMissionDescriptionEngine;
			if (_loadingText == "") then {_loadingText = _loadingTextConfig;}; //--- Use overview data
			if (_loadingText in ["",localize "str_load_world"]) then {_loadingText = gettext (missionconfigfile >> "overviewText");};

			//--- MP type
			_gameType = gettext (missionconfigfile >> "Header" >> "gameType");
			_gameTypeName = gettext (configfile >> "CfgMPGameTypes" >> _gameType >> "name");
			if (_gameTypeName == "") then {_gameTypeName = gettext (configfile >> "CfgMPGameTypes" >> "Unknown" >> "name");};

			//_showMission = if (false) then {missionconfigfile >> "onLoadIntroTime"} else {missionconfigfile >> "onLoadMissionTime"};
			//_showMission = if (isnumber _showMission) then {getnumber _showMission > 0} else {true};
			//if (_showMission && (_loadingText != "" || _loadingPicture != "")) then {

			//--- When loading a different terrain, current mission is sometimes still available. Check if it belongs to the terrain.
			_last = uinamespace getvariable ["RscDisplayLoading_last",[worldname,missionname]];
			_lastWorld = _last select 0;
			_lastMission = _last select 1;
			_showMission = if (missionname == _lastMission) then {worldname == _lastWorld} else {true};
			uinamespace setvariable ["RscDisplayLoading_last",[worldname,missionname]];

			//--- Get loading bars
			_progressMap = _display displayctrl IDC_PROGRESS_PROGRESS;
			if (isnull _progressMap) then {_display displayctrl IDC_CLIENT_PROGRESS};
			_progressMission = _display displayctrl IDC_LOADING_PROGRESSMISSION;
			RscDisplayLoading_progress = _progressMap;

			if (str missionconfigfile != "" && _showMission) then {
				_loadingName = _loadingName call (uinamespace getvariable "bis_fnc_localize");
				_loadingText = _loadingText call (uinamespace getvariable "bis_fnc_localize");

				if (_loadingName == "") then {_loadingName = localize "STR_a3_rscdisplay_loading_noname"};
				if (_loadingPicture == "") then {_loadingPicture = _pictureShot;};

				if (_gameTypeName != "" && _isMultiplayer) then {
					_ctrlMissionType ctrlsettext toupper _gameTypeName;
				} else {
					_ctrlMissionType ctrlshow false;
				};
				_ctrlMissionName ctrlsettext toupper _loadingName;
				_ctrlMissionPicture ctrlsettext _loadingPicture;
				_ctrlMissionDescription ctrlsetstructuredtext parsetext _loadingText;

				//--- Set height based on text
				_ctrlMissionDescriptionPos = ctrlposition _ctrlMissionDescription;
				_ctrlMissionDescriptionPos set [3,ctrltextheight _ctrlMissionDescription + 0.01];
				if (_loadingText == "") then {_ctrlMissionDescriptionPos set [3,0];};
				_ctrlMissionDescription ctrlsetposition _ctrlMissionDescriptionPos;
				_ctrlMissionDescription ctrlcommit 0;

				[missionconfigfile,_ctrlMissionAuthor] call bis_fnc_overviewauthor;


				//DLC notification--------------------------------------------------------------------
				//--- Set height based on text
				_ctrlDLCDescription = _display displayctrl IDC_LOADING_DLCDESCRIPTION;
				_ctrlDLCDescriptionPos = ctrlposition _ctrlDLCDescription;
				_ctrlDLCDescriptionPos set [3,ctrltextheight _ctrlDLCDescription + 0.01];
				_ctrlDLCDescription ctrlsetposition _ctrlDLCDescriptionPos;
				_ctrlDLCDescription ctrlcommit 0;

				//Show only if at least one DLC is not owned. Info is selected randomly among the non-owned DLCs.
				_showDLCLoading = false;

				//if(count(getDlcs 2) > 0) then
				if(false) then //SWITCHED OFF - since getDlcs 2 already returns some DLCs in Steam dev, even if none was released.
				{
					_showDLCLoading = true;

					//Separate DLCs from mods (DLC has appID defined, mods not).
					_notOwnedDLCs = [];

					{
						_appId = getNumber (_x >> "appId");

						if (_appId != 0) then
						{
							_notOwnedDLCs = _notOwnedDLCs + [_appId];
						};

					} foreach ((configfile >> "CfgMods") call bis_fnc_returnChildren);

					//Randomly select one of the non-owned DLCs and read info from it
					_selectedDLC = floor(random (count _notOwnedDLCs));

					{
						if(getNumber(_x >> "appId") == (_notOwnedDLCs select _selectedDLC)) then
						{
							//name
							_ctrl = _display displayctrl IDC_LOADING_DLCNAME;
							_ctrl ctrlSetText getText(_x >> "name");
							//author
							_ctrl = _display displayctrl IDC_LOADING_DLCAUTHOR;
							_ctrl ctrlSetText (format [localize "STR_FORMAT_AUTHOR_SCRIPTED", getText(_x >> "author")]);
							//icon
							_ctrl = _display displayctrl IDC_LOADING_DLCICON;
							_ctrl ctrlSetText getText(_x >> "picture");
							//picture
							_ctrl = _display displayctrl IDC_LOADING_DLCPICTURE;
							_ctrl ctrlSetText getText(_x >> "overviewPicture");
						};
					} foreach ((configfile >> "CfgMods") call bis_fnc_returnChildren);
				};

				//Show/hide DLC part of loading screen
				{
					(_display displayctrl _x) ctrlshow _showDLCLoading;
				}
				forEach
				[
					IDC_LOADING_DLCPICTUREBACK,
					IDC_LOADING_DLCPICTURE,
					IDC_LOADING_DLCDESCRIPTION,
					IDC_LOADING_DLCNAME,
					IDC_LOADING_DLCAUTHOR,
					IDC_LOADING_DLCSTRIPE,
					IDC_LOADING_DLCICON
				];

				//DLC notification--------------------------------------------------------------------


				//--- Mission loading bar
				_progressMapPos = ctrlposition _progressMap;
				_progressMissionPos = ctrlposition _progressMission;
				if (missionnamespace getvariable ["RscDisplayLoading_progressMission",false]) then {

					//--- Mission loading - make the terrain bar full and animate only the mission bar
					_progressMap ctrlsetposition _progressMissionPos;
					_progressMap ctrlcommit 0;
					_progressMission ctrlsetposition _progressMapPos;
					_progressMission ctrlcommit 0;
					_progressMission progresssetposition 1;
				} else {

					//--- When loading a different map, a rogue loading screen without progress bar appears. Move the progress bar by script.
					_limit = [1,2] select _isMultiplayer;
					if (count (uinamespace getvariable "loading_displays") > _limit) then {
						_progressMap ctrlshow false;
						_progressMission ctrlsetposition _progressMapPos;
						_progressMission ctrlcommit 0;
						_progressMission progresssetposition 0.33;
					} else {
						_progressMission ctrlshow false;
					};
				};
			} else {
				_ctrlMission ctrlsetfade 1;
				_ctrlMission ctrlcommit 0;
			};
		};

		_ctrlMission = _display displayctrl IDC_LOADING_MISSION;
		if (!(isnull _ctrlMission)) then {
			[_display,0] call _fnc_loadMission;
			//[_display,1] spawn _fnc_loadMission; //--- Spawn it for detecting text passed to the scripted loading, not used in the engine loading
		};

		//--- Disclaimer - Moved here to prevent showing Lite Disclaimer when starting/shutting down the game
		if (getnumber (configfile >> "CfgMods" >> "gamma") == 1) then {
			_ctrlDisclaimer = _display displayctrl IDC_LOADING_DISCLAIMER;
			_ctrlDisclaimerName = _display displayctrl IDC_LOADING_DISCLAIMERNAME;
			_ctrlDisclaimerDescription = _display displayctrl IDC_LOADING_DISCLAIMERDESCRIPTION;

			_build = productversion select 4;
			if (_build == "Development") then {
				_ctrlDisclaimerName ctrlsettext format ["%1 - %2",localize "str_a3_rscdisplay_loading_dev",ctrltext ((finddisplay 0) displayctrl 118)];
				_ctrlDisclaimerDescription ctrlsetstructuredtext parsetext localize "str_a3_rscdisplay_loading_devinfo";
				_ctrlDisclaimerDescription ctrlsettextcolor [1,1,1,1];
				[_ctrlDisclaimerDescription,0.01] call bis_fnc_ctrlFitToTextHeight;
			} else {
				_ctrlDisclaimer ctrlshow false;
			};
		};

		//--- Track mission time
/*
		if (str _display == "Display #101") then {
			[] call bis_fnc_trackMissionTime;
		};
*/
	};
};