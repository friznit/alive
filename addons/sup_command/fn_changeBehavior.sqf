_index = lbCurSel 7248;
_behavior =  toUpper (lbData [7248, _index]);

if (leader (group player) == player) then {
	(group player) setBehaviour _behavior;
} else {
	hint "You are not the group leader";
};