private ["_m","_markers","_delay"];

_markers = [];
_delay = 15;

{
	_m = createMarkerLocal [str _x, position _x];
	//_m setMarkerShapeLocal "ICON";
	_m setMarkerTypeLocal "mil_dot";
	//_m setMarkerTextLocal typeof _x;
	_markers set [count _markers, _m];
	switch (side _x) do {
		case west: {
			_m setMarkerColorLocal "ColorBLUFOR";
		};
		case east: {
			_m setMarkerColorLocal "ColorOPFOR";
		};
		case resistance: {
			_m setMarkerColorLocal "ColorIndependent";
		};
		case civilian: {
			_m setMarkerColorLocal "ColorCivilian";
		};
	};
} forEach allUnits;
				
sleep _delay;

{
	deleteMarkerLocal _x;
} forEach _markers;
