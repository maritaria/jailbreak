function include_file(filePath)
	assert(type(filePath) == "string");
	local isShared = string.find(filePath, "sh_");
	local isClient = string.find(filePath, "cl_");
	local isServer = string.find(filePath, "sv_");
	if (isShared or isClient) then
		AddCSLuaFile(filePath);
	end
	if (isServer and CLIENT) then return end;
	if (isClient and SERVER) then return end;
	print("[jailbreak] Including lua file: " .. filePath);
	include(filePath);
end

function include_dir(filePath)
	assert(type(filePath) == "string");
	if (string.sub(filePath, -1) != "/") then
		filePath = filePath .. "/";
	end
	local pattern = filePath .. "*.lua";
	local files, directories = file.Find(pattern, "LUA");
	for _, name in pairs(files) do
		include_file(filePath .. name);
	end
end

include_dir("util");
include_dir("util/3rdparty");
include_dir("classes");
include_dir("jailbreak");
--include_dir("sleekmanager");
--include_dir("virtualarmory");
--include_dir("modsit");
--include_dir("kenui");