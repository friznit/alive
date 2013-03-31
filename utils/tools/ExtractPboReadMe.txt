ExtractPbo Version 1.xx by Mikero
see genreadme.txt

min dll level is 3.90
----------------------
fixes
1.85
enabled ifa (pbo) extraction files
fixed no pause on error with ask

1.83
fixed small irritation when asking to allow an overwrite of an existing folder, a response key (y/n) had to be pressed twice
1.82
fixed 1.81
1.81
default is now tabbed output for derapped files
use -T for spaced output
1.80
accepts drive:\ and drive:/ as where clause (fix for six updater)
1.79
added syntax for folder or lst 
fixed folder test
lists all files scanned if noisy foldertest

1.78
now allows either folder or an extraction.lst in addition to pboname.pbo

1.77
prevented any attempt to extract to a relative destination

-p to not pause on error

This is a powerful dos console extractor that extracts ANY pbo from CWR thru to VBS2 LITE (xbo files)

ExtractPbo uses a heuristic approach to output the best possible results to the best-possible output folder. While you can over-ride the default options the general scenario is that the extactor will

Derapify binarised content (mission.sqm, config.bin. *rvmat ,etc)
Decompress a pbo (ofp only)
Decrypt Elite and VBS2 Lite pbo's
Autodetect the type of pbo / xbo / ebo
Verify valid compression for p3d and paa content (eg)


In the specific case of non-ofp pbo's , the prefix is accounted for by writing a $PBOPREFIX$ file to the output.

A $PBOPREFIX$ file if detected in the pbo itself, is NEVER extracted.


usage

extractpbo [-options...] NameOfPbo[.pbo|.xbo|.ebo]/aFolder/AnExtractionList [SomeFolder]

.extensions are not required. a 'pbo' is considred to be ANY *.xbo,*.ebo,*pbo

options (optional, case insensitive)

-L list only 
-LB brief dir style output
-P do not pause on error (allow the controlling program to handle the bad return status)
-S silent (default)
-N Noisy 
-D Derapify file(s) where relevant (default)
-R Dont Derapify file(s)
-Y Don't prompt if overwriting a folder
-A deprecated
-T used spaced (not tabbed) derap output
-W Warnings are errors
-V1 force extraction of vbs2 lite uk
-V2 ditto us
     normally, the dll will detect which type it is. In extreme circumstances the heuristic model might fail, and you can force it to one, or the other.
     Note missions (pbo) and addons (xbo) are equivalent.

-F filelist[,...] name(s) of file(s) to extract
   extracted file(s) will appear in their 'correct' position in the relevent output folder tree
   thus, multiple instances of config.cpp (eg) can be extracted.

   a minor form of wildcard the aster dot sequence can indicate 'all' extensions of that type

-K ignore prefix


====OUTPUT FOLDER====

Distinctions exist between folder output for OFP vs non OFP (ARMA) 

in OFP the NameOfPbo is sacrosanct. It must form part of the output to have any meaning to the engine.
in ARMA the prefix inside the pbo is sacrosanct. It will form part of the output.

The dll detects the difference.

Thus:

For OFP:

 extractppo thing.pbo          >> contents to thing\
 extractpbo thing.pbo anywhere >> contents to anywhere\thing\

For ARMA:

 extractppo thing.pbo          >> contents to thing\'prefix'\
 extractpbo thing.pbo drive:\anywhere >> contents to contents to anywhere\'prefix'\

the anywhere clause for arma allows creation of a p:\ca by specifying

 extractpbo thing P:\

Note that the -K option ignores the prefix and writes to output as per ofp
this can be a convenience when decoding very long paths

---------------------------------------------------------------------
Be WARNED

Normally, extractPBO does two important things

1) it checks before over-writing a folder
2) it erases all output folder content in an 'all bets are off' approach before extracting the pbo

using the anywhere option causes these 2 features to be disabled.

if you have crap in the output folder(s). the crap will remain in the output folder(s)
if you specify an 'interesting' destination. you will get, 'interesting' results. 

----------------------------------------------------------------------


/*
** extraction behaviour
**
** Fundamentally, a folder is created of the same name as the pbo in the same folder as the pbo.
**
** Arma pbo's will, in addition, create subfolders based on the detected prefix. Thus:
**
** ExtractPbo Thing
**
** OFP pbo 		thing.pbo -> thing\.....
** ARMA pbo     thing.pbo -> thing\Prefix\......
**
** Option -K is used to force OFP behaviour
**
** ExtractPbo -k Thing //Arma prefix subfolders are NOT created (but the $PREFIX% is still supplied correctly)
**
**				thing.pbo -> thing\..... (prefix is ignored)
**
**============================
** Specifying a destination
**============================
**
ExtractPbo thing  P:\
	thing.pbo ->P:\prefix\....	will create a perfect namespace based on the prefix.

	ExtractPbo thing  -k P:\
	thing.pbo ->P:\thing\prefix\....

ExtractPbo thing  P:\SomeWhere

	thing.pbo ->P:\Somewhere\prefix\...

ExtractPbo -K thing  P:\SomeWhere

	thing.pbo ->P:\Somewhere\thing\.........

	
	=============================
	Specifying a relative destiation address
	=============================

	you can't. drive: MUST be specified


====Other examples====

 
extractpbo thing

 will extract thing.pbo to thing\ folder and derapify any content (such as mission.sqm) that has been binarised

extractpbo -f -r mission.sqm thing.pbo

 will extract a single file (and NOT derapify)

extractpbo -L thing

 does a dir listing of pbo content along with added info

extractpbo -f *.p3d nameofpbo
 
 will extract ONLY p3d files

extractpbo ExtractionList.any [toSomewhere]
 
 will extract files contiained in extraction list. Nameof extraction list can be anything other than .pbo, or foldername
 line syntax for each line is identical to command line.
 global parameters FROM the command line operate as defaults if not respecified in the list

extractpbo Folder [toSomewhere]

will recurse subfolders of above searching for pbo files.


==warning messages====
"1st/last entry has non-zero real_size, reserved, or BlockLength field"
"reserved field non zero anywhere in entry bodies (except xbo)"
 Normally an attempt to prevent extraction and should present no issues. But, users should suspect something wonky in the author's implementation

"no shakey on arma";
 early pbo makers did not create the appended 21 byte sha. This causes issues only if attempting to sign the pbo for MP play

"residual bytes in file" // throws an error anyway
 something has been either misinterpreted, or the pbo maker is at fault

"arma pbo is missing a prefix (probably a mission)";
missions do not require prefix entries. But, as a matter of de-riguer, they normally have them.

