// addEH.sqf
private ["_name"];
_name = _this select 0;
_name setVariable ["NORRN_handDamage", 0, false];
_name setVariable ["NORRN_legDamage", 0, false];
_name setVariable ["NORRN_headDamage", 0, false];
_name setVariable ["NORRN_bodyDamage", 0, false];
// Add damageEH
_name addEventHandler ["HandleDamage", {_this execVM "revive_sqf\damageEH\handleDamage.sqf"; 0}];
if ( format ["%1", (_name getVariable "NORRN_totalDamage")] == "<null>")      then {_name setVariable ["NORRN_totalDamage", 0, false]};
Hint "Single Player Mission";