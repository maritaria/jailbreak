local freeday = newClass("Jailbreak.FreedayState", "Jailbreak.FreedayState");

function freeday:ctor(machine)
	getDefinition("Jailbreak.RoundState").ctor(self, "Freeday", machine);
end