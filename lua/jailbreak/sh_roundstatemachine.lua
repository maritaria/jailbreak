local jailbreakStateMachine = newClass("Jailbreak.RoundStateMachine", "StateMachine");

function jailbreakStateMachine:ctor()
	getDefinition("StateMachine").ctor(self);
	self:addJailbreakState("FreeRoam");
	self:addJailbreakState("Prepare");
	self:addJailbreakState("Play");
	self:addJailbreakState("LastRequest");
	self:addJailbreakState("LastKill");
	self:setActiveState(self:getState("FreeRoam"));
end

function jailbreakStateMachine:addJailbreakState(name)
	assertArgument(2, "string");
	local className = "Jailbreak." .. name .. "State";
	self:addState(classes.newInstance(className, self));
end

function jailbreakStateMachine:setActiveState(state)
	getDefinition("StateMachine").setActiveState(self, state);
	if SERVER then
		self:broadcastCurrentState();
	end
end