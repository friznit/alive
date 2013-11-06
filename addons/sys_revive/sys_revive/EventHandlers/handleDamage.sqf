// handleDamage.sqf

_unit = _this select 0;
_hitLocation = _this select 1;
_damage = _this select 2;

if(!local _unit || _damage <= 0.1) exitWith {};  

if (_hitLocation == "legs") then 
{
    _totalDamage = (_unit getVariable "NORRN_legDamage") + _damage/20; 
    _unit setHit ["legs", _totalDamage]; 
    _unit setVariable ["NORRN_legDamage", _totalDamage, false];

    //hint format ["Legs: %1", _totalDamage];
};

if (_hitLocation == "hands") then 
{
    _totalDamage = (_unit getVariable "NORRN_handDamage") + _damage/40; 
    _unit setHit ["hands", _totalDamage]; 
    _unit setVariable ["NORRN_handDamage", _totalDamage, false];

    //hint format ["Hands: %1", _totalDamage];
};

if (_hitLocation == "head_hit") then 
{    
    _totalDamage = (_unit getVariable "NORRN_headDamage") + _damage; 
    if (_totalDamage > 0.9) then {_totalDamage = 0.9; _unit setVariable ["NORRN_unconscious", true, true]};
    _unit setHit ["head_hit", _totalDamage]; 
    _unit setVariable ["NORRN_headDamage", _totalDamage, false];

    //hint format ["Head: %1", _totalDamage];
};

if (_hitLocation == "body") then 
{
    _totalDamage = (_unit getVariable "NORRN_bodyDamage") + _damage;
    if (_totalDamage > 0.9) then {_totalDamage = 0.9; _unit setVariable ["NORRN_unconscious", true, true]};
    _unit setHit ["body", _totalDamage]; 
    _unit setVariable ["NORRN_bodyDamage", _totalDamage, false];

    //hint format ["Body: %1", _totalDamage];
};
sleep 0.1;
_overallDamage = ((_unit getVariable "NORRN_legDamage") + (_unit getVariable "NORRN_handDamage") + (_unit getVariable "NORRN_headDamage") + (_unit getVariable "NORRN_bodyDamage"));
_unit setVariable ["NORRN_totalDamage", _overallDamage, false];
if (_overallDamage > 0.9) then
{    
    _unit setVariable ["NORRN_unconscious", true, true];
};
//hint format ["%1", _unit getVariable "NORRN_unconscious"];
//hint format ["Body: %1", _overallDamage];
