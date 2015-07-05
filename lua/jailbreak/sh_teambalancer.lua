local balancer = newClass("Jailbreak.TeamBalancer", "GamemodeComponent");

function balancer:ctor(gamemode)
	getDefinition("GamemodeComponent").ctor(self, gamemode);
	self._ratioSetting = nil;
end

function balancer:initSettings(manager)
	self._ratioSetting = newInstance("Setting", manager, "Jailbreak.TeamBalancer.Ratio", 0.35);
end

function balancer:getGuardRatioSetting()
	return self._ratioSetting;
end

function balancer:getPrisonerTeam()
	return self._prisonerTeam;
end

function balancer:setPrisonerTeam(value)
	assertArgument(2, "Team");
	self._prisonerTeam = value;
end

function balancer:getGuardTeam()
	return self._guardTeam;
end

function balancer:setGuardTeam(value)
	assertArgument(2, "Team");
	self._guardTeam = value;
end

function balancer:checkBalance()
	print("balancer:checkBalance()");
	if self:shouldBalanceTeams() then
		self:balance();
	end
end

function balancer:shouldBalanceTeams()
	local guardCount = self:getGuardTeam():getPlayerCount();
	local prisonerCount = self:getPrisonerTeam():getPlayerCount();
	local ratio = self:getRatio(guardCount, prisonerCount);
	
end

function balancer:balance()
	print("balancer:balance()");
	local targetRatio = self:getGuardRatioSetting():getValue();
	local guardCount = self:getGuardTeam():getPlayerCount();
	local prisonerCount = self:getPrisonerTeam():getPlayerCount();
	local totalCount = guardCount + prisonerCount;
	local deadzone = 0.5 / (guardCount + prisonerCount);
	while (true) do
		local currentRatio = self:getRatio(guardCount, prisonerCount);
		print("Target:", targetRatio, "Current:", currentRatio, "Deadzone:", deadzone);
		if self:isInsideDeadzone(currentRatio, targetRatio, deadzone) then
			print("deadzoned");
			break;
		end
		if (currentRatio < targetRatio) then
			self:switchGuardToPrisoner();
		else
			self:switchPrisonerToGuard();
		end
	end
end

function balancer:getRatio(guardCount, prisonerCount)
	local ratio = guardCount / prisonerCount;
	if math.isNan(ratio) then
		ratio = 1;
	end
	return ratio;
end

function balancer:isInsideDeadzone(value, target, deadzone)
	return abs(value - target) <= deadzone;
end

function balancer:switchGuardToPrisoner()
	local guard = self:getNextGuardForSwap();
	prisoner:setTeam(self:getPrisonerTeam());
end

function balancer:getNextGuardForSwap()
	local pool = self:getGuardTeam():getPlayers();
	return pool[math.random(1, #pool)];
end

function balancer:switchPrisonerToGuard()
	local prisoner = self:getNextPrisonerForSwap();
	prisoner:setTeam(self:getGuardTeam());
end

function balancer:getNextPrisonerForSwap()
	local pool = self:getPrisonerTeam():getPlayers();
	return pool[math.random(1, #pool)];
end

function balancer:pickTeamForPlayer(ply)
	
end