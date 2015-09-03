local gamemode = newInstance("Jailbreak.Gamemode");

local function gm_wrapCall(gamemode, key)
	return function(_, ...)
		return gamemode[key](gamemode, ...);
	end
end

local function gm_wrapEvent(gamemode, key)
	return function(_, ...)
		return gamemode:fireEvent(key, ...);
	end
end

setmetatable(GM, {
	__index = function(tbl, key)
		if (type(key) == "string") then
			local fixedName = fixHookName(key);
			local asFunction = "on" .. fixedName;
			if (gamemode[asFunction]) then
				return gm_wrapCall(gamemode, asFunction);
			else
				return gm_wrapEvent(gamemode, fixedName);
			end
		end
		return rawget(tbl, key);
	end,
});

--ULX accesses the Name key, so we better don't break that or people will get mad
GM.Name = "Jailbreak";

function GM:getGamemode()
	return gamemode;
end