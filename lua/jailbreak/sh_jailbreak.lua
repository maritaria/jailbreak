local jailbreak = newClass("Jailbreak.Gamemode", "Gamemode");

function jailbreak:ctor()
	getDefinition("Gamemode").ctor(self);
	self._stateMachine = newInstance("Jailbreak.RoundStateMachine");
	self:setupTeams(self:getTeamManager());
	self._settingsManager = newInstance("SettingsManager");
	self:initSettings(self:getSettingsManager());
end

function jailbreak:getStateMachine()
	return self._stateMachine;
end

function jailbreak:setupTeams(manager)
	local teams = manager:getTeams();
	local spectators = newInstance("Jailbreak.SpectatorsTeam", 51);
	teams:add(spectators);
	manager:setDefaultTeam(spectators);
	teams:add(newInstance("Jailbreak.PrisonersTeam", 2));
	teams:add(newInstance("Jailbreak.GuardsTeam", 3));
end

function jailbreak:getSettingsManager()
	return self._settingsManager;
end

function jailbreak:initSettings(manager)
	local setting = newInstance("Setting", manager, "MySetting");
	manager:add(setting);
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

include_dir("jailbreak/teams");