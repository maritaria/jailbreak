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
	self._valueUpdatedEvent = newInstance("Event");
	self._requestDeniedEvent = newInstance("Event");
	self._commitAcceptedEvent = newInstance("Event");
	self._commitDeniedEvent = newInstance("Event");
end

function setting:getManager()
	return self._manager;
end

function setting:getName()
	return self._name;
end

function setting:getValue()
	if CLIENT and not self:isReceived() then
		self:request();
	end
	return self._value;
end

function setting:setValue(value)
	if CLIENT then
		assert(not self:isCommitPending(), "Setting value not allowed to change during commit");
	end
	self._value = value;
	if SERVER then
		self:getManager():commit(self);
	end
end

if CLIENT then
	
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

	function setting:getValueUpdatedEvent()
		return self._valueUpdatedEvent;
	end

	function setting:getRequestDeniedEvent()
		return self._requestDeniedEvent;
	end

	function setting:getCommitAcceptedEvent()
		return self._commitAcceptedEvent;
	end

	function setting:getCommitDeniedEvent()
		return self._commitDeniedEvent;
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
	
	function setting:onRequestAccepted(value)
		self._received = true;
		self._requested = false;
		self._value = value;
		self._lastReceivedValue = value;
		self:getValueUpdatedEvent():fire(self);
	end

	function setting:onRequestDenied()
		self._requested = false;
		self:getRequestDeniedEvent():fire(self);
	end

	function setting:onCommitAccepted()
		self._commitPending = false;
		self:getCommitAcceptedEvent();fire(self);
	end

	function setting:onCommitDenied()
		self._commitPending = false;
		self:getCommitDeniedEvent();fire(self);
	end
	
end

function setting:canCommit(ply)
	assertArgument(2, "Player");
	return true;
end

function setting:canRequest(ply)
	assertArgument(2, "Player");
	return true;
end