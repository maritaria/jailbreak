local settingsManager = newClass("SettingsManager", "TypedList");

function settingsManager:commit(setting, players)
	assertType(2, "Setting");
	assertType(3, "Player", "table");
	local packet = { name = setting:getName(), value = setting:getValue() };
	self:getCommitChannel():transmit(packet);
end

function settingsManager:handleUpdate(channel, request, ply)
	assertArgument(3, "table");
	assertArgument(4, "Player");
	if self:isValidUpdateRequest(request) then
		if self:isUpdateAllowed(request, ply) then
			local value = self:getSetting(request.name):getValue();
			self:sendUpdateAccepted(request, value, ply);
		else
			self:sendUpdateDenied(request, ply);
		end
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

function settingsManager:handleCommit(channel, commit, ply)
	assertArgument(3, "table");
	assertArgument(4, "Player");
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