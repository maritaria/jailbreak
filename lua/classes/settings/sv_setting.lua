local setting = newClass("Setting", "Base");

function setting:getValue()
	return self._value;
end

function setting:setValue(value)
	self._value = value;
	self:update();
end

function setting:update(players)
	assertArgument(2, "Player", "table", "nil");
	self:getManager():update(self, players);
end

function setting:onRequestAccepted(ply)
	self:getRequestAcceptedEvent():fire(self, ply);
end

function setting:onRequestDenied(ply)
	self:getRequestDeniedEvent():fire(self, ply);
end

function setting:onCommitAccepted(ply)
	self:getCommitAcceptedEvent():fire(self, ply);
end

function setting:onCommitDenied(ply)
	self:getCommitDeniedEvent():fire(self, ply);
end