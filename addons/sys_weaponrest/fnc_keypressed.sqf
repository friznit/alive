#include "script_component.hpp"

#define __stand ["amovpercmstpsraswrfldnon", "aadjpercmstpsraswrfldup",  "aadjpercmstpsraswrflddown", "aidlpercmstpsraswrfldnon_aiming01", "aidlpercmstpsraswrfldnon_idlesteady01", "aidlpercmstpsraswrfldnon_idlesteady02", "aidlpercmstpsraswrfldnon_idlesteady03", "aidlpercmstpsraswrfldnon_idlesteady04", "aidlpercmstpsraswrfldnon_aiming02"]
#define __kneel ["amovpknlmstpsraswrfldnon", "aadjpknlmstpsraswrfldup", "aadjpknlmstpsraswrflddown", "aidlpknlmstpsraswrfldnon_player_idlesteady01", "aidlpknlmstpsraswrfldnon_player_idlesteady02", "aidlpknlmstpsraswrfldnon_player_idlesteady03", "aidlpknlmstpsraswrfldnon_player_idlesteady04"]
#define __prone ["amovppnemstpsraswrfldnon", "aadjppnemstpsraswrfldup","aadjppnemstpsraswrflddown"]

private ["_r"];
TRACE_1("",_this);
_r = false;
if (scriptDone GVAR(key_pid)) then {
	TRACE_1("ANIMATION",animationstate player);
	if ( (animationstate player) in (__stand + __prone + __kneel) ) then {
		GVAR(key_pid) = [animationstate player] spawn FUNC(check);
		_r = true; // Cannot properly implement because of required spawn, sleeps etc. etc.
	};
};

_r;
