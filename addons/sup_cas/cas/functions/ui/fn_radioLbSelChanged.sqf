private ["_display", "_map", "_lb", "_index", "_supportMarker", "_artyMarkers"];
_display = findDisplay 655555;
_map = _display displayCtrl 655560;
_lb = _this select 0;
_index = _this select 1;
_supportMarker = ALIVE_radioLogic getVariable "ALIVE_supportMarker";
_artyMarkers = ALIVE_radioLogic getVariable "ALIVE_supportArtyMarkers";


//CAS Controls
private 
[
	"_casUnitLb", "_casUnitText", "_casHelpUnitText", "_casConfirmButton", "_casBaseButton", "_casTaskLb", "_casTaskText", "_casTaskHelpText",
	"_casFlyHeightSlider", "_casFlyHeighSliderText", "_casRadiusSlider", "_casRadiusSliderText"
];
_casUnitLb = _display displayCtrl 1500;
_casUnitText = _display displayCtrl 655583;
_casHelpUnitText = _display displayCtrl 655584;
_casConfirmButton = _display displayCtrl 655585;
_casBaseButton = _display displayCtrl 655586;
_casTaskLb = _display displayCtrl 655587;
_casTaskText = _display displayCtrl 655588;
_casTaskHelpText = _display displayCtrl 655589;



//Re-initialize Controls
{ (_x select 0) ctrlSetEventHandler [(_x select 1), ""] } forEach [[_map, "MouseButtonDown"]];
{ _x ctrlSetPosition [1, 1, (safeZoneW / 1000), (safeZoneH / 1000)]; _x ctrlCommit 0; } forEach [ _casConfirmButton, _casBaseButton, _casFlyHeightSlider, _casRadiusSlider];
{ _x ctrlSetText "" } forEach  [_casUnitText, _casHelpUnitText, _casTaskText, _casTaskHelpText, _casFlyHeighSliderText, _casRadiusSliderText];
{ _x ctrlEnable false; } forEach [ _casUnitLb, _casTaskLb];
{ lbClear _x } forEach [ _casUnitLb, _casTaskLb];

//Markers
{ uinamespace setVariable [_x, nil] } forEach ["ALIVE_casMarkerCreated"];

	{
		private ["_casArray"];
		_casArray = ALIVE_radioLogic getVariable format ["ALIVE_radioCasArray_%1", side player];
		
		if (count _casArray > 0) then
		{
			_casUnitText ctrlSetStructuredText parseText "<t color='#FFFFFF' size='0.8' font='Zeppelin33Italic'>UNIT</t>";
			_casHelpUnitText ctrlSetStructuredText parseText "<t color='#FFFF00' size='0.7' font='Zeppelin33Italic'>Select a unit</t>";
			
			_casConfirmButton ctrlEnable false; _casConfirmButton ctrlSetPosition [safeZoneX + (safeZoneW / 3), safeZoneY + (safeZoneH / 1.425), (safeZoneW / 10), (safeZoneH / 20)]; _casConfirmButton ctrlCommit 0;
			_casBaseButton ctrlEnable false; _casBaseButton ctrlSetPosition [safeZoneX + (safeZoneW / 3), safeZoneY + (safeZoneH / 1.375), (safeZoneW / 8), (safeZoneH / 20)]; _casBaseButton ctrlCommit 0;
			
			_casUnitLb ctrlEnable true;
			lbClear _casUnitLb;
			{
				_casUnitLb lbAdd (_x select 2);
				_casUnitLb lbSetPicture [_forEachIndex, (getText (configFile >> "CfgVehicles" >> typeOf (_x select 0) >> "picture"))];
			} forEach _casArray;
			
			_casUnitLb ctrlSetEventHandler ["LBSelChanged", "_this call ALIVE_fnc_casUnitLbSelChanged"];
			_casTaskLb ctrlSetEventHandler ["LBSelChanged", "_this call ALIVE_fnc_casTaskLbSelChanged"];
			_casConfirmButton ctrlSetEventHandler ["ButtonClick", "_this call ALIVE_fnc_casConfirmButton"];
			_casBaseButton ctrlSetEventHandler ["ButtonClick", "_this call ALIVE_fnc_casBaseButton"];
			
			if (count _casArray < 1) then { lbSetCurSel [655582, 0] };
		};
	};
