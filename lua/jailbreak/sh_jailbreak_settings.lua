local jailbreak = newClass("Jailbreak.Gamemode", "Gamemode");

function jailbreak:initSettings()
	print("jailbreak:initSettings()");
	local manager = self:getSettingsManager();
	
	self._wardenSetting = newInstance("Setting", manager, "Jailbreak.Warden", NULL);
	self._minimumPlayerCountSetting = newInstance("Setting", manager, "Jailbreak.MinimumPlayerCount", 3);
	
	self:getTeamBalancer():initSettings(manager);
	self:getStateMachine():initSettings(manager);
end

function jailbreak:getWardenSetting()
	return self._wardenSetting;
end

function jailbreak:getMinimumPlayerCountSetting()
	return self._minimumPlayerCountSetting;
end