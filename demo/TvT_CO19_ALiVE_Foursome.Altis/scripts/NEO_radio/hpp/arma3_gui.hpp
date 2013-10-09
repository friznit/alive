////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT START (by [Pte] Gunny [MS], v1.063, #Natixe)
////////////////////////////////////////////////////////

class RscFrame_1800: RscFrame
{
	idc = 1800;
	x = 0.110255 * safezoneW + safezoneX;
	y = 0.108 * safezoneH + safezoneY;
	w = 0.748559 * safezoneW;
	h = 0.616 * safezoneH;
	colorBackground[] = {1,1,1,1};
};
class RSC_Map: RscPicture
{
	idc = 1200;
	text = "#(argb,8,8,3)color(1,1,1,1)";
	x = 0.580424 * safezoneW + safezoneX;
	y = 0.178 * safezoneH + safezoneY;
	w = 0.25983 * safezoneW;
	h = 0.434 * safezoneH;
};
class NEO_RadioTitle: RscText
{
	idc = 1000;
	text = "Support Radio"; //--- ToDo: Localize;
	x = 0.425763 * safezoneW + safezoneX;
	y = 0.122 * safezoneH + safezoneY;
	w = 0.0804237 * safezoneW;
	h = 0.028 * safezoneH;
};
class NEO_radioMainTitle: RscText
{
	idc = 1001;
	text = "Available Support"; //--- ToDo: Localize;
	x = 0.153559 * safezoneW + safezoneX;
	y = 0.178 * safezoneH + safezoneY;
	w = 0.098983 * safezoneW;
	h = 0.028 * safezoneH;
};
class NEO_radioAbort: RscButton
{
	idc = 1600;
	text = "Close"; //--- ToDo: Localize;
	x = 0.159746 * safezoneW + safezoneX;
	y = 0.654 * safezoneH + safezoneY;
	w = 0.0804237 * safezoneW;
	h = 0.028 * safezoneH;
};
class NEO_radioMainList: RscListbox
{
	idc = 1500;
	x = 0.128814 * safezoneW + safezoneX;
	y = 0.22 * safezoneH + safezoneY;
	w = 0.142288 * safezoneW;
	h = 0.126 * safezoneH;
};
class NEO_radioTransportUnitList: RscListbox
{
	idc = 1501;
	x = 0.302034 * safezoneW + safezoneX;
	y = 0.22 * safezoneH + safezoneY;
	w = 0.098983 * safezoneW;
	h = 0.126 * safezoneH;
};
class NEO_radioTransportUnitText: RscText
{
	idc = 1002;
	x = 0.302034 * safezoneW + safezoneX;
	y = 0.178 * safezoneH + safezoneY;
	w = 0.098983 * safezoneW;
	h = 0.028 * safezoneH;
};
class NEO_radioTransportHelpUnitText: RscText
{
	idc = 1003;
	x = 0.302034 * safezoneW + safezoneX;
	y = 0.36 * safezoneH + safezoneY;
	w = 0.0927966 * safezoneW;
	h = 0.112 * safezoneH;
};
class NEO_radioTransportTaskText: RscText
{
	idc = 1004;
	x = 0.444322 * safezoneW + safezoneX;
	y = 0.178 * safezoneH + safezoneY;
	w = 0.098983 * safezoneW;
	h = 0.028 * safezoneH;
};
class NEO_radioTransportHelpTaskText: RscText
{
	idc = 1005;
	x = 0.444322 * safezoneW + safezoneX;
	y = 0.36 * safezoneH + safezoneY;
	w = 0.0927966 * safezoneW;
	h = 0.112 * safezoneH;
};
class NEO_radioTransportTaskList: RscListbox
{
	idc = 1502;
	x = 0.438136 * safezoneW + safezoneX;
	y = 0.22 * safezoneH + safezoneY;
	w = 0.098983 * safezoneW;
	h = 0.126 * safezoneH;
};
class NEO_radioTransportConfirmButton: RscButton
{
	idc = 1601;
	text = "Confirm"; //--- ToDo: Localize;
	x = 0.302034 * safezoneW + safezoneX;
	y = 0.654 * safezoneH + safezoneY;
	w = 0.0804237 * safezoneW;
	h = 0.028 * safezoneH;
};
class NEO_radioTransportBaseButton: RscButton
{
	idc = 1602;
	text = "Return to Base"; //--- ToDo: Localize;
	x = 0.438136 * safezoneW + safezoneX;
	y = 0.654 * safezoneH + safezoneY;
	w = 0.098983 * safezoneW;
	h = 0.028 * safezoneH;
};
class NEO_radioTransportSmokeFoundButton: RscButton
{
	idc = 1603;
	text = "Confirm Smoke"; //--- ToDo: Localize;
	x = 0.58661 * safezoneW + safezoneX;
	y = 0.654 * safezoneH + safezoneY;
	w = 0.0927966 * safezoneW;
	h = 0.028 * safezoneH;
};
class NEO_radioTransportCircleSlider: RscSlider
{
	idc = 1900;
	x = 0.135 * safezoneW + safezoneX;
	y = 0.5 * safezoneH + safezoneY;
	w = 0.136102 * safezoneW;
	h = 0.028 * safezoneH;
};
class NEO_radioTransportCircleSliderText: RscText
{
	idc = 1006;
	text = "Radius: 100/300"; //--- ToDo: Localize;
	x = 0.153559 * safezoneW + safezoneX;
	y = 0.43 * safezoneH + safezoneY;
	w = 0.098983 * safezoneW;
	h = 0.028 * safezoneH;
};
class NEO_radioTransportPropertiesText: RscText
{
	idc = 1007;
	text = "Behaviour"; //--- ToDo: Localize;
	x = 0.32678 * safezoneW + safezoneX;
	y = 0.528 * safezoneH + safezoneY;
	w = 0.0618644 * safezoneW;
	h = 0.028 * safezoneH;
};
class NEO_radioTransportHeightCb: RscCombo
{
	idc = 2100;
	x = 0.135 * safezoneW + safezoneX;
	y = 0.57 * safezoneH + safezoneY;
	w = 0.129915 * safezoneW;
	h = 0.028 * safezoneH;
};
class NEO_radioTransportSpeedCb: RscCombo
{
	idc = 2101;
	x = 0.283475 * safezoneW + safezoneX;
	y = 0.57 * safezoneH + safezoneY;
	w = 0.129915 * safezoneW;
	h = 0.028 * safezoneH;
};
class NEO_radioTransportRoeCb: RscCombo
{
	idc = 2102;
	x = 0.438136 * safezoneW + safezoneX;
	y = 0.57 * safezoneH + safezoneY;
	w = 0.129915 * safezoneW;
	h = 0.028 * safezoneH;
};
class RscButton_1604: RscButton
{
	idc = 1604;
	text = "New Smoke"; //--- ToDo: Localize;
	x = 0.728898 * safezoneW + safezoneX;
	y = 0.654 * safezoneH + safezoneY;
	w = 0.0804237 * safezoneW;
	h = 0.028 * safezoneH;
};

