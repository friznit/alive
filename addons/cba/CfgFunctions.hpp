class CfgFunctions
{
	class CBA
	{
		class Arrays
		{
			// CBA_fnc_join
			class join
			{
				description = "Joins an array of values into a single string, joining each fragment around a separator string. Inverse of <CBA_fnc_split>.";
				file = "\x\alive\addons\cba\arrays\fnc_join.sqf";
			};
		};
		class Diagnostic
		{
			// CBA_fnc_error
			class error
			{
				description = "Logs an error message to the RPT log.";
				file = "\x\alive\addons\cba\Diagnostic\fnc_error.sqf";
			};
			// CBA_fnc_log
			class log
			{
				description = "Logs a message to the RPT log.";
				file = "\x\alive\addons\cba\Diagnostic\fnc_log.sqf";
			};
		};
		class Misc
		{
			// CBA_fnc_defaultParam
			class defaultParam
			{
				description = "Gets a value from parameters list (usually _this) with a default.";
				file = "\x\alive\addons\cba\common\fnc_defaultParam.sqf";
			};
		};
		class Strings
		{
			// CBA_fnc_formatElapsedTime
			class formatElapsedTime
			{
				description = "Formats time in seconds according to a format. Intended to show time elapsed, rather than time-of-day.";
				file = "\x\alive\addons\cba\strings\fnc_formatElapsedTime.sqf";
			};
			// CBA_fnc_formatNumber
			class formatNumber
			{
				description = "Formats a number to a minimum integer width and to a specific number of decimal places (including padding with 0s and correct rounding). Numbers are always displayed fully, never being condensed using an exponent (e.g. the number 1.234e9 would be given as ""1234000000"").";
				file = "\x\alive\addons\cba\strings\fnc_formatNumber.sqf";
			};
			// CBA_fnc_replace
			class replace
			{
				description = "Replaces substrings within a string. Case-dependent.";
				file = "\x\alive\addons\cba\Strings\fnc_replace.sqf";
			};
			// CBA_fnc_split
			class split
			{
				description = "Splits a string into substrings using a separator. Inverse of <CBA_fnc_join>.";
				file = "\x\alive\addons\cba\Strings\fnc_split.sqf";
			};
		};
	};
};
