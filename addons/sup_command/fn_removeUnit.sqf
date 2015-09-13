_index = lbCurSel 7245;
_units = player getVariable 'STCcurrentGroup';
_unit = _units select _index;

if (!isPlayer _unit) then {
	switch (toLower(_this select 0)) do {
		case "remove": {
			_side = side _unit;
			_newGroup = createGroup _side;
			[_unit] joinSilent _newGroup;
		};
		case "delete": {deleteVehicle _unit};
	};
} else {
	_newGroup = createGroup (side _unit);
	[_unit] joinSilent _newGroup;
};

//-- Build new list
["squadlist"] spawn ALiVE_fnc_buildList;