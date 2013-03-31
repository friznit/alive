from mikero@norfolk.nf

DePbo.dll is the 'driver' behind most of Mikero's tools. It is intended to be a non-reinventing-the-wheel service so that any application can
access one, well proven, decompression alogorithm (eg), rather than re-writing or pasting the source code again and again into different exe's.

While the name suggests a pbo only driver, in fact, depbo has expanded over the years to much greater functionality. Rapification, to name one.

If you require source, or an SDK, or Visual basic wrappers to this dll. they are available at

www.ofpec.com
http://andrew.nf/ofp/tools
http://linux-sxs.org  (linux .so version intended for server apps)
http://dev-heaven.net/projects/list_files/mikero-pbodll

or contact me at above email (if you're brave enough to face my anti-spammer)


A single Depbo.dll should be placed in your windows\system32 folder for each and any tool.exe to gain access to one, common driver.

alternatively, simply place the dll in the same folder as the exe


**********************************************************************************************************************************************
the depbo.lib is NOT required for tool use. Dont even bother extracting it unless you intended programming via visual basic and using the api
**********************************************************************************************************************************************

enjoy



ALL exes exhibit similar behaviour in command line usage.

nameof.exe [-options] sourcefile/Folder[.ext]/orList[.lst] [[outfile/Folder[.ext]]

Destination specs

where (an often optinonal) destination can be specified, the name can be either a file or a path or both

In general, the resulting filename follows the exe's specification extension such as p3d, cpp. rvmat. Obviously, dependent on context.


