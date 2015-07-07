local component = newClass("GamemodeComponent");

function component:ctor(gamemode)
	assertArgument(2, "Gamemode");
	self._gamemode = gamemode;
end

function component:getGamemode()
	return self._gamemode;
end

function component:initSettings(manager)
	
end