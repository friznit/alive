// carry.sqf
// norrin, MAY 2013
private ["_dragee","_pos","_dir"];
_dragee                = _this select 3;
r_carry_sqf         = true;
r_drag_sqf            = false;
player removeAction Norrn_carryAction;
if (isNull _dragee) exitWith {};
detach _dragee;
sleep 1;
_dragee setDir (getDir player + 180);
sleep 1;
norrnRpvEH = [NORRN_rSwitchAnim,[[_dragee,"AinjPfalMstpSnonWnonDnon_carried_up"]]];
publicVariable "norrnRpvEH";
_dragee switchMove "AinjPfalMstpSnonWnonDnon_carried_up"; //"AinjPfalMstpSnonWnonDnon_carried_up";"AinjPfalMstpSnonWnonDnon_carried_still";"AinjPfalMstpSnonWrflDnon_carried_still"
sleep 0.5;
player switchMove "AcinPknlMstpSrasWrflDnon_AcinPercMrunSrasWrflDnon";
sleep 15; //15.95
if (alive player && !(player getVariable "NORRN_AIunconscious")) then {
    norrnRpvEH = [NORRN_rSwitchAnim,[[_dragee,"AinjPfalMstpSnonWnonDf_carried_dead"]]];
    publicVariable "norrnRpvEH";
    _dragee switchMove "AinjPfalMstpSnonWnonDf_carried_dead";
    _dragee attachto [player,[-0.2, 0.25, 0]];
};
while {r_carry_sqf} do {
    player forceWalk true;
    _anim_name = animationstate player; 
    if (!(_dragee getVariable "NORRN_AIunconscious")) exitWith { 
        detach _dragee;
        player switchMove "";
        player removeAction Norrn_dropAction;
        r_carry_sqf = false;
    };     
    //check that dragged unit still exists
    if (!alive player || !(_anim_name in NORRN_rCarryAnims)) exitWith {    
        player removeAction NORRN_dropAction;
        detach _dragee;
        player switchMove "";
        r_carry_sqf = false;
    };         
    sleep 0.1;
};
detach _dragee;
player forceWalk false;
if (alive _dragee && (_dragee getVariable "NORRN_AIunconscious")) then {    
    norrnRpvEH = [NORRN_rSwitchAnim,[[_dragee,"AinjPpneMstpSnonWnonDnon"]]];
    publicVariable "norrnRpvEH";
    _dragee switchMove "AinjPpneMstpSnonWnonDnon";
};

