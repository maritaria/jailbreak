local play = newClass("Jailbreak.PlayState", "Jailbreak.RoundState");

function play:enter()
	getDefinition("Jailbreak.RoundState").enter(self);
	
	local guards = self:getMachine():getGamemode():getGuardTeam();
	local pool = guards:getPlayers();
	local index = math.random(1, #pool);
	local warden = pool[index];
	local machine = self:getMachine();
	local gamemode = machine:getGamemode();
	local setting = gamemode:getWardenSetting();
	setting:setValue(warden);
	
end