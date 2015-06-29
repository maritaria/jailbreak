local event = newClass("Event");

function event:ctor()
	self._listeners = {};
end

function event:subscribe(identifier, callback)
	assertArgument(2, "string");
	assertArgument(3, "function");
	self._listeners[identifier] = callback;
end

function event:unsubscribe(identifier)
	assertArgument(2, "string");
	self._listeners[identifier] = nil;
end

function event:fire(...)
	for _, callback in pairs(self._listeners) do
		callback(...);
	end
end