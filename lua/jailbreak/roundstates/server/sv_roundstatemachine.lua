local roundStateMachine = newClass("Jailbreak.RoundStateMachine", "StateMachine");

function roundStateMachine:setActiveState(state)
	getDefinition("StateMachine").setActiveState(self, state);
	self:broadcastState();
end

function roundStateMachine:broadcastState()
	local setting = self:getActiveStateSetting();
	local state = self:getActiveState();
	if (setting != nil) and (state != nil) then
		local stateName = state:getName();
		setting:setValue(stateName);
	end
end