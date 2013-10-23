#define CT_STATIC           0
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

//Procedural colors
#define ProcTextWhite "#(argb,8,8,3)color(1,1,1,1)"
#define ProcTextBlack "#(argb,8,8,3)color(0,0,0,1)"
#define ProcTextGray "#(argb,8,8,3)color(0.3,0.3,0.3,1)"
#define ProcTextRed "#(argb,8,8,3)color(1,0,0,1)"
#define ProcTextGreen "#(argb,8,8,3)color(0,1,0,1)"
#define ProcTextBlue "#(argb,8,8,3)color(0,0,1,1)"
#define ProcTextOrange "#(argb,8,8,3)color(1,0.5,0,1)"
#define ProcTextTransparent "#(argb,8,8,3)color(0,0,0,0)"

#ifndef _COMMON_DEFS_HPP
#define _COMMON_DEFS_HPP

#define true 1
#define false 0

#define ReadAndWrite 0 //! any modifications enabled
#define ReadAndCreate 1 //! only adding new class members is allowed
#define ReadOnly 2 //! no modifications enabled
#define ReadOnlyVerified 3 //! no modifications enabled, CRC test applied

//--- New grid for new A3 displays
#define GUI_GRID_WAbs     ((safezoneW / safezoneH) min 1.2)
#define GUI_GRID_HAbs     (GUI_GRID_WAbs / 1.2)
#define GUI_GRID_W      (GUI_GRID_WAbs / 40)
#define GUI_GRID_H      (GUI_GRID_HAbs / 25)
#define GUI_GRID_X      (safezoneX)
#define GUI_GRID_Y      (safezoneY + safezoneH - GUI_GRID_HAbs)

///////////////////////////////////////////////////////////////////////////
/// Text Sizes - A3
///////////////////////////////////////////////////////////////////////////
//MUF - text sizes are using new grid (40/25)
#define GUI_TEXT_SIZE_SMALL   (GUI_GRID_H * 0.8)
#define GUI_TEXT_SIZE_MEDIUM    (GUI_GRID_H * 1)
#define GUI_TEXT_SIZE_LARGE   (GUI_GRID_H * 1.2)
#define IGUI_TEXT_SIZE_MEDIUM   (GUI_GRID_H * 0.8)

///////////////////////////////////////////////////////////////////////////
/// Fonts - A3
///////////////////////////////////////////////////////////////////////////
#define GUI_FONT_NORMAL     PuristaMedium
#define GUI_FONT_BOLD     PuristaSemibold
#define GUI_FONT_MONO     EtelkaMonospaceProBold
#define GUI_FONT_SMALL      PuristaMedium
#define GUI_FONT_THIN     PuristaLight

#define FontMAIN      PuristaMedium
#define FontDEBUG       PuristaMedium

#define SizeXSmall ( 16 / 408 )
#define SizeSmall ( 16 / 408 )
#define SizeNormal ( 21 / 408 )
#define SizeMedium ( 29 / 408 )
#define SizeLarge ( 36 / 408 )

#define SizeTitle 0.08
#define SizeBookTitle 0.06
#define SizeBook 0.05
#define SizeHint 0.0468
#define SizeListBig  0.042
#define SizeList  0.0378

#define SizeMapMarker  32

#define Black 0, 0, 0
#define Green 0.0, 0.6, 0.0
#define Red 0.7, 0.1, 0.0
#define Yellow 0.8, 0.6, 0.0
#define White 0.8, 0.8, 0.8
#define ShineGreen 0.07, 0.7, 0.2
#define ShineRed 1, 0.2, 0.2
#define ShineYellow 1, 1, 0
#define ShineWhite 1, 1, 1
#define Blue 0.1, 0.1, 0.9

#define Gray1 0.00, 0.00, 0.00
#define Gray2 0.20, 0.20, 0.20
#define Gray3 0.50, 0.50, 0.50
#define Gray4 0.60, 0.60, 0.60
#define Gray5 0.80, 0.80, 0.80

#endif


