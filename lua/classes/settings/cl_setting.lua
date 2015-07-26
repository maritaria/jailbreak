local setting = newClass("Setting", "Base");

function setting:getValue()
	if not self:isReceived() then
		self:request();
	end
	return self._value;
end

function setting:setValue(value)
	assert(not self:isCommitPending(), "Setting value not allowed to change during commit");
	self._value = value;
end

function setting:getLastReceivedValue()
	return self._lastReceivedValue;
end

function setting:isReceived()
	return self._received;
end

function setting:isRequested()
	return self._requested;
end

function setting:isCommitPending()
	return self._commitPending;
end

function setting:isModified()
	return self:getLastReceivedValue() != self:getValue();
end

function setting:request()
	if not self:isRequested() then
		self:getManager():request(self);
		self._requested = true;
	end
end

function setting:commit()
	if not self:isCommitPending() then
		self:getManager():commit(self);
		self._commitPending = true;
	end
end

function setting:onValueUpdated(value)
	self._received = true;
	self._value = value;
	self._lastReceivedValue = value;
	PrintTable(self);
	self:getValueUpdatedEvent():fire(self);
end

function setting:onRequestAccepted(value)
	self._requested = false;
	self:onValueUpdated(value);
	self:getRequestAcceptedEvent():fire(self);
end

function setting:onRequestDenied()
	self._requested = false;
	self:getRequestDeniedEvent():fire(self);
end

function setting:onCommitAccepted()
	self._commitPending = false;
	self:getCommitAcceptedEvent():fire(self);
end

function setting:onCommitDenied()
	self._commitPending = false;
	self:getCommitDeniedEvent():fire(self);
end