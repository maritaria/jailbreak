local validatedList = newClass("ValidatedList", "List");

function validatedList:ctor(validation_func, initial_collection)
	assertArgument(2, "function");
	getDefinition("List").ctor(self, initial_collection);
	self._validationFunction = validation_func;
end

function validatedList:add(item)
	self:assertValidItem(item);
	return getDefinition("List").add(self, item);
end

function validatedList:insert(item, index)
	self:assertValidItem(item);
	return getDefinition("List").add(self, item, index);
end

function validatedList:assertValidItem(item)
	assert(self:isValid(item), string.format("the value '%s' (%s) is not valid for the list", item, typeof(item)));
end

function validatedList:isValid(item)
	return self:getValidationFunction()(item);
end

function validatedList:getValidationFunction()
	return self._validationFunction;
end