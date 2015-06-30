local play = newClass("Jailbreak.PlayState", "Jailbreak.RoundState");

function play:ctor(machine)
	getDefinition("Jailbreak.RoundState").ctor(self, "Play", machine);
end