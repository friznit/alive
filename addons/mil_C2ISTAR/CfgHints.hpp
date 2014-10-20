class CfgHints
{
	class PREFIX
	{
		// Topic title (displayed only in topic listbox in Field Manual)
		displayName = "ALiVE Mod";
		class ADDON
		{
			// Hint title, filled by arguments from 'arguments' param
			displayName = "C2ISTAR";
            // Optional hint subtitle, filled by arguments from 'arguments' param
			displayNameShort = "Missions and Tasks";
			// Structured text, filled by arguments from 'arguments' param
			description = "Allows players to request tasks from a friendly Military AI Commander (OPCOM) or define their own tasks manually.  Tasks are saved to the database and restored at the beginning of each new mission.%1%2Open the %3ALiVE Action Menu%4 and select %3C2ISTAR%4 from the list%2Select Player Tasks to view the task management console%2Select the desired type of task and options and submit the request to HQ%1%1Autogenerated missions chosen by OPCOM may include a number of subtasks that should be completed in order.";
            // Optional structured text, filled by arguments from 'arguments' param (first argument is %11, see notes bellow), grey color of text
            tip = "Manual tasks placed by the player will need to be manually updated when they are completed.";
			arguments[] = {
				{{"getOver"}},  // Double nested array means assigned key (will be specially formatted)
                {"name"},       // Nested array means element (specially formatted part of text)
				"name player"   // Simple string will be simply compiled and called
                                // String is used as a link to localization database in case it starts by str_
			};
			// Optional image
			image = "x\alive\addons\ui\logo_alive_square.paa";
			// optional parameter for not showing of image in context hint in mission (default false))
			noImage = false;
		};
	};
};

/*

    First item from arguments field in config is inserted in text via variable %11, second item via %12, etc.
    Variables %1 - %10 are hardcoded:
         %1 - small empty line
         %2 - bullet (for item in list)
         %3 - highlight start
         %4 - highlight end
         %5 - warning color formated for using in structured text tag
         %6 - BLUFOR color attribute
         %7 - OPFOR color attribute
         %8 - Independent color attribute
         %9 - Civilian color attribute
         %10 - Unknown side color attribute
    color formated for using in structured text is string: "color = 'given_color'"
*/

