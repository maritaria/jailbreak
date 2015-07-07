local settingsManager = newClass("SettingsManager", "TypedList");

function settingsManager:update(setting, players)
	assertArgument(2, "Setting");
	assertArgument(3, "Player", "table", "nil");
	local packet = { name = setting:getName(), value = setting:getValue() };
	self:getUpdateChannel():transmit(packet, players);
end

function settingsManager:handleUpdate(channel, packet, ply)
	error("This should never happen, the channel is one way");
end

function settingsManager:handleRequest(channel, request, ply)
	assertArgument(3, "table");
	assertArgument(4, "Player");
	if self:isValidRequest(request) then
		local setting = self:getSetting(request.name);
		if self:isRequestAllowed(request, ply) then
			local value = setting:getValue();
			self:sendRequestAccepted(request, value, ply);
			setting:onRequestAccepted(ply);
			self:getRequestAcceptedEvent():fire(self, ply, setting, request);
		else
			self:sendRequestDenied(request, ply);
			setting:onRequestDenied(ply);
			self:getRequestDeniedEvent():fire(self, ply, setting, request);
		end
	end
end

function settingsManager:isValidRequest(request)
	PrintTable(request);
	return (type(request.name) == "string") and (self:hasSetting(request.name));
end

function settingsManager:isRequestAllowed(request, ply)
	return self:getSetting(request.name):canRequest(ply);
end

function settingsManager:sendRequestAccepted(request, value, ply)
	self:getRequestChannel():transmit({ setting = request.name, result = settingsManager.REQUEST_ACCEPTED, value = value }, ply);
end

function settingsManager:sendRequestDenied(request, ply)
	self:getRequestChannel():transmit({ setting = request.name, result = settingsManager.REQUEST_DENIED }, ply);
end

function settingsManager:handleCommit(channel, commit, ply)
	assertArgument(3, "table");
	assertArgument(4, "Player");
	if self:isValidCommit(commit) then
		local setting = self:getSetting(commit.name);
		if self:isCommitAllowed(commit, ply) then
			setting:setValue(commit.value);
			self:sendCommitAccepted(commit, ply);
			setting:onCommitAccepted(ply);
			self:getCommitAcceptedEvent():fire(self, ply, setting, commit);
		else
			self:sendCommitDenied(commit, ply);
			setting:onCommitDenied(ply);
			self:getCommitDeniedEvent():fire(self, ply, setting, commit);
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