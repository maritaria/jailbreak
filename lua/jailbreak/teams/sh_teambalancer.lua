local balancer = newClass("Jailbreak.TeamBalancer", "GamemodeComponent");

function balancer:ctor(gamemode)
	getDefinition("GamemodeComponent").ctor(self, gamemode);
	self._ratioSetting = nil;
end

function balancer:initSettings(manager)
	self._ratioSetting = newInstance("Setting", manager, "Jailbreak.TeamBalancer.Ratio", 0.35);
end

function balancer:subscribeEvents()
end

function balancer:unsubscribeEvents()
end

function balancer:getGuardRatioSetting()
	return self._ratioSetting;
end

function balancer:getPrisonerTeam()
	return self:getGamemode():getPrisonerTeam();
end

function balancer:getGuardTeam()
	return self:getGamemode():getGuardTeam();
end

function balancer:balance()
	print("balancer:balance()");
	local targetRatio = self:getGuardRatioSetting():getValue();
	local guardCount = self:getGuardTeam():getPlayerCount();
	local prisonerCount = self:getPrisonerTeam():getPlayerCount();
	local totalCount = guardCount + prisonerCount;
	local deadzone = 0.5 / (guardCount + prisonerCount);
	while (true) do
		guardCount = self:getGuardTeam():getPlayerCount();
		local currentRatio = self:getRatio(guardCount, totalCount);
		if self:isInsideDeadzone(currentRatio, targetRatio, deadzone) then
			break;
		end
		if (currentRatio > targetRatio) then
			self:switchGuardToPrisoner();
		else
			self:switchPrisonerToGuard();
		end
	end
end

function balancer:getRatio(guardCount, totalCount)
	local ratio = guardCount / totalCount;
	if math.isNan(ratio) or math.isInf(ratio) then
		ratio = 1;
	end
	return ratio;
end

function balancer:isInsideDeadzone(value, target, deadzone)
	return math.abs(value - target) <= deadzone;
end

function balancer:switchGuardToPrisoner()
	local guard = self:getNextGuardForSwap();
	guard:setTeam(self:getPrisonerTeam());
end

function balancer:getNextGuardForSwap()
	local pool = self:getGuardTeam():getPlayers();
	local index = math.random(1, #pool);
	return pool[index];
end

function balancer:switchPrisonerToGuard()
	local prisoner = self:getNextPrisonerForSwap();
	prisoner:setTeam(self:getGuardTeam());
end

function balancer:getNextPrisonerForSwap()
	local pool = self:getPrisonerTeam():getPlayers();
	local index = math.random(1, #pool);
	return pool[index];
end