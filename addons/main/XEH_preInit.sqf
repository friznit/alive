#include <script_component.hpp>

LOG(MSG_INIT);

//Default value to disable auto-saving due to out of mem crashes
enableSaving [false, false];

//Set ALiVE Interaction menu on custom userkey 20 and if none is defined fallback to 221 App key
if ((count ActionKeys "User20") > 0) then {
	SELF_INTERACTION_KEY = [(ActionKeys "User20" select 0),[false,false,false]];
} else {
	SELF_INTERACTION_KEY = [221,[false,false,false]];    
};