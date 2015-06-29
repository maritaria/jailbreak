local sortedList = newClass("SortedList", "List");

function sortedList:ctor(sort_func, initial_collection)
	assertArgument(2, "function");
	getDefinition("List").ctor(self, initial_collection);
	self._sortFunction = sort_func;
end

function sortedList:add(item)
	local r = getDefinition("List").add(self, item);
	self:sort();
	return r;
end

function list:insert(item, index)
	local r = getDefinition("List").insert(self, item, index);
	self:sort();
	return r;
end

function sortedList:remove(item)
	local r = getDefinition("List").remove(self, item);
	self:sort();
	return r;
end

function sortedList:removeAt(index)
	local r = getDefinition("List").removeAt(self, index);
	self:sort();
	return r;
end

function sortedList:sort(func)
	assertArgument(2, "function", "nil");
	func = func or self:getSortFunction();
	getDefinition("List").sort(self, func);
end

function sortedList:getSortFunction()
	return self._sortFunction;
end