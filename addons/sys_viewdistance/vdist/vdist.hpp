#include "slider\commonDefs.hpp"
#include "slider\rscCommon.hpp"

class vdist_Slider : RscSlider
{
}; 

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

class vdist_dialog
{
	idd = 10568; 
	movingEnable = 1; 
	enableSimulation = 1;
	enableDisplay = 1; 
	
	onLoad = "vdist_dialog = _this; disableSerialization"; 
	

	class controls 
	{
		class vdistback: IGUIBack
		{
			type = 0;
			idc = 124;
			style = 128;
			text = "Set View Settings";
			colorText[] = {0,0,0,0};
			font = GUI_FONT_NORMAL;
			sizeEx = 0;
			shadow = 0;
			x = X_MODB * GUI_GRID_W + GUI_GRID_X;
			y = (SLIDER_START - SLIDER_TITLE_SPACE)  * GUI_GRID_H + GUI_GRID_Y;
			w = 16 * GUI_GRID_W;
			h = 5.1 * GUI_GRID_H;
			colorbackground[] = {0,0,0,0.5};
		};
		
		class RscText_1012: RscText
		{
			idc = 1012;
			text = "View Distance"; 
			x = X_MOD * GUI_GRID_W + GUI_GRID_X;
			y = (SLIDER_START - SLIDER_TITLE_SPACE)  * GUI_GRID_H + GUI_GRID_Y;
			w = 14.5 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		
		class RscSlider_1912: RscSlider // view distance slider
		{
			idc = 1912;
			x = X_MOD * GUI_GRID_W + GUI_GRID_X;
			y = SLIDER_START * GUI_GRID_H + GUI_GRID_Y;
			w = 15 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};	
		class RscText_1013: RscText
		{
			idc = 1013;
			text = "Terrain Detail"; 
			x = X_MOD * GUI_GRID_W + GUI_GRID_X;
			y = ((SLIDER_START + (SLIDER_INTERVAL * 0.5))-SLIDER_TITLE_SPACE)  * GUI_GRID_H + GUI_GRID_Y;
			w = 14.5 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		
		class RscSlider_1913: RscSlider // view distance slider
		{
			idc = 1913;
			x = X_MOD * GUI_GRID_W + GUI_GRID_X;
			y = (SLIDER_START + (SLIDER_INTERVAL * 0.5)) * GUI_GRID_H + GUI_GRID_Y;
			w = 15 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};	
	};
};
