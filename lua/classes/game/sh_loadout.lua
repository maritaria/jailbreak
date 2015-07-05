local loadout = newClass("Loadout");

function loadout:ctor()
	getDefinition("Base").ctor(self);
	self._items = newInstance("TypedList", "Spawnable");
	self._weapons = newInstance("TypedList", "WeaponItem");
	self._ammo = newInstance("TypedList", "AmmoItem");
end

function loadout:getItemList()
	return self._items;
end

function loadout:getWeaponList()
	return self._weapons;
end

function loadout:getAmmoList()
	return self._ammo;
end

function loadout:giveToPlayer(ply)
	assertArgument(2, "Player");
	self:giveItems(ply);
	self:giveWeapons(ply);
	self:giveAmmo(ply);
end

function loadout:giveItems(ply)
	for _, item in pairs(self:getItemList()) do
		if weapon:canGiveTo(ply) then
			item:giveTo(ply);
		end
	end
end

function loadout:giveWeapons(ply)
	assertArgument(2, "Player");
	for _, weapon in pairs(self:getWeaponList()) do
		if weapon:canGiveTo(ply) then
			weapon:giveTo(ply);
		end
	end
end

function loadout:giveAmmo(ply)
	assertArgument(2, "Player");
	for _, ammo in pairs(self:getAmmoList()) do
		if ammo:canGiveTo(ply) then
			ammo:giveTo(ply);
		end
	end
end