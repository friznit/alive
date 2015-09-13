private ["_operation"];

if (isNil {uiNamespace getVariable "SpyderCommandTablet_MissionPosition"}) exitWith {hint "Please select a position on the map first"};

_operation = lbCurSel 7239;

switch (str (_operation)) do {
	case "0": {
		["client"] spawn ALiVE_fnc_requestReinforcements;
	};
	case "1": {
		["client"] spawn ALiVE_fnc_requestRecon;
	};
	case "2": {
		["client"] spawn ALiVE_fnc_requestAssault;
	};
};