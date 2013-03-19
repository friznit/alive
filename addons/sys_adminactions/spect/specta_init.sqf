// ====================================================================================

// RESTRICT VIEWABLE UNITS
// We use the array KEGsShownSides to restrict which sides will be visible to 
// spectating players:
	
// KEGsShownSides = [west, east, resistance, civilian];

// if (side player == west) then {KEGsShownSides = [west];};
// if (side player == east) then {KEGsShownSides = [east];};
// if (side player == resistance) then {KEGsShownSides = [resistance];};
// if (side player == civilian) then {KEGsShownSides = [civilian];};

// Modified for MSO A3 adminActions by [KH]Jman

// ====================================================================================

for "_i" from 0 to 20 do {
	scopeName "SpectaLoop";
	[cameraOn,cameraOn,cameraOn] execVM "\x\alive\addons\sys_adminactions\spect\specta.sqf";breakOut "SpectaLoop";
	sleep 0.5;
};
