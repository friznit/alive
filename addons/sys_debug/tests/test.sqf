#include <\x\alive\addons\sys_profile\script_component.hpp>

#define TESTS ["debug"];

SCRIPT(test-debug);

// ----------------------------------------------------------------------------

LOG("=== Testing Debug ===");

{
	call compile preprocessFileLineNumbers format ["\x\alive\addons\sys_debug\tests\test_%1.sqf", _x];
} forEach TESTS;

nil;
