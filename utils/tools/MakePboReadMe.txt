MakePbo version 1.xx by mikero.
see readmegeneral.txt
see fixes.txt
see caveat.txt

This pbo maker will create different types of pbo depending on options specified on the command line. It is sensitive
to the differences needed between ofp, ArmaType missions, and ArmaType campaigns. ArmaTypes include vbs, toh, Xbox Elite, and Arrowhead.

Syntax: MakePbo [-options] Full\Path\To\Foldername [destpath and/or pboname[.pbo|ebo|xbo]]

Despite the wealth of options available, the most common and generally accurate syntax is

makepbo Full\Path\To\Foldername

Foldername.pbo will be produed in the parent folder of foldername
-----------------------------------------------------------

Below is the full bells and whistles of what you can really do

options are case INsensitive

-A   ArmA (default)
-C   CWC
-R   Resistance 
-E   Elite
-Ve  VS2 EBO(not implemented)
-Vm1 Vbslite pbo UK Mission
-vm2 Vbslite pbo US Mission
-Vx1 xbo file UK
-Vx2 xbo file US
-B Binarise (default) Lintcheck then potentially save result as binarised (mission.sqm eg). Some file types (desc.ext) are never saved as binarised.
-L Lintcheck: check any file that is rapifiable text (*.rvmat eg) but commit as unbinarised

	In both cases, 'any file' means
		*.rvmat
		*.bisurf
		*.fsm
		*.sqm
		*.bikb
		*.cpp
		*.ext

-T binarise  and include config.cpp as config.cpp.txt (eg) allow .hpp (eg) to pass unmolested
-N do Nothing special. Make a pbo wysiwig
-P PrefixName this will over-ride $PBOPREFIX$ and use a direct over-ride
-G Check external references
-GS Show rap decoding (debug useful in conjunction with -G)
-Gp Check externals but not proxies
-K  dont pause on error (bad status still reported and up to the controlling program to do something about it)
-Z default See compression list readme
-Z "Comma,Separated,List" Compression where possible
-Z IgnoreList[.lst|.txt|<.ext>] Compression where possible
-X none exclude nothing
-X "Comma,Separated,ExcludeList" see the ExcludeListReadme
-X ExcludeList[.lst|.txt|<.ext>] see the ExcludeListReadme
-J Ignore lack of mission.sqm or config.cpp
-D reDuction of description.ext
-U allow unbinarised p3d
-$ potentially allow unprefixed addons
-Q Lint only (pretend to make a pbo, but just scan for errors (use in conjunction with G/GS)

LINT ONLY Q option
this option DOES NOT MAKE A PBO. it scans unbinarised wrp and p3d for errors (in addition to general rvmat and config checking)

EXTERNAL REFERENCES

-G Check external references when rapifying

This is a safety check that the p3d and paa files (eg) as detected in a config.cpp (eg) are present on the p: drive

You can safely create a pbo without this option. It is 'there' as a confidence check that you haven't created typos

Note that the dll only checks when rapifying or lintchecking *any* file. The -G option warns of missing files, -GS shows which ones

==== SHA/CRC SIGNATURES =========
sha key signatures (Arma) or crc checks (elite) are automatically appended to end of file

====See ReadMe.Prefix.txt======



****** REDUCTION ************

-D option will compile, then decompile *.fsm , *.bikb's and description ext in an effort to reduce #defines and extraneous data.
it will fail with an error message if desc.ext contains EXEC/EVALS


=========See ReadMe.Compression =========



===Optional destination===

can take several forms

*MakePbo [MyPath\]MyAddon       		->output to [MyPath\]MyAddon.pbo
MakePbo [MyPath\]MyAddon ThisAddon      	->output to CurrentDir\ThisAddon.pbo
*MakePbo [MyPath\]MyAddon ThisAddon\     	->output to CurrentDir\ThisAddon\MyAddon.pbo
MakePbo [MyPath\]MyAddon ThisAddon\ThisPbo      ->output to CurrentDir\ThisAddon\ThisPbo.pbo
MakePbo [MyPath\]MyAddon \ThisAddon      	->output to \ThisAddon.pbo
*MakePbo [MyPath\]MyAddon \ThisAddon\     	->output to \ThisAddon\MyAddon.pbo
MakePbo [MyPath\]MyAddon \ThisAddon\ThisPbo    	->output to \ThisAddon\ThisPbo.pbo

Note that, under ALL circumstances, if 'ThisAddon' happens to be the name of a folder, it is equivalent to stating 'ThisAddon\'

Note: extension type is not required and has consequence for users specifying an XBO target but, in fact, the dll discovers it's a vbs2 lite mission.
under that, special, unique circumstance, the intended.xbo is renamed to .pbo (a vbs 2 lite quirk)

*MyAddon is subject to pboname.h. see versioning readme
 ====see versioning readme======
--------------- PBO OUTPUT NAME -------------

the rules are as follows

'standard' behaviour is to place an NameOf.pbo in the parent folder of where\ever\NameOf Folder.

example:

makepbo any\where\fred -> any\where\fred.pbo

makepbo fred -> fred.pbo

==specifying output==

makepbo some\folder any\where ->any\where\folder.pbo

makepbo some\folder any\where\this.pb0 -> any\where\this.pbo


pboname.h

if a pboname.h is detected in the primary folder, it replaces the output name. 

NOTE THAT
1) destination folders remain the same
2) if a destination PBO is named, the pboname.h is ignored

NOTE THAT

drives: and or \root\path specifications are as equally valid as relative addressing


