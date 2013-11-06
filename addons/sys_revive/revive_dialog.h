class REV_DLG_Waiting_For_Revive
{
	idd = 89453;
	
	// Hide respawn_camp button if the option is not selected
	onLoad = "if !(REV_CFG_Allow_Respawn) then {_this select 0 displayCtrl 89454 ctrlShow false;} else {_this select 0 displayCtrl 89454 ctrlSetText STR_REV_BTN_Respawn};";
	
	// If the window is closed with escape, it reopens later (time to leave the party if they wanted to leave, otherwise it resets the menu)
	onKeyDown = "if (_this select 1 == 1) then {call REV_FNCT_Delete_Unconcious_Marker; [] spawn {sleep 8; if (player getVariable ""REV_Unconscious"" && isNull (findDisplay 89453)) then {call REV_FNCT_Delete_Unconcious_Marker; call REV_FNCT_Create_Unconscious_Marker; createDialog ""REV_DLG_Waiting_For_Revive"";};};}; false";
	
	controlsBackground[] = {};
	objects[] = {};
	controls[] =
	{
		REV_dlg_AR_btn_focus,
		REV_dlg_AR_btn_respawn_camp
	};
	
	// Capturing invisible button focus, to prevent the entry and active space accidentally touches the respawn camp
	class REV_dlg_AR_btn_focus
	{
		idc = -1;
		
		type = 1;
		style = 0x02;
		w = 0.0; x = 0.0;
		h = 0.0; y = 0.0;
		text = "";
		action = "";
		colorText[] = {0.0, 0.0, 0.0, 0.0};
		font = "TahomaB";
		sizeEx = 0.0;
		colorBackground[] = {0.0, 0.0, 0.0, 0.0};
		colorFocused[] = {0.0, 0.0, 0.0, 0.0};
		colorDisabled[] = {0.0, 0.0, 0.0, 0.0};
		colorBackgroundDisabled[] = {0.0, 0.0, 0.0, 0.0};
		colorBackgroundActive[] = {0.0, 0.0, 0.0, 0.0};
		offsetX = 0.0;
		offsetY = 0.0;
		offsetPressedX = 0.0;
		offsetPressedY = 0.0;
		colorShadow[] = {0.0, 0.0, 0.0, 0.0};
		colorBorder[] = {0.0, 0.0, 0.0, 0.0};
		borderSize = 0.0;
		soundEnter[] = {"", 0.0, 1.0};
		soundPush[] = {"", 0.1, 1.0};
		soundClick[] = {"", 0.0, 1.0};
		soundEscape[] = {"", 0.0, 1.0};
	};
	
	class REV_dlg_AR_btn_respawn_camp
	{
		idc = 89454;
		
		type = 1;
		style = 0x02;
		// x = 0.375;
		// y = 0.88;
		// w = 0.25;
		// h = 0.08;
		
		text = "Respawn"; //--- ToDo: Localize;
		x = 0.3825;
		y = 0.8992;
		w = 0.225;
		h = 0.06;
		tooltip = "Player Respawn"; //--- ToDo: Localize;
		
		// text = "Respawn";
		action = "[] spawn REV_FNCT_respawn_camp;";
		colorText[] = {1,1,1,1};
		font = "TahomaB";
		sizeEx = 0.035;
		// tooltip = "Player Respawn";
		colorBackground[] = {0,0.29,0.27,0.15};
		colorFocused[] = {0.59,0.52,0,0.5};
		colorDisabled[] = {0.13,0.13,0.13,0.5};
		colorBackgroundDisabled[] = {0.19,0.03,0,0};
		colorBackgroundActive[] = {0,0.38,0,0.39};
		offsetX = 0.003;
		offsetY = 0.003;
		offsetPressedX = 0.002;
		offsetPressedY = 0.002;
		colorShadow[] = {0.0, 0.0, 0.0, 0.5};
		colorBorder[] = {0.0, 0.0, 0.0, 1.0};
		borderSize = 0.0;
		soundEnter[] = {"", 0.0, 1.0};
		soundPush[] = {"", 0.1, 1.0};
		soundClick[] = {"", 0.0, 1.0};
		soundEscape[] = {"", 0.0, 1.0};
	};
};