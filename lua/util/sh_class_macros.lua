function newClass(name, base)
	assert(name != base, "Trying to register a class to it's own base");
	return classes.getDefinition(name) or classes.newClass(name, base or "Base");
end

function newInstance(classname, ...)
	return classes.newInstance(classname, ...);
end

function getDefinition(classname)
	return classes.getDefinition(classname);
end