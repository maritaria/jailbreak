local base = classes.newClass("Base");

function base:ctor() end

function base:getClass()
	return self.__decl;
end

function base:type()
	return self:getClass():getName();
end

function base:typeOf(className)
	local class = self:getClass();
	repeat
		if (class:getName() == className) then
			return true;
		end
		class = class:getBase();
	until (class == nil)
end