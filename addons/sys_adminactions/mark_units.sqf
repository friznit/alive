private ["_m","_markers","_delay"];

_markers = [];
_delay = 15;

{
	_m = createMarkerLocal [str _x, position _x];
	//_m setMarkerShapeLocal "ICON";
	// _m setMarkerTypeLocal "mil_dot";
	//_m setMarkerTextLocal typeof _x;
	_m setMarkerSizeLocal [.5,.5];
	_markers set [count _markers, _m];
	switch (side _x) do {
		case west: {
			_m setMarkerTypeLocal "b_unknown";
			_m setMarkerColorLocal "ColorBLUFOR";
		};
		case east: {
			_m setMarkerTypeLocal "o_unknown";
			_m setMarkerColorLocal "ColorOPFOR";
		};
		case resistance: {
			_m setMarkerTypeLocal "n_unknown";
			_m setMarkerColorLocal "ColorIndependent";
		};
		case civilian: {
			_m setMarkerTypeLocal "c_unknown";
			_m setMarkerColorLocal "ColorCivilian";
		};
	};
} forEach allUnits;
				
sleep _delay;

{
	deleteMarkerLocal _x;
} forEach _markers;
