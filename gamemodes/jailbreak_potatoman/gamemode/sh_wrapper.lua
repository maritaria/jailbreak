local gamemode = newInstance("Jailbreak.Gamemode");

local function gm_wrap(gamemode, key)
	return function(_, ...) return gamemode[key](gamemode, ...) end
end

setmetatable(GM, {
	__index = function(tbl, key)
		if (type(key) == "string") then
			key = "on" .. fixHookName(key);
			if (gamemode[key]) then
				return gm_wrap(gamemode, key);
			end
		end
	end
});