local spectators = newClass("Jailbreak.SpectatorsTeam", "Jailbreak.Team");

function spectators:ctor(identifier)
	getDefinition("Jailbreak.Team").ctor(self, identifier);
	self:setName("Spectators");
	self:setKillOnLeave(false);
end

function spectators:initLoadout(loadout)
	loadout:getWeaponList():add(newInstance("WeaponItem", "weapon_pistol"));
	loadout:getAmmoList():add(newInstance("AmmoItem", "Pistol", 24));
end

function spectators:applyObserverMode(ply)
	assertArgument(2, "Player");
	ply:Spectate(OBS_MODE_ROAMING);
end
