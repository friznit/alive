/*
    	private ["_logic","_unit","_sentences","_side","_lastTime","_varName","_sentence","_kind","_lastKind","_exitNow","_chatRep","_repExChance","_ct"];

	_unit = _this select 0;
	_sentences = _this select 1;
	_side = side _unit;
    _logic = _this select ((count _this)-1);

	if (({(((side _x) == _side) and (isPlayer _x))} count AllUnits) < 1) exitWith {};

	_kind = _this select 2;

	_varName = "_West";

	switch (_side) do
		{
		case (east) : {_varName = "_East"};
		case (resistance) : {_varName = "_Guer"};
		};

	_lastTime = missionNameSpace getVariable ["HAC_AIChatLT" + _varName,[0,""]];
	_lastKind = _lastTime select 1;
	_lastTime = _lastTime select 0;

	if ((time - _lastTime) < 10) then {sleep (4 + (random 2))};

	_lastTime = missionNameSpace getVariable ["HAC_AIChatLT" + _varName,[0,""]];
	_lastKind = _lastTime select 1;
	_lastTime = _lastTime select 0;

	if ((time - _lastTime) < 10) exitWith {}; 

	_exitNow = false;

	_chatRep = 0;

	if (_lastKind in [_kind]) then
		{
		_chatRep = missionNameSpace getVariable ["HAC_AIChatRep" + _varName,0];
		_repExChance = round (random 2);

		if (_chatRep >= _repExChance) then 
			{
			if ((random 100) < (90 + _chatRep)) then
				{
				_exitNow = true
				}
			}
		};

	if (_exitNow) exitWith {};

	missionNameSpace setVariable ["HAC_AIChatLT" + _varName,[_lastTime,_kind]];

	if (_lastKind in [_kind]) then
		{
		missionNameSpace setVariable ["HAC_AIChatRep" + _varName,_chatRep + 1]
		};

	_sentence = _sentences select (floor (random (count _sentences)));

	if not (isMultiplayer) then
		{
		_unit sideRadio _sentence
		}
	else
		{
		[_unit,nil, "per", rSIDERADIO,_sentence] call RE;
		};
	//player sidechat format ["sent: %1",_sentence];
	missionNameSpace setVariable ["HAC_AIChatLT" + _varName,[time,_kind]];
*/
    