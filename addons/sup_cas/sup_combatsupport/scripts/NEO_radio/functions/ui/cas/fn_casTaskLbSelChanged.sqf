private ["_lb", "_index", "_display", "_map"];
_lb = _this select 0;
_index = _this select 1;
_display = findDisplay 655555;
_map = _display displayCtrl 655560;

private 
[
	"_casArray", "_casUnitLb", "_casUnitText", "_casHelpUnitText", "_casConfirmButton", "_casBaseButton", "_casTaskLb", "_casTaskText", 
	"_casTaskHelpText", "_show", "_veh", "_casRadiusSlider", "_casRadiusSliderText"
];
_casArray = NEO_radioLogic getVariable format ["NEO_radioCasArray_%1", side player];
_casUnitLb = _display displayCtrl 655582;
_casUnitText = _display displayCtrl 655583;
_casHelpUnitText = _display displayCtrl 655584;
_casConfirmButton = _display displayCtrl 655585;
_casBaseButton = _display displayCtrl 655586;
_casTaskLb = _display displayCtrl 655587;
_casTaskText = _display displayCtrl 655588;
_casTaskHelpText = _display displayCtrl 655589;
_show = switch (toUpper (_lb lbText _index)) do
{
	case "SAD" : { "<t color='#FFFF73' size='0.7' font='PuristaMedium'>Unit will move to location, provide Close Air Support and engage all painted targets</t>" };
};
_veh = _casArray select (lbCurSel _casUnitLb) select 0;
_casRadiusSlider = _display displayCtrl 655592;
_casRadiusSliderText = _display displayCtrl 655593;

//Radius Slider
if (toUpper (_lb lbText _index) == "SAD") then
{
	_casRadiusSliderText ctrlSetText "CAS Radius: 500m";
	_casRadiusSliderText ctrlSetPosition [0.280111 * safezoneW + safezoneX, 0.514 * safezoneH + safezoneY, (0.0927966 * safezoneW), (0.028 * safezoneH)];
	_casRadiusSliderText ctrlCommit 0;
	_casRadiusSlider ctrlSetPosition [0.281002 * safezoneW + safezoneX, 0.5504 * safezoneH + safezoneY, (0.0927966 * safezoneW), (0.0196 * safezoneH)];
	_casRadiusSlider ctrlCommit 0;

	_casFlyHeighSliderText ctrlCommit 0;
	_casRadiusSlider sliderSetRange [250, 1000];
	_casRadiusSlider sliderSetspeed [50, 100];
	_casRadiusSlider sliderSetPosition 500;
	_casRadiusSlider ctrlSetEventHandler ["SliderPosChanged", 
	"
		private [""_slider"", ""_pos"", ""_casRadiusSliderText"", ""_text""];
		_slider = _this select 0;
		_pos = round (_this select 1);
		_casRadiusSliderText = (findDisplay 655555) displayCtrl 655593;
		_text = format [""CAS Radius: %1m"", _pos];
		
		_slider sliderSetPosition _pos;
		_casRadiusSliderText ctrlSetText _text;
	"];
}
else
{
	_casRadiusSliderText ctrlSetText "";
	_casRadiusSliderText ctrlSetPosition [safeZoneX + (safeZoneW / 2.255), safeZoneY + (safeZoneH / 1.48), (safeZoneW / 1000), (safeZoneH / 1000)];
	_casRadiusSliderText ctrlCommit 0;
	_casRadiusSlider ctrlSetPosition [safeZoneX + (safeZoneW / 2.275), safeZoneY + (safeZoneH / 1.45), (safeZoneW / 1000), (safeZoneH / 1000)];
	_casRadiusSlider ctrlCommit 0;
};

//Help Text
_casTaskHelpText ctrlSetStructuredText parseText _show;

//Confirm Button
[] call NEO_fnc_casConfirmButtonEnable;
