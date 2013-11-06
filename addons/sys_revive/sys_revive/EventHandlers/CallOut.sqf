// Norrn_CallOut
// MAY 2013 - norrin
private ["_call_out_function","_unit","_ran"];
_call_out_function     =  NORRN_revive_array select 6;
_unit                 = _this select 0;
_ran                 = floor(random 11);
if (_call_out_function == 1) then { 
    _unit say (NORRN_r_commentsBrian select _ran);
    norrnRpvEH = [NORRN_rSay,[_unit, _ran]];
    publicVariable "norrnRpvEH";
};
20 + ceil(random 10);