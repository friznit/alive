sleep .01; 

createDialog "vdist_dialog";
sleep 0.1;

#define SLIDER_VIEWDISTANCE ((vdist_dialog select 0) displayCtrl 1912)
#define TEXT_VIEWDISTANCE ((vdist_dialog select 0) displayCtrl 1012)


TEXT_VIEWDISTANCE ctrlSetText "Viewdistance: " + str(round viewDistance);


#define ESTABLISH_SLIDER(DIALOG_GVAR,CTRL_NUM,RANGEMAX,INCREMENTER)	\
CTRL_NUM sliderSetRange [0,RANGEMAX]; \
CTRL_NUM sliderSetPosition INCREMENTER;\

ESTABLISH_SLIDER(vdist_dialog,SLIDER_VIEWDISTANCE,15000,(viewDistance));

SLIDER_VIEWDISTANCE ctrlSetEventHandler ["SliderPosChanged","_this call fn_vdist_Slider_ChangeViewDistance"];

fn_vdist_Slider_ChangeViewDistance =
{
	_val = _this select 1;
	setViewDistance _val;
	TEXT_VIEWDISTANCE ctrlSetText "Viewdistance: " + str(round _val);
};
