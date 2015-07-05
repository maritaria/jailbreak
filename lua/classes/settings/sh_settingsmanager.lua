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
	self._updateChannel = newInstance("NetworkChannel", "SettingsManager.UpdateChannel");
	self._updateChannel:getTransmissionReceivedEvent():subscribe("SettingsManager", wrap(self.handleUpdate, self));
	self._commitChannel = newInstance("NetworkChannel", "SettingsManager.CommitChannel");
	self._commitChannel:getTransmissionReceivedEvent():subscribe("SettingsManager", wrap(self.handleCommit, self));
end

function settingsManager:getUpdateChannel()
	return self._updateChannel;
end

function settingsManager:getCommitChannel()
	return self._commitChannel;
end

function settingsManager:initEvents()
	self._settingUpdatedEvent = newInstance("Event");
	self._updateDeniedEvent = newInstance("Event");
	self._commitAcceptedEvent = newInstance("Event");
	self._commitDeniedEvent = newInstance("Event");
end

function settingsManager:getSettingUpdatedEvent()
	return self._settingUpdatedEvent;
end

function settingsManager:getUpdateDeniedEvent()
	return self._updateDeniedEvent;
end

function settingsManager:getCommitAcceptedEvent()
	return self._commitAcceptedEvent;
end

function settingsManager:getCommitDeniedEvent()
	return self._commitDeniedEvent;
end

function settingsManager:request(setting)
	assert(CLIENT);
	local packet = { name = setting:getName() };
	self:getUpdateChannel():transmit(packet);
end

function settingsManager:commit(setting)
	local packet = { name = setting:getName(), value = setting:getValue() };
	self:getCommitChannel():transmit(packet);
end

function settingsManager:handleUpdate(channel, packet, ply)
	if SERVER then
		self:handleUpdateRequest(packet, ply);
	else
		self:handleUpdateResponse(packet);
	end
end

function settingsManager:handleUpdateRequest(request, ply)
	assertArgument(2, "table");
	assertArgument(3, "Player");
	if self:isValidUpdateRequest(request) then
		if self:isUpdateAllowed(request, ply) then
			local value = self:getSetting(request.name):getValue();
			self:sendUpdateAccepted(request, value, ply);
		else
			self:sendUpdateDenied(request, ply);
		end
	else
	end
end

function settingsManager:isValidUpdateRequest(request)
	PrintTable(request);
	return (type(request.name) == "string") and (self:hasSetting(request.name));
end

function settingsManager:isUpdateAllowed(request, ply)
	return self:getSetting(request.name):canRequest(ply);
end

function settingsManager:sendUpdateAccepted(request, value, ply)
	self:getUpdateChannel():transmit({ setting = request.name, result = settingsManager.REQUEST_ACCEPTED, value = value }, ply);
end

function settingsManager:sendUpdateDenied(request, ply)
	self:getUpdateChannel():transmit({ setting = request.name, result = settingsManager.REQUEST_DENIED }, ply);
end

function settingsManager:handleUpdateResponse(request)
	assertArgument(2, "table");
	if self:isValidRequestResponse(request) then
		local setting = self:getSetting(request.name);
		if self:isRequestAccepted(request) then
			setting:onRequestAccepted(request.value);
			self:getSettingUpdatedEvent():fire(self, setting);
		else
			setting:onRequestDenied();
			self:getRequestDeniedEvent():fire(self, setting);
		end
	end
end

function settingsManager:isValidRequestResponse(request)
	return (type(request.name) == "string") and (self:hasSetting(request.name)) and (type(request.result) == "number");
end

function settingsManager:isRequestAccepted(request)
	return (request.result == settingsManager.REQUEST_ACCEPTED);
end

function settingsManager:handleCommit(channel, packet, ply)
	if SERVER then
		self:handleCommitRequest(packet, ply);
	else
		self:handleCommitResponse(packet);
	end
end

function settingsManager:handleCommitRequest( commit, ply)
	assertArgument(2, "table");
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

function settingsManager:isValidCommit(commit)
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

function settingsManager:handleCommitResponse(packet, ply)
	assertArgument(2, "table");
	if self:isValidCommitResponse(packet) then
		local setting = self:getSetting(packet.name);
		if self:isCommitAccepted(packet) then
			setting:onCommitAccepted();
			self:getCommitAcceptedEvent():fire(self, setting);
		else
			setting:onCommitDenied();
			self:getCommitDeniedEvent():fire(self, setting);
		end
	end
end

function settingsManager:isValidCommitResponse(packet)
	return (type(packet.name) == "string") and (self:hasSetting(packet.name)) and (type(packet.result) == "number");
end

function settingsManager:isCommitAccepted(commit)
	return (commit.result == settingsManager.REQUEST_ACCEPTED);
end
