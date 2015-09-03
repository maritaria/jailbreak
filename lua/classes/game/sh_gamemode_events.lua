local gamemode = newClass("Gamemode");

function gamemode:initEvents()
	self._events = {};
end

function gamemode:fireEvent(eventName, ...)
	local eventTable = self._events[eventName] or {};
	local result = {};
	for identifier, callback in pairs(eventTable) do
		local packed = self:callSafe(callback, identifier, ...);
		if #result == 0 then
			result = packed;
		else
			PrintTable(result);
		end
	end
	return unpack(result);
end

function gamemode:callSafe(func, ...)
	local result = { xpcall(func, ErrorNoHalt, ...) };
	table.remove(result, 1);
	return result;
end

function gamemode:subscribe(eventName, identifier, callbackKey)
	assertArgument(2, "string");
	assertArgument(3, "table", "Entity", "Player");
	assertArgument(4, "string");
	self._events[eventName] = self._events[eventName] or {};
	local callback = self:wrapSubscriber(identifier, callbackKey);
	self._events[eventName][identifier] = callback;
end

function gamemode:wrapSubscriber(tbl, key)
	return function(self, ...) return tbl[key](tbl, ...) end;
end

function gamemode:unsubscribe(eventName, identifier)
	assertArgument(2, "string");
	assertArgument(3, "string", "table", "Entity", "Player");
	if (type(self._events[eventName]) == "table") then
		self._events[eventName][identifier] = nil;
	end
end

function gamemode:unsubscribeAll(identifier)
	assertArgument(2, "table", "Entity", "Player");
	for eventName, callbackTable in pairs(self._events) do
		self:unsubscribe(eventName, identifier);
	end
	
end