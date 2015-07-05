local inventory = newClass("Inventory", "Serializable");

function inventory:ctor()
	getDefinition("Serializable").ctor(self, "InventoryItem");
	self._width = -1;
	self._height = -1;
end

function inventory:getWidth()
	return self._width;
end

function inventory:setWidth(value)
	assertArgument(2, "number");
	self._width = value;
end

function inventory:getHeight()
	return self._height;
end

function inventory:setHeight(value)
	assertArgument(2, "number");
	self._height = value;
end

function inventory:resize(width, height)
	self:setWidth(width);
	self:setHeight(height);
end

function inventory:getCapacity()
	local w, h = self:getWidth(), self:getHeight();
	if (w == -1) or (h == -1) then
		return -1;
	end
	return w * h;
end