///////////////////////////////////////////////////////////////////////////
/// Base Classes
///////////////////////////////////////////////////////////////////////////
class RscText
{
  access = 0;
  type = 0;
  idc = -1;
  colorBackground[] = {0,0,0,0};
  colorText[] = {1,1,1,1};
  text = "";
  fixedWidth = 0;
  x = 0;
  y = 0;
  h = 0.037;
  w = 0.3;
  style = 0;
  shadow = 1;
  colorShadow[] = {0,0,0,0.5};
  font = GUI_FONT_NORMAL;
  SizeEx = "(     (     (1 / 1.2) / 20) * 0.9)";
  linespacing = 1;
};
class RscStructuredText
{
  access = 0;
  type = 13;
  idc = -1;
  style = 0;
  colorText[] = {1,1,1,1};
  class Attributes
  {
    font = GUI_FONT_NORMAL;
    color = "#ffffff";
    align = "left";
    shadow = 1;
  };
  x = 0;
  y = 0;
  h = 0.035;
  w = 0.1;
  text = "";
  size = "(     (     (1 / 1.2) / 20) * 0.9)";
  shadow = 1;
};
class RscPicture
{
  colorBackground[] = {0,0,0,0};
  colorText[] = {1,1,1,1};
  fixedWidth = 0;
  access = 0;
  type = 0;
  idc = -1;
  style = 48;
  font = GUI_FONT_NORMAL;
  sizeEx = 0;
  lineSpacing = 0;
  text = "";
  shadow = 0;
  x = 0;
  y = 0;
  w = 0.2;
  h = 0.15;
};
class RscEdit
{
  access = 0;
  type = 2;
  x = 0;
  y = 0;
  h = 0.04;
  w = 0.2;
  colorBackground[] = {0,0,0,1};
  colorText[] = {0.95,0.95,0.95,1};
  colorSelection[] = {0,0,0,1};
  autocomplete = "";
  text = "";
  size = 0.2;
  style = "0x00 + 0x40";
  font = GUI_FONT_NORMAL;
  shadow = 2;
  sizeEx = "(     (     (1 / 1.2) / 20) * 0.9)";
};
class RscCombo
{
  access = 0;
  type = 4;
  style = 0;
  colorSelect[] = {1,1,1,1};
  colorText[] = {1,1,1,1};
  colorBackground[] = {0,0,0,1};
  colorScrollbar[] = {0.023529,0,0.0313725,1};
  soundSelect[] = {"",0.1,1};
  soundExpand[] = {"",0.1,1};
  soundCollapse[] = {"",0.1,1};
  maxHistoryDelay = 1;
  class ScrollBar
  {
    color[] = {1,1,1,0.6};
    colorActive[] = {1,1,1,1};
    colorDisabled[] = {1,1,1,0.3};
    shadow = 0;
    thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa";
    arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa";
    arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";
    border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa";
  };
  x = 0;
  y = 0;
  w = 0.12;
  h = 0.035;
  shadow = 0;
  colorSelectBackground[] = {0,0,0,1};
  arrowEmpty = "#(argb,8,8,3)color(1,1,1,1)";
  arrowFull = "#(argb,8,8,3)color(1,1,1,1)";
  wholeHeight = 0.45;
  color[] = {0,0,0,0.6};
  colorActive[] = {0,0,0,1};
  colorDisabled[] = {0,0,0,0.3};
  font = GUI_FONT_NORMAL;
  sizeEx = "(     (     (1 / 1.2) / 20) * 0.9)";
};
class RscListBox
{
  access = 0;
  type = 5;
  w = 0.4;
  h = 0.4;
  rowHeight = 0;
  colorText[] = {1,1,1,1};
  colorScrollbar[] = {0.95,0.95,0.95,1};
  colorSelect[] = {1,1,1,1};
  colorSelect2[] = {1,1,1,1};
  colorSelectBackground[] = {0,0,0,1};
  colorSelectBackground2[] = {0,0,0,1};
  colorBackground[] = {0,0,0,0.2};
  soundSelect[] = {"",0.1,1};
  arrowEmpty = "#(argb,8,8,3)color(1,1,1,1)";
  arrowFull = "#(argb,8,8,3)color(1,1,1,1)";
  class ScrollBar
  {
    color[] = {1,1,1,0.6};
    colorActive[] = {1,1,1,1};
    colorDisabled[] = {1,1,1,0.3};
    shadow = 0;
    thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa";
    arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa";
    arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";
    border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa";
    };
  style = 16;
  font = GUI_FONT_NORMAL;
  sizeEx = "(     (     (1 / 1.2) / 20) * 0.9)";
  shadow = 1;
  colorShadow[] = {0,0,0,0.5};
  color[] = {1,1,1,1};
  period = 1.2;
  maxHistoryDelay = 1;
  autoScrollSpeed = -1;
  autoScrollDelay = 5;
  autoScrollRewind = 0;
};
class RscButton
{
  access = 0;
  type = 1;
  text = "";
  colorText[] = {1,1,1,1};
  colorDisabled[] = {0.4,0.4,0.4,1};
  colorBackground[] = {0,0,0,1};
  colorBackgroundDisabled[] = {0.95,0.95,0.95,1};
  colorBackgroundActive[] = {0,0,0,1};
  colorFocused[] = {0,0,0,1};
  colorShadow[] = {0.023529,0,0.0313725,1};
  colorBorder[] = {0.023529,0,0.0313725,1};
  soundEnter[] = {"\ca\ui_f\data\sound\onover",0.09,1};
  soundPush[] = {"\ca\ui_f\data\sound\new1",0,0};
  soundClick[] = {"\ca\ui_f\data\sound\onclick",0.07,1};
  soundEscape[] = {"\ca\ui_f\data\sound\onescape",0.09,1};
  style = 2;
  x = 0;
  y = 0;
  w = 0.095589;
  h = 0.039216;
  shadow = 2;
  font = GUI_FONT_NORMAL;
  sizeEx = "(     (     (1 / 1.2) / 20) * 0.9)";
  offsetX = 0.003;
  offsetY = 0.003;
  offsetPressedX = 0.002;
  offsetPressedY = 0.002;
  borderSize = 0;
};
class RscShortcutButton
{
  type = 16;
  x = 0.1;
  y = 0.1;
  class HitZone
  {
    left = 0;
    top = 0;
    right = 0;
    bottom = 0;
  };
  class ShortcutPos
  {
    left = 0;
    top = "(      (     (1 / 1.2) / 20) -     (     (     (1 / 1.2) / 20) * 0.9)) / 2";
    w = "(      (     (1 / 1.2) / 20) * 0.9) * (3/4)";
    h = "(      (     (1 / 1.2) / 20) * 0.9)";
  };
  class TextPos
  {
    left = "(     (     (1 / 1.2) / 20) * 0.9) * (3/4)";
    top = "(      (     (1 / 1.2) / 20) -     (     (     (1 / 1.2) / 20) * 0.9)) / 2";
    right = 0.005;
    bottom = 0;
  };
  shortcuts[] = {};
  textureNoShortcut = "#(argb,8,8,3)color(0,0,0,0)";
  color[] = {1,1,1,1};
  color2[] = {0.95,0.95,0.95,1};
  colorDisabled[] = {1,1,1,0.25};
  colorBackground[] = {0,0,0,1};
  colorBackground2[] = {0,0,0,1};
  class Attributes
  {
    font = GUI_FONT_NORMAL;
    color = "#E5E5E5";
    align = "left";
    shadow = "true";
  };
  idc = -1;
  style = 0;
  default = 0;
  shadow = 1;
  w = 0.183825;
  h = "(      (1 / 1.2) / 20)";
  animTextureDefault = "#(argb,8,8,3)color(1,1,1,1)";
  animTextureDisabled = "#(argb,8,8,3)color(1,1,1,1)";
  animTextureFocused = "#(argb,8,8,3)color(1,1,1,1)";
  animTextureNormal = "#(argb,8,8,3)color(1,1,1,1)";
  animTextureOver = "#(argb,8,8,3)color(1,1,1,0.5)";
  animTexturePressed = "#(argb,8,8,3)color(1,1,1,1)";
  periodFocus = 1.2;
  periodOver = 0.8;
  period = 0.4;
  font = GUI_FONT_NORMAL;
  size = "(     (     (1 / 1.2) / 20) * 0.9)";
  sizeEx = "(     (     (1 / 1.2) / 20) * 0.9)";
  text = "";
  soundClick[] = {"\A3\ui_f\data\sound\onclick",0.07,1};
  soundEnter[] = {"\A3\ui_f\data\sound\onover",0.09,1};
  soundEscape[] = {"\A3\ui_f\data\sound\onescape",0.09,1};
  soundPush[] = {"\A3\ui_f\data\sound\new1",0,0};
  action = "";
  class AttributesImage
  {
    font = GUI_FONT_NORMAL;
    color = "#E5E5E5";
    align = "left";
  };
};
class RscShortcutButtonMain
{
  idc = -1;
  style = 0;
  default = 0;
  w = 0.313726;
  h = 0.104575;
  color[] = {1,1,1,1};
  colorDisabled[] = {1,1,1,0.25};
  class HitZone
  {
    left = 0;
    top = 0;
    right = 0;
    bottom = 0;
  };
  class ShortcutPos
  {
    left = 0.0145;
    top = "(      (     (1 / 1.2) / 20) -       (     (     (1 / 1.2) / 20) * 1.1)) / 2";
    w = "(      (     (1 / 1.2) / 20) * 1.1) * (3/4)";
    h = "(      (     (1 / 1.2) / 20) * 1.1)";
  };
  class TextPos
  {
    left = "(     (1) / 32) * 1.5";
    top = "(      (     (1 / 1.2) / 20)*2 -       (     (     (1 / 1.2) / 20) * 1.1)) / 2";
    right = 0.005;
    bottom = 0;
  };
   animTextureDefault = "#(argb,8,8,3)color(1,1,1,1)";
  animTextureDisabled = "#(argb,8,8,3)color(1,1,1,1)";
  animTextureFocused = "#(argb,8,8,3)color(1,1,1,1)";
  animTextureNormal = "#(argb,8,8,3)color(1,1,1,1)";
  animTextureOver = "#(argb,8,8,3)color(1,1,1,0.5)";
  animTexturePressed = "#(argb,8,8,3)color(1,1,1,1)";
  period = 0.5;
  font = GUI_FONT_NORMAL;
  size = "(     (     (1 / 1.2) / 20) * 1.1)";
  sizeEx = "(     (     (1 / 1.2) / 20) * 1.1)";
  text = "";
 soundClick[] = {"\A3\ui_f\data\sound\onclick",0.07,1};
  soundEnter[] = {"\A3\ui_f\data\sound\onover",0.09,1};
  soundEscape[] = {"\A3\ui_f\data\sound\onescape",0.09,1};
  soundPush[] = {"\A3\ui_f\data\sound\new1",0,0};
  action = "";
  class Attributes
  {
    font = GUI_FONT_NORMAL;
    color = "#E5E5E5";
    align = "left";
    shadow = "false";
  };
  class AttributesImage
  {
    font = GUI_FONT_NORMAL;
    color = "#E5E5E5";
    align = "false";
  };
};
class RscFrame
{
  type = 0;
  idc = -1;
  style = 64;
  shadow = 2;
  colorBackground[] = {0,0,0,0};
  colorText[] = {1,1,1,1};
  font = GUI_FONT_NORMAL;
  sizeEx = 0.02;
  text = "";
};
class RscSlider
{
  access = 0;
  type = 3;
  style = 1024;
  w = 0.3;
  color[] = {1,1,1,0.8};
  colorActive[] = {1,1,1,1};
  shadow = 0;
  h = 0.025;
};
class IGUIBack
{
  type = 0;
  idc = 124;
  style = 128;
  text = "";
  colorText[] = {0,0,0,0};
  font = GUI_FONT_NORMAL;
  sizeEx = 0;
  shadow = 0;
  x = 0.1;
  y = 0.1;
  w = 0.1;
  h = 0.1;
  colorbackground[] = {0,0,0,1};
};
class RscControlsGroup
{
  class VScrollbar
  {
    color[] = {1,1,1,1};
    width = 0.021;
    autoScrollSpeed = -1;
    autoScrollDelay = 5;
    autoScrollRewind = 0;
    shadow = 0;
  };
  class HScrollbar
  {
    color[] = {1,1,1,1};
    height = 0.028;
    shadow = 0;
  };
  class ScrollBar
  {
    color[] = {1,1,1,0.6};
    colorActive[] = {1,1,1,1};
    colorDisabled[] = {1,1,1,0.3};
    shadow = 0;
    thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa";
    arrowEmpty = "#(argb,8,8,3)color(1,1,1,1)";
  arrowFull = "#(argb,8,8,3)color(1,1,1,1)";
    border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa";
  };
  class Controls
  {
  };
  type = 15;
  idc = -1;
  x = 0;
  y = 0;
  w = 1;
  h = 1;
  shadow = 0;
  style = 16;
};

class RSCMapControl
{
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

