_position = (_this select 0) ctrlMapScreenToWorld [(_this select 2),(_this select 3)];
_index = lbCurSel 7239;
disableSerialization;

//-- Delete existing position
if !(isNil {uiNamespace getVariable "SpyderCommandTablet_MissionPosition"}) then {
	deleteMarkerLocal (uiNamespace getVariable "SpyderCommandTablet_MissionPosition");
	uiNamespace setVariable ["SpyderCommandTablet_MissionPosition", nil];
};

if !(_index == -1) then {
	_marker = createMarkerLocal [(format ["%1", random 100]), _position];
	_marker setMarkerShapeLocal "ICON";
	_marker setMarkerTypeLocal "mil_dot";
	switch (str (_index)) do {
		case "0": {_marker setMarkerTextLocal "Reinforcement location"};
		case "1": {_marker setMarkerTextLocal "Recon location"};
		case "2": {_marker setMarkerTextLocal "Assault location"};
	};
	uiNamespace setVariable ["SpyderCommandTablet_MissionPosition", _marker];

	//-- Focus map on position
	ctrlMapAnimClear (findDisplay 723 displayCtrl 7232);
	(findDisplay 723 displayCtrl 7232) ctrlMapAnimAdd [.3, ctrlMapScale (findDisplay 723 displayCtrl 7232), _position];
	ctrlMapAnimCommit (findDisplay 723 displayCtrl 7232);
};