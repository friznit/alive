#include "\x\alive\addons\x_lib\script_component.hpp"

/*
	Function: ALiVE_fnc_sendActorMessage
	Author(s): Naught
	Description:
		Sends a message a given actor, which is then executed on the actor's machine.
	Parameters:
		0 - Actor [object]
		1 - Message [any]
	Returns:
		Nothing [nil]
*/

private ["_actor"];
_actor = _this select 0;

if (local _actor) then
{
	+(_this) spawn (_actor getVariable "ALiVE_actors_messageHandler");
}
else
{
	private ["_owner"];
	_owner = _actor getVariable ["ALiVE_actors_owner", -1];
	ALiVE_actors_newMessage = _this;
	
	if (_owner < 0) then
	{
		publicVariableServer "ALiVE_actors_newMessage";
	}
	else
	{
		_owner publicVariableClient "ALiVE_actors_newMessage";
	};
};
