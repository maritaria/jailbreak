local gamemode = newClass("Gamemode", "Base");

function gamemode:ctor()
	getDefinition("Base").ctor(self);
	self:setTeamManager(newInstance("TeamManager", self));
end

function gamemode:getTeamManager()
	return self._teamManager;
end

function gamemode:setTeamManager(value)
	assertArgument(2, "TeamManager");
	self._teamManager = value;
end

function gamemode:onGamemodeLoaded()
	self:load();
end

function gamemode:load() end

function gamemode:shutDown()
	self:unload();
end

function gamemode:unload() end

function gamemode:playerSpawn(ply)
	print("gamemode:playerSpawn("..tostring(ply)..")");
	ply:getTeam():handleSpawn(ply);
end

function gamemode:playerSelectSpawn(ply)
	print("gamemode:playerSelectSpawn("..tostring(ply)..")");
	return ply:getTeam():selectSpawnPoint(ply);
end

function gamemode:playerInitialSpawn(ply)
	print("gamemode:playerInitialSpawn("..tostring(ply)..")");
	ply:setTeam(self:getTeamManager():getDefaultTeam());
end

function gamemode:keyPressed(ply, key) end