local settingsManager = newClass("SettingsManager", "TypedList");

function settingsManager:request(setting)
	assertType(2, "Setting");
	local packet = { name = setting:getName() };
	self:getUpdateChannel():transmit(packet);
end

function settingsManager:commit(setting)
	assertType(2, "Setting");
	local packet = { name = setting:getName(), value = setting:getValue() };
	self:getCommitChannel():transmit(packet);
end

function settingsManager:handleUpdate(channel, update)
	if self:isValidUpdate(update) then
		local setting = self:getSetting(update.name);
		setting:onValueUpdated(update.value);
		self:getSettingUpdatedEvent():fire(self, setting);
	end
end

function settingsManager:isValidUpdate(update)
	return (type(update.name) == "string") and (self:hasSetting(update.name));
end

function settingsManager:handleRequest(channel, request)
	assertArgument(3, "table");
	if self:isValidRequestResponse(request) then
		local setting = self:getSetting(request.name);
		if self:isRequestAccepted(request) then
			setting:onRequestAccepted(request.value);
			self:getRequestAcceptedEvent():fire(self, setting);
		else
			setting:onRequestDenied();
			self:getRequestDeniedEvent():fire(self, setting);
		end
	end
end

function settingsManager:isValidRequestResponse(packet)
	return (type(packet.name) == "string") and (self:hasSetting(packet.name)) and (type(packet.result) == "number");
end

function settingsManager:isRequestAccepted(request)
	return (request.result == settingsManager.REQUEST_ACCEPTED);
end

function settingsManager:handleCommit(channel, packet)
	assertArgument(3, "table");
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
