local deathLog = newClass("Jailbreak.DeathLog", "GamemodeComponent");

function deathLog:ctor(gamemode)
	getDefinition("GamemodeComponent").ctor(self, gamemode);
	self._Deaths = newInstance("TypedList", "Jailbreak.DeathEntry");
end

function deathLog:initSettings(manager)
	self._capacitySetting = newInstance("Setting", manager, "DeathLog.Capacity", 1);
end

function deathLog:getCapacity()
	return self._capacitySetting:getValue();
end

if SERVER then
	function deathLog:setCapacity(value)
		self._capacitySetting:setValue(value);
	end
end

function deathLog:subscribeEvents()
	local gm = self:getGamemode();
	if SERVER then
		gm:subscribe("PlayerDeath", self, "onPlayerDeath");
		gm:subscribe("PlayerSilentDeath", self, "onPlayerDeath");
	end
end

function deathLog:unsubscribeEvents()
	local gm = self:getGamemode();
	if SERVER then
		gm:unsubscribe(self);
		gm:getPlayerDeathEvent():unsubscribe(self);
	end
end

function deathLog:onPlayerDeath(victim, inflictory, attacker)
	print("deathLog:onPlayerDeath(" .. tostring(ply) .. ")");
	local death = newInstance("Jailbreak.DeathEntry", victim, inflictory, attacker);
	self:addDeath(death);
end

function deathLog:addDeath(death)
	print("deathLog:addDeath(" .. tostring(death) .. ")");
	self._Deaths:add(death);
	while self:isOverCapacity() do
		self._Deaths:removeAt(0);
	end
end

function deathLog:isOverCapacity()
	local capacity = self:getCapacity();
	return (self._Deaths:getCount() > capacity) and (capacity > 0);
end

function deathLog:getLastDeath()
	return self._Deaths[self._Deaths:getCount()];
end

