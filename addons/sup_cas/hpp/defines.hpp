// Control types
/*#define CT_STATIC           0
#define CT_BUTTON           1
#define CT_EDIT             2
#define CT_SLIDER           3
#define CT_COMBO            4
#define CT_LISTBOX          5
#define CT_TOOLBOX          6
#define CT_CHECKBOXES       7
#define CT_PROGRESS         8
#define CT_HTML             9
#define CT_STATIC_SKEW      10
#define CT_ACTIVETEXT       11
#define CT_TREE             12
#define CT_STRUCTURED_TEXT  13
#define CT_CONTEXT_MENU     14
#define CT_CONTROLS_GROUP   15
#define CT_SHORTCUTBUTTON   16
#define CT_XKEYDESC         40
#define CT_XBUTTON          41
#define CT_XLISTBOX         42
#define CT_XSLIDER          43
#define CT_XCOMBO           44
#define CT_ANIMATED_TEXTURE 45
#define CT_OBJECT           80
#define CT_OBJECT_ZOOM      81
#define CT_OBJECT_CONTAINER 82
#define CT_OBJECT_CONT_ANIM 83
#define CT_LINEBREAK        98
#define CT_USER             99
#define CT_MAP              100
#define CT_MAP_MAIN         101
#define CT_LISTNBOX         102

// Static styles
#define ST_POS            0x0F
#define ST_HPOS           0x03
#define ST_VPOS           0x0C
#define ST_LEFT           0x00
#define ST_RIGHT          0x01
#define ST_CENTER         0x02
#define ST_DOWN           0x04
#define ST_UP             0x08
#define ST_VCENTER        0x0C
#define ST_GROUP_BOX       96
#define ST_GROUP_BOX2      112
#define ST_ROUNDED_CORNER  ST_GROUP_BOX + ST_CENTER
#define ST_ROUNDED_CORNER2 ST_GROUP_BOX2 + ST_CENTER

#define ST_TYPE           0xF0
#define ST_SINGLE         0x00
#define ST_MULTI          0x10
#define ST_TITLE_BAR      0x20
#define ST_PICTURE        0x30
#define ST_FRAME          0x40
#define ST_BACKGROUND     0x50
#define ST_GROUP_BOX      0x60
#define ST_GROUP_BOX2     0x70
#define ST_HUD_BACKGROUND 0x80
#define ST_TILE_PICTURE   0x90
#define ST_WITH_RECT      0xA0
#define ST_LINE           0xB0

#define ST_SHADOW         0x100
#define ST_NO_RECT        0x200
#define ST_KEEP_ASPECT_RATIO  0x800

#define ST_TITLE          ST_TITLE_BAR + ST_CENTER

// Slider styles
#define SL_DIR            0x400
#define SL_VERT           0
#define SL_HORZ           0x400

#define SL_TEXTURES       0x10

// progress bar 
#define ST_VERTICAL       0x01
#define ST_HORIZONTAL     0

// Listbox styles
#define LB_TEXTURES       0x10
#define LB_MULTI          0x20

// Tree styles
#define TR_SHOWROOT       1
#define TR_AUTOCOLLAPSE   2

// MessageBox styles
#define MB_BUTTON_OK      1
#define MB_BUTTON_CANCEL  2
#define MB_BUTTON_USER    4
#define ALIVE_TEXT 6 
#define ALIVE_STATIC 0
#define ALIVE_BUTTON 1
#define ALIVE_EDIT 2
#define ALIVE_SLIDER 3
#define ALIVE_COMBO 4
#define ALIVE_LISTBOX 5
#define ALIVE_TOOLBOX 6
#define ALIVE_CHECKBOXES 7
#define ALIVE_PROGRESS 8
#define ALIVE_HTML 9
#define ALIVE_STATIC_SKEW 10
#define ALIVE_ACTIVETEXT 11
#define ALIVE_TREE 12
#define ALIVE_STRUCTURED_TEXT 13
#define ALIVE_CONTEXT_MENU 14
#define ALIVE_CONTROLS_GROUP 15
#define ALIVE_XKEYDESC 40
#define ALIVE_XBUTTON 41
#define ALIVE_XLISTBOX 42
#define ALIVE_XSLIDER 43
#define ALIVE_XCOMBO 44
#define ALIVE_ANIMATED_TEXTURE 45
#define ALIVE_OBJECT 80
#define ALIVE_OBJECT_ZOOM 81
#define ALIVE_OBJECT_CONTAINER 82
#define ALIVE_OBJECT_CONT_ANIM 83
#define ALIVE_LINEBREAK 98
#define ALIVE_USER 99
#define ALIVE_MAP 100
#define ALIVE_MAP_MAIN 101 // Static styles
#define ALIVE_POS 0x0F
#define ALIVE_HPOS 0x03
#define ALIVE_VPOS 0x0C
#define ALIVE_LEFT 0x00
#define ALIVE_RIGHT 0x01
#define ALIVE_CENTER 0x02
#define ALIVE_DOWN 0x04
#define ALIVE_UP 0x08
#define ALIVE_VCENTER 0x0c
#define ALIVE_TYPE 0xF0
#define ALIVE_SINGLE 0
#define ALIVE_MULTI 16
#define ALIVE_TITLE_BAR 32
#define ALIVE_PICTURE 48
#define ALIVE_FRAME 64
#define ALIVE_BACKGROUND 80
#define ALIVE_GROUP_BOX 96

#define ALIVE_GROUP_BOX2 112
#define ALIVE_HUD_BACKGROUND 128
#define ALIVE_TILE_PICTURE 144
#define ALIVE_WITH_RECT 160
#define ALIVE_LINE 176
#define ALIVEFontM "PuristaMedium"
#define Size_Main_Small 0.027
#define Size_Main_Normal 0.04
#define Size_Text_Default Size_Main_Normal
#define Size_Text_Small Size_Main_Small
#define Color_White {1, 1, 1, 1}
#define Color_Main_Foreground1 Color_White
#define Color_Text_Default Color_Main_Foreground1

#define LB_TEXTURES 0x10
#define LB_MULTI 0x20 

#define SL_DIR 0x400
#define SL_VERT 0
#define SL_HORZ 0x400

#define true 1
#define false 0



////////////////
//Base Classes//
////////////////

class ALIVE_RscText
{
    access = 0;

    type = CT_STATIC;
    style = ST_MULTI;
    linespacing = 1;
    colorBackground[] = {0,0,0,0};
    colorText[] = {1,1,1,.5};
    text = "";
    shadow = 2;
    font = "puristamedium";
    SizeEx = 0.02300;
    fixedWidth = 0;
    x = 0;
    y = 0;
    h = 0;
    w = 0;
   
};


class ALIVE_RscButton
{
    
   access = 0;
    type = CT_BUTTON;
    text = "";
    colorText[] = {1,1,1,.9};
    colorDisabled[] = {0.4,0.4,0.4,0};
    colorBackground[] = {0.75,0.75,0.75,0.8};
    colorBackgroundDisabled[] = {0,0.0,0};
    colorBackgroundActive[] = {0.75,0.75,0.75,1};
    colorFocused[] = {0.75,0.75,0.75,.5};
    colorShadow[] = {0.023529,0,0.0313725,1};
    colorBorder[] = {0.023529,0,0.0313725,1};
    soundEnter[] = {"\ca\ui\data\sound\onover",0.09,1};
    soundPush[] = {"\ca\ui\data\sound\new1",0,0};
    soundClick[] = {"\ca\ui\data\sound\onclick",0.07,1};
    soundEscape[] = {"\ca\ui\data\sound\onescape",0.09,1};
    style = 2;
    x = 0;
    y = 0;
    w = 0.055589;
    h = 0.039216;
    shadow = 2;
    font = "puristamedium";
    sizeEx = 0.03921;
    offsetX = 0.003;
    offsetY = 0.003;
    offsetPressedX = 0.002;
    offsetPressedY = 0.002;
    borderSize = 0;
};

class ALIVE_RscFrame
{
    type = CT_STATIC;
    style = ST_FRAME;
    shadow = 2;
    colorBackground[] = {1,1,1,1};
    colorText[] = {1,1,1,0.9};
    font = "puristamedium";
    sizeEx = 0.03;
    text = "";
};
class ALIVE_BOX
{ 
   type = CT_STATIC;
    style = ST_CENTER;
    shadow = 2;
    colorText[] = {1,1,1,1};
    font = "puristamedium";
    sizeEx = 0.02;
    colorBackground[] = { 0.2,0.2,0.2, 0.9 }; 
    text = ""; 

};
class ALIVE_RscMap 
{
	x = 21 * GUI_GRID_W + GUI_GRID_X;
	y = 7.5 * GUI_GRID_H + GUI_GRID_Y;
	w = 13.5 * GUI_GRID_W;
	h = 11 * GUI_GRID_H;
  access = 0;
  alphaFadeEndScale = 0.4;
  alphaFadeStartScale = 0.35;
  colorBackground[] = {0.969,0.957,0.949,1};
  colorCountlines[] = {0.572,0.354,0.188,0.25};
  colorCountlinesWater[] = {0.491,0.577,0.702,0.3};
  colorForest[] = {0.624,0.78,0.388,0.5};
  colorForestBorder[] = {0,0,0,0};
  colorGrid[] = {0.1,0.1,0.1,0.6};
  colorGridMap[] = {0.1,0.1,0.1,0.6};
  colorInactive[] = {1,1,1,0.5};
  colorLevels[] = {0.286,0.177,0.094,0.5};
  colorMainCountlines[] = {0.572,0.354,0.188,0.5};
  colorMainCountlinesWater[] = {0.491,0.577,0.702,0.6};
  colorMainRoads[] = {0.9,0.5,0.3,1};
  colorMainRoadsFill[] = {1,0.6,0.4,1};
  colorNames[] = {0.1,0.1,0.1,0.9};
  colorOutside[] = {0,0,0,1};
  colorPowerLines[] = {0.1,0.1,0.1,1};
  colorRailWay[] = {0.8,0.2,0,1};
  colorRoads[] = {0.7,0.7,0.7,1};
  colorRoadsFill[] = {1,1,1,1};
  colorRocks[] = {0,0,0,0.3};
  colorRocksBorder[] = {0,0,0,0};
  colorSea[] = {0.467,0.631,0.851,0.5};
  colorText[] = {0,0,0,1};
  colorTracks[] = {0.84,0.76,0.65,0.15};
  colorTracksFill[] = {0.84,0.76,0.65,1};
  font = "TahomaB";
  fontGrid = "TahomaB";
  fontInfo = "PuristaMedium";
  fontLabel = "PuristaMedium";
  fontLevel = "TahomaB";
  fontNames = "PuristaMedium";
  fontUnits = "TahomaB";
   maxSatelliteAlpha = 0.85;
  moveOnEdges = 1;
ptsPerSquareSea = 8;
  ptsPerSquareTxt = 10;
  ptsPerSquareCLn = 10;
  ptsPerSquareExp = 10;
  ptsPerSquareCost = 10;
  ptsPerSquareFor = "6.0f";
  ptsPerSquareForEdge = "15.0f";
  ptsPerSquareRoad = "3f";
  ptsPerSquareObj = 15;
  scaleDefault = 0.16;
  scaleMax = 1;
  scaleMin = 0.001;
  shadow = 0;
  showCountourInterval = 0;
  sizeEx = 0.04;
  sizeExGrid = 0.02;
  sizeExInfo = "(     (     (     ((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
  sizeExLabel = "(      (     (     ((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
  sizeExLevel = 0.02;
  sizeExNames = "(      (     (     ((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8) * 2";
  sizeExUnits = "(      (     (     ((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
  stickX[] = {0.2,["Gamma",1,1.5]};
  stickY[] = {0.2,["Gamma",1,1.5]};
  style = 48;
  text = "#(argb,8,8,3)color(1,1,1,1)";
  type = 101;
class ActiveMarker
    {
    color[] = {0.3,0.1,0.9,1};
    size = 50;
    };
  class Bunker
    {
    coefMax = 4;
    coefMin = 0.25;
    color[] = {0,0,0,1};
    icon = "\A3\ui_f\data\map\mapcontrol\bunker_ca.paa";
    importance = "1.5 * 14 * 0.05";
    size = 14;
    };
  class Bush
    {
    coefMax = 4;
    coefMin = 0.25;
    color[] = {0.45,0.64,0.33,0.4};
    icon = "\A3\ui_f\data\map\mapcontrol\bush_ca.paa";
    importance = "0.2 * 14 * 0.05 * 0.05";
    size = "14/2";
    };
  class BusStop
    {
    coefMax = 1;
    coefMin = 0.85;
    color[] = {1,1,1,1};
    icon = "\A3\ui_f\data\map\mapcontrol\busstop_CA.paa";
    importance = 1;
    size = 24;
    };
  class Chapel
    {
    coefMax = 4;
    coefMin = 0.85;
    color[] = {0,0,0,1};
    icon = "\A3\ui_f\data\map\mapcontrol\Chapel_CA.paa";
    importance = 1;
    size = 24;
    };
  class Church
    {
    coefMax = 1;
    coefMin = 0.85;
    color[] = {1,1,1,1};
    icon = "\A3\ui_f\data\map\mapcontrol\church_CA.paa";
    importance = 1;
    size = 24;
    };
  class Command
    {
    coefMax = 1;
    coefMin = 1;
    color[] = {1,1,1,1};
    icon = "\A3\ui_f\data\map\mapcontrol\waypoint_ca.paa";
    importance =1;
    size = 18;
    };
  class Cross
    {
    coefMax = 1;
    coefMin = 0.85;
    color[] = {0,0,0,1};
    icon = "\A3\ui_f\data\map\mapcontrol\Cross_CA.paa";
    importance = 1;
    size = 24;
    };
  class CustomMark
    {
    coefMax = 1;
    coefMin = 1;
    color[] = {0,0,0,1};
    icon = "\A3\ui_f\data\map\mapcontrol\custommark_ca.paa";
    importance = 1;
    size = 24;
    };
  class Fortress
    {
    coefMax = 4;
    coefMin = 0.25;
    color[] = {0,0,0,1};
    icon = "\A3\ui_f\data\map\mapcontrol\bunker_ca.paa";
    importance = "2 * 16 * 0.05";
    size = 16;
    };
  class Fountain
    {
    coefMax = 4;
    coefMin = 0.25;
    color[] = {0,0,0,1};
    icon = "\A3\ui_f\data\map\mapcontrol\fountain_ca.paa";
    importance = "1 * 12 * 0.05";
    size = 11;
    };
  class Fuelstation
    {
    coefMax = 1;
    coefMin = 0.85;
    color[] = {1,1,1,1};
    icon = "\A3\ui_f\data\map\mapcontrol\fuelstation_CA.paa";
    importance = 1;
    size = 24;
    };
  class Hospital
    {
    coefMax = 1;
    coefMin = 0.85;
    color[] = {1,1,1,1};
    icon = "\A3\ui_f\data\map\mapcontrol\hospital_CA.paa";
    importance = 1;
    size = 24;
    };
  class Legend
    {
    color[] = {0,0,0,1};
    colorBackground[] = {1,1,1,0.5};
    font = "PuristaMedium";
    h = "3.5 *          (     (     ((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
    sizeEx = "(     (     (     ((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
    w = "10 *           (     ((safezoneW / safezoneH) min 1.2) / 40)";
    x = "SafeZoneX +          (     ((safezoneW / safezoneH) min 1.2) / 40)";
    y = "SafeZoneY + safezoneH - 4.5 *          (     (     ((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
    };
  class Lighthouse
    {
    coefMax = 1;
    coefMin = 0.85;
    color[] = {1,1,1,1};
    icon = "\A3\ui_f\data\map\mapcontrol\lighthouse_CA.paa";
    importance = 1;
    size = 24;
    };
  class power
    {
    coefMax = 1;
    coefMin = 0.85;
    color[] = {1,1,1,1};
    icon = "\A3\ui_f\data\map\mapcontrol\power_CA.paa";
    importance = 1;
    size = 24;
    };
  class powersolar
    {
    coefMax = 1;
    coefMin = 0.85;
    color[] = {1,1,1,1};
    icon = "\A3\ui_f\data\map\mapcontrol\powersolar_CA.paa";
    importance = 1;
    size = 24;
    };
  class powerwind
    {
    coefMax = 1;
    coefMin = 0.85;
    color[] = {1,1,1,1};
    icon = "\A3\ui_f\data\map\mapcontrol\powerwind_CA.paa";
    importance = 1;
    size = 24;
    };
  class powerwave
    {
    coefMax = 1;
    coefMin = 0.85;
    color[] = {1,1,1,1};
    icon = "\A3\ui_f\data\map\mapcontrol\powerwave_CA.paa";
    importance = 1;
    size = 24;
    };
  class Quay
    {
    coefMax = 1;
    coefMin = 0.85;
    color[] = {1,1,1,1};
    icon = "\A3\ui_f\data\map\mapcontrol\quay_CA.paa";
    importance = 1;
    size = 24;
    };
  class Rock
    {
    coefMax = 4;
    coefMin = 0.25;
    color[] = {0.1,0.1,0.1,0.8};
    icon = "\A3\ui_f\data\map\mapcontrol\rock_ca.paa";
    importance = "0.5 * 12 * 0.05";
    size = 12;
    };
  class Ruin
    {
    coefMax = 4;
    coefMin = 1;
    color[] = {0,0,0,1};
    icon = "\A3\ui_f\data\map\mapcontrol\ruin_ca.paa";
    importance = "1.2 * 16 * 0.05";
    size = 16;
    };
  class shipwreck
    {
    coefMax = 1;
    coefMin = 0.85;
    color[] = {1,1,1,1};
    icon = "\A3\ui_f\data\map\mapcontrol\shipwreck_CA.paa";
    importance = 1;
    size = 24;
    };
  class SmallTree
    {
    coefMax = 4;
    coefMin = 0.25;
    color[] = {0.45,0.64,0.33,0.4};
    icon = "\A3\ui_f\data\map\mapcontrol\bush_ca.paa";
    importance = "0.6 * 12 * 0.05";
    size = 12;
    };
  class Stack
    {
    coefMax = 4;
    coefMin = 0.9;
    color[] = {0,0,0,1};
    icon = "\A3\ui_f\data\map\mapcontrol\stack_ca.paa";
    importance = "2 * 16 * 0.05";
    size = 20;
    };
  class Task
    {
    coefMax = 1;
    coefMin = 1;
    color[] = {"(profilenamespace getvariable ['IGUI_TEXT_RGB_R',0])","(profilenamespace getvariable ['IGUI_TEXT_RGB_G',1])","(profilenamespace getvariable ['IGUI_TEXT_RGB_B',1])","(profilenamespace getvariable ['IGUI_TEXT_RGB_A',0.8])"};
    colorCanceled[] = {0.7,0.7,0.7,1};
    colorCreated[] = {1,1,1,1};
    colorDone[] = {0.7,1,0.3,1};
    colorFailed[] = {1,0.3,0.2,1};
    icon = "\A3\ui_f\data\map\mapcontrol\taskIcon_CA.paa";
    iconCanceled = "\A3\ui_f\data\map\mapcontrol\taskIconCanceled_CA.paa";
    iconCreated = "\A3\ui_f\data\map\mapcontrol\taskIconCreated_CA.paa";
    iconDone = "\A3\ui_f\data\map\mapcontrol\taskIconDone_CA.paa";
    iconFailed = "\A3\ui_f\data\map\mapcontrol\taskIconFailed_CA.paa";
    importance = 1;
    size = 27;
    };
  class Tourism
    {
    coefMax = 4;
    coefMin = 0.7;
    color[] = {0,0,0,1};
    icon = "\A3\ui_f\data\map\mapcontrol\tourism_ca.paa";
    importance = "1 * 16 * 0.05";
    size = 16;
    };
  class Transmitter
    {
    coefMax = 1;
    coefMin = 0.85;
    color[] = {1,1,1,1};
    icon = "\A3\ui_f\data\map\mapcontrol\transmitter_CA.paa";
    importance = 1;
    size = 24;
    };
  class Tree
    {
    coefMax = 4;
    coefMin = 0.25;
    color[] = {0.45,0.64,0.33,0.4};
    icon = "\A3\ui_f\data\map\mapcontrol\bush_ca.paa";
    importance = "0.9 * 16 * 0.05";
    size = 12;
    };
  class ViewTower
    {
    coefMax = 4;
    coefMin = 0.5;
    color[] = {0,0,0,1};
    icon = "\A3\ui_f\data\map\mapcontrol\viewtower_ca.paa";
    importance = "2.5 * 16 * 0.05";
    size = 16;
    };
  class Watertower
    {
    coefMax = 1;
    coefMin = 0.85;
    color[] = {1,1,1,1};
    icon = "\A3\ui_f\data\map\mapcontrol\watertower_CA.paa";
    importance = 1;
    size = 24;
    };
  class Waypoint
    {
    coefMax = 1;
    coefMin = 1;
    color[] = {0,0,0,1};
    icon = "\A3\ui_f\data\map\mapcontrol\waypoint_ca.paa";
    importance = 1;
    size = 24;
    };
  class WaypointCompleted
    {
    coefMax = 1;
    coefMin = 1;
    color[] = {0,0,0,1};
    icon = "\A3\ui_f\data\map\mapcontrol\waypointCompleted_ca.paa";
    importance = 1;
    size = 24;
    };
  
  };
  class ALIVE_RscListbox
{
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
class Alive_RscCombo
{
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
