local last_kill = newClass("Jailbreak.LastKillState", "Jailbreak.RoundState");

function last_kill:ctor(machine)
	getDefinition("Jailbreak.RoundState").ctor(self, "LastKill", machine);
end

function last_kill:onEnter() end

function last_kill:onTick() end

function last_kill:onLeave() end