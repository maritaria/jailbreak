local item = newClass("InventoryItem", "Serializable");

function item:ctor(spawnable)
	assertArgument(2, "Inventory");
	getDefinition("Serializable").ctor(self);
	self._inventory = spawnable;
	inv:addItem(self);
end

function item:getSpawnable()
	return self._spawnable;
end

function item:setSpawnable(value)
	assertArgument(2, "Spawnable");
	self._spawnable = value;
end

function item:setPos(x, y)
	assertArgument(2, "number");
	assertArgument(3, "number");
end

function item:getPos()
	return self._x, self._y;
end