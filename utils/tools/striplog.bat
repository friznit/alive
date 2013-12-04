@echo off
rem
rem striplog removes erroneous error messages from the .log
rem

set fred=%~dp1

findstr  /vc:"NoTiWrite" "%1" >"%fred%pipe.txt"
findstr  /vc:"very small normal" "%fred%pipe.txt" >"%1%"
findstr  /vc:"str_disp_server_control" "%1" >"%fred%pipe.txt"
findstr  /vc:"Warnings" "%fred%pipe.txt" >"%1%"
findstr  /vc:"ReportStack" "%1" >"%fred%pipe.txt"
findstr  /vc:"Error while trying" "%fred%pipe.txt" >"%1%"
findstr  /vc:"Warning: UV coordinate on point" "%1" >%fred%pipe.txt" 
findstr  /vc:"Updating base class" "%fred%pipe.txt" >"%1%"
findstr  /vc:"String STR_" "%1" >%fred%pipe.txt" 
rem findstr  /vc:"special LOD contains 2nd UV set" "%fred%pipe.txt" >"%1%"
copy %fred%pipe.txt "%1"
type "%1%
