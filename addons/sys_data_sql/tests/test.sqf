#include <\x\alive\addons\sys_data_sql\script_component.hpp>

#define TESTS ["readData"];

SCRIPT(test-sql);

// ----------------------------------------------------------------------------

LOG("=== Testing Analysis ===");

{
	call compile preprocessFileLineNumbers format ["\x\alive\addons\sys_data_sql\tests\test_%1.sqf", _x];
} forEach TESTS;

nil;
