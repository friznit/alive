params ["_unit"];

//-- Clean any existing displayed gear
lbClear 7244;


//-- Get primary weapon
_displayName = getText (configfile >> "CfgWeapons" >> (primaryWeapon _unit) >> "displayName");
_primaryWep = format ["Primary weapon: %1", _displayName];
_row = lbAdd [7244,_primaryWep];


//-- Get handgun
_displayName = getText (configfile >> "CfgWeapons" >> (handgunWeapon _unit) >> "displayName");
_handgunWep = format ["Secondary: %1", _displayName];
_row = lbAdd [7244,_handgunWep];


//-- Get secondary weapon
_displayName = getText (configfile >> "CfgWeapons" >> (secondaryWeapon _unit) >> "displayName");
_secondaryWep = format ["Launcher: %1", _displayName];
_row = lbAdd [7244,_secondaryWep];


//-- Get magazines
_magazines = magazines _unit;
{
	_magazine = _x;
	_count = {_x == _magazine} count _magazines;
	if !(_count == 0) then {
		for "_i" from 0 to _count step 1 do {_magazines = _magazines - [_magazine]};

		_displayName = getText (configfile >> "CfgMagazines" >> _magazine >> "displayName");
		_magazineInfo = format ["%1: %2", _displayName,_count];
		_row = lbAdd [7244,_magazineInfo];
	};
} forEach _magazines;


//-- Get items
_items = items _unit;
{
	_item = _x;
	_count = {_x == _item} count _items;
	if !(_count == 0) then {
		for "_i" from 0 to _count step 1 do {_items = _items - [_item]};

		_displayName = getText (configfile >> "CfgWeapons" >> _item >> "displayName");
		if (isNil "_displayName") then {_displayName = getText (configfile >> "CfgMagazines" >> _item >> "displayName")};
		if (isNil "_displayName") then {_displayName = getText (configfile >> "CfgVehicles" >> _item >> "displayName")};
		_itemInfo = format ["%1: %2", _displayName,_count];
		_row = lbAdd [7244,_itemInfo];
	};
} forEach _items;