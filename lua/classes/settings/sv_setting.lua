local setting = newClass("Setting", "Base");

function setting:getValue(default)
	return self._value;
end

function setting:setValue(value)
	self._value = value;
	self:getManager():commit(self);
end

function setting:commit(ply)
	assertArgument(2, "Player", "table");
	self:getManager():commit(self, ply);
end