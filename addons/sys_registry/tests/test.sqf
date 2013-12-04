#include <\x\alive\addons\mil_command\script_component.hpp>

#define TESTS ["registry"];

SCRIPT(test-registry);

// ----------------------------------------------------------------------------

LOG("=== Testing Registry ===");

{
	call compile preprocessFileLineNumbers format ["\x\alive\addons\sys_registry\tests\test_%1.sqf", _x];
} forEach TESTS;

nil;
