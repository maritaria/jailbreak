classes = {};
local registry = {};

function classes.newClass(className, baseName)
	assert(type(className) == "string");
	if baseName ~= nil then
		assert(type(baseName) == "string");
	end
	assert(registry[className] == nil);
	local class = classes.createClassDefinition(className, baseName);
	classes.registerClass(class);
	return class._definition;
end

local baseClassDefinition = {};
baseClassDefinition.__index = baseClassDefinition;

function baseClassDefinition:getName()
	return self._className;
end

function baseClassDefinition:getBase()
	if self._baseName then
		return classes.getClass(self._baseName);
	else
		return nil;
	end
end

function baseClassDefinition:getDefinition()
	return self._definition;
end

function baseClassDefinition:isLinked()
	return self._linked;
end

function baseClassDefinition:markAsLinked()
	self._linked = true;
end

function baseClassDefinition:link()
	self:linkBase();
	if self:isLinked() then
		self:linkDerived();
	end
end

function baseClassDefinition:linkBase()
	if (self._baseName) then
		local base = self:getBase();
		if base then
			local def = self:getDefinition();
			local meta = { __index = base:getDefinition() };
			setmetatable(def, meta);
			self:markAsLinked();
		end
	else
		self:markAsLinked();
	end
end

function baseClassDefinition:linkDerived()
	for _, class in pairs(registry) do
		if (not class:isLinked()) and (class:getBase() == self) then
			class:link();
			assert(class:isLinked(), "class remained unlinked after linking to base");
		end
	end
end

function classes.createClassDefinition(className, baseName)
	local class = {
		_className = className,
		_baseName = baseName,
		_linked = false,
		_definition = {},
	};
	class._definition.__decl = class;
	setmetatable(class, baseClassDefinition);
	return class;
end

function classes.registerClass(class)
	registry[class:getName()] = class;
	class:link();
end

function classes.getClass(name)
	assert(type(name) == "string");
	return registry[name];
end

function classes.getDefinition(name)
	local class = classes.getClass(name);
	if class then
		return class:getDefinition();
	end
end

function classes.newInstance(name, ...)
	assert(type(name) == "string");
	local class = classes.getClass(name);
	assert(class ~= nil, string.format("class '%s' not found", name));
	assert(class:isLinked() == true, string.format("class '%s' is not yet linked", name));
	local instance = {};
	local meta = { __index = class:getDefinition() };
	setmetatable(instance, meta);
	if instance.ctor then
		instance:ctor(...);
	end
	return instance;
end



--[[--
function classes.loadDirectory(directory)
	for _, filename in pairs(love.filesystem.getDirectoryItems(directory)) do
		if love.filesystem.isFile(directory .. "/" .. filename) then
			local strippedName = string.match(filename, "(.+)%.lua$");
			if (#strippedName > 0) then
				require(directory .. "/" .. strippedName);
			end
		end
	end
end
--]]--