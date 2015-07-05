local weaponitem = newClass("WeaponItem", "Spawnable");

function weaponitem:ctor(weaponName)
	assertArgument(2, "string", "nil");
	getDefinition("Spawnable").ctor(self);
	self._weaponName = weaponName;
end

function weaponitem:getWeaponName()
	return self._weaponName;
end

function weaponitem:setWeaponName(value)
	assertArgument(2, "string");
	self._weaponName = value;
end

function weaponitem:giveTo(ply)
	assertArgument(2, "Player");
	print("weaponitem:giveTo()", ply, self:getWeaponName());
	ply:Give(self:getWeaponName());
end