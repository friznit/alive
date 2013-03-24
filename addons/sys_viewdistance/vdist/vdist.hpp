#include "GUI\commonDefs.hpp"
#include "GUI\rscCommon.hpp"

class vdist_Slider : RscSlider
{
}; 

#define X_MOD 60 
#define Y_MOD 10
#define SLIDER_START -19
#define SLIDER_INTERVAL 4
#define SLIDER_TITLE_SPACE 1.3

class vdist_dialog
{
	idd = 10568; 
	movingEnable = 1; 
	enableSimulation = 1;
	enableDisplay = 1; 
	
	onLoad = "vdist_dialog = _this; disableSerialization"; 
	

	class controls 
	{
		
		class RscText_1012: RscText
		{
			idc = 1012;
			text = "Viewdistance"; 
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
	};
};



