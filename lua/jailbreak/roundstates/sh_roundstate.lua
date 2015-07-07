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