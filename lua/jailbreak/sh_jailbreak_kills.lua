local jailbreak = newClass("Jailbreak.Gamemode", "Gamemode");

function jailbreak:initDeathLog()
	self._deathLog = newInstance("Jailbreak.DeathLog", self);
	self._deathLog:initSettings(self:getSettingsManager());
	self._deathLog:subscribeEvents();
end

function jailbreak:getDeathLog()
	return self._deathLog;
end