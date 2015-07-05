local _pairs = pairs;

function pairs(tbl)
	local meta = getmetatable(tbl);
	if (type(meta) == "table") and (type(meta.__pairs) == "function") then
		return meta.__pairs(tbl);
	else
		return _pairs(tbl);
	end
end
