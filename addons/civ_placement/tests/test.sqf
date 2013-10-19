#include <\x\alive\addons\civ_placement\script_component.hpp>

#define TESTS ["CO"]

SCRIPT(test-strategic);

// ----------------------------------------------------------------------------

LOG("=== Testing Civ Strategic ===");

{
	call compile preprocessFileLineNumbers format ["\x\alive\addons\civ_placement\tests\test_%1.sqf", _x];
} forEach TESTS;

nil;
