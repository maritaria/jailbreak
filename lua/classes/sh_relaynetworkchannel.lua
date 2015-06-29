local relay = newClass("RelayNetworkChannel", "NetworkChannel");

function relay:ctor(name)
	getDefinition("NetworkChannel").ctor(self, name);
	self._hooks = {};
end

function relay:addListener(identifier, callback)
	self._hooks[identifier] = callback;
end

function relay:removeListener(identifier)
	self._hooks[identifier] = nil;
end

function relay:receive(data, ply)
	for identifier, callback in pairs(self._hooks) do
		xpcall(callback, wrap(self.onCallbackError, self), data, ply);
	end
end

function relay:onCallbackError()
	ErrorNoHalt();
end