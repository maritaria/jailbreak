local play = newClass("Jailbreak.PlayState", "Jailbreak.RoundState");

function play:enter()
	getDefinition("Jailbreak.RoundState").enter(self);
	self:selectWarden();
end

function play:selectWarden()
	local guards = self:getGuardTeam();
	local pool = guards:getPlayers();
	local index = math.random(1, #pool);
	local warden = pool[index];
	print(string.format("We have decided to make %s the warden :)", warden));
	local gamemode = self:getGamemode();
	gamemode:setWarden(warden);
end

function play:tick()
	getDefinition("Jailbreak.RoundState").tick(self);
	
	local prisonerTeam = self:getPrisonerTeam();
	local guardTeam = self:getGuardTeam();
	
	local prisonerCount = self:getLiveCount(prisonerTeam);
	local guardCount = self:getLiveCount(guardTeam);
	
	if (prisonerCount == 0) or (guardCount == 0) then
		self:changeTo("LastKill");
	elseif not self:isWardenAlive() then
		self:changeTo("Freeday");
	elseif prisonerCount < 2 then
		self:changeTo("LastRequest");
	end
end

function play:leave()
	getDefinition("Jailbreak.RoundState").leave(self);
end

function play:onPlayerLeave(ply)
	self:checkPlayerCounts("PlayerLeave");
	
end