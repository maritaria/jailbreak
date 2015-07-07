local jailbreak = newClass("Jailbreak.Gamemode", "Gamemode");

function jailbreak:ctor()
	getDefinition("Gamemode").ctor(self);
	self._stateMachine = newInstance("Jailbreak.RoundStateMachine", self);
	self._settingsManager = newInstance("SettingsManager");
	self._balancer = newInstance("Jailbreak.TeamBalancer", self);
	self:initTeams();
end

function jailbreak:getSettingsManager()
	return self._settingsManager;
end

function jailbreak:getStateMachine()
	return self._stateMachine;
end

function jailbreak:getTeamBalancer()
	return self._balancer;
end

function jailbreak:start()
	print("jailbreak:start()");
	self:initSettings();
	self:gotoFreeRoam();
end

function jailbreak:gotoFreeRoam()
	local statemachine = self:getStateMachine();
	local freeroam = statemachine:getState("FreeRoam");
	statemachine:setActiveState(freeroam);
end

function jailbreak:think()
	self:getStateMachine():tick();
end

function jailbreak:stop()
	print("jailbreak:stop()");
end