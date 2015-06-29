local stateMachine = newClass("StateMachine", "Base");

function stateMachine:ctor()
	getDefinition("Base").ctor(self);
	self._activeState = nil;
	self._states = {};
	self._started = false;
end

function stateMachine:addState(state)
	assertArgument(2, "class:State");
	assert(not self:isStarted(), "cannot edit states after machine has started");
	assert(not self:hasState(state));
	table.insert(self._states, state);
end

function stateMachine:newState(name, tick, enter, leave)
	assertArgument(2, "string");
	assertArgument(3, "function", "nil");
	assertArgument(4, "function", "nil");
	assertArgument(5, "function", "nil");
	local state = classes.newInstance("State", name, self);
	state.onTick = tick or state.onTick;
	state.onEnter = enter or state.onEnter;
	state.onLeave = leave or state.onLeave;
	self:addState(state);
	return state;
end

function stateMachine:removeState(state)
	assertArgument(2, "class:State");
	assert(not self:isStarted(), "cannot edit states after machine has started");
	table.remove(self._states, state);
end

function stateMachine:hasState(state)
	assertArgument(2, "class:State");
	return self:getState(state:getName()) != nil;
end

function stateMachine:getState(name)
	assertArgument(2, "string");
	for _, state in pairs(self._states) do
		if (state:getName() == name) then
			return state;
		end
	end
end

function stateMachine:getActiveState()
	return self._activeState;
end

function stateMachine:setActiveState(newState)
	assertArgument(2, "class:State");
	assert(self:hasState(newState));
	if self:isStarted() then
		self:getActiveState():leave(newState);
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