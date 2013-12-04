


#define SLIDER_VIEWDISTANCE ((vdist_dialog select 0) displayCtrl 1912)
#define TEXT_VIEWDISTANCE ((vdist_dialog select 0) displayCtrl 10091)
#define SLIDER_TERRAINDETAIL ((vdist_dialog select 0) displayCtrl 1913)
#define TEXT_TERRAINDETAIL ((vdist_dialog select 0) displayCtrl 10093)
//if (isnil terraindetail) then {terraindetail = 3};
TEXT_VIEWDISTANCE ctrlSetText "" + str(round viewDistance);
TEXT_TERRAINDETAIL ctrlSetText "" + str(round terraindetail);

_mingetvd = Alive_vdist getvariable["minVD", 2]; // get the minimum view distance set in themodule
_minsetvd= parseNumber _mingetvd; // convert the minimum variable to a number
if (_minsetVD == 0) then {_minsetvd = 500;}; //if the minimum view distance has not been set i.e blank, then set it to 500
_maxgetvd = (ALIVE_vdist getVariable ["maxVD", 2]); // get the maximum view distance se in the module
_maxsetvd = parseNumber _maxgetvd; // convert the maximum variable to a number
if (_maxsetvd == 0) then {_maxsetvd= 15000;};//if the maximum view distance has not been set i.e blank, then set it to 10000


createDialog "vdist_dialog";


#define ESTABLISH_VDIST_SLIDER(DIALOG_GVAR,CTRL_NUMVD,RANGEMAX,INCREMENTER)	\
CTRL_NUMVD sliderSetRange [_minsetvd,_maxsetvd]; \
CTRL_NUMVD sliderSetPosition INCREMENTER;\
MAXVD = _maxsetvd;
ESTABLISH_VDIST_SLIDER(vdist_dialog,SLIDER_VIEWDISTANCE,15000,(viewDistance));


SLIDER_VIEWDISTANCE ctrlSetEventHandler ["SliderPosChanged","_this call fn_vdist_Slider_ChangeViewDistance"];

fn_vdist_Slider_ChangeViewDistance =
{
_val = _this select 1;
setviewdistance _val;
TEXT_VIEWDISTANCE ctrlSetText "" + str(round viewdistance);
};

#define ESTABLISH_TDTL_SLIDER(DIALOG_GVAR,CTRL_NUMTD,RANGEMAX,INCREMENTER)	\
CTRL_NUMTD sliderSetRange [1, 5]; \
sliderSetPosition [1913, terraindetail];\

ESTABLISH_TDTL_SLIDER(vdist_dialog,SLIDER_TERRAINDETAIL,15000,(terrainDetail));


SLIDER_TERRAINDETAIL ctrlSetEventHandler ["SliderPosChanged","_this call fn_vdist_Slider_ChangeTerrainDetail"];

fn_vdist_Slider_ChangeTerrainDetail =
	{
 _terraindetail = round(_this select 1); 
 terraindetail = _terraindetail; 
TEXT_TERRAINDETAIL  ctrlSetText "" + str(round terraindetail);
if (terraindetail == _terraindetail) then {
	setterraingrid ([50, 25, 12.5, 6.25, 3.125] select (terraindetail - 1));
	};

					};