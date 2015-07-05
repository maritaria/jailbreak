local ammoitem = newClass("AmmoItem", "Spawnable");

function ammoitem:ctor(ammoType, amount)
	assertArgument(2, "string", "nil");
	assertArgument(3, "number", "nil");
	getDefinition("Spawnable").ctor(self);
	self._ammoType = ammoType;
	self._amount = amount or 0;
end

function ammoitem:getAmmoType()
	return self._ammoType;
end

function ammoitem:setAmmoType(value)
	assertArgument(2, "string");
	self._ammoType = value;
end

function ammoitem:getAmount()
	return self._amount;
end

function ammoitem:setAmount(value)
	assertArgument(2, "number");
	self._amount = value;
end

function ammoitem:giveTo(ply)
	assertArgument(2, "Player");
	print("ammoitem:giveTo()", ply, self:getAmount(), self:getAmmoType());
	ply:GiveAmmo(self:getAmount(), self:getAmmoType());
end