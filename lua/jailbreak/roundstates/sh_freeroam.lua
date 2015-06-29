local freeroam = newClass("Jailbreak.FreeRoamState", "Jailbreak.RoundState");

function freeroam:ctor(machine)
	getDefinition("Jailbreak.RoundState").ctor(self, "FreeRoam", machine);
end

function freeroam:onEnter()
	game.CleanUpMap();
end

function freeroam:onTick() end

function freeroam:onLeave()
	for _, ply in pairs(player.GetAll()) do
		if ply:Alive() then
			ply:KillSilent();
		end
	end
end

function freeroam:shouldStateChange()
	return #player.GetAll() >= 2;
end

function freeroam:getNextState()
	return self:getMachine():getState("Prepare");
end