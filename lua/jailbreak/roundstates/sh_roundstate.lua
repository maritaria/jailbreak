local jailbreakState = newClass("Jailbreak.RoundState", "State");

function jailbreakState:ctor(name, machine)
	getDefinition("State").ctor(self, name, machine);
	self._nextState = nil;
	self._stateStart = 0;
	self._gamemode = self:getMachine():getGamemode();
end

function jailbreakState:getGamemode()
	return self._gamemode;
end

function jailbreakState:getPrisonerTeam()
	return self:getGamemode():getPrisonerTeam();
end

function jailbreakState:getGuardTeam()
	return self:getGamemode():getGuardTeam();
end

function jailbreakState:getLiveCount(team)
	local count = 0;
	for _, ply in pairs(team:getPlayers()) do
		if ply:Alive() then
			count = count + 1;
		end
	end
	return count;
end

function jailbreakState:isWardenAlive()
	local warden = self:getGamemode():getWarden();
	return IsValid(warden) and warden:IsPlayer() and warden:Alive();
end

function jailbreakState:enter()
	print(self:getName() .. ".enter()");
	self._stateStart = RealTime();
	self:subscribeEvents();
	getDefinition("State").enter(self);
end

function jailbreakState:leave()
	print(self:getName() .. ".leave()");
	self:unsubscribeEvents();
	getDefinition("State").leave(self);
end

function jailbreakState:subscribeEvents()
	--[[--
	local gm = self:getGamemode();
	gm:subscribe("MyEventName", self, self.myEventHandlerFunction);
	--]]--
end

function jailbreakState:unsubscribeEvents()
	local gm = self:getGamemode();
	gm:unsubscribeAll(self);
end