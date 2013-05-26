#include <\x\alive\addons\nme_strategic\script_component.hpp>

#define TESTS ["SEP"]

SCRIPT(test-strategic);

// ----------------------------------------------------------------------------

LOG("=== Testing NME Strategic ===");

{
	call compile preprocessFileLineNumbers format ["\x\alive\addons\nme_strategic\tests\test_%1.sqf", _x];
} forEach TESTS;

nil;
