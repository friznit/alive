_index = lbCurSel 7246;
_formation = lbData [7246, _index];

if (leader (group player) == player) then {
	(group player) setFormation _formation;
} else {
	hint "You are not the group leader";
};