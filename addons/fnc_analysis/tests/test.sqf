#include <\x\alive\addons\fnc_analysis\script_component.hpp>

#define TESTS ["sector","sectorGrid","analysisData","unitAnalysis","terrainAnalysis","elevationAnalysis"];

SCRIPT(test-analysis);

// ----------------------------------------------------------------------------

LOG("=== Testing Analysis ===");

{
	call compile preprocessFileLineNumbers format ["\x\alive\addons\fnc_analysis\tests\test_%1.sqf", _x];
} forEach TESTS;

nil;
