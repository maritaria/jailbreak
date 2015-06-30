local last_kill = newClass("Jailbreak.LastKillState", "Jailbreak.RoundState");

function last_kill:ctor(machine)
	getDefinition("Jailbreak.RoundState").ctor(self, "LastKill", machine);
end