local gamemode = newClass("Gamemode", "Base");

function gamemode:ctor()
	getDefinition("Base").ctor(self);
	self:setTeamManager(newInstance("TeamManager", self));
	self:initEvents();
end

function gamemode:getTeamManager()
	return self._teamManager;
end

function gamemode:setTeamManager(value)
	assertArgument(2, "TeamManager");
	self._teamManager = value;
end

function gamemode:onInitPostEntity()
	return self:start();
end

function gamemode:start()
end

function gamemode:onShutDown()
	return self:stop();
end

function gamemode:stop()
end

function gamemode:onPlayerInitialSpawn(ply)
	print("gamemode:onPlayerInitialSpawn("..tostring(ply)..")");
	ply:setTeam(self:getTeamManager():getDefaultTeam());
end

function gamemode:onPlayerSpawn(ply)
	print("gamemode:onPlayerSpawn("..tostring(ply)..")");
	ply:getTeam():handleSpawn(ply);
end

function gamemode:onPlayerSelectSpawn(ply)
	print("gamemode:onPlayerSelectSpawn("..tostring(ply)..")");
	return ply:getTeam():selectSpawnPoint(ply);
end