//CAS EXTRA

class NEO_radioCasFlyHeightText: RscText
{
	idc = 1006;
	text = "Radius"; //--- ToDo: Localize;
	x = 0.153559 * safezoneW + safezoneX;
	y = 0.388 * safezoneH + safezoneY;
	w = 0.098983 * safezoneW;
	h = 0.028 * safezoneH;
};
class NEO_radioCasFlyHeightSlider: RscSlider
{
	idc = 1901;
	x = 0.122627 * safezoneW + safezoneX;
	y = 0.514 * safezoneH + safezoneY;
	w = 0.136102 * safezoneW;
	h = 0.028 * safezoneH;
////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT END
////////////////////////////////////////////////////////
class NEO_radioArtyRateOfFireText: RscText
{
	idc = 1006;
	x = 0.302034 * safezoneW + safezoneX;
	y = 0.486 * safezoneH + safezoneY;
	w = 0.098983 * safezoneW;
	h = 0.028 * safezoneH;
};
class NEO_radioArtyRateOfFireLb: RscListbox
{
	idc = 1503;
	x = 0.302034 * safezoneW + safezoneX;
	y = 0.528 * safezoneH + safezoneY;
	w = 0.098983 * safezoneW;
	h = 0.098 * safezoneH;
};
class NEO_radioArtyRoundCountText: RscText
{
	idc = 1007;
	x = 0.438136 * safezoneW + safezoneX;
	y = 0.486 * safezoneH + safezoneY;
	w = 0.098983 * safezoneW;
	h = 0.028 * safezoneH;
};
class NEO_radioArtyRoundCountLb: RscListbox
{
	idc = 1504;
	x = 0.438136 * safezoneW + safezoneX;
	y = 0.528 * safezoneH + safezoneY;
	w = 0.098983 * safezoneW;
	h = 0.098 * safezoneH;