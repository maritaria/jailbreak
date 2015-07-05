local query = newClass("Query", "Base");

function query:ctor(qry, provider)
	assertArgument(2, "string");
	assertArgument(3, "DatabaseProvider");
	getDefinition("Base").ctor(self);
	self._query = qry;
	self._provider = provider;
	self._busy = false;
	self._result = nil;
end

function query:start()
	assert(not self._busy, "query already started");
	self._busy = true;
	self._provider:query(qry, function(data) self:onQueryCompleted(data) end, function(e) self:onQueryFailed(e) end);
end

function query:abort()
	assert(self._busy, "query not yet started");
	self._busy = false;
end

function query:isBusy()
	return self._busy;
end

function query:onQueryCompleted(data)

end

function query:onQueryFailed(errorMessage)

end