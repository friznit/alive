/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_multispawnAddAction

Description:
Function used to Add all the necessary actions to HQs that are active on the server

Parameters:
Object - The MHQ Vehicle or Building to which you wish to add the relevant MHQ actions

Returns:
- nil

Attributes:
- nil

Examples:
- N/A

See Also:
- N/A

Author:
WobbleyHeadedBob

Peer Reviewed:
- nil

Notes:
I'd like to get rid of this function altogether, I'd much prefer if the ALIVE 
cascading menu could pick up any nearby MHQ Objects and display the appropriate 
options/actions. This would bring with it some simplification to the overall control 
structure of this module.
---------------------------------------------------------------------------- */
private ["_hqObject"];
_hqObject = _this select 0;

_hqObject addAction [("<t color=""#dddd00"">" + ("Deploy MHQ") + "</t>"),{[_this select 0] call ALIVE_fnc_multispawnDeploy},["multispawn"],-99,true,false,'',""];
_hqObject addAction [("<t color=""#dddd00"">" + ("Sign in at MHQ") + "</t>"),{[_this select 0] call ALIVE_fnc_multispawnPlayerSetSpawn},["multispawn"],-99,true,false,'',""];
_hqObject addAction [("<t color=""#dddd00"">" + ("Pack up MHQ") + "</t>"),{[_this select 0] call ALIVE_fnc_multispawnUndeploy},["multispawn"],-99,true,false,'',""];