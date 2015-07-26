local deathLog = newClass("Jailbreak.DeathLog", "GamemodeComponent");

function deathLog:ctor(gamemode)
	getDefinition("GamemodeComponent").ctor(self, gamemode);
	self:initSettings(gamemode:getSettingsManager());
	self:subscribeGamemodeEvents(gamemode);
end

function deathLog:initSettings(manager)
	
end

function deathLog:subscribeGamemodeEvents(gamemode)
	gamemode:getPlayerDeathEvent():subscribe("deathLog", wrap(self.onPlayerDeath, self));
end

function deathLog:onPlayerDeath(ply)
	--self._log:add(newInstance("DeathEntry", ply);
end