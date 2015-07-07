local jailbreakState = newClass("Jailbreak.RoundState", "State");

function jailbreakState:tick()
	getDefinition("State").tick(self);
	if self:shouldStateChange() then
		self:getMachine():setActiveState(self:getNextState());
	end
end

function jailbreakState:shouldStateChange()
	return self:getNextState() != nil;
end

function jailbreakState:getNextState()
	return self._nextState;
end

function jailbreakState:setNextState(value)
	assertArgument(2, "State");
	self._nextState = value;
end

function jailbreakState:getStateActiveTime()
	if self:isActive() then
		return RealTime() - self._stateStart;
	else
		return 0;
	end
end