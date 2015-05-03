#include <script_component.hpp>
#include <CfgPatches.hpp>
#include "CfgFunctions.hpp"
#include "c_ui.hpp"


// ALiVE Main UI
class Extended_PreInit_EventHandlers
{
	class alive_ui
	{
		clientInit = "call compile preProcessFileLineNumbers '\x\alive\addons\ui\XEH_preClientInit.sqf'";
	};
};
class RscText;
class RscShortcutButton;
//-------------------------------------
class _flexiMenu_RscShortcutButton: RscShortcutButton
{
	class HitZone
	{
		left = 0.002;
		top = 0.003;
		right = 0.002;
		bottom = 0.003; //0.016;
	};
	class ShortcutPos
	{
		left = -0.006;
		top = -0.007;
		w = 0.0392157;
		h = 2*(safeZoneH/36); //0.0522876;
	};
	class TextPos
	{
		left = 0.01; // indent
		top = 0.002;
		right = 0.01;
		bottom = 0.002; //0.016;
	};
};
//-----------------------------------------------------------------------------
#include "flexiMenu\data\menu_popup.hpp"

class RscStandardDisplay;
class RscPicture;
class RscPictureKeepAspect;
class RscStructuredText;
class RscControlsGroup;
class RscControlsGroupNoScrollbars;
class RscButtonMenu;
class RscButtonMenuCancel;
class RscTitle;
class RscDebugConsole;
class RscScrollBar;

class cfgScriptPaths
{
	alive = "\x\alive\addons\UI\";
};



class RscDisplayLoadMission: RscStandardDisplay
{
	onLoad = "[""onLoad"",_this,""RscDisplayLoadingALIVE"",'Loading'] call compile preprocessfilelinenumbers ""\x\alive\addons\UI\initDisplay.sqf""";
	class controls
	{
		class ALIVE_Logo: RscPictureKeepAspect
		{
			idc = 1202;
			text = "\x\alive\addons\UI\logo_alive.paa";
			x = 0.835156 * safezoneW + safezoneX;
			y = 0.841 * safezoneH + safezoneY;
			w = 0.154687 * safezoneW;
			h = 0.143 * safezoneH;
			colorText[] = {1,1,1,0.5};
		};
	};
};


class RscBackgroundLogo: RscPictureKeepAspect
{
//	text = "\x\alive\addons\UI\logo_alive.paa";
	align = "top";
	background = 1;
	x = "safezoneX + safezoneW - (9 * 			(		((safezoneW / safezoneH) min 1.2) / 32))";
	y = "safezoneY - 2 * 			(		(		((safezoneW / safezoneH) min 1.2) / 1.2) / 20)";
	w = "(8 * 			(		((safezoneW / safezoneH) min 1.2) / 32))";
	h = "(8 * 			(		(		((safezoneW / safezoneH) min 1.2) / 1.2) / 20))";
};


class RscDisplayMain: RscStandardDisplay
{
	class controls
	{
		class ALiVEGameLogo: RscPicture
		{
			idc = 1202;
			text = "\x\alive\addons\UI\logo_alive_white.paa";
			tooltip = "$STR_ALIVE_UI_TOOLTIP_LOGO_ABOUT";
			x = "safezoneX + safezoneW - 5.2 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
			y = "21 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + 			(safezoneY + safezoneH - 			(			((safezoneW / safezoneH) min 1.2) / 1.2))";
			w = "3 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";			
			h = "1.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";	
		};
	};
};

