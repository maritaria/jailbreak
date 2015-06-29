function assertType(value, types, message, ...)
	message = message or "assertion failed";
	assert(type(types) == "table");
	vtype = type(value);
	for k, t in pairs(types) do
		if t:StartWith("class:") and pcall(assertClass, value, t:sub(7), message, ...) then
			return;
		elseif (vtype == t) then
			return;
		end
	end
	error(string.format(message, ...));
end

function assertTypeOrNil(value, types, message, ...)
	message = message or "assertion failed";
	if (value != nil) then
		assertType(value, types, message, ...)
	end
end

function assertClass(value, className, message, ...)
	message = message or "assertion failed";
	assertType(value, { "table" }, message, ...);
	assert(type(value.typeOf) == "function", string.format(message, ...));
	assert(value:typeOf(className or "Base"), string.format(message, ...));
end

function assertClassOrNil(value, className, message, ...)
	message = message or "assertion failed";
	if (value != nil) then
		assertClass(value, className, message, ...);
	end
end

function assertArgument(index, ...)
	local types = { ... };
	local variableName, value = debug.getlocal(2, index);
	local funcname = debug.getinfo(2, "n").name;
	local args = string.Implode(", ", types);
	assertType(value, types, "invalid argument %s to '%s', expected {%s} but got %s", index, funcname, args, typeof(value));
end

function typeof(value)
	local t = type(value);
	if (t == "table") and (value.type) then
		t = value:type();
	end
	return t;
end

function assertAllowEntitySpawn()
	assert(isEntitySpawnAllowed(), "Entities can't be spawned yet");
end