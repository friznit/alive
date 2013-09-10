#include <\x\alive\addons\mil_strategic\script_component.hpp>

#define TESTS ["MO"]

SCRIPT(test-strategic);

// ----------------------------------------------------------------------------

LOG("=== Testing Mil Strategic ===");

{
	call compile preprocessFileLineNumbers format ["\x\alive\addons\mil_strategic\tests\test_%1.sqf", _x];
} forEach TESTS;

nil;
