local teamManager = newClass("TeamManager");

function teamManager:ctor()
	getDefinition("Base").ctor(self);
	self._teams = newInstance("TypedList", "class:Team");
	self._defaultTeam = nil;
	self:initChannels();
end

function teamManager:getTeams()
	return self._teams;
end

function teamManager:getDefaultTeam()
	assert(self._defaultTeam != nil, "no default team assigned");
	return self._defaultTeam;
end

function teamManager:setDefaultTeam(value)
	assertArgument(2, "class:Team");
	assert(self:getTeams():contains(value), "team does not belong to this TeamManager");
	self._defaultTeam = value;
end

function teamManager:getTeamByIdentifier(identifier)
	for _, team in self:getTeams():enumerate() do
		if (team:getIdentifier() == identifier) then
			return team;
		end
	end
end

function teamManager:initChannels()
	local channel = newInstance("NetworkChannel", "TeamManager");
	channel.onReceived = wrap(self.onNotification, self);
	self._notificationChannel = channel;
end

function teamManager:onNotification(channel, data, ply)
	error("not yet implemented");
	if SERVER then
		
	else
		
	end
end