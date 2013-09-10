#include <\x\alive\addons\mil_strategic\script_component.hpp>

#define TESTS ["MP","findHQ"]

SCRIPT(test-placement);

// ----------------------------------------------------------------------------

LOG("=== Testing Mil Placement ===");

{
	call compile preprocessFileLineNumbers format ["\x\alive\addons\mil_placement\tests\test_%1.sqf", _x];
} forEach TESTS;

nil;
