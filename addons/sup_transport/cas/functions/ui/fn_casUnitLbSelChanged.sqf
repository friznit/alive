private ["_display", "_map"];
_display = findDisplay 655555;
_map = _display displayCtrl 655560;

private 
[
	"_casArray", "_casUnitLb", "_casUnitText", "_casHelpUnitText", "_casConfirmButton", "_casBaseButton", "_casTaskLb", "_casTaskText", 
	"_casTaskHelpText", "_casFlyHeightSlider", "_casFlyHeighSliderText", "_casRadiusSlider", "_casRadiusSliderText", "_supportMarker", 
	"_veh", "_status"
];
_casArray = ALIVE_radioLogic getVariable format ["ALIVE_radioCasArray_%1", side player];
_casUnitLb = _display displayCtrl 655582;
_casUnitText = _display displayCtrl 655583;
_casHelpUnitText = _display displayCtrl 655584;
_casConfirmButton = _display displayCtrl 655585;
_casBaseButton = _display displayCtrl 655586;
_casTaskLb = _display displayCtrl 655587;
_casTaskText = _display displayCtrl 655588;
_casTaskHelpText = _display displayCtrl 655589;
_casFlyHeightSlider = _display displayCtrl 655590;
_casFlyHeighSliderText = _display displayCtrl 655591;
_casRadiusSlider = _display displayCtrl 655592;
_casRadiusSliderText = _display displayCtrl 655593;
_supportMarker = ALIVE_radioLogic getVariable "ALIVE_supportMarker";
_veh = _casArray select (lbCurSel _casUnitLb) select 0;
_status = _veh getVariable "ALIVE_radioCasUnitStatus";

//Status Text
_casHelpUnitText ctrlSetStructuredText parseText (switch (_status) do
{
	case "NONE" : { "<t color='#00FF00' size='0.7' font='Zeppelin33Italic'>Unit is available and waiting for task</t>" };
	case "KILLED" : { "<t color='#FF0000' size='0.7' font='Zeppelin33Italic'>Unit is combat innefective</t>" };
	case "MISSION" : { "<t color='#FFFF00' size='0.7' font='Zeppelin33Italic'>Unit is on a mission, you may abort or change the current task</t>" };
	case "RTB" : { "<t color='#FFFF00' size='0.7' font='Zeppelin33Italic'>Unit is RTB</t>" };
});

//Marker
uinamespace setVariable ["ALIVE_casMarkerCreated", nil];
_supportMarker setMarkerAlphaLocal 0;

//Base Button
if (_status == "RTB" || _status == "NONE" || _status == "KILLED" || getPosATL _veh select 2 < 10) then
{
	_casBaseButton ctrlEnable false;
}
else
{
	_casBaseButton ctrlEnable true;
};

//Re-initialize Controls
{ _x ctrlSetPosition [1, 1, (safeZoneW / 1000), (safeZoneH / 1000)]; _x ctrlCommit 0; } forEach [_casFlyHeightSlider, _casRadiusSlider];
{ _x ctrlSetText "" } forEach [_casTaskText, _casTaskHelpText, _casFlyHeighSliderText, _casRadiusSliderText];
{ lbClear _x } forEach [_casTaskLb];

if (_status != "KILLED") then
{
	//Targets Text
	_casTaskText ctrlSetStructuredText parseText "<t color='#FFFFFF' size='0.8' font='Zeppelin33Italic'>TASK</t>";
	_casTaskHelpText ctrlSetStructuredText parseText "<t color='#FFFF00' size='0.7' font='Zeppelin33Italic'>Select a task</t>";
	
	//Tasks LB
	_casTaskLb ctrlEnable true;
	lbClear _casTaskLb;
	{
		_casTaskLb lbAdd _x;
	} forEach ["SAD"];
	
	//GPS
	uinamespace setVariable ["ALIVE_casMarkerCreated", nil];
	_supportMarker setMarkerAlphaLocal 0;
	
	//Sliders
	_casFlyHeighSliderText ctrlSetText "Flying Altitude: Medium";
	_casFlyHeighSliderText ctrlSetPosition [safeZoneX + (safeZoneW / 3.05), safeZoneY + (safeZoneH / 1.48), (safeZoneW / 10), (safeZoneH / 75)];
	_casFlyHeighSliderText ctrlCommit 0;
	_casFlyHeightSlider ctrlSetPosition [safeZoneX + (safeZoneW / 3.10), safeZoneY + (safeZoneH / 1.45), (safeZoneW / 10), (safeZoneH / 75)];
	_casFlyHeightSlider ctrlCommit 0;
	
	_casFlyHeightSlider sliderSetRange [1, 3];
	_casFlyHeightSlider sliderSetspeed [1, 1];
	_casFlyHeightSlider sliderSetPosition 2;
	_casFlyHeightSlider ctrlSetEventHandler ["SliderPosChanged", 
	"
		private [""_slider"", ""_pos"", ""_casFlyHeightSliderText"", ""_text""];
		_slider = _this select 0;
		_pos = round (_this select 1);
		_casFlyHeightSliderText = (findDisplay 655555) displayCtrl 655591;
		_text = switch (_pos) do
		{
			case 1 : { ""Flying Altitude: Low"" };
			case 2 : { ""Flying Altitude: Medium"" };
			case 3 : { ""Flying Altitude: High"" };
		};
		
		_slider sliderSetPosition _pos;
		_casFlyHeightSliderText ctrlSetText _text;
	"];
	
	//GPS
	_map ctrlSetEventHandler ["MouseButtonDown", "_this call ALIVE_fnc_radioMapEvent"];
};

//Confirm Button
[] call ALIVE_fnc_casConfirmButtonEnable;
