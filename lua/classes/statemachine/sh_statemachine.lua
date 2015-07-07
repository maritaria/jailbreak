local stateMachine = newClass("StateMachine", "Base");

function stateMachine:ctor()
	getDefinition("Base").ctor(self);
	self._activeState = nil;
	self._states = newInstance("TypedList", "State");
	self._started = false;
end

function stateMachine:addState(state)
	assertArgument(2, "State");
	assert(not self:isStarted(), "cannot edit states after machine has started");
	assert(not self:hasState(state));
	self._states:add(state);
end

function stateMachine:removeState(state)
	assertArgument(2, "State");
	assert(not self:isStarted(), "cannot edit states after machine has started");
	self._states:remove(state);
end

function stateMachine:hasState(state)
	assertArgument(2, "State");
	return self._states:contains(state);
end

function stateMachine:getState(name)
	assertArgument(2, "string");
	for _, state in pairs(self._states) do
		if (state:getName() == name) then
			return state;
		end
	end
	error(string.format("State not found: '%s'", name));
end

function stateMachine:getActiveState()
	return self._activeState;
end

function stateMachine:setActiveState(newState)
	assertArgument(2, "State");
	assert(self:hasState(newState));
	if self:isStarted() then
		local currentState = self:getActiveState();
		xpcall(currentState.leave, ErrorNoHalt, currentState, newState);
	end
	self._started = true;
	self._activeState = newState;
	self:getActiveState():enter();
end

function stateMachine:isStarted()
	return self._started;
end

function stateMachine:tick()
	local activeState = self:getActiveState();
	if (activeState != nil) then
		activeState:tick();
	end
end