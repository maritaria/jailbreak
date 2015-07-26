local component = newClass("GamemodeComponent");
print("TODO: Refactor the gamemode constructor argument away");
function component:ctor(gamemode)
	assertArgument(2, "Gamemode");
	self._gamemode = gamemode;
	self:subscribeEvents();
end

function component:getGamemode()
	return self._gamemode;
end

function component:initSettings(manager)
end

function component:subscribeEvents()
end

function component:unsubscribeEvents()
end

print("not yet implemented");