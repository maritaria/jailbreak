local freeroam = newClass("Jailbreak.FreeRoamState", "Jailbreak.RoundState");

function freeroam:ctor(machine)
	getDefinition("Jailbreak.RoundState").ctor(self, "FreeRoam", machine);
end