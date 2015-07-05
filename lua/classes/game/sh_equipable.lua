do return end;
local equipable = newClass("Equipable");

function equipable:ctor()
	getDefinition("Base").ctor(self);
end

function equipable:giveTo()
	error("not implemented");
end

function equipable:equip()
	error("not implemented");
end

function equipable:canEquip()
	return true;
end

function equipable:unequip()
	error("not implemented");
end

function equipable:canUnequip()
	return true;
end