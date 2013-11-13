
if (!enable_playertags) exitWith {foundUnitsCount = 0;};

_gen = player;
_tolerance = playertags_tolerance;
_maxDistance = playertags_distance;
_ownSide = side _gen;
_possibleVehicles = ["Man", "Car", "Tank", "StaticWeapon", "Helicopter", "Plane"];
_playerVehicle = vehicle _gen;
_genPos = getPos _gen;
_objects = [];
_i = 0;
{
	if (side _x == _ownSide && _x != _gen) then {
		_objects set [_i, _x];
		_i = _i + 1;
	};
} foreach nearestObjects [_genPos, _possibleVehicles, _maxDistance];
_objCount = count _objects;

foundUnitsText = [];
foundUnitsCount = 0;
_i = 0;
_shownObjects = 0;

while { (_shownObjects < 10) && (_i < _objCount) } do {
	_obj = _objects select _i;
	if (_obj != _playerVehicle) then {
		_objPos = getPos _obj;
		_bb = boundingBox _obj;
		_bbZMin = (_bb select 0) select 2;
		_bbZMax = (_bb select 1) select 2;
		_bbZDiff = (_bbZMax - _bbZMin) / 2.0;
		if (_bbZDiff > 1) then { _bbZDiff = 1; };
		_objPos set [2, (_objPos select 2) + _bbZDiff];
		_scrPos = worldToScreen _objPos;
		if (count _scrPos == 2) then {
			_scrX = _scrPos select 0;
			_scrY = _scrPos select 1;
			if (_scrX < 1.5 && _scrX > -1.5 && _scrY < 1.5 && _scrY > -1.5) then {
				_distToCenter = sqrt ((_scrX - 0.5) * (_scrX - 0.5) + (_scrY - 0.5) * (_scrY - 0.5));
				_objSizeMod = 1.0;
				_objDist = _gen distance _obj;
				_objDistMod = 2 - (_objDist / _maxDistance);

				if (_distToCenter <= _tolerance * _objSizeMod * _objDistMod) then {
					_shownObjects = _shownObjects + 1;
					[_obj, _objDist, _scrPos, _objDistMod, false] call playertags_generateLabelText;
				};
			};
		};
	};
	_i = _i + 1;
};
if (_playerVehicle != _gen) then {
	if (foundUnitsCount > 9) then {
		foundUnitsCount = 9;
	};
	[_playerVehicle, 0, [0.0, 0.05], 2, true] call playertags_generateLabelText;
};

