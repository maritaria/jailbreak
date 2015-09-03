local jailbreak = newClass("Jailbreak.Gamemode", "Gamemode");

function jailbreak:ctor()
	getDefinition("Gamemode").ctor(self);
	self:setName("Jailbreak");
	self._settingsManager = newInstance("SettingsManager");
	self:subscribe("Think", self, "onThink");
end

function jailbreak:getSettingsManager()
	return self._settingsManager;
end

function jailbreak:start()
	print("jailbreak:start()");
	self:initStateMachine();
	self:initDeathLog();
	self:initTeamBalancer();
	self:initTeams();
	self:initSettings();
	self:gotoFreeRoam();
end

function jailbreak:gotoFreeRoam()
	local statemachine = self:getStateMachine();
	local freeroam = statemachine:getState("FreeRoam");
	statemachine:setActiveState(freeroam);
end

function jailbreak:onThink()
	self:getStateMachine():tick();
end

function jailbreak:stop()
	print("jailbreak:stop()");
	self:unsubscribeAll(self);
end