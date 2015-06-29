local typedList = newClass("TypedList", "ValidatedList");

function typedList:ctor(allowedTypes, initial_collection)
	assertArgument(2, "table", "string");
	getDefinition("ValidatedList").ctor(self, wrap(self.validate, self), initial_collection);
	if (type(allowedTypes) == "string") then
		allowedTypes = { allowedTypes };
	end
	self._allowedTypes = table.Merge({}, allowedTypes);
end

function typedList:validate(value)
	local result, message = pcall(assertType, value, self._allowedTypes);
	if not result then print(message) end
	return result;
end
