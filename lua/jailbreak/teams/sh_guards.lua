local guards = newClass("Jailbreak.GuardsTeam", "Team");

function guards:ctor(identifier)
	getDefinition("Team").ctor(self, identifier);
	self:setName("guards");
	self:setKillOnLeave(true);
end

function guards:equipPlayer(ply)
	getDefinition("Team").equipPlayer(self, ply);
end

function guards:unequipPlayer(ply)
	getDefinition("Team").unequipPlayer(self, ply);
end