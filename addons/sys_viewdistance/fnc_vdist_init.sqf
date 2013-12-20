
#define SLIDER_VIEWDISTANCE ((vdist_dialog select 0) displayCtrl 1912)
#define TEXT_VIEWDISTANCE ((vdist_dialog select 0) displayCtrl 10091)
#define SLIDER_TERRAINGRID ((vdist_dialog select 0) displayCtrl 1913)
#define TEXT_TERRAINGRID ((vdist_dialog select 0) displayCtrl 10093)

#define ESTABLISH_VDIST_SLIDER(DIALOG_GVAR,CTRL_NUMVD,RANGEMAX,INCREMENTER)	\
CTRL_NUMVD sliderSetRange [_minsetvd,_maxsetvd]; \
CTRL_NUMVD sliderSetPosition INCREMENTER;\
MAXVD = _maxsetvd;


_mingettg = Alive_vdist getvariable["minTG", 2]; // get the minimum terrain grid set in themodule
_minsettg = parseNumber _mingettg; // convert the minimum variable to a number
if (_minsettg == 0) then {_minsettg = 1;}; //if the minimum terrain grid has not been set i.e blank, then set it to 1
_maxgettg = (ALIVE_vdist getVariable ["maxTG", 2]); // get the maximum terrain grid set in the module
_maxsettg = parseNumber _maxgettg; // convert the maximum variable to a number
if (_maxsettg == 0) then {_maxsettg = 5;};//if the maximum terrain grid has not been set i.e blank, then set it to  5

tgvalue = _maxsettg - _minsettg;



if(tgvalue > 0) then {
if(_minsettg == 1 && _maxsettg == 2) then {TGARRAY = [50, 25];terrainGrid = 1}; 
if(_minsettg == 1 && _maxsettg == 3) then {TGARRAY = [50, 25, 12.5];terrainGrid = 2};  
if(_minsettg == 1 && _maxsettg == 4) then {TGARRAY = [50, 25, 12.5, 6.25];terrainGrid = 3};      
if(_minsettg == 1 && _maxsettg == 5) then {TGARRAY = [50, 25, 12.5, 6.25, 3.125];terrainGrid = 3};  
if(_minsettg == 2 && _maxsettg == 3) then {TGARRAY = [25, 12.5];terrainGrid = 2};     
if(_minsettg == 2 && _maxsettg == 4) then {TGARRAY = [25, 12.5, 6.25];terrainGrid = 2}; 
if(_minsettg == 2 && _maxsettg == 5) then {TGARRAY = [25, 12.5, 6.25, 3.125];terrainGrid = 3}; 
if(_minsettg == 3 && _maxsettg == 4) then {TGARRAY = [12.5, 6.25];terrainGrid = 3}; 
if(_minsettg == 3 && _maxsettg == 5) then {TGARRAY = [12.5, 6.25, 3.125];terrainGrid = 3}; 
if(_minsettg == 4 && _maxsettg == 5) then {TGARRAY = [6.25, 3.125];terrainGrid = 4}; 
};  
                                                                                                                                     



#define ESTABLISH_TDTL_SLIDER(DIALOG_GVAR,CTRL_NUMTD,RANGEMAX,INCREMENTER)	\
CTRL_NUMTD sliderSetRange [_minsettg, _maxsettg]; \
sliderSetPosition [1913, terrainGrid];

fn_vdist_Slider_ChangeViewDistance =
{
        private ["_val"];
        _val = _this select 1;
        setviewdistance _val;
        TEXT_VIEWDISTANCE ctrlSetText "" + str(round viewdistance);
};

fn_vdist_Slider_ChangeTerrainGrid =
{
        private ["_terrainGrid"];
        _terrainGrid = round(_this select 1); 
        terrainGrid = _terrainGrid;
        if(tgvalue == 0) then {
        TEXT_TERRAINGRID  ctrlSetText "Disabled";
        } else { 
        TEXT_TERRAINGRID  ctrlSetText "" + str(round terrainGrid);
        if (terrainGrid == _terrainGrid) then {
                setterraingrid (TGARRAY select (terrainGrid - 1));
        };
};
};


private ["_minsetvd","_maxsetvd","_mingetvd","_maxgetvd"];


_mingetvd = Alive_vdist getvariable["minVD", 2]; // get the minimum view distance set in themodule
_minsetvd = parseNumber _mingetvd; // convert the minimum variable to a number
if (_minsetVD == 0) then {_minsetvd = 500;}; //if the minimum view distance has not been set i.e blank, then set it to 500
_maxgetvd = (ALIVE_vdist getVariable ["maxVD", 2]); // get the maximum view distance se in the module
_maxsetvd = parseNumber _maxgetvd; // convert the maximum variable to a number
if (_maxsetvd == 0) then {_maxsetvd = 15000;};//if the maximum view distance has not been set i.e blank, then set it to 10000


createDialog "vdist_dialog";

ESTABLISH_VDIST_SLIDER(vdist_dialog,SLIDER_VIEWDISTANCE,15000,(viewDistance));
TEXT_VIEWDISTANCE ctrlSetText "" + str(round viewDistance);
SLIDER_VIEWDISTANCE ctrlSetEventHandler ["SliderPosChanged","_this call fn_vdist_Slider_ChangeViewDistance"];

ESTABLISH_TDTL_SLIDER(vdist_dialog,SLIDER_TERRAINGRID,50,(terrainGrid));
if(tgvalue == 0) then {
        TEXT_TERRAINGRID  ctrlSetText "Disabled";
        } else {
TEXT_TERRAINGRID  ctrlSetText "" + str(round terrainGrid);
SLIDER_TERRAINGRID ctrlSetEventHandler ["SliderPosChanged","_this call fn_vdist_Slider_ChangeTerrainGrid"];
};

