local freeday = newClass("Jailbreak.FreedayState", "Jailbreak.RoundState");

function freeday:shouldStateChange()
	return self:haveAllPrisonersDied() or self:haveAllGuardsDied();
end

function freeday:haveAllPrisonersDied()
	return self:getLiveCount(self:getPrisonerTeam()) == 0;
end

function freeday:haveAllGuardsDied()
	return self:getLiveCount(self:getGuardTeam()) == 0;
end

function freeday:getNextState()
	self:getMachine():getState("Prepare");
end