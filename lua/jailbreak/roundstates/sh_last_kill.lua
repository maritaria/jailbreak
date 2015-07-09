local lastKill = newClass("Jailbreak.LastKillState", "Jailbreak.RoundState");

function lastKill:ctor(machine)
	getDefinition("Jailbreak.RoundState").ctor(self, "LastKill", machine);
end