#include "Common.hpp"
#include "commonDefines.hpp"

#define X_MOD 52 
#define X_MODB 51.5
#define Y_MOD 10
#define SLIDER_START -19
#define SLIDER_INTERVAL 4
#define SLIDER_TITLE_SPACE 1.3
#define GUI_GRID_WAbs			((safezoneW / safezoneH) min 1.2)
#define GUI_GRID_HAbs			(GUI_GRID_WAbs / 1.2)
#define GUI_GRID_W			(GUI_GRID_WAbs / 40)
#define GUI_GRID_H			(GUI_GRID_HAbs / 25)
#define GUI_GRID_X			(safezoneX)
#define GUI_GRID_Y			(safezoneY + safezoneH - GUI_GRID_HAbs)

class newsfeed_dialog
{
	idd = 660002; 
	movingEnable = 1; 
	enableSimulation = 1;
	enableDisplay = 1; 
	
	onLoad = "newsfeed_dialog = _this; disableSerialization"; 
	

	class controls 
	{
			
		class NewsTitle: RscText
				{
					colorBackground[] = {0.69,0.75,0.5,0.8};
					idc = 1003;
					x = "0 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
					y = "0 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					w = "15 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
					h = "1 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
				};
				class NewsBackgroundDate: RscText
				{
					idc = 1002;
					x = "0 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
					y = "1.1 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					w = "15 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
					h = "1 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					colorBackground[] = {0,0,0,0.4};
				};
				class NewsBackground: RscText
				{
					idc = 1005;
					x = "0 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
					y = "2.2 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					w = "15 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
					h = "17.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					colorBackground[] = {0,0,0,0.4};
				};
				class NewsText: RscHTML
				{	
					filename = "http://www.kevingunn.co.uk/alive_news.php";
					shadow = 0;
					class H1
					{
						font = "PuristaMedium";
						fontBold = "PuristaLight";
						sizeEx = "(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.2)";
					};
					class H2: H1
					{
						sizeEx = "(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.2)";
						font = "PuristaLight";
					};
					class P: H1
					{
						sizeEx = "(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
						fontBold = "PuristaLight";
					};
					colorBold[] = {0.6,0.6,0.6,1};
					colorLink[] = {0.69,0.75,0.5,1};
					colorLinkActive[] = {0.69,0.75,0.5,1};
					idc = 1004;
					x = "0.5 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
					y = "-0.1 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					w = "14 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
					h = "19.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
				};	
	};
};
