#include <\x\alive\addons\main\script_component.hpp>
SCRIPT(logger);

/* ----------------------------------------------------------------------------
Function: MSO_fnc_logger

Description:
Message logger for MSO.

Output timestamped messages to RPT.

Parameters:
String - Message to log

Examples:
(begin example)
"Initialisation Completed" call mso_fnc_logger;
(end)

See Also:
- <MSO_fnc_initialising>

Author:
Wolffy.au
---------------------------------------------------------------------------- */

private["_text","_message"];
PARAMS_1(_text);
_message = format["MSO-%1 %2", time, _text];
diag_log text _message;

