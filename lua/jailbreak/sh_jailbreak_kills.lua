local jailbreak = newClass("Jailbreak.Gamemode", "Gamemode");

function jailbreak:initDeathLog()
	self._deathLog = newInstance("Jailbreak.DeathLog", self);
end

function jailbreak:getDeathLog()
	return self._deathLog;
end

function jailbreak:playerDeath(victim, inflictor, attacker)
	self:getKillLogger():addKill(victim, inflictor, attacker);
	
	victim:setLastDeathTimestamp(CurTime());
	
end

function jailbreak:playerSilentDeath(victim, inflictor, attacker)
	
end

function jailbreak:postPlayerDeath(ply)
	
end