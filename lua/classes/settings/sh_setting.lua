local setting = newClass("Setting", "Base");

function setting:ctor(manager, name, value)
	assertArgument(2, "SettingsManager");
	assertArgument(3, "string");
	getDefinition("Base").ctor(self);
	self._manager = manager;
	self._name = name;
	self._value = value;
	self._lastReceivedValue = nil;
	self._received = SERVER;
	self._requested = false;
	self._commitPending = false;
	self._requestAcceptedEvent = newInstance("Event");
	self._requestDeniedEvent = newInstance("Event");
	self._commitAcceptedEvent = newInstance("Event");
	self._commitDeniedEvent = newInstance("Event");
	self._valueUpdatedEvent = newInstance("Event");
	self:getManager():add(self);
end

function setting:getManager()
	return self._manager;
end

function setting:getName()
	return self._name;
end

function setting:getRequestAcceptedEvent()
	return self._requestAcceptedEvent;
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

function setting:getValueUpdatedEvent()
	return self._valueUpdatedEvent;
end

function setting:canCommit(ply)
	assertArgument(2, "Player");
	return true;
end

function setting:canRequest(ply)
	assertArgument(2, "Player");
	return true;
end