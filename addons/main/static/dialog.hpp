// ====================================================================================
// DEFINES
#define CT_STRUCTURED_TEXT	13
#define ST_LEFT				0
#define CT_LISTBOX			5
#define GUI_GRID_X  (0)
#define GUI_GRID_Y  (0)
#define GUI_GRID_W  (0.025)
#define GUI_GRID_H  (0.04)
#define GUI_GRID_WAbs (1)
#define GUI_GRID_HAbs (1)
#define GUI_GRID_CENTER_WAbs		((safezoneW / safezoneH) min 1.2)
#define GUI_GRID_CENTER_HAbs		(GUI_GRID_CENTER_WAbs / 1.2)
#define GUI_GRID_CENTER_W		(GUI_GRID_CENTER_WAbs / 40)
#define GUI_GRID_CENTER_H		(GUI_GRID_CENTER_HAbs / 25)
#define GUI_GRID_CENTER_X		(safezoneX + (safezoneW - GUI_GRID_CENTER_WAbs)/2)
#define GUI_GRID_CENTER_Y		(safezoneY + (safezoneH - GUI_GRID_CENTER_HAbs)/2)

// ====================================================================================

class RscText;
class RscTextCheckbox;
class RscButton;
///////////////////////////////////////////////////////////////////////////
/// Class Dialogs
///////////////////////////////////////////////////////////////////////////


class alive_indexing_list
{

	idd = 1601;
	movingEnable = 1;
	enableSimulation = 1;

	class Controls
	{
		/*class ALiVEIndexListBox: RscListBox
		{
			access = 0; // Control access (0 - ReadAndWrite, 1 - ReadAndCreate, 2 - ReadOnly, 3 - ReadOnlyVerified)
			idc = 1; // Control identification (without it, the control won't be displayed)
			type = CT_LISTBOX; // Type is 5
			style = ST_LEFT + 0x10 + LB_MULTI; // Style

			x = 0; // Horizontal coordinates
			y = 0 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y; // Vertical coordinates
			w = 10 * GUI_GRID_CENTER_W; // Width
			h = 21 * GUI_GRID_CENTER_H; // Height

			default = 0; // Control selected by default (only one within a display can be used)
			blinkingPeriod = 0; // Time in which control will fade out and back in. Use 0 to disable the effect.
			colorBackground[] = {0.2,0.2,0.2,0.5}; // Fill color
			colorSelectBackground[] = {1,0.5,0,0.8}; // Selected item fill color
			colorSelectBackground2[] = {0,0,0,1}; // Selected item fill color (oscillates between this and colorSelectBackground)

			sizeEx = GUI_GRID_CENTER_H; // Text size
			shadow = 0; // Shadow (0 - none, 1 - directional, color affected by colorShadow, 2 - black outline)
			colorText[] = {1,1,1,1}; // Text and frame color
			colorDisabled[] = {1,1,1,0.5}; // Disabled text color
			colorSelect[] = {1,1,1,1}; // Text selection color
			colorSelect2[] = {1,1,1,1}; // Text selection color (oscillates between this and colorSelect)
			colorShadow[] = {0,0,0,0.5}; // Text shadow color (used only when shadow is 1)

			pictureColor[] = {1,0.5,0,1}; // Picture color
			pictureColorSelect[] = {1,1,1,1}; // Selected picture color
			pictureColorDisabled[] = {1,1,1,0.5}; // Disabled picture color

			tooltip = "Choose Object Category"; // Tooltip text
			tooltipColorShade[] = {0,0,0,1}; // Tooltip background color
			tooltipColorText[] = {1,1,1,1}; // Tooltip text color
			tooltipColorBox[] = {1,1,1,1}; // Tooltip frame color

			period = 1; // Oscillation time between colorSelect/colorSelectBackground2 and colorSelect2/colorSelectBackground when selected

			rowHeight = 1.1 * GUI_GRID_CENTER_H; // Row height
			itemSpacing = 0; // Height of empty space between items
			maxHistoryDelay = 1; // Time since last keyboard type search to reset it
			canDrag = 1; // 1 (true) to allow item dragging

			soundSelect[] = {"\A3\ui_f\data\sound\RscListbox\soundSelect",0.09,1}; // Sound played when an item is selected

			// Scrollbar configuration (applied only when LB_TEXTURES style is used)
			class ListScrollBar //In older games this class is "ScrollBar"
			{
				width = 0; // width of ListScrollBar
				height = 0; // height of ListScrollBar
				scrollSpeed = 0.01; // scroll speed of ListScrollBar

				arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa"; // Arrow
				arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa"; // Arrow when clicked on
				border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa"; // Slider background (stretched vertically)
				thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa"; // Dragging element (stretched vertically)

				color[] = {1,1,1,1}; // Scrollbar color
			};

			onLBDblClick = "systemChat format['%1 allocated to %2', ALiVE_wrp_model, (_this select 0) lbtext (lbCurSel 1)]; ALIVE_map_index_choice = lbCurSel 1; false";

		};*/

