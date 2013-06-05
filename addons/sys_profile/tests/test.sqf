#include <\x\alive\addons\sys_profile\script_component.hpp>

#define TESTS ["profile","agentProfile","groupProfile","profileHandler","functionality"];

SCRIPT(test-profile);

// ----------------------------------------------------------------------------

LOG("=== Testing Profile ===");

{
	call compile preprocessFileLineNumbers format ["\x\alive\addons\sys_profile\tests\test_%1.sqf", _x];
} forEach TESTS;

nil;
