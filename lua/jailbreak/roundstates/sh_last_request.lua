local lastRequest = newClass("Jailbreak.LastRequestState", "Jailbreak.RoundState");

function lastRequest:ctor(machine)
	getDefinition("Jailbreak.RoundState").ctor(self, "LastRequest", machine);
end