		class ALiVEIndexHeader: RscText
		{
			idc = 2;
			x = -5 * GUI_GRID_CENTER_W;
			y = 0;
			w = 17 * GUI_GRID_CENTER_W; // Width
			h = 2 * GUI_GRID_CENTER_H; // Height
			colorBackground[] = {1,0.5,0,0.8};
			colorText[] = {1,1,1,1};
 			style = ST_LEFT;
			sizeEx = GUI_GRID_CENTER_H; // Text size
			shadow = 0; // Shadow (0 - none, 1 - directional, color affected by
			text = "Select all that apply:";
		};
		class ALiVEIndexListBox: RscTextCheckBox
		{
			access = 0; // Control access (0 - ReadAndWrite, 1 - ReadAndCreate, 2 - ReadOnly, 3 - ReadOnlyVerified)
			idc = 1; // Control identification (without it, the control won't be displayed)

			x = -5 * GUI_GRID_CENTER_W;
			y = 2 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y; // Vertical coordinates
			w = 17 * GUI_GRID_CENTER_W; // Width
			h = 21 * GUI_GRID_CENTER_H; // Height
			style = 0x0c;
			colorBackground[] = {0.2,0.2,0.2,0.5}; // Fill color
			colorSelectBackground[] = {0.4,0.4,0.4,0.7}; // Selected item fill color
			colorSelectBackground2[] = {0,0,0,1}; // Selected item fill color (oscillates between this and colorSelectBackground)
			colorSelectedBg[] = {0.4,0.4,0.4,0.7}; // Selected item fill color

			sizeEx = GUI_GRID_CENTER_H; // Text size
			shadow = 0; // Shadow (0 - none, 1 - directional, color affected by colorShadow, 2 - black outline)
			colorText[] = {1,1,1,1}; // Text and frame color
			colorTextSelect[] = {0,1,0,1}; // Text and frame color
			colorTextDisable[] = {0.3,0.3,0.3,1}; // Text and frame color
			colorDisable[] = {1,1,1,0.5}; // Disabled text color
			colorSelect[] = {1,1,1,1}; // Text selection color
			colorShadow[] = {0,0,0,0.5}; // Text shadow color (used only when shadow is 1)

			pictureColor[] = {1,0.5,0,1}; // Picture color
			pictureColorSelect[] = {1,1,1,1}; // Selected picture color
			pictureColorDisabled[] = {1,1,1,0.5}; // Disabled picture color

			tooltip = "Choose all that apply"; // Tooltip text
			tooltipColorShade[] = {0,0,0,1}; // Tooltip background color
			tooltipColorText[] = {1,1,1,1}; // Tooltip text color
			tooltipColorBox[] = {1,1,1,1}; // Tooltip frame color

			period = 1; // Oscillation time between colorSelect/colorSelectBackground2 and colorSelect2/colorSelectBackground when selected
			checked_strings[] = {};
			strings[] = {
				"Blacklist",
				"Military Buildings (General)",
				"- Allow ambient vehicles to spawn here",
				"- Allow ambient supplies to spawn here",
				"- Allow this building to be used as an HQ",
				"Aircraft (Fixed Wing) Buildings",
				"- Primarily used by Military aircraft",
				"- Used by Civilian aircraft only",
				"Aircraft (Rotary Wing) Buildings",
				"- Primarily used by Military aircraft",
				"- Used by Civilian aircraft only",
				"Civilian Buildings (General)",
				"- Allow this building to be used as an HQ",
				"- Allow ambient civilians here",
				"Civilian - Power",
				"Civilian - Comms",
				"Civilian - Marine",
				"Civilian - Rail",
				"Civilian - Fuel",
				"Civilian - Construction"
			};
			rows = 20;
			columns = 1;
			//rowHeight = 1.1 * GUI_GRID_CENTER_H; // Row height
			//itemSpacing = 0; // Height of empty space between items
			//maxHistoryDelay = 1; // Time since last keyboard type search to reset it

			soundSelect[] = {"\A3\ui_f\data\sound\RscListbox\soundSelect",0.09,1}; // Sound played when an item is selected

			onCheckBoxesSelChanged = "_this call ALiVE_fnc_autoUpdateStaticData;";

		};
		class ALiVEIndexButton: RscButton
		{
			idc = 3;
			x = -5 * GUI_GRID_CENTER_W;
			y = 23 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y;
			w = 17 * GUI_GRID_CENTER_W; // Width
			h = 2 * GUI_GRID_CENTER_H; // Height
			colorBackground[] = {1,0.5,0,0.8};
			colorBackgroundActive[] = {0,1,0,0.8};
			colorText[] = {1,1,1,1};
 			style = 0x02 + 0x0c;
			sizeEx = GUI_GRID_CENTER_H; // Text size
			shadow = 0; // Shadow (0 - none, 1 - directional, color affected by
			text = "Click for Next Object";
			action = "ALIVE_map_index_choice = 1";
		};
	};
};


