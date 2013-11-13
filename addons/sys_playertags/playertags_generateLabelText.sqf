
private ['_lineCount', '_tmpText', '_type', '_vehicle', '_playerVehicle'];

_obj = _this select 0;
_objDist = _this select 1;
_scrPos = _this select 2;
_objDistMod = _this select 3;
_absolutePos = _this select 4;
_lineCount = 0;
_tmpText = "";
_type = vehicle _obj;
_ownGroup = group player;

func_getRank = {
	private["_rankid","_ranktag"];
	_rankid = _this;
	_ranktag = "";
	switch (_rankid) do {
		case 0 : {_ranktag = "Private";};
		case 1 : {_ranktag = "Corporal";};
		case 2 : {_ranktag = "Sergeant";};
		case 3 : {_ranktag = "Lieutenant";};
		case 4 : {_ranktag = "Captain";};
		case 5 : {_ranktag = "Major";};
		case 6 : {_ranktag = "Colonel";};
		default  {};
	};
	_ranktag
};
		
		
if (_type isKindOf "Car" ||
		_type isKindOf "StaticWeapon" ||
		_type isKindOf "Plane" ||
		_type isKindOf "Helicopter" ||
		_type isKindOf "Tank") then {
	_vehicle = _obj;
	_objTypeStr = format["%1", (typeOf _vehicle)];
	_name = getText(configFile >> "cfgVehicles" >> _objTypeStr >> "displayName");
	_tmpText = _tmpText + format["%1:<br/>", _name];
	_lineCount = 1;
	{
		if (!(isNull _x) && alive _x) then {
			if (gunner _vehicle == _x) then {
				_tmpText = _tmpText + "G: ";
			};
			if (driver _vehicle == _x) then {
				_tmpText = _tmpText + "D: ";
			};
			if (commander _vehicle == _x) then {
				_tmpText = _tmpText + "C: ";
			};
			_nameColor = '#ffffff';
			_groupColor = '#A8F000'; // green
			_rankColor = '#ffffff';
			if (_x == leader group _x) then {
				_nameColor = '#FFB300'; // yellow
			};
			if (group _x == _ownGroup) then {
				_groupColor = '#009D91'; // Cyan
			};
			_rank = '';
			if (PLAYERTAGS_RANK) then {
				_rank = (rankId _x) call func_getRank;
			};
			_thisgroup = '';
			if (PLAYERTAGS_GROUP) then {
				_thisgroup = group _x;
			};
			_tmpText = _tmpText + format["<t color='%1'>%5 %2</t><br/>", _nameColor, name _x, _groupColor, _thisgroup, _rank, _rankColor];
			_lineCount = _lineCount + 1;
		}
	} foreach (crew _vehicle);
}
else {
	_man = _obj;
	_group = group _man;
	_nameColor = '#ffffff';
	_groupColor = '#A8F000'; // green
	_rankColor = '#ffffff';

	if (alive _man) then
	{
		if (_man == leader _group) then {
			_nameColor = '#FFB300'; // yellow
		};
		if (_group == _ownGroup) then {
			_groupColor = '#009D91'; // cyan
		};
		_rank = '';
		if (PLAYERTAGS_RANK) then {
		_rank = (rankId _man) call func_getRank;
		};
		_thisgroup = '';
		if (PLAYERTAGS_GROUP) then {
				_thisgroup = group _man;
		};
		_tmpText = _tmpText + format["<t color='%1'>%5 %2</t> <br/><t color='%3'>%4</t>", _nameColor, name _man, _groupColor, _thisgroup, _rank, _rankColor];
		_lineCount = 1;
	};
};
	
foundUnitsText set [foundUnitsCount, [_tmpText, _scrPos, _lineCount, _objDistMod, _absolutePos]];
foundUnitsCount = foundUnitsCount + 1;
