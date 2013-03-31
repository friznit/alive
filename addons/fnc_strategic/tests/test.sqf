#include <\x\alive\addons\fnc_strategic\script_component.hpp>

#define TESTS ["houses","clusters"/*,"clusters2"*/]

SCRIPT(test-strategic);

// ----------------------------------------------------------------------------

LOG("=== Testing Strategic ===");

{
	call compile preprocessFileLineNumbers format ["\x\alive\addons\fnc_strategic\tests\test_%1.sqf", _x];
} forEach TESTS;

nil;
