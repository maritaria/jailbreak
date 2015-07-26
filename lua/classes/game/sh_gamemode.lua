local gamemode = newClass("Gamemode");

function gamemode:ctor()
	getDefinition("Base").ctor(self);
	self:initEvents();
	self:initTeamManager();
	self:getInitPostEntityEvent():subscribe(self, self.start);
	self:getShutDownEvent():subscribe(self, self.stop);
end

function gamemode:initTeamManager()
	self:setTeamManager(newInstance("TeamManager", self));
end

function gamemode:getTeamManager()
	return self._teamManager;
end

function gamemode:setTeamManager(value)
	assertArgument(2, "TeamManager");
	if (self._teamManager != nil) then
		self._teamManager:unsubscribeGamemodeEvents();
	end
	self._teamManager = value;
end

function gamemode:start()
end

function gamemode:stop()
end