local prisoners = newClass("Jailbreak.PrisonersTeam", "Team");

function prisoners:ctor(identifier)
	getDefinition("Team").ctor(self, identifier);
	self:setName("Prisoners");
	self:setKillOnLeave(true);
end

function prisoners:equipPlayer(ply)
	getDefinition("Team").equipPlayer(self, ply);
end

function prisoners:unequipPlayer(ply)
	getDefinition("Team").unequipPlayer(self, ply);
end