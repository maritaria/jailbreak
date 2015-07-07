local team = newClass("Jailbreak.Team", "Team");

function team:ctor(identifier)
	getDefinition("Team").ctor(self, identifier);
end

function team:onPlayerLeave(ply)
	getDefinition("Team").onPlayerLeave(self, ply);
	if (ply:Alive()) then
		ply:KillSilent();
	end
end