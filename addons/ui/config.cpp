#include <script_component.hpp>
#include <CfgPatches.hpp>
#include "CfgFunctions.hpp"


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
class RscControlsGroup;
class RscControlsGroupNoScrollbars;

class cfgScriptPaths
{
	alive = "\x\alive\addons\UI\";
};

class RscDisplayStart: RscStandardDisplay
{
 onLoad = "[""onLoad"",_this,""RscDisplayLoadingALIVE"",'Loading'] call compile preprocessfilelinenumbers ""\x\alive\addons\UI\initDisplay.sqf""";
 class controls
 {
  class LoadingStart: RscControlsGroup
  {
    class controls
	{
		class Logo: RscPictureKeepAspect
		{
			idc = 1200;
			text = "\x\alive\addons\UI\logo_alive.paa";
			x = "0.25 * safezoneW";
			y = "0.3125 * safezoneH";
			w = "0.5 * safezoneW";
			h = "0.25 * safezoneH";
		};
		class Noise: RscPicture
		{
			text = "\x\alive\addons\UI\alive_bg.paa";
		};
	};
  };
 };
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
	text = "\x\alive\addons\UI\logo_alive.paa";
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
		class GameLogo: RscPicture
		{
			idc = 1202;
			text = "\x\alive\addons\UI\logo_alive_white.paa";
			tooltip = "$STR_ALIVE_UI_TOOLTIP_LOGO_ABOUT";
		};
	};
};
