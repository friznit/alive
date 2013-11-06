// resetSPVars.sqf
_name = _this select 0;
_name setVariable ["NORRN_handDamage", 0, false];
_name setVariable ["NORRN_legDamage", 0, false];
_name setVariable ["NORRN_headDamage", 0, false];
_name setVariable ["NORRN_bodyDamage", 0, false];
_name setVariable ["NORRN_totalDamage", 0, false];
_name setHit ["legs", 0]; 
_name setHit ["hands", 0]; 
_name setHit ["head_hit", 0];
_name setHit ["body", 0];