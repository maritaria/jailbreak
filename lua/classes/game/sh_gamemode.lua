local gamemode = newClass("Gamemode");

function gamemode:ctor()
	getDefinition("Base").ctor(self);
	self:initEvents();
	self:initTeamManager();
	self:subscribe("InitPostEntity", self, "start");
	self:subscribe("ShutDown", self, "stop");
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

function gamemode:reload()
	self:stop();
	self:start();
end

function gamemode:getName()
	return self._Name;
end

function gamemode:setName(value)
	assertArgument(2, "string");
	self._Name = value;
end
