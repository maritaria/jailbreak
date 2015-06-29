local settingsManager = newClass("SettingsManager", "TypedList");
settingsManager.REQUEST_ACCEPTED = 0;
settingsManager.REQUEST_DENIED = 1;
settingsManager.COMMIT_ACCEPTED = 0;
settingsManager.COMMIT_DENIED = 1;

function settingsManager:ctor()
	getDefinition("TypedList").ctor(self, "Setting");
	self:initChannels();
	self:initEvents();
end

function settingsManager:getSetting(name)
	for _, setting in self:enumerate() do
		if (setting:getName() == name) then
			return setting;
		end
	end
end

function settingsManager:hasSetting(name)
	return self:getSetting(name) != nil;
end

function settingsManager:initChannels()
	self._requestChannel = newInstance("NetworkChannel");
	self._requestChannel.receive = wrap(self.handleRequestMessage, self);
	self._commitChannel = newInstance("NetworkChannel");
	self._commitChannel.receive = wrap(self.handleCommitMessage, self);
end

function settingsManager:getRequestChannel()
	return self._requestChannel;
end

function settingsManager:getCommitChannel()
	return self._commitChannel;
end

function settingsManager:initEvents()
	self._requestAcceptedEvent = newInstance("Event");
	self._requestDeniedEvent = newInstance("Event");
	self._commitAcceptedEvent = newInstance("Event");
	self._commitDeniedEvent = newInstance("Event");
end

function settingsManager:getRequestAcceptedEvent()
	return self._requestAcceptedEvent;
end

function settingsManager:getCommitAcceptedEvent()
	return self._commitAcceptedEvent;
end

if SERVER then
	
	function settingsManager:handleRequestMessage(request, ply)
		assertArgument(2, "table", "nil");
		assertArgument(3, "Player");
		if self:isValidRequest(request) then
			if self:isRequestAllowed(request, ply) then
				local value = self:getSetting(request.name):getValue();
				self:sendRequestAccepted(request, value, ply);
			else
				self:sendRequestDenied(request, ply);
			end
		end
	end
	
	function settingsManager:isRequestValid(request)
		return (type(request.name) == "string") and (self:hasSetting(request.name));
	end
	
	function settingaManager:isRequestAllowed(request, ply)
		return self:getSetting(request.name):canRequest(ply);
	end
	
	function settingsManager:sendRequestAccepted(request, value, ply)
		self:getRequestChannel():transmit({ setting = request.name, result = settingsManager.REQUEST_ACCEPTED, value = value }, ply);
	end
	
	function settingsManager:sendRequestDenied(request, ply)
		self:getRequestChannel():transmit({ setting = request.name, result = settingsManager.REQUEST_DENIED }, ply);
	end
	
	function settingsManager:handleCommitMessage(commit, ply)
		assertArgument(2, "table", "nil");
		assertArgument(3, "Player");
		if self:isValidCommit(commit) then
			local setting = self:getSetting(commit.name);
			if self:isCommitAllowed(commit, ply) then
				setting:setValue(commit.value);
				self:sendCommitAccepted(commit, ply);
				self:getCommitAcceptedEvent():fire(self, setting);
			else
				self:sendCommitDenied(commit, ply);
				self:getCommitDeniedEvent():fire(self, setting);
			end
		end
	end
	
	function settingsManager:isCommitValid(commit)
		return (type(commit.name) == "string") and (self:hasSetting(commit.name));
	end
	
	function settingsManager:isCommitAllowed(commit, ply)
		return self:getSetting(commit.name):canCommit(ply);
	end
	
	function settingsManager:sendCommitAccepted(commit, ply)
		self:getCommitChannel():transmit({ setting = commit.name, result = settingsManager.COMMIT_ACCEPTED }, ply);
	end
	
	function settingsManager:sendCommitDenied(commit, ply)
		self:getCommitChannel():transmit({ setting = commit.name, result = settingsManager.COMMIT_DENIED }, ply);
	end
	
else
	
	function settingsManager:handleRequestMessage(request)
		assertArgument(2, "table", "nil");
		if self:isValidRequestResponse(request) then
			local setting = self:getSetting(request.name);
			if self:isRequestAccepted(request) then
				setting:setValue(request.value);
				self:getRequestAcceptedEvent():fire(self, setting);
			else
				self:getRequestDeniedEvent():fire(self, setting);
			end
		end
	end
	
	function settingsManager:isValidRequestResponse(request)
		return (type(request.name) == "string") and (self:hasSetting(request.name)) and (type(request.result) == "number");
	end
	
	function settingsManager:isRequestAccepted(request)
		return request.result = settingsManager.REQUEST_ACCEPTED;
	end
	
	function settingsManager:handleCommitMessage(commit, ply)
		assertArgument(2, "table", "nil");
		if self:isValidCommitResponse(request) then
			local setting = self:getSetting(request.name);
			if self:isCommitAccepted(request) then
				setting:receive(commit);
				self:getCommitAcceptedEvent():fire(self, setting);
			else
				self:getCommitDeniedEvent():fire(self, setting);
			end
		end
	end
	
	function settingsManager:request(setting)
		local packet = { name = setting:getName() };
		self:getRequestChannel():transmit(packet);
	end

	function settingsManager:commit(setting)
		local packet = { name = setting:getName(), value = setting:getValue() };
		self:getCommitChannel():transmit(packet);
	end
	
end