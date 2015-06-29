local weaklist = newClass("WeakList", "List");

function weaklist:ctor(initial_collection)
	self._items = setmetatable({}, { __mode = "v" });
	getDefinition("List").ctor(self, initial_collection);
end