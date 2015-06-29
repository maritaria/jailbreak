local provider = newClass("DatabaseProvider", "Base");

function provider:ctor()
	getDefinition("Base").ctor(self);
end

function provider:isConnected() end

function provider:connect(hostname, port, username, password, databaseName)
	assertArgument(2, "string");
	assertArgument(3, "number", "nil");
	assertArgument(4, "string", "nil");
	assertArgument(5, "string", "nil");
	assertArgument(6, "string", "nil");
end

function provider:disconnect()
	assert(self:isConnected(), "not yet connected");
end

function provider:query(command, completedCallback, failedCallback) end
