local gamemode = classes.newInstance("Jailbreak.Gamemode");
setmetatable(GM, {
	__index = function(tbl, key)
		key = key:SetChar(1, key:lower()[1]);
		return gamemode[key];
	end
});