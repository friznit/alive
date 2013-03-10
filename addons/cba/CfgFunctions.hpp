class CfgFunctions
{
	class CBA
	{
		class Strings
		{
			// CBA_fnc_replace
			class replace
			{
				description = "Replaces substrings within a string. Case-dependent.";
				file = "\x\alive\addons\cba\fnc_replace.sqf";
			};
			// CBA_fnc_split
			class split
			{
				description = "Splits a string into substrings using a separator. Inverse of <CBA_fnc_join>.";
				file = "\x\alive\addons\cba\fnc_split.sqf";
			};
		};
		class Diagnostic
		{
			// CBA_fnc_error
			class error
			{
				description = "Logs an error message to the RPT log.";
				file = "\x\alive\addons\cba\fnc_error.sqf";
			};
			// CBA_fnc_log
			class log
			{
				description = "Logs a message to the RPT log.";
				file = "\x\alive\addons\cba\fnc_log.sqf";
			};
		};
	};
};
