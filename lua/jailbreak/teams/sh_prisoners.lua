local prisoners = newClass("Jailbreak.PrisonersTeam", "Jailbreak.Team");

function prisoners:ctor(identifier)
	getDefinition("Jailbreak.Team").ctor(self, identifier);
	self:setName("Prisoners");
end

function prisoners:initLoadout(loadout)
	
end
