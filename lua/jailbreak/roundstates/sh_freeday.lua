local freeday = newClass("Jailbreak.FreedayState", "Jailbreak.RoundState");

function freeday:ctor(machine)
	getDefinition("Jailbreak.RoundState").ctor(self, "Freeday", machine);
end