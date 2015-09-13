params ["_marker"];

while {markerAlpha _marker > 0.02} do {
	_marker setMarkerAlpha (markerAlpha _marker - .02);
	sleep 10;
};

deleteMarker _marker;