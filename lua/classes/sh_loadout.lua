local loadout = newClass("Loadout");

function loadout:ctor()
	getDefinition("Base").ctor(self);
	self._items = newInstance("List");
	self._weapons = newInstance("List");
	self._ammo = newInstance("List");
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

function loadout:giveWeapons(ply)
	assertArgument(2, "Player");
	for _, weapon in self:getAmmoList():enumerate() do
		weapon:giveTo(ply);
	end
end

function loadout:giveAmmo(ply)
	assertArgument(2, "Player");
	for _, ammo in self:getAmmoList():enumerate() do
		ammo:giveTo(ply);
	end
end

function loadout:giveItems(ply)
	for _, item in self:getItemList():enumerate() do
		item:giveTo(ply);
	end
end