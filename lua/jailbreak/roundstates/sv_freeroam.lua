local freeroam = newClass("Jailbreak.FreeRoamState", "Jailbreak.RoundState");

function freeroam:enter()
	getDefinition("Jailbreak.RoundState").enter(self);
	game.CleanUpMap();
	for _, ply in pairs(player.GetAll()) do
		if not ply:Alive() then
			ply:Spawn();
		end
	end
end

function freeroam:shouldStateChange()
	return self:getValidPlayerCount() >= self:getRequiredPlayerCount();
end

function freeroam:getValidPlayerCount()
	local validPlayers = 0;
	for _, ply in pairs(player.GetAll()) do
		if IsValid(ply) then
			validPlayers = validPlayers + 1;
		end
	end
	return validPlayers;
end

function freeroam:getRequiredPlayerCount()
	local gamemode = self:getMachine():getGamemode();
	local setting = gamemode:getMinimumPlayerCountSetting();
	return setting:getValue();
end

function freeroam:getNextState()
	return self:getMachine():getState("Prepare");
end