local spawninfo = newClass("SpawnInfo");

function spawninfo:ctor()
	self._position = Vector(0, 0, 0);
	self._angles = Angle(0, 0, 0);
end

function spawninfo:getPosition()
	return self._position;
end

function spawninfo:setPosition(pos)
	assertArgument(2, "Vector");
	self._position = pos;
end

function spawninfo:getAngles()
	return self._orientation;
end

function spawninfo:setAngles(ang)
	assertArgument(2, "Angle");
end