#include <\x\alive\addons\mil_strategic\script_component.hpp>

#define TESTS ["SEP","findHQ"]

SCRIPT(test-strategic);

// ----------------------------------------------------------------------------

LOG("=== Testing NME Strategic ===");

{
	call compile preprocessFileLineNumbers format ["\x\alive\addons\mil_strategic\tests\test_%1.sqf", _x];
} forEach TESTS;

nil;
