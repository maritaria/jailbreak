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
	self:addJailbreakState("Freeday");
end

function roundStateMachine:addJailbreakState(name)
	assertArgument(2, "string");
	local className = "Jailbreak." .. name .. "State";
	self:addState(classes.newInstance(className, self));
end

function roundStateMachine:getActiveStateSetting()
	return self._activeStateSetting;
end

function roundStateMachine:getGamemode()
	return self._gamemode;
end

function roundStateMachine:initSettings(manager)
	self._activeStateSetting = newInstance("ReadonlySetting", manager, "RoundStateMachine.ActiveState", "FreeRoam");
	if CLIENT then
		self._activeStateSetting:getValueUpdatedEvent():subscribe("RoundStateMachine", wrap(self.onActiveValueUpdated, self));
	end
	if (self:isStarted()) then
		if SERVER then
			self:broadcastState();
		else
			self:requestState();
		end
	end
end