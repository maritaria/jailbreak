print("not yet implemented");
do return end;
local inventory = newClass("Inventory");

function inventory:ctor()
	getDefinition("Base").ctor(self);
	self._width = -1;
	self._hidth = -1;
	self._items = {};
end

function inventory:getWidth()
	return self._width;
end

function inventory:setWidth(value)
	assertArgument(2, "number");
	self:resize(value, self:getHeight());
end

function inventory:getHeight()
	return self._height;
end

function inventory:setHeight(value)
	assertArgument(2, "number");
	self:resize(self:getWidth(), value);
end

function inventory:getCapacity()
	local w, h = self:getWidth(), self:getHeight();
	if (w == -1) or (h == -1) then
		return -1;
	end
	return w * h;
end

function inventory:getCount()
	return #self._items;
end


