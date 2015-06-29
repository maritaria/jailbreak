local weapondesc = newClass("WeaponDescription", "Spawnable");

function weapondesc:ctor(weaponName)
	assertArgument(2, "string");
	getDefinition("Spawnable").ctor(self);
	self._weaponName = weaponName;
end

function weapondesc:spawn()
	assertArgument(2, "Player", "nil");
	assertAllowEntitySpawn();
end

function weapondesc:giveToPlayer(ply)
	assertArgument(2, "Player");
	ply:Give(self:getWeaponName());
end

function weapondesc:canGiveToPlayer(ply)
	
end