local spawnpoint = newClass("SpawnPoint");

function spawnpoint:ctor(ent)
	assertArgument(2, "Entity", "nil");
	getDefinition("Base").ctor(self);
	self._position = Vector(0, 0, 0);
	self._orientation = Angle(0, 0, 0);
	if IsValid(ent) then
		self._entity = ent;
	elseif isEntitySpawnAllowed() then
		self:spawnEntity();
	end
end

function spawnpoint:getPosition()
	return self._position;
end

function spawnpoint:setPosition(pos)
	assertArgument(2, "Vector");
end

function spawnpoint:getOrientation()
	if (self:getEntity() != nil) then
		return self:getEntity():GetAngles();
	else
		return self._orientation;
	end
end

function spawnpoint:setOrientation(ang)
	assertArgument(2, "Angle");
	self._orientation = ang;
	if (self:getEntity() != nil) then
		self:getEntity():SetAngles(ang);
	end
end

function spawnpoint:getEntity()
	if IsValid(self._entity) then
		return self._entity;
	end
end

function spawnpoint:spawnEntity()
	assertAllowEntitySpawn();
	assert(self:getEntity() == nil, "entity already spawned");
	local ent = ents.Create("info_player_start");
	ent:SetPos(self:getPosition());
	ent:SetAngles(self.getOrientation());
	ent:Spawn();
	self._entity = ent;
end