local list = newClass("List");

function list:ctor(initial_collection)
	assertArgument(2, "table", "nil");
	getDefinition("Base").ctor(self);
	self._items = table.Merge(self._items or {}, initial_collection or {});
end

function list:add(item)
	table.insert(self._items, item);
	return item;
end

function list:insert(item, index)
	assertType(index, "number");
	table.insert(self._items, index, item);
	return item;
end

function list:remove(item)
	return self:removeAt(self:indexOf(item));
end

function list:removeAt(index)
	assertArgument(2, "number");
	return table.remove(self._items, index);
end

function list:indexOf(item)
	for index, listedItem in self:enumerate() do
		if (listedItem == item) then
			return index;
		end
	end
end

function list:contains(item)
	return self:indexOf(item) != nil;
end

function list:get(index)
	assertArgument(2, "number");
	return self._items[index];
end

function list:sort(func)
	assertArgument(2, "function", "nil");
	table.sort(self._items, func);
end

function list:enumerate()
	return pairs(self._items);
end