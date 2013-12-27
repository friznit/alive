#define COMPONENT sys_event_log
#include <\x\alive\addons\main\script_mod.hpp>

#ifdef DEBUG_ENABLED_SYS_EVENT_LOG
	#define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_SETTINGS_SYS_EVENT_LOG
	#define DEBUG_SETTINGS DEBUG_SETTINGS_SYS_EVENT_LOG
#endif

#include <\x\cba\addons\main\script_macros.hpp>
