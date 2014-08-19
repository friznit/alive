#include <\x\alive\addons\mil_C2ISTAR\script_component.hpp>
SCRIPT(taskHandlerEventToClient);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_taskHandlerEventToClient
Description:

Transfers event from server task handler to client task handler

Parameters:
Array - event hash

Returns:

See Also:

Author:
ARJay

Peer Reviewed:
nil
---------------------------------------------------------------------------- */

[ALIVE_taskHandlerClient,"handleEvent",_this] call ALIVE_fnc_taskHandlerClient;
