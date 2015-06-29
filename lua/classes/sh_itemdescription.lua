local itemDesc = newClass("ItemDescription", "Spawnable");

function itemDesc:ctor(name)
	assertArgument(2, "string");
	getDefinition("Spawnable").ctor(self);
end