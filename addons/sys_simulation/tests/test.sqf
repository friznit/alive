#include <\x\alive\addons\sys_profile\script_component.hpp>

#define TESTS ["simulation"];

SCRIPT(test-simulation);

// ----------------------------------------------------------------------------

LOG("=== Testing Simulation ===");

{
	call compile preprocessFileLineNumbers format ["\x\alive\addons\sys_simulation\tests\test_%1.sqf", _x];
} forEach TESTS;

nil;
