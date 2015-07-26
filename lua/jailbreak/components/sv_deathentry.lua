local deathLog = newClass("Jailbreak.DeathEntry", "Serializable");

function deathLog:ctor(victim, inflictor, killer)
	self:setVictim(victim);
	self:setInflictor(inflictor);
	self:setKiller(killer);
end

function deathLog:getKiller()
	return self._killer;
end

function deathLog:setKiller(killer)
	self._killer = killer;
end

function deathLog:getVictim()
	return self._victim;
end

function deathLog:setVictim(value)
	self._victim = value;
end

function deathLog:getInflictor()
	return self._inflictor;
end

function deathLog:setInflictor(value)
	self._inflictor = value;
end

function deathLog:serialize()
end

function deathLog:deserialize(tbl)
end
