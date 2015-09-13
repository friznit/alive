private ["_operation"];

_operation = lbCurSel 7237;

switch (str (_operation)) do {
	case "-1": {
		hint "You must select a form of analysis first";
	};
	case "0": {
		[] spawn ALiVE_fnc_markObjectives;
	};
	case "1": {
		[] spawn ALiVE_fnc_markUnits;
	};
};