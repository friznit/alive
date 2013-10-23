

class ALIVE_Dialog
{
	idd =-1;
	movingenable = true;

class Controls
{
class ALIVE_FRAME: ALIVE_RscFrame
{
	idc = 1800;
	text = "CAS"; //--- ToDo: Localize;
	x = 4.86 * GUI_GRID_W + GUI_GRID_X;
	y = 6.94 * GUI_GRID_H + GUI_GRID_Y;
	w = 30.5 * GUI_GRID_W;
	h = 12 * GUI_GRID_H;
};
class ALIVE_miniMAP: ALIVE_rscMap
{
idc = 655560;
};
class ALIVE_casList: ALIVE_RscListbox
{
	idc = 1500;
	x = 5.5 * GUI_GRID_W + GUI_GRID_X;
	y = 9.5 * GUI_GRID_H + GUI_GRID_Y;
	w = 4 * GUI_GRID_W;
	h = 3 * GUI_GRID_H;
	type = 0;
	text="";
	style = 0 + 0x10;
	font = "PuristaMedium";
	sizeEx = 0.03921;
	color[] = {1, 1, 1, 1};
	colorText[] = {0.95, 0.95, 0.95, 1};
	colorScrollbar[] = {0.95, 0.95, 0.95, 1};
	colorSelect[] = {0.023529, 0, 0.0313725, 1};
	colorSelect2[] = {0.023529, 0, 0.0313725, 1};
	colorSelectBackground[] = {0.58, 0.1147, 0.1108, 1};
	colorSelectBackground2[] = {0.58, 0.1147, 0.1108, 1};
	period = 1;
	colorBackground[] = {0, 0, 0, 1};
	maxHistoryDelay = 1.0;
	autoScrollSpeed = -1;
	autoScrollDelay = 5;
	autoScrollRewind = 0;
	linespacing = 1;
	class ScrollBar {
		color[] = {1, 1, 1, 0.6};
		colorActive[] = {1, 1, 1, 1};
		colorDisabled[] = {1, 1, 1, 0.3};
		thumb = "\ca\ui\data\ui_scrollbar_thumb_ca.paa";
		arrowFull = "\ca\ui\data\ui_arrow_top_active_ca.paa";
		arrowEmpty = "\ca\ui\data\ui_arrow_top_ca.paa";
		border = "\ca\ui\data\ui_border_scroll_ca.paa";
	};
};
class ALIVE_callsignText: ALIVE_RscText
{
	idc = 1000;
	text = "Callsign"; //--- ToDo: Localize;
	style = ALIVE_CENTER;
	x = 5.5 * GUI_GRID_W + GUI_GRID_X;
	y = 8 * GUI_GRID_H + GUI_GRID_Y;
	w = 4 * GUI_GRID_W;
	h = 1 * GUI_GRID_H;
	colorBackground[] = {-1,-1,-1,1};
	type = 0;
	font = ALIVEFontM;
	colorText[] = { 0, 0, 0, 1 };
	sizeEx = 0.0;
	
};
class ALIVE_targetText: ALIVE_RscText
{
	idc = 1001;
	text = "Target"; //--- ToDo: Localize;
	x = 5.5 * GUI_GRID_W + GUI_GRID_X;
	y = 13.5 * GUI_GRID_H + GUI_GRID_Y;
	w = 4 * GUI_GRID_W;
	h = 1 * GUI_GRID_H;
	colorBackground[] = {-1,-1,-1,1};
	type = 0;
		font = ALIVEFontM;
	colorText[] = { 0, 0, 0, 1 };
	sizeEx = 0.0;
};
class ALIVE_targetCombo: Alive_RscCombo
{
	idc = 2100;
	x = 5.5 * GUI_GRID_W + GUI_GRID_X;
	y = 15 * GUI_GRID_H + GUI_GRID_Y;
	w = 7.5 * GUI_GRID_W;
	h = 1 * GUI_GRID_H;
	type = ALIVE_COMBO;
		style = ALIVE_LEFT;
		rowHeight = 0.028;
		wholeHeight = 13 * 0.028;
		color[] = {1,1,1,1};
		colorSelect[] = {0.70, 0.99, 0.65, 1};
			colorActive[] = {1, 1, 1, 1};
			colorDisabled[] = {1, 1, 1, 0.3};
		colorBackground[] = {0.28, 0.36, 0.26, 1};
		colorSelectBackground[] = {0.36, 0.46, 0.36, 1};
		soundSelect[] = {"", 0.0, 1};
		soundExpand[] = {"", 0.0, 1};
		soundCollapse[] = {"", 0.0, 1};
		arrowEmpty = "\ca\ui\data\ui_arrow_combo_ca.paa";
		arrowFull = "\ca\ui\data\ui_arrow_combo_active_ca.paa";
		maxHistoryDelay = 1;
		font = ALIVEFontM;
	colorText[] = { 0, 0, 0, 1 };
	sizeEx = 0.0;
		class ScrollBar
		{
			color[] = {1, 1, 1, 0.6};
			colorActive[] = {1, 1, 1, 1};
			colorDisabled[] = {1, 1, 1, 0.3};
			thumb = "\ca\ui\data\ui_scrollbar_thumb_ca.paa";
			arrowFull = "\ca\ui\data\ui_arrow_top_active_ca.paa";
			arrowEmpty = "\ca\ui\data\ui_arrow_top_ca.paa";
			border = "\ca\ui\data\ui_border_scroll_ca.paa";
		};
	};
class Alive_confirmButton: ALIVE_RscButton
{
	idc = 1700;
	text = "Confirm"; //--- ToDo: Localize;
	x = 6 * GUI_GRID_W + GUI_GRID_X;
	y = 17 * GUI_GRID_H + GUI_GRID_Y;
	w = 6 * GUI_GRID_W;
	h = 1.5 * GUI_GRID_H;
	type = 0;
	font = ALIVEFontM;
	colorText[] = { 0, 0, 0, 1 };
	sizeEx = 0.0;
};

class ALIVE_closeButton: ALIVE_RscButton
{
	idc = 1701;
	text = "Close"; //--- ToDo: Localize;
	x = 14 * GUI_GRID_W + GUI_GRID_X;
	y = 17 * GUI_GRID_H + GUI_GRID_Y;
	w = 6 * GUI_GRID_W;
	h = 1.5 * GUI_GRID_H;
	type = 0;
	font = ALIVEFontM;
	colorText[] = { 0, 0, 0, 1 };
	sizeEx = 0.0;
};

class RscText_1003: ALIVE_RscText
{
	idc = 1003;
	x = 0.385553;
	y = 0.941176;
	w = 0.1;
	h = 0.1;
		colorBackground[] = {-1,-1,-1,1};
	type = 0;
		font = ALIVEFontM;
	colorText[] = { 0, 0, 0, 1 };
	sizeEx = 0.0;
};
class ALIVE_statusInfo: ALIVE_RscText
{
	idc = 1004;
	text = "Status"; //--- ToDo: Localize;
	x = 12 * GUI_GRID_W + GUI_GRID_X;
	y = 9.5 * GUI_GRID_H + GUI_GRID_Y;
	w = 8 * GUI_GRID_W;
	h = 3 * GUI_GRID_H;
		colorBackground[] = {-1,-1,-1,1};
	type = 0;
		font = ALIVEFontM;
	colorText[] = { 0, 0, 0, 1 };
	sizeEx = 0.0;
};
class ALIVE_statusText: ALIVE_RscText
{
	idc = 1002;
	text = "Status"; //--- ToDo: Localize;
	x = 13.5 * GUI_GRID_W + GUI_GRID_X;
	y = 8 * GUI_GRID_H + GUI_GRID_Y;
	w = 4 * GUI_GRID_W;
	h = 1 * GUI_GRID_H;
	colorBackground[] = {-1,-1,-1,1};
	type = 0;
	font = ALIVEFontM;
	colorText[] = { 0, 0, 0, 1 };
	sizeEx = 0.0;
};

};

};