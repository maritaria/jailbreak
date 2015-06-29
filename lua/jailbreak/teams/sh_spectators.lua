local spectators = newClass("Jailbreak.SpectatorsTeam", "Team");

function spectators:ctor(identifier)
	getDefinition("Team").ctor(self, identifier);
	self:setName("Spectators");
	self:setKillOnLeave(false);
end

function spectators:equipPlayer(ply)
	getDefinition("Team").equipPlayer(self, ply);
end

function spectators:unequipPlayer(ply)
	getDefinition("Team").unequipPlayer(self, ply);
end