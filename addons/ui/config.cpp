#include <script_component.hpp>
#include <CfgPatches.hpp>

// ALiVE Main UI

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
			text = "\x\alive\addons\UI\logo_alive_crop.paa";
			x = "1 * 			(			((safezoneW / safezoneH) min 1.2) / 40) + 			(safezoneX)";
			y = "9.3 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + 			(safezoneY + safezoneH - 			(			((safezoneW / safezoneH) min 1.2) / 1.2))";
			w = "7.5 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
			h = "3.75 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			tooltip = "$STR_ALIVE_UI_TOOLTIP_LOGO_ABOUT";
		};
	};
};