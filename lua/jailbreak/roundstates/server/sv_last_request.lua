local lastRequest = newClass("Jailbreak.LastRequestState", "Jailbreak.RoundState");

function lastRequest:enter()
	getDefinition("Jailbreak.RoundState").enter(self);
end

function lastRequest:tick()
	getDefinition("Jailbreak.RoundState").tick(self);
	
	local prisonerTeam = self:getGamemode():getPrisonerTeam();
	local guardTeam = self:getGamemode():getGuardTeam();
	
	local prisonerCount = self:getLiveCount(prisonerTeam);
	local guardCount = self:getLiveCount(guardTeam);
	
	if (prisonerCount == 0) or (guardCount == 0) then
		self:changeTo("LastKill");
	end
end