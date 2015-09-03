local jailbreak = newClass("Jailbreak.Gamemode", "Gamemode");

function jailbreak:initStateMachine()
	self._stateMachine = newInstance("Jailbreak.RoundStateMachine", self);
end

function jailbreak:getStateMachine()
	return self._stateMachine;
end