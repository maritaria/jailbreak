local lastRequest = newClass("Jailbreak.LastRequestState", "Jailbreak.RoundState");

function lastRequest:enter()
	getDefinition("Jailbreak.RoundState").enter(self);
end