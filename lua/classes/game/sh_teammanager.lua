local teamManager = newClass("TeamManager", "GamemodeComponent");

function teamManager:ctor(gamemode)
	getDefinition("GamemodeComponent").ctor(self, gamemode);
	self._teams = newInstance("TypedList", "Team");
	self._defaultTeam = nil;
end

function teamManager:addTeam(team)
	self:getTeams():add(team);
end

function teamManager:getTeams()
	return self._teams;
end

function teamManager:getDefaultTeam()
	assert(self._defaultTeam != nil, "no default team assigned");
	return self._defaultTeam;
end

function teamManager:setDefaultTeam(value)
	assertArgument(2, "Team");
	assert(self:getTeams():contains(value), "team does not belong to this TeamManager");
	self._defaultTeam = value;
end

function teamManager:getTeamByIdentifier(identifier)
	for _, team in pairs(self:getTeams()) do
		if (team:getIdentifier() == identifier) then
			return team;
		end
	end
end