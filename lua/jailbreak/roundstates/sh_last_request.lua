local last_request = newClass("Jailbreak.LastRequestState", "Jailbreak.RoundState");

function last_request:ctor(machine)
	getDefinition("Jailbreak.RoundState").ctor(self, "LastRequest", machine);
end