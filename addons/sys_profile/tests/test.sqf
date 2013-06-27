#include <\x\alive\addons\sys_profile\script_component.hpp>

#define TESTS ["profile","profileEntity","profileVehicle","profileHandler","functionality1","functionality2","functionality3"];

SCRIPT(test-profile);

// ----------------------------------------------------------------------------

LOG("=== Testing Profile ===");

{
	call compile preprocessFileLineNumbers format ["\x\alive\addons\sys_profile\tests\test_%1.sqf", _x];
} forEach TESTS;

nil;
