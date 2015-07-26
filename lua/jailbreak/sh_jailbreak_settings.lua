local jailbreak = newClass("Jailbreak.Gamemode", "Gamemode");

function jailbreak:initSettings()
	print("jailbreak:initSettings()");
	local manager = self:getSettingsManager();
	
	self._wardenSetting = newInstance("Setting", manager, "Jailbreak.Warden", NULL);
	self._minimumPlayerCountSetting = newInstance("Setting", manager, "Jailbreak.MinimumPlayerCount", 3);
	self._lastKillDurationSetting = newInstance("Setting", manager, "Jailbreak.LastKillDuration", 10);
	
	self:getTeamBalancer():initSettings(manager);
	self:getStateMachine():initSettings(manager);
	
	hook.Run("Jailbreak.initSettings", self);
end

function jailbreak:getWardenSetting()
	return self._wardenSetting;
end

function jailbreak:getWarden()
	return self:getWardenSetting():getValue();
end

function jailbreak:setWarden(value)
	assertArgument(2, "Player", "Entity");
	self:getWardenSetting():setValue(value);
end

function jailbreak:getMinimumPlayerCountSetting()
	return self._minimumPlayerCountSetting;
end

function jailbreak:getLastKillDurationSetting()
	return self._lastKillDurationSetting;
end