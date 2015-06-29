local last_request = newClass("Jailbreak.LastRequestState", "Jailbreak.RoundState");

function last_request:ctor(machine)
	getDefinition("Jailbreak.RoundState").ctor(self, "LastRequest", machine);
end

function last_request:onEnter() end

function last_request:onTick() end

function last_request:onLeave() end