@echo off
rem
rem striplog removes erroneous error messages from the .log
rem as of arrowhead, binarise no longer respects the cfgpatches class and you get (erroneous) missing strings and updated base classes
rem

set fred=%~dp1

findstr  /vc:"NoTiWrite" "%1" >"%fred%pipe.txt"
findstr  /vc:"very small normal" "%fred%pipe.txt" >"%1%"

findstr  /vc:"str_disp_server_control" "%1" >"%fred%pipe.txt"
findstr  /vc:"Warnings" "%fred%pipe.txt" >"%1%"

findstr  /vc:"ReportStack" "%1" >"%fred%pipe.txt"
findstr  /vc:"Error while trying" "%fred%pipe.txt" >"%1%"

findstr  /vc:"Warning: UV coordinate on point" "%1" >%fred%pipe.txt" 
rem *************
rem the following two log warnings broke as of arrowhead
rem binarise no longer respects the cfgpatches load order
rem ****************
rem remove the "updating base classes"
findstr  /vc:"Updating base class" "%fred%pipe.txt" >"%1%"
rem remove the "Cannot register string STR_LIEUTENANT - global stringtable not found"
findstr  /vc:"tring STR_" "%1" >%fred%pipe.txt" 
rem findstr  /vc:"special LOD contains 2nd UV set" "%fred%pipe.txt" >"%1%"
copy %fred%pipe.txt "%1"
del %fred%pipe.txt
rem type "%1%

