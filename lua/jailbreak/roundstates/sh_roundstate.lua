local jailbreakState = newClass("Jailbreak.RoundState", "State");

function jailbreakState:ctor(name, machine)
	getDefinition("State").ctor(self, name, machine);
	self._nextState = nil;
	self._stateStart = 0;
end

function jailbreakState:enter()
	print(self:getName() .. ".enter()");
	self._stateStart = RealTime();
	getDefinition("State").enter(self);
end

function jailbreakState:leave()
	print(self:getName() .. ".leave()");
	getDefinition("State").leave(self);
end

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