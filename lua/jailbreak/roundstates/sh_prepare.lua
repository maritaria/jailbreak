local prepare = newClass("Jailbreak.PrepareState", "Jailbreak.RoundState");

function prepare:ctor(machine)
	getDefinition("Jailbreak.RoundState").ctor(self, "Prepare", machine);
end

function prepare:enter()
	getDefinition("Jailbreak.RoundState").enter(self);
	self:setNextState(self:getMachine():getState("Play"));
	self:killPlayers();
	self:resetMap();
	self:balanceTeams();
	self:spawnPlayers();
end

function prepare:killPlayers()
	print("prepare:killPlayers()");
	for _, ply in pairs(player.GetAll()) do
		ply:KillSilent();
	end
end

function prepare:resetMap()
	print("prepare:resetMap()");
	game.CleanUpMap();
end

function prepare:balanceTeams()
	print("prepare:balanceTeams()");
	GAMEMODE:getGamemode():getBalancer():balance();
end

function prepare:spawnPlayers()
	print("prepare:spawnPlayers()");
	for _, ply in pairs(player.GetAll()) do
		ply:Spawn();
	end
end