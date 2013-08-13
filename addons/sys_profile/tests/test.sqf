#include <\x\alive\addons\sys_profile\script_component.hpp>

#define TESTS ["profile","profileEntity","profileVehicle","profileHandler","getNearProfiles","functionality1","functionality2","functionality3","functionality4","functionality5","functionality6"];

SCRIPT(test-profile);

// ----------------------------------------------------------------------------

LOG("=== Testing Profile ===");

{
	call compile preprocessFileLineNumbers format ["\x\alive\addons\sys_profile\tests\test_%1.sqf", _x];
} forEach TESTS;

nil;
