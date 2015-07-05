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
	--print("[JailBreak] " .. filePath);
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

function include_dir_recursive(filePath)
	assert(type(filePath) == "string");
	assert(type(filePath) == "string");
	if (string.sub(filePath, -1) != "/") then
		filePath = filePath .. "/";
	end
	include_dir(filePath);
	local pattern = filePath .. "*";
	local files, directories = file.Find(pattern, "LUA");
	for _, dir in pairs(directories) do
		include_dir_recursive(filePath .. dir);
	end
end

include_dir_recursive("util");
include_dir_recursive("classes");
include_dir_recursive("jailbreak");

print("Jailbreak loaded");
--include_dir_recursive("sleekmanager");
--include_dir_recursive("virtualarmory");
--include_dir_recursive("modsit");
--include_dir_recursive("kenui");