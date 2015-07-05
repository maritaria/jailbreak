local team = newClass("Jailbreak.Team", "Team");

function team:ctor(identifier)
	getDefinition("Team").ctor(self, identifier);
end