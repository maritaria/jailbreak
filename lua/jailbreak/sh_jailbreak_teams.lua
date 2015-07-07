local jailbreak = newClass("Jailbreak.Gamemode", "Gamemode");

function jailbreak:initTeams()
	local manager = self:getTeamManager();
	local teamBalancer = self:getTeamBalancer();
	
	local spectators = newInstance("Jailbreak.SpectatorsTeam", 1);
	manager:addTeam(spectators);
	self._spectatorTeam = spectators;
	
	local prisoners = newInstance("Jailbreak.PrisonersTeam", 2);
	manager:addTeam(prisoners);
	manager:setDefaultTeam(prisoners);
	self._prisonerTeam = prisoners;
	
	local guards = newInstance("Jailbreak.GuardsTeam", 3);
	manager:addTeam(guards);
	self._guardTeam = guards;
	
end

function jailbreak:getSpectatorTeam()
	return self._spectatorTeam;
end

function jailbreak:getPrisonerTeam()
	return self._prisonerTeam;
end

function jailbreak:getGuardTeam()
	return self._guardTeam;
end