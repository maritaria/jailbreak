local component = newClass("GamemodeComponent");

function component:ctor(gamemode)
	assertArgument(2, "Gamemode");
	self._gamemode = gamemode;
	self:subscribeEvents();
end

function component:getGamemode()
	return self._gamemode;
end

function component:initSettings(manager)
	error("not yet implemented");
end

function component:subscribeEvents()
	error("not yet implemented");
end

function component:unsubscribeEvents()
	error("not yet implemented");
end

print("TODO: Refactor the gamemode constructor argument away, do this by making the gamemode set-able and call unsub and sub from there instead");