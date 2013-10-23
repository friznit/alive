#include "common.hpp"

class ALIVE_resourceRadio
{
	idd = 655555;
	onLoad = "_this call ALIVE_fnc_radioOnLoad";
	onUnload = "_this call ALIVE_fnc_radioOnUnload";
	
	class controls
	{
	
			class IGUIBack_2200: IGUIBack
		{
			idc = -1;
			x = 4.86 * GUI_GRID_W + GUI_GRID_X;
			y = 6.94 * GUI_GRID_H + GUI_GRID_Y;
			w = 30.5 * GUI_GRID_W;
			h = 12 * GUI_GRID_H;
		};
		class ALIVE_radioMap: RSCMapControl
				{
					idc = 655560;
			x = 21 * GUI_GRID_W + GUI_GRID_X;
			y = 7.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 13.5 * GUI_GRID_W;
			h = 11 * GUI_GRID_H;
		};
				

		class ALIVE_ListBox: RscListbox
		{
			idc = 1500;
			x = 5.5 * GUI_GRID_W + GUI_GRID_X;
			y = 9.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 4 * GUI_GRID_W;
			h = 3 * GUI_GRID_H;
			colorBackground[] = {0.663,0.663,0.663,1};
			colorText[] = {1,1,1,1};
		};
		class ALIVE_callSignText: RscText
		{
			idc = 1000;
			text = "Callsign"; //--- ToDo: Localize;
			x = 5.5 * GUI_GRID_W + GUI_GRID_X;
			y = 8 * GUI_GRID_H + GUI_GRID_Y;
			w = 4 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
			style = ST_CENTER;
			colorBackground[] = {-1,-1,-1,1};
		};
		class ALIVE_targetText: RscText
		{
			idc = 1001;
			text = "Target"; //--- ToDo: Localize;
			x = 5.5 * GUI_GRID_W + GUI_GRID_X;
			y = 13.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 4 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
			style = ST_CENTER;
			colorBackground[] = {-1,-1,-1,1};
		};
		class Alive_targetCombo: RscCombo
		{
			idc = 2100;
			x = 5.5 * GUI_GRID_W + GUI_GRID_X;
			y = 15 * GUI_GRID_H + GUI_GRID_Y;
			w = 7.5 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};
		class Alive_confirmButton: RscShortcutButton
		{
			idc = 1700;
			text = "Confirm"; //--- ToDo: Localize;
			x = 6 * GUI_GRID_W + GUI_GRID_X;
			y = 17 * GUI_GRID_H + GUI_GRID_Y;
			w = 6 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
			colorBackground[] = {0,0.4,0,1};
			style = ST_CENTER;
		};
		class ALIVE_closeButton: RscShortcutButton
		{
			idc = 1701;
			text = "Close"; //--- ToDo: Localize;
			x = 14 * GUI_GRID_W + GUI_GRID_X;
			y = 17 * GUI_GRID_H + GUI_GRID_Y;
			w = 6 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
			colorBackground[] = {0.596,0,0,1};
			style = ST_CENTER;
			action = "closeDialog 0";
		};
		class RscText_1003: RscText
		{
			idc = 1003;
			x = 0.385553;
			y = 0.941176;
			w = 0.1;
			h = 0.1;
		};
		class ALIVE_statusInfo: RscText
		{
			idc = 1004;
			text = ""; //--- ToDo: Localize;
			x = 12 * GUI_GRID_W + GUI_GRID_X;
			y = 9.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 8 * GUI_GRID_W;
			h = 3 * GUI_GRID_H;
			style = ST_CENTER;
		};
		class ALIVE_statusText: RscText
		{
			idc = 1002;
			text = "Status"; //--- ToDo: Localize;
			x = 13.5 * GUI_GRID_W + GUI_GRID_X;
			y = 8 * GUI_GRID_H + GUI_GRID_Y;
			w = 4 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
			colorBackground[] = {-1,-1,-1,1};
		};
	
	};
};


