#include <\x\alive\addons\civ_strategic\script_component.hpp>

#define TESTS ["CO"]

SCRIPT(test-strategic);

// ----------------------------------------------------------------------------

LOG("=== Testing Civ Strategic ===");

{
	call compile preprocessFileLineNumbers format ["\x\alive\addons\civ_strategic\tests\test_%1.sqf", _x];
} forEach TESTS;

nil;
