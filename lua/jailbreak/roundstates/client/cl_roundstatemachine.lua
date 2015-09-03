local roundStateMachine = newClass("Jailbreak.RoundStateMachine", "StateMachine");

function roundStateMachine:requestState()
	local setting = self:getActiveStateSetting();
	if (setting != nil) then
		setting:request();
	end
end

function roundStateMachine:onActiveStateUpdated(setting)
	local stateName = setting:getValue();
	local state = self:getState(stateName);
	self:setActiveState(state);
end