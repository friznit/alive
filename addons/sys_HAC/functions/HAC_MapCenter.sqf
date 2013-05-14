//MapCenter.sqf script code by Kempco

disableSerialization;

openMap [true, false];

waitUntil {visibleMap};

_Map_display = findDisplay 12;
_map_cntrl = _Map_display displayCtrl 51; 
_map_cntrl ctrlMapAnimAdd [0, 1000, [9999999999, 9999999999]];
ctrlMapAnimCommit _map_cntrl;
waitUntil {ctrlMapAnimDone _map_cntrl};

_zoom_max = ctrlMapScale _map_cntrl;
_limit = _map_cntrl ctrlMapScreenToWorld [0.5, 0.5];
_x_max = _limit select 0;
_y_max = _limit select 1;

_map_center = [0.5*(_limit select 0),0.5*(_limit select 1)]; 

openMap [false, false];

_logic setvariable ["HAC_BB_MapC", _map_center];
_logic setvariable ["HAC_BB_MapXMax", _x_max];
_logic setvariable ["HAC_BB_MapYMax", _y_max];