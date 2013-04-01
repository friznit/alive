#include "script_component.hpp"

LOG(MSG_INIT);

ADDON = false;

// Register Client with DB

if (isMultiplayer) then {

	_name = name player;
	_class = getText (configFile >> "cfgVehicles" >> (typeof player) >> "displayName");
	_puid = getplayeruid player;
	
	_PlayerSide = side (group player); // group side is more reliable
	_PlayerFaction = faction player;

	_data = format["""Event"":""PlayerStart"" , ""PlayerSide"":""%1"" , ""PlayerFaction"":""%2"" , ""PlayerName"":""%3"" ,""PlayerType"":""%4"" , ""PlayerClass"":""%5"" , ""Player"":""%6""", _PlayerSide, _PlayerFaction, _name, typeof player, _class, _puid];

	GVAR(UPDATE_EVENTS) = _data;
	publicVariableServer QGVAR(UPDATE_EVENTS);
	
	// Set player startTime
	player setVariable [QGVAR(timeStarted), date, true];
	
	// Set player shotsFired
	player setVariable [QGVAR(shotsFired), [[primaryweapon player, 0, primaryweapon player, getText (configFile >> "cfgWeapons" >> primaryweapon player >> "displayName")]]];
	
	// Player eventhandlers
	
	// Set up player fired
	player addEventHandler ["Fired", {_this call GVAR(fnc_playerfiredEH);}];
		
	// Set up handleDamage
//	player addEventHandler ["handleDamage", {_this call GVAR(fnc_handleDamageEH);}];
	
	// Set up hit handler
	player addEventHandler ["hit", {_this call GVAR(fnc_hitEH);}];
	
	// Set up handleHeal
	player addEventHandler ["handleHeal", {_this call GVAR(fnc_handleHealEH);}];

};


ADDON = true;
