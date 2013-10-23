disableSerialization;

if (isnil {uinamespace getvariable "ALIVE_radioHint"}) then { uinamespace setvariable ["ALIVE_radioHint", displaynull] };
if (isnull (uinamespace getvariable "ALIVE_radioHint")) then { 2988 cutrsc ["ALIVE_radioHintInterface", "plain", 2] };

private ["_display", "_textRsc", "_text"];
_display = uinamespace getvariable "ALIVE_radioHint";
_textRsc = _display displayctrl 655001;
_text = _this;

_textRsc ctrlSetStructuredText parseText format ["<t color='#FFFFFF' size='1' font='Zeppelin33Italic'>%1</t>", _text];

sleep 15;
2988 cutrsc ["Default", "Plain", 2];
