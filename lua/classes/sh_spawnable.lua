local spawnable = newClass("Spawnable");

function spawnable:ctor()
	getDefinition("Base").ctor(self);
	self._position = Vector(0, 0, 0);
	self._orientation = Angle(0, 0, 0);
end

function spawnable:spawn()
	error("not implemented");
end

function spawnable:canSpawn()
	return true;
end