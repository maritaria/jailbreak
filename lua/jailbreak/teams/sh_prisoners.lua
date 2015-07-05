local prisoners = newClass("Jailbreak.PrisonersTeam", "Jailbreak.Team");

function prisoners:ctor(identifier)
	getDefinition("Jailbreak.Team").ctor(self, identifier);
	self:setName("Prisoners");
	self:setKillOnLeave(true);
end

function prisoners:initLoadout(loadout)
	
end
