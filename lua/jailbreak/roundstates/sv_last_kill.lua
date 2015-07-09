local lastKill = newClass("Jailbreak.LastKillState", "Jailbreak.RoundState");

function lastKill:enter()
	getDefinition("Jailbreak.RoundState").enter(self);
	self:announceWinner();
end

function lastKill:announceWinner()
	local kill = self:getGamemode():getLastKill();
	local winner = kill:getKiller();
	local lastLoser = kill:getVictim();
end

function lastKill:shouldStateChange()
	return self:getStateActiveTime() > self:getGamemode():getLastKillDurationSetting():getValue();
end

function lastKill:getNextState()
	return self:getMachine():getState("Prepare");
end