
#-----------------------------------------------#
#	ALiVE: Make Development Build Script		#
#		   Version 1.0							#
#		   By Naught							#
#-----------------------------------------------#
#	Description:								#
#		Creates a "dummy" development			#
#		environment in the Arma 3 directory		#
#		for linking with the unpacked addons.	#
#-----------------------------------------------#

# Settings -------------------------------------#

$bi_game = "arma 3";
$make_pbo_exe = "mikero\MakePbo.exe";
$dev_mod_folder = "@ALiVE_dev";
$dev_repo_path = "\x\alive\addons";

# Functions ------------------------------------#

function GetGameDir {
	Param([string]$game);
	$game_dir = $null;
	$reg_keys = @(
		"HKLM:\SOFTWARE\Wow6432Node\Bohemia Interactive\",
		"HKLM:\SOFTWARE\Bohemia Interactive Studio\",
		"HKLM:\SOFTWARE\Bohemia Interactive\"
	);
	foreach ($key in $reg_keys) {
		$val = Get-ItemProperty -Path ($key + $game) -Name "main" -ErrorAction SilentlyContinue
		if ($val -ne $null) {
			$game_dir = $val.main;
			break;
        };
	};
	return $game_dir;
};

function EchoSpaced {
	Param([string]$text);
	echo " ";
	echo $text;
	echo " ";
};

function EndScript {
	echo " ";
	echo " ";
	Read-Host "Press ENTER to continue";
};

# Script ---------------------------------------#

EchoSpaced "Started Make Development Build Script.";

$game_dir = GetGameDir $bi_game;

if ($game_dir -ne $null) { # Check game path
	echo "Found $bi_game game path.";
	
	$mod_path = $game_dir + "\" + $dev_mod_folder;
	$dev_path = $game_dir + $dev_repo_path;
	
	if (Test-Path $dev_path) { # Check dev repo path
		echo "Found addon development path '$dev_repo_path'.";
		
		# Check dummy dev env
		if (Test-Path $mod_path) {
			# Delete old dummy dev env
			Remove-Item $mod_path -Force -Recurse;
			echo "Removed old $dev_mod_folder development environment.";
		};
		
		# Create new dummy dev env
		New-Item -ItemType directory -Path ($mod_path + "\addons") | Out-Null;
		echo "Created new $dev_mod_folder development environment.";
		
		EchoSpaced "Creating addon dummies...";
		
		# Iterate over available addons
		foreach ($addon in (Get-ChildItem $dev_path)) {
			$addon_path = $mod_path + "\addons\" + $addon.name + "_dummy";
			New-Item -ItemType directory -Path $addon_path | Out-Null;
			
			# Add config.cpp hook to dev path
			if (Test-Path ($addon.fullname + "\config.cpp")) {
				"#include <$dev_repo_path\$addon\config.cpp>" > ($addon_path + "\config.cpp");
			};
			
			# Compile addon to PBO
			& $make_pbo_exe -A -N -P -@="$dev_repo_path\$addon" "$addon_path";
			
			# Remove addon folder
			Remove-Item $addon_path -Force -Recurse;
		};
		
		EchoSpaced "Finished creating addon dummies.";
		
	} else {
		EchoSpaced "ERROR: No such development repo path '$dev_repo_path' in game directory.";
	};
} else {
	EchoSpaced "ERROR: Cannot find game directory in registry.";
};

EchoSpaced "Finished Make Development Build Script.";

EndScript;
