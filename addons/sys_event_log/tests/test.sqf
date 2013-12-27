#include <\x\alive\addons\event_log\script_component.hpp>

#define TESTS ["event_log"];

SCRIPT(test-event_log);

// ----------------------------------------------------------------------------

LOG("=== Testing Event Log ===");

{
	call compile preprocessFileLineNumbers format ["\x\alive\addons\sys_event_log\tests\test_%1.sqf", _x];
} forEach TESTS;

nil;
