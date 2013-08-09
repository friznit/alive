#include <\x\alive\addons\sys_view\script_component.hpp>

#define TESTS ["view"];

SCRIPT(test-view);

// ----------------------------------------------------------------------------

LOG("=== Testing View ===");

{
	call compile preprocessFileLineNumbers format ["\x\alive\addons\sys_view\tests\test_%1.sqf", _x];
} forEach TESTS;

nil;
