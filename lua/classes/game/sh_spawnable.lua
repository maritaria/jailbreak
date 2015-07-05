local spawnable = newClass("Spawnable", "Serializable");

function spawnable:ctor()
	getDefinition("Base").ctor(self);
end

function spawnable:spawn(spawnInfo)
	error("not implemented");
end

function spawnable:canSpawn(spawnInfo)
	assertArgument(2, "SpawnInfo");
	return true;
end

function spawnable:giveTo(ply)
	error("not implemented");
end

function spawnable:canGiveTo(ply)
	assertArgument(2, "Player");
	return true;
end