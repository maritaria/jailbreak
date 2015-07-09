local play = newClass("Jailbreak.PlayState", "Jailbreak.RoundState");

function play:enter()
	getDefinition("Jailbreak.RoundState").enter(self);
	
	local guards = self:getMachine():getGamemode():getGuardTeam();
	local pool = guards:getPlayers();
	local index = math.random(1, #pool);
	local warden = pool[index];
	print(string.format("We have decided to make %s the warden :)", warden));
	local machine = self:getMachine();
	local gamemode = machine:getGamemode();
	local setting = gamemode:getWardenSetting();
	setting:setValue(warden);
	
end

function play:tick()
	getDefinition("Jailbreak.RoundState").tick(self);
	
	local prisonerTeam = self:getMachine():getGamemode():getPrisonerTeam();
	local guardTeam = self:getMachine():getGamemode():getGuardTeam();
	
	local prisonerCount = self:getLiveCount(prisonerTeam);
	local guardCount = self:getLiveCount(guardTeam);
	
	if (prisonerCount == 0) or (guardCount == 0) then
		self:getMachine():setNextState(self:getMachine():getState("LastKill"));
	else if prisonerCount < 2 then
		self:getMachine():setNextState(self:getMachine():getState("LastRequest"));
	end
end

function play:getLiveCount(team)
	local count = 0;
	for _, ply in pairs(team) do
		if ply:Alive() then
			count = count + 1;
		end
	end
	return count;
end

function play:leave()
	getDefintion("Jailbreak.RoundState").leave(self);
end