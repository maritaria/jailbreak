local state = newClass("State", "Base");

function state:ctor(name, machine)
	assertArgument(2, "string");
	assertArgument(3, "class:StateMachine");
	getDefinition("Base").ctor(self);
	self._name = name;
	self._active = false;
	self._machine = machine;
end

function state:getName()
	return self._name;
end

function state:isActive()
	return self._active;
end

function state:getMachine()
	return self._machine;
end

function state:tick()
	assert(self:isActive(), "The state is not the active state");
	self:onTick();
end

function state:onTick() end;

function state:enter()
	assert(not self:isActive(), "The state is already active");
	self._active = true;
	self:onEnter();
end

function state:onEnter() end;

function state:leave()
	assert(self:isActive(), "The state is not the active state");
	self._active = false;
	self:onLeave();
end

function state:onLeave() end;

function state:changeTo(stateName)
	assertArgument(2, "string");
	assert(self:isActive(), "The state is not the active state");
	local otherState = self:getMachine():getState(otherState);
	self:getMachine():setActiveState(otherState);
end