local roundStateMachine = newClass("Jailbreak.RoundStateMachine", "StateMachine");

function roundStateMachine:ctor(gamemode)
	assertArgument(2, "Gamemode");
	getDefinition("StateMachine").ctor(self);
	self._gamemode = gamemode;
	self:addJailbreakState("FreeRoam");
	self:addJailbreakState("Prepare");
	self:addJailbreakState("Play");
	self:addJailbreakState("LastRequest");
	self:addJailbreakState("LastKill");
	self:setActiveState(self:getState("FreeRoam"));
end

function roundStateMachine:getGamemode()
	return self._gamemode;
end

function roundStateMachine:addJailbreakState(name)
	assertArgument(2, "string");
	local className = "Jailbreak." .. name .. "State";
	self:addState(classes.newInstance(className, self));
end

function roundStateMachine:setActiveState(state)
	getDefinition("StateMachine").setActiveState(self, state);
	if SERVER then
		self:broadcastCurrentState();
	end
end