class RscDisplayMPInterrupt: RscStandardDisplay
{
	// Needing to do this due to broken serverCommandAvailable in 1.32
	onLoad = "[""onLoad"",_this,""RscDisplayMPInterruptALIVE"",'Loading'] call compile preprocessfilelinenumbers ""\x\alive\addons\UI\initDisplay.sqf""";	
	class controls
	{
		delete ButtonAbort;
		class ALiVETitle: RscTitle
		{
			idc = 599;
			style = 0;
			text = "ALiVE Menu";
			x = "1 * 			(((safezoneW / safezoneH) min 1.2) /40) + safezoneX + (16 * (((safezoneW / safezoneH) min 1.2) /40))";
			y = "17.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + 			(safezoneY + safezoneH - 			(			((safezoneW / safezoneH) min 1.2) / 1.2))";
			w = "15 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
			h = "1 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			colorBackground[] = {0.69,0.75,0.5,0.8};
		};
		class ALiVEButtonServerSave: RscButtonMenu
		{
			idc = 195;
			text = "SERVER SAVE AND EXIT (Admin Only)";
			x = "1 * 			(((safezoneW / safezoneH) min 1.2) /40) + safezoneX + (16 * (((safezoneW / safezoneH) min 1.2) /40))";
			y = "18.6 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + 			(safezoneY + safezoneH - 			(			((safezoneW / safezoneH) min 1.2) / 1.2))";
			w = "15 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
			h = "1 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
		};		
		class ALiVEButtonServerAbort: RscButtonMenu
		{
			idc = 196;
			text = "SERVER EXIT (Admin Only)";
			x = "1 * 			(((safezoneW / safezoneH) min 1.2) /40) + safezoneX + (16 * (((safezoneW / safezoneH) min 1.2) /40))";
			y = "19.7 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + 			(safezoneY + safezoneH - 			(			((safezoneW / safezoneH) min 1.2) / 1.2))";
			w = "15 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
			h = "1 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
		};
		class ALiVEButtonSave: RscButtonMenu
		{
			idc = 198;
			text = "PLAYER EXIT";
			x = "1 * 			(((safezoneW / safezoneH) min 1.2) /40) + safezoneX + (16 * (((safezoneW / safezoneH) min 1.2) /40))";
			y = "20.8 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + 			(safezoneY + safezoneH - 			(			((safezoneW / safezoneH) min 1.2) / 1.2))";
			w = "15 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
			h = "1 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			action = "['SAVE'] call alive_fnc_buttonAbort";
		};
		class ALIVEButtonAbort: RscButtonMenu
		{
			idc = 199;
			text = "$STR_DISP_INT_ABORT";
			x = "1 * 			(			((safezoneW / safezoneH) min 1.2) / 40) + 			(safezoneX)";
			y = "20.8 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + 			(safezoneY + safezoneH - 			(			((safezoneW / safezoneH) min 1.2) / 1.2))";
			w = "15 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
			h = "1 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			action = "['ABORT'] call alive_fnc_buttonAbort";
		};
		class DebugConsole: RscDebugConsole
		{
			x = "33 * 			(			((safezoneW / safezoneH) min 1.2) / 40) + 			(safezoneX)";
		};
	};
};


class CfgDebriefing
{  
	class Saved
	{
		title = "Player Progress Saved";
		subtitle = "";
		description = "You have saved your mission progress.";
		pictureBackground = "";
		picture = "b_inf";
		pictureColor[] = {0.0,0.3,0.6,1};
	};
	class Abort
	{
		title = "Mission Exit";
		subtitle = "";
		description = "You have quit from the current running mission";
		pictureBackground = "";
		picture = "b_inf";
		pictureColor[] = {0.0,0.3,0.6,1};
	};
	class ServerSaved
	{
		title = "Mission Progress Saved";
		subtitle = "";
		description = "You have saved the mission, mission will now exit.";
		pictureBackground = "";
		picture = "b_hq";
		pictureColor[] = {0.0,0.3,0.6,1};
	};
	class ServerAbort
	{
		title = "Mission Exit";
		subtitle = "";
		description = "The Mission will now exit.";
		pictureBackground = "";
		picture = "b_hq";
		pictureColor[] = {0.0,0.3,0.6,1};
	};
};

#include <\x\alive\addons\ui\menu\data\menu_common.hpp>
#include <\x\alive\addons\ui\menu\data\menu_full.hpp>
#include <\x\alive\addons\ui\menu\data\menu_full_image.hpp>
#include <\x\alive\addons\ui\menu\data\menu_full_map.hpp>
#include <\x\alive\addons\ui\menu\data\menu_modal.hpp>
#include <\x\alive\addons\ui\menu\data\menu_wide.hpp>

class RscTitles {
    #include <\x\alive\addons\ui\menu\data\splash.hpp>
    #include <\x\alive\addons\ui\menu\data\menu_side.hpp>
    #include <\x\alive\addons\ui\menu\data\menu_side_small.hpp>
    #include <\x\alive\addons\ui\menu\data\menu_side_top.hpp>
    #include <\x\alive\addons\ui\menu\data\menu_side_top_small.hpp>
    #include <\x\alive\addons\ui\menu\data\menu_side_full.hpp>
    #include <\x\alive\addons\ui\menu\data\subtitle_side_small.hpp>
};
