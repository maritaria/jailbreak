local setting = newClass("Setting", "Base");

function setting:ctor(manager, name, value)
	assertArgument(2, "class:SettingsManager");
	assertArgument(3, "string");
	getDefinition("Base").ctor(self);
	self._manager = manager;
	self._name = name;
	self._value = value;
	self._lastReceivedValue = nil;
	self._received = false;
	self._requested = false;
	self._commitPending = false;
end

function setting:getManager()
	return self._manager;
end

function setting:getName()
	return self._name;
end

function setting:getValue()
	if not self:isReceived() and not self:isRequested() then
		self:requestValue();
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

function setting:requestValue()
	if not self:isRequested() then
		self:getManager():request(self);
		self._requested = true;
	end
end

function setting:receive(value)
	self._received = true;
	self._requested = false;
	self._value = value;
	self._lastReceivedValue = value;
end

function setting:commit()
	if self:canCommit() then
		self:getManager():commit(self);
		self._commitPending = true;
	end
end

function setting:canCommit()
	return not self:isCommitPending();
end

function setting:onCommitAccepted()
	self._commitPending = false;
end

function setting:onCommitDenied(message)
	self._commitPending = false;
end