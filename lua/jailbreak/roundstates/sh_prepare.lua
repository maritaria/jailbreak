local prepare = newClass("Jailbreak.PrepareState", "Jailbreak.RoundState");

function prepare:ctor(machine)
	getDefinition("Jailbreak.RoundState").ctor(self, "Prepare", machine);
end