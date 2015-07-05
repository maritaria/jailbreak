local jailbreak = newClass("Jailbreak.Gamemode", "Gamemode");

function jailbreak:ctor()
	getDefinition("Gamemode").ctor(self);
	self._stateMachine = newInstance("Jailbreak.RoundStateMachine", self);
	self._balancer = newInstance("Jailbreak.TeamBalancer", self);
	self:initTeams(self:getTeamManager());
	self._settingsManager = newInstance("SettingsManager");
	self:initSettings(self:getSettingsManager());
end

function jailbreak:getStateMachine()
	return self._stateMachine;
end

function jailbreak:getTeamBalancer()
	return self._balancer;
end

function jailbreak:initTeams(manager)
	local teams = manager:getTeams();
	local spectators = newInstance("Jailbreak.SpectatorsTeam", 51);
	teams:add(spectators);
	manager:setDefaultTeam(spectators);
	local prisoners = newInstance("Jailbreak.PrisonersTeam", 2);
	teams:add(prisoners);
	self:getTeamBalancer():setPrisonerTeam(prisoners);
	local guards = newInstance("Jailbreak.GuardsTeam", 3);
	teams:add(guards);
	self:getTeamBalancer():setGuardTeam(prisoners);
end

function jailbreak:getSettingsManager()
	return self._settingsManager;
end

function jailbreak:initSettings(manager)
	local setting = newInstance("Setting", manager, "MySetting");
	self:getTeamBalancer():initSettings(manager);
	if SERVER then
		setting._value = 18;
	else
		timer.Simple(1, function() setting:getValue() end);
	end
end

function jailbreak:onGamemodeLoaded()
	getDefinition("Gamemode").onGamemodeLoaded(self);
	print("jailbreak loaded");
end

function jailbreak:think()
	self:getStateMachine():tick();
end

function jailbreak:shutDown()
	getDefinition("Gamemode").shutDown(self);
end