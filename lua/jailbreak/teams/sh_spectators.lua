local spectators = newClass("Jailbreak.SpectatorsTeam", "Team");

function spectators:ctor(identifier)
	getDefinition("Team").ctor(self, identifier);
	self:setName("Spectators");
	self:setKillOnLeave(false);
	local loadout = self:getLoadout();
end

function spectators:initLoadout(loadout)
	loadout:getWeaponList():add(newInstance("WeaponItem", "weapon_pistol"));
	loadout:getAmmoList():add(newInstance("AmmoItem", "Pistol", 24));
end

function spectators:applyObserverMode(ply)
	assertArgument(2, "Player");
	ply:Spectate(OBS_MODE_ROAMING);
end

--[[--
function spectators:equipPlayer(ply)
	getDefinition("Team").equipPlayer(self, ply);
end

function spectators:unequipPlayer(ply)
	getDefinition("Team").unequipPlayer(self, ply);
end
--]]--
