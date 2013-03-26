sleep .01; 

createDialog "vdist_dialog";
sleep 0.1;

#define SLIDER_VIEWDISTANCE ((vdist_dialog select 0) displayCtrl 1912)
#define TEXT_VIEWDISTANCE ((vdist_dialog select 0) displayCtrl 1012)


TEXT_VIEWDISTANCE ctrlSetText "View Distance: " + str(round viewDistance);

_mingetvd = Alive_vdist getvariable["minVD", 2]; // get the minimum view distance set in themodule
_minsetvd= parseNumber _mingetvd; // convert the minimum variable to a number
if (_minsetVD == 0) then {_minsetvd = 500;}; //if the minimum view distance has not been set i.e blank, then set it to 500
_maxgetvd = (ALIVE_vdist getVariable ["maxVD", 2]); // get the maximum view distance se in the module
_maxsetvd = parseNumber _maxgetvd; // convert the maximum variable to a number
if (_maxsetvd == 0) then {_maxsetvd= 15000;};//if the maximum view distance has not been set i.e blank, then set it to 10000

#define ESTABLISH_SLIDER(DIALOG_GVAR,CTRL_NUM,RANGEMAX,INCREMENTER)	\
CTRL_NUM sliderSetRange [_minsetvd,_maxsetvd]; \
CTRL_NUM sliderSetPosition INCREMENTER;\

ESTABLISH_SLIDER(vdist_dialog,SLIDER_VIEWDISTANCE,15000,(viewDistance));


SLIDER_VIEWDISTANCE ctrlSetEventHandler ["SliderPosChanged","_this call fn_vdist_Slider_ChangeViewDistance"];

fn_vdist_Slider_ChangeViewDistance =
{
	_val = _this select 1;
	setViewDistance _val;
	TEXT_VIEWDISTANCE ctrlSetText "View Distance: " + str(round _val);
};