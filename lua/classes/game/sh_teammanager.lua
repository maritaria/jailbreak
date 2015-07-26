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

function teamManager:subscribeEvents()
	local gm = self:getGamemode();
	if SERVER then
		gm:getPlayerInitialSpawnEvent():subscribe(self, self.onPlayerInitialSpawn);
		gm:getPlayerSpawnEvent():subscribe(self, self.onPlayerSpawn);
		gm:getPlayerSelectSpawnEvent():subscribe(self, self.onPlayerSelectSpawn);
	end
end

function teamManager:unsubscribeEvents()
	local gm = self:getGamemode();
	if SERVER then
		gm:getPlayerInitialSpawnEvent():unsubscribe(self);
		gm:getPlayerSpawnEvent():unsubscribe(self);
		gm:getPlayerSelectSpawnEvent():unsubscribe(self);
	end
end

function teamManager:onPlayerInitialSpawn(ply)
	print("teamManager:onPlayerInitialSpawn("..tostring(ply)..")");
	ply:setTeam(self:getDefaultTeam());
end

function teamManager:onPlayerSpawn(ply)
	print("teamManager:onPlayerSpawn("..tostring(ply)..")");
	ply:getTeam():handleSpawn(ply);
end

function teamManager:onPlayerSelectSpawn(ply)
	print("teamManager:onPlayerSelectSpawn("..tostring(ply)..")");
	local team = ply:getTeam();
	if (team != nil) then
		return team:selectSpawnPoint(ply);
	else
		return game.GetWorld();
	end
end