local gamemode = classes.newInstance("Jailbreak.Gamemode");

local function gm_wrap(gamemode, key)
	return function(_, ...) return gamemode[key](gamemode, ...) end
end

setmetatable(GM, {
	__index = function(tbl, key)
		key = key:SetChar(1, key:lower()[1]);
		if (gamemode[key]) then
			return gm_wrap(gamemode, key);
		end
	end
});