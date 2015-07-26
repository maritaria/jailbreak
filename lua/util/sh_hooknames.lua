function fixHookName(str)
	if (type(str) == "string") then
		return str:removePrefix("On");
	else
		return str;
	end
end

function string.removePrefix(str, prefix)
	if str:StartWith(prefix) then
		return str:sub(1 + prefix:len());
	else
		return str;
	end
end