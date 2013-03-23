// COMPONENT should be defined in the script_component.hpp and included BEFORE this hpp
#define PREFIX ALiVE
// TODO: Consider Mod-wide or Component-narrow versions (or both, depending on wishes!)
#define MAJOR 0
#define MINOR 1
#define PATCHLVL 0
#define BUILD 1

#define VERSION MAJOR.MINOR.PATCHLVL.BUILD
#define VERSION_AR MAJOR,MINOR,PATCHLVL,BUILD


// MINIMAL required version for the Mod. Components can specify others..
#define REQUIRED_VERSION 1.0

/*
// Defined DEBUG_MODE_NORMAL in a few CBA_fncs to prevent looped logging :)
#ifndef DEBUG_MODE_NORMAL
	#define DEBUG_MODE_FULL
#endif
*/

// Set a default debug mode for the component here (See documentation on how to default to each of the modes).
//	#define DEBUG_ENABLED_MAIN
	#define DEBUG_ENABLED_SYS_ADMINACTIONS
/*
	#define DEBUG_ENABLED_SYS_DEBUG
	#define DEBUG_ENABLED_COMMON
	#define DEBUG_ENABLED_DIAGNOSTIC
	#define DEBUG_ENABLED_EVENTS
	#define DEBUG_ENABLED_HASHES
	#define DEBUG_ENABLED_NETWORK
	#define DEBUG_ENABLED_STRINGS
	#define DEBUG_ENABLED_VERSIONING
*/

#define MOD(var1) GVARMAIN(var1)
#define QMOD(var1) QUOTE(GVARMAIN(var1))

#include <\x\cba\addons\main\script_macros.